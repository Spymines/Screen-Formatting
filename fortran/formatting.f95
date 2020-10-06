!Trevor Mines
!CSC 330
!Screen Formatting Project

program formatting

character(:), allocatable :: long_string
integer :: filesize
character(len = 50) :: filename

interface
        subroutine read_file(long_string, filesize, filename)
                character(:), allocatable :: long_string
                integer :: filesize
                character(len = 50) :: filename
        end subroutine getInput

end interface

call GET_COMMAND_ARGUMENT(1, filename)
call read_file(long_string, filesize, filename)


end program formatting



subroutine read_file(long_string, filesize, filename)
        


end subroutine read_file
