      * Trevor Mines
      * CSC 330 
      * Screen Formatting Project

        IDENTIFICATION DIVISION.
        PROGRAM-ID. formatting.
        
        ENVIRONMENT DIVISION.
        INPUT-OUTPUT SECTION.
        FILE-CONTROL.
               SELECT inputFile ASSIGN TO filename
                        ORGANIZATION IS SEQUENTIAL.

        DATA DIVISION.
        FILE SECTION.
        FD inputFile.
        01 currLine PIC X(5000000).
        WORKING-STORAGE SECTION.
        01 filename PIC X(256).
        01 command1 PIC X(50).
        01 END-OF-FILE PIC Z(1).
       
        01 point PIC Z(8).
        01 newString PIC X(5000000).
        01 word PIC X(100).
        01 currCount PIC Z(8).
        01 stringLength PIC Z(8).
        01 currLen PIC 9(8).
        01 totLen PIC 9(8).
        01 wordLen PIC 9(8).
        01 thisLine PIC X(60).
        01 sixtyone PIC 9(2).
        01 lineNum PIC 9(8).
        01 zip PIC 9(1).
        01 wordCount PIC 9(2).
        01 shortLen PIC 9(2).
        01 longLen PIC 9(2).
        01 shortLine PIC X(60).
        01 longLine PIC X(60).
        01 shortLineNum PIC 9(8).
        01 longLineNum PIC 9(8).

        PROCEDURE DIVISION CHAINING filename.

        Begin.
      *         Opens and retrieves the contents of the input file
                OPEN INPUT inputFile
                READ inputFile
                        AT END MOVE 1 TO END-OF-FILE
                END-READ
               
                IF END-OF-FILE = 1 
                        CLOSE inputFile
                END-IF

                MOVE 0 TO END-OF-FILE.

      *         Replaces all new line characters and numbers 
      *         with spaces so they can later be removed by looking
      *         for duplicate spaces
                INSPECT currLine REPLACING ALL X'0A' BY ' '
                INSPECT currLine CONVERTING "0123456789" to "          "
     

                MOVE 0 to currCount
                MOVE 1 to point
                MOVE 0 to totLen
                MOVE 0 to currLen
                MOVE 61 to sixtyone
                MOVE 1 to lineNum
                MOVE 0 to wordLen
                MOVE 0 to zip  

                MOVE 0 to wordCount
                MOVE 99 to shortLen
                MOVE 0 to longLen
                MOVE " " to shortLine
                MOVE " " to longLine

 
      *          DISPLAY "123456789*123456789*123456789*123456789*12345"
      *         "6789*123456789*123456789*"
                
                move FUNCTION LENGTH(FUNCTION TRIM(currLine)) to 
                        stringLength

      *         Loops through the string word by word
      *         As each word is pulled using UNSTRING it is checked
      *         to make sure it won't overflow the line, if it will
      *         then the line is printed and the word is added to the
      *         next line
                PERFORM UNTIL point >=  stringLength
 
                        UNSTRING currLine DELIMITED BY SPACE
                                INTO word
                                WITH POINTER point  
                                TALLYING IN currCount      

                        MOVE FUNCTION LENGTH(FUNCTION TRIM(word)) 
                                                        to wordLen     
                        ADD 1 to wordLen                        

                        if wordLen  not = 1             
      *                 Checks to see if the line would be too long
      *                 with the addition of the next word
                        if (currLen+wordLen) >  sixtyone
                                DISPLAY lineNum "  " FUNCTION 
                                                        TRIM(thisLine) 
      *                         Checks to see if the current line is the
      *                         line with the least amount of words
                                if wordCount <= shortLen
                                        MOVE wordCount to shortLen
                                        MOVE FUNCTION TRIM(thisLine) to
                                                               shortLine
                                        MOVE lineNum to shortLineNum
                                end-if
      *                         Checks to see if the current line is the
      *                         line with the highest amount of words
                                if wordCount >= longLen
                                        MOVE wordCount to longLen
                                        MOVE FUNCTION TRIM(thisLine) to 
                                                                longLine
                                        move lineNum to longLineNum
                                end-if 

                                ADD 1 to lineNum
      *                         Resets variables for next line
                                MOVE " " to thisLine
                                MOVE 0 to currLen
                                MOVE 0 to wordCount
                        END-IF

      *                 Appends the word to the line
                        STRING FUNCTION TRIM(thisLine) DELIMITED 
                                                        BY SIZE
                                SPACE
                                FUNCTION TRIM(word) DELIMITED BY SIZE
                                INTO thisLine

                        Add wordLen to currLen
                        MOVE 0 to wordLen 
                        ADD 1 to wordCount

                        END-IF
                END-PERFORM

      *         Prints the long and short lines in the specified format
                DISPLAY "LONG   " longLineNum "     " longLine
                DISPLAY "Short  " shortLineNum "     " shortLine   
  
                CLOSE inputFile
        STOP RUN.
