        IDENTIFICATION DIVISION.
        PROGRAM-ID. formatting.
        
        ENVIRONMENT DIVISION.
        INPUT-OUTPUT SECTION.
        FILE-CONTROL.
               SELECT inputFile ASSIGN TO "../fortran/test.txt"
                        ORGANIZATION IS LINE SEQUENTIAL.

        DATA DIVISION.
        FILE SECTION.
        FD inputFile.
        01 currLine PIC X(256).
        WORKING-STORAGE SECTION.
        01 command1 PIC X(50).
        01 END-OF-FILE PIC Z(1).
         
        PROCEDURE DIVISION.

        Begin.
                ACCEPT command1 FROM ARGUMENT-VALUE
                display command1

                OPEN INPUT inputFile
                READ inputFile
                        AT END MOVE 1 TO END-OF-FILE
                END-READ
               
                IF END-OF-FILE = 1 
                        CLOSE inputFile
                END-IF

                MOVE 0 TO END-OF-FILE.

                PERFORM UNTIL END-OF-FILE = 1
                        DISPLAY currLine
                        READ inputFile
                                AT END MOVE 1 TO END-OF-FILE
                        END-READ
                END-PERFORM
                CLOSE inputFile
        STOP RUN.
