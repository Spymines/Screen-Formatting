#!/usr/bin/sbcl --script

(defvar file)
(defvar line)
(string fullText)

(setq file (open "/pub/pounds/CSC330/translations/KJV.txt" ) )

      (loop for line = (read-line file nil :eof) ; stream, no error, :eof value
                  until (eq line :eof)
                        do (concatenate fullText line )
      )

(close file)
