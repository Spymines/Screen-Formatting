!Trevor Mines
!CSC 330
!Screen Formatting Project

program formatting

character(:), allocatable :: long_string, currString
integer :: filesize, counter, lastSpace, lineNum, currIndex
integer :: startIndex, shortSize, longSize, longLine, shortLine
character(len = 60) ::longString, shortString
character(len = 50) :: filename

interface

        subroutine read_file(long_string, filesize, filename)
                character(:), allocatable :: long_string
                integer :: filesize
                character(len = 50) :: filename
        end subroutine read_file
       
        subroutine formatString(long_string, filesize, currString)
                character(*) :: long_string
                character(:), allocatable :: out, currString
                integer :: filesize
        end subroutine formatString

end interface

call GET_COMMAND_ARGUMENT(1, filename)
call read_file(long_string, filesize, filename)
call formatString(long_string, filesize, currString)

print*,&
"123456789*123456789*123456789*123456789*123456789*123456789*123456789*123456789*"
startIndex = 1
currIndex = 1
counter = 1
lineNum = 1
shortSize = 61
longSize = -1
do while (currIndex .le. len(currString))
        if(counter .le. 61) then
                if(currString(currIndex:currIndex) .eq. " ") then
                        lastSpace = currIndex
                end if
                counter = counter + 1 
        end if
        if(counter .eq. 62) then
                print *, lineNum, currString(startIndex:lastSpace-1)
                counter = 1

                lineLen = lastSpace -1 - startIndex
                if(lineLen .le. shortSize) then
                        shortString = currString(startIndex:lastSpace -1)
                        shortLine = lineNum 
                        shortSize = lineLen                       
                end if
                if(lineLen .ge. longSize) then
                        longString = currString(startIndex:lastSpace -1)
                        longLine = lineNum
                        longSize = lineLen
                end if

                lineNum = lineNum + 1
                currIndex = lastSpace
                startIndex = lastSpace + 1
        end if
        if(currIndex .eq. len(currString)) then
                print *, lineNum, currString(startIndex:currIndex)

                lineLen = currIndex -1 - startIndex
                if(lineLen .le. shortSize) then
                        shortString = currString(startIndex:lastSpace -1)
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
end do 

print*, "LONG", longLine, longString
print*, "SHORT", shortLine, shortString

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
        integer :: ascii
        character(:), allocatable :: currString

        counter = 0
        i = 1
        do while(i .le. filesize)
                ascii  = iachar(long_string(i:i))
                if (ascii .lt. 48 .or. ascii .gt. 57)  then
                        counter = counter + 1
                end if
                i = i + 1
        end do 
        allocate(character(counter) :: currString)
        i = 1
        currPos = 1
        do while(i .le. filesize)
                ascii = iachar(long_string(i:i))
                if (ascii .lt. 48 .or. ascii .gt. 57) then
                        if (ascii .eq. 10) then
                                currString(currPos:currPos) = " "
                        else
                                currString(currPos:currPos) = long_string(i:i)
                        end if
                        currPos = currPos + 1
                end if
                i = i + 1
        end do
end subroutine formatString



















