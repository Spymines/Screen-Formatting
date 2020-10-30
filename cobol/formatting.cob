        IDENTIFICATION DIVISION.
        PROGRAM-ID. formatting.
        
        ENVIRONMENT DIVISION.
        INPUT-OUTPUT SECTION.
        FILE-CONTROL.
                SELECT file ASSIGN TO command1
                        ORGANIZATION IS LINE SEQUENTIAL.

        DATA DIVISION.
        01 generalInput PIC(256).
        WORKING-STORAGE SECTION.
        01 command1 PIC X(50).
         
        PROCEDURE DIVISION.

        Begin.
                ACCEPT command1 FROM ARGUMENT-VALUE
                display command1

                OPEN INPUT file
                READ file
                        AT END MOVE 1 TO END-OF-FILE
                END READ
                
                IF END-OF-FILE = 1
                        CLOSE file
                END-IF

        STOP RUN.
