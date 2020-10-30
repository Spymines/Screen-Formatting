--Trevor Mines
--CSC 330
--Screen Formatting Project

with Ada.IO_Exceptions;
use Ada.IO_Exceptions;

with Ada.Strings.Unbounded;
use Ada.Strings.Unbounded; 

with Ada.Text_IO.Unbounded_IO;
use Ada.Text_IO.Unbounded_IO;

with Ada.Text_IO;
use Ada.Text_IO;

with Ada.Command_Line;
use Ada.Command_Line;

with Ada.Characters.Handling; 
use Ada.Characters.Handling;


procedure formatting is

	In_File : Ada.Text_IO.File_Type;
	value : Ada.Strings.Unbounded.Unbounded_String;
	longString : Ada.Strings.Unbounded.Unbounded_String;
	i, lineNum, lastSpace, location : integer;
	last, curr : character;

begin

	Ada.Text_IO.Open (File => In_File, Mode => Ada.Text_IO.In_File, Name => Argument(1));
 
	while not Ada.Text_IO.End_Of_File(In_File) loop
		Ada.Strings.Unbounded.Append(Source => longString, New_Item => Ada.Text_IO.Get_Line(File => In_File));
		Ada.Strings.Unbounded.Append(Source => longString, New_Item => (" "));
	end loop;

	i := 1;
	last := 'a';
	while i <= Ada.Strings.Unbounded.Length(longString) loop
		--Gets Current Character
		curr := Ada.Strings.Unbounded.Element(longString, i);
		--Loops through and removes extra spaces and numbers
		if (last = ' ' and curr = ' ') or (Ada.Characters.Handling.Is_Digit(curr)) then
			Ada.Strings.Unbounded.Delete(longString, i, i);
			i := i - 1; 
		else 
			last := curr;	
		end if;		
		i := i + 1;
	end loop;

	lastSpace := 0;
	location := 1; 
	i := 1;
	lineNum := 1;
	while i <= Ada.Strings.Unbounded.Length(LongString) 
			


	Ada.Text_IO.Unbounded_IO.Put_Line(longString);
	
end formatting;






