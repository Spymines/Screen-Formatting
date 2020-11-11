#!/usr/bin/sbcl --script

(defvar file)
(defvar curr)
(defvar lineCount)
(setq lineCount 0)
(defvar words)
(defvar x 0)
(defvar prev)
(setq prev #\p)

(defvar lineNumber 1)

(defvar longString)

;Commented out column counter, can be put back in if needed. 
;(write-line "123456789*123456789*123456789*123456789*123456789*123456789*123456789*")


(setq file (open (car(cdr *posix-argv* ) )))

(setf longString(make-string(file-length file)))

	;Loops through the entire file character by character and adds it to the
	;final string if it needs to be, effectively formats the input
      	(loop for curr = (read-char file nil :eof) ; stream, no error, :eof value
                  until (eq curr :eof)
                        do
			(cond ((or (char> curr #\9) (char< curr #\0)) 
				;Case 1
				;For anything besides a new line or space
				(cond ((and (char/= curr #\NewLine)(char/= curr #\Space))
					(setf (aref longString x) curr)
					(incf x)
					(setq prev curr))
					
					;Case 2 
					;For new line characters      
					((and(char= curr #\NewLine)(char/= prev #\Space)) 
					(setf (aref longString x) #\Space)
					(incf x)
					(setq prev #\Space))

					;Case 3	
					;For 2 spaces after eachother
					((and (char= curr #\Space)(char= prev #\Space))
					(setq prev #\Space))

					;Case 4
					;For a space following something that isn't a space
					((and (char= curr #\Space)(char/= prev #\Space))
					(setf (aref longString x) curr)
					(incf x)
					(setq prev curr))
				)	
		  	      )
			)
      	)

(defvar lastSpace 0)
(defvar counter 0)
(defvar startIndex 0 )
(defvar currIndex 0)
(defvar wordCount 0)
(defvar longest "")
(defvar shortest "")
(defvar longSize 0)
(defvar shortSize 100)
(defvar longLine 0)
(defvar shortLine 0)

	;Loops through entire formatted string to create lines
	(loop until (= currIndex (+ x 1))
		;Sets last space for purposes of cutting the string off when reaching 60
		do
		(cond((char= #\Space (aref longString currIndex))
			(setq lastSpace currIndex)
			(incf wordCount))
		)
		;Enters when 61 characters have been checked
		;(61 instead of 60 in case a word ends on 60)
		(cond((= counter 61)
			(format t "~8@A  ~A ~%" lineNumber (subseq longString startIndex lastSpace))

			;Checks to see if the line contains the least number of words
			(cond((<= wordCount shortSize)
				(setq shortest (subseq longString startIndex lastSpace))
				(setq shortLine lineNumber)
				(setq shortSize wordCount))
			)
			;Checks to see if the line contains the highest number of words
			(cond((>= wordCount longSize)
				(setq longest (subseq longString startIndex lastSpace))
				(setq longLine lineNumber)
				(setq longSize wordCount))
			)

			(setq counter 0)
			(setq currIndex lastSpace)
       		        (setq startIndex (+ lastSpace 1))
			(incf lineNumber)
			(setq wordCount 0)
		     )
		)
		;Handles a partial final line that doesn't reach 60 characters
		(cond((= currIndex x)
			(format t "~8@A  ~A ~%" lineNumber (subseq longString startIndex currIndex))

			;Checks to see if the line contains the least number of words
			(cond((<= wordCount shortSize)
                                (setq shortest (subseq longString startIndex currIndex))
                                (setq shortLine lineNumber)
                                (setq shortSize wordCount))
                        )
			;Checks to see if the line contains the highest number of words
                        (cond((>= wordCount longSize)
                                (setq longest (subseq longString startIndex currIndex))
                                (setq longLine lineNumber)
                                (setq longSize wordCount))
                        )
		     )

		)
		
		(incf counter)
		(incf currIndex)
	)
;Prints the longest and shortest line (wordcount)
;in the specified format
(format t "Long   ~11A  ~A ~%" longLine longest)
(format t "Short  ~11A  ~A ~%" shortLine shortest)

(terpri)
(close file)
































