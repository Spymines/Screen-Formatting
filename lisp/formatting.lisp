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

;(defvar input)
;(setq input '())

(defvar longString)

(write-line "123456789*123456789*123456789*123456789*123456789*123456789*123456789*")


(setq file (open (car(cdr *posix-argv* ) )))

(setf longString(make-string(file-length file)))

      	(loop for curr = (read-char file nil :eof) ; stream, no error, :eof value
                  until (eq curr :eof)
                        do
			(cond ((or (char> curr #\9) (char< curr #\0)) 
				(cond ((and (char/= curr #\NewLine)(char/= curr #\Space))
					(setf (aref longString x) curr)
					(incf x)
					(setq prev curr))
					
					;Case 2       
					((and(char= curr #\NewLine)(char/= prev #\Space)) 
					(setf (aref longString x) #\Space)
					(incf x)
					(setq prev #\Space))

					;Case 3	
					((and (char= curr #\Space)(char= prev #\Space))
					(setq prev #\Space))

					;Case 4
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

	(loop until (= currIndex (+ x 1))
		do
		(cond((char= #\Space (aref longString currIndex))
			(setq lastSpace currIndex)
			(incf wordCount))
		)
		(cond((= counter 61)
			(format t "~8@A  ~A ~%" lineNumber (subseq longString startIndex lastSpace))

			(cond((<= wordCount shortSize)
				(setq shortest (subseq longString startIndex lastSpace))
				(setq shortLine lineNumber)
				(setq shortSize wordCount))
			)
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
		(cond((= currIndex x)
			(format t "~8@A  ~A ~%" lineNumber (subseq longString startIndex currIndex))

			(cond((<= wordCount shortSize)
                                (setq shortest (subseq longString startIndex currIndex))
                                (setq shortLine lineNumber)
                                (setq shortSize wordCount))
                        )
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
(format t "Long   ~11A  ~A ~%" longLine longest)
(format t "Short  ~11A  ~A ~%" shortLine shortest)

(terpri)
(close file)
































