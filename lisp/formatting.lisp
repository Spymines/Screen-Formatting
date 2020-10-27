#!/usr/bin/sbcl --script

(defvar file)
(defvar line)
(setq lineCount 0)

(setq file (open (car(cdr *posix-argv* ) )))

      (loop for line = (read-line file nil :eof) ; stream, no error, :eof value
                  until (eq line :eof)
                        do
			(write-line line)
			(incf lineCount)
      )

(print lineCount)
(terpri)
(close file)
