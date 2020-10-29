#!/usr/bin/sbcl --script

(defvar file)
(defvar curr)
(defvar lineCount)
(setq lineCount 0)
(defvar words)
(defvar x 0)
(defvar prev)
(setq prev #\p)

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
				(cond ((char/= curr #\NewLine)
					(setf (aref longString x) curr)
					(incf x))
					;Case 2       
					((char= curr #\NewLine)
					(setf (aref longString x) #\Space)
					(incf x))
				)	
		  	      )
			)
      	)

(print longString)
;(print lineCount)
(terpri)
(close file)
