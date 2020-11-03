!Trevor Mines
!CSC 330
!Screen Formatting Project

!My program loops through finding spaces rather than tokenizing the input.
!The input is checked char by char and when a space is found it's location
!is noted. When 61 chars have been checked (61 is checked to see if a word ends
!on 60) the line is printed from it's start to the last space found.


program formatting

character(:), allocatable :: long_string, currString
integer :: filesize, counter, lastSpace, lineNum, currIndex
integer :: startIndex, shortSize, longSize, longLine, shortLine
character(len = 61) ::longString, shortString
character(len = 50) :: filename
character(len = 12) :: longNum, shortNum

interface

        subroutine read_file(long_string, filesize, filename)
                character(:), allocatable :: long_string
                integer :: filesize
                character(len = 50) :: filename
        end subroutine read_file
       
        subroutine formatString(long_string, filesize, currString)
                character(*) :: long_string
                character(:), allocatable :: out,tempString, currString
                integer :: filesize, last, duplicates
        end subroutine formatString

        integer function countWords(line) result(out)
                character(*) :: line
                integer :: i, ascii, last
        end function countWords

end interface

call GET_COMMAND_ARGUMENT(1, filename)
call read_file(long_string, filesize, filename)
call formatString(long_string, filesize, currString)

!Column marker that can be uncommented if needed
!write(*,"(a80)")&
!"123456789*123456789*123456789*123456789*123456789*123456789*123456789*123456789*"

startIndex = 1
currIndex = 1
counter = 1
lineNum = 1
shortSize = 61
longSize = -1

!Loops through the string while currIndex != the length of the string
do while (currIndex .le. len(currString))
         !Sets last space if a space is found at the current location
         if(counter .le. 62) then
                if(currString(currIndex:currIndex) .eq. " ") then
                        lastSpace = currIndex
                end if 
        end if
        !Outputs the line and checks to see if it is the longest or shortest
        if(counter .eq. 62) then
                write(*, "(i8, a1)",advance="no") lineNum, ""
                print*, currString(startIndex:lastSpace-1)
                counter = 1

                lineLen = countWords(currString(startIndex:lastSpace-1))
                if(lineLen .le. shortSize) then
                        shortString = currString(startIndex:lastSpace -1)
                        shortLine = lineNum 
                        shortSize = lineLen                       
                end if
                if(lineLen .ge. longSize) then
                        longString = currString(startIndex:lastSpace-1)
                        longLine = lineNum
                        longSize = lineLen
                end if
                lineNum = lineNum + 1
                currIndex = lastSpace
                startIndex = lastSpace + 1
        end if
        !Prints last line and checks to see if it is longest or shortest when
        !the end of the file is reached
        if(currIndex .eq. len(currString)) then
                write(*,"(i8, a1)", advance="no") lineNum, ""
                print*, currString(startIndex:currIndex)

                lineLen = countWords(currString(startIndex:lastSpace-1))
                if(lineLen .le. shortSize) then
                        shortString = currString(startIndex:len(currString))
                        shortLine = lineNum
                        shortSize = lineLen
                end if
                if(lineLen .ge. longSize) then
                        longString = currString(startIndex:lastSpace -1)
                        longLine = lineNum
                        longSize = lineLen
                end if

        end if
        currIndex = currIndex + 1
        counter = counter + 1
end do 

!Converts line numbers to strings for printing
write(longNum,*) longLine
write(shortNum,*) shortLine

!Printing of long and short information
write(*,"(a4,a3,a12,a1,a61)") "LONG","", adjustl(longNum),"", longString
write(*,"(a5,a2,a12,a1,a61)") "SHORT","", adjustl(shortNum),"", shortString

end program formatting


!Reads in the contents of the file specified on the command line
!and puts it in long_string
subroutine read_file(long_string, filesize, filename)
        character(:), allocatable :: long_string
        integer :: filesize, counter
        character(len = 50) :: filename
        character(len = 1) :: input

        inquire (file = filename, size = filesize)
        open (unit=5,status="old",access="direct",form="unformatted",recl=1,file= filename)
        allocate(character(filesize) :: long_string)
        
        counter = 1
        100 read(5,rec=counter,err=200) input        
                long_string(counter:counter) = input
                counter = counter + 1
                goto 100
        200 continue
        counter = counter - 1
        close(5)
end subroutine read_file


!Removes all numbers and replaces new line characters with spaces
subroutine formatString(long_string, filesize, currString)
        character(*) :: long_string
        integer :: filesize, counter, i, currPos
        integer :: ascii, last, duplicates, curr
        character(:), allocatable :: tempString,currString


        counter = 0
        i = 1
        do while(i .le. filesize)
                ascii  = iachar(long_string(i:i))
                if (ascii .lt. 48 .or. ascii .gt. 57)  then
                        counter = counter + 1
                end if
                i = i + 1
        end do 
        allocate(character(counter) :: tempString)
        i = 1
        currPos = 1
        do while(i .le. filesize)
                ascii = iachar(long_string(i:i))
                if (ascii .lt. 48 .or. ascii .gt. 57) then
                        if (ascii .eq. 10) then
                                tempString(currPos:currPos) = " "
                        else
                                tempString(currPos:currPos) = long_string(i:i)
                        end if
                        currPos = currPos + 1
                end if
                i = i + 1
        end do


        !Remove duplicate spaces
        duplicates = 0
        i = 0
        last = 0
        do while(i .lt. counter)
                ascii = iachar(tempString(i:i))
                if(ascii .eq. 32 .and. last .eq. 32) then
                        duplicates = duplicates + 1
                end if
                last = ascii
                i = i + 1
        end do
        

        i = 0
        last = 0
        curr = 1
        allocate(character(len(tempString)-duplicates) :: currString)
        !Rewrite the long_string removing extra spaces
        do while(i .le. (len(tempString))) 
                ascii = iachar(tempString(i:i))
                if (ascii .ne. 32)then
                        currString(curr:curr) = tempString(i:i)
                        curr = curr + 1
                else if (last .ne. 32)then
                        currString(curr:curr) = tempString(i:i)
                        curr = curr + 1
                end if
                i = i + 1
                last = ascii
        end do

end subroutine formatString

!Returns the number of words in the string that is passed in
integer function countWords(line) result(out)
        character(*) :: line
        integer :: i, ascii, last 
        i = 0
        out = 0
        last = 32
        do while (i .lt. len(line))
                ascii = iachar(line(i:i))
                if(ascii .eq. 32 .and. last .ne. 32) then 
                        out = out + 1
                end if
                i = i + 1
                last = ascii 
        end do 
        !Add one to out to account for the last word in the line
        out = out + 1

end function countWords




