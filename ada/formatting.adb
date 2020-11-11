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

	procedure stdPrint(currLine : in string; lineNum : in Integer) is
		temp,x: integer;
	begin
		x := 1;
		temp := 8 - (Integer'Image(lineNum)'Length);
		while x <= temp loop
			Ada.Text_IO.Put(" ");
			x := x + 1;
		end loop;
        	Ada.Text_IO.Put(Integer'Image(lineNum));
       		Ada.Text_IO.Put("  ");
        	Ada.Text_IO.Put_Line(currLine);
	end stdPrint;

	procedure longShortPrint(currLine : in string; lineNum : in Integer) is
		temp,x : Integer;
	begin
		x := 1;
		temp := 14-(Integer'Image(lineNum)'Length);
		Ada.Text_IO.Put(Integer'Image(lineNum));
		while x <= temp loop
			Ada.Text_IO.Put(" ");
			x := x + 1; 
		end loop;
		Ada.Text_IO.Put_Line(currLine);
	end longShortPrint;

	In_File : Ada.Text_IO.File_Type;
	value : Ada.Strings.Unbounded.Unbounded_String;
	longString : Ada.Strings.Unbounded.Unbounded_String;
	i,lineNum, lastSpace : integer;
	last, curr : character;
	currIndex, counter, startIndex : integer;
	currChar : character;
	wordCount, longLine, shortLine, shortSize, longSize : integer;
	longest, shortest : Ada.Strings.Unbounded.Unbounded_String;


begin

--Column header, can be uncommented out to be used
--Ada.Text_IO.Put_Line("123456789*123456789*123456789*123456789*123456789*123456789*123456789*");


	Ada.Text_IO.Open (File => In_File, Mode => Ada.Text_IO.In_File, Name => Argument(1));
 
	while not Ada.Text_IO.End_Of_File(In_File) loop
		Ada.Strings.Unbounded.Append(Source => longString, New_Item => Ada.Text_IO.Get_Line(File => In_File));
		Ada.Strings.Unbounded.Append(Source => longString, New_Item => (" "));
	end loop;

	i := 1;
	last := 'a';
	--Formats input to specified form
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
	lineNum := 1;
	currIndex := 1;
	counter :=1;
	startIndex := 1;
	wordCount := 0;
	longSize := 0;
	shortSize := 100;
	shortLine := 0;
	longLine := 0;

	--Loops through the entire formatted string
	while currIndex <= Ada.Strings.Unbounded.Length(LongString) loop 
		currChar := Ada.Strings.Unbounded.Element(longString, currIndex);
		if counter <= 61 then
			if (currChar = Character'Val(32)) then
				lastSpace := currIndex;
				wordCount := wordCount + 1;
			end if; 		
		end if;
		--Handles all lines except last line
		if counter = 61 then
			stdPrint(Ada.Strings.Unbounded.Slice(longString,startIndex,lastSpace),lineNum);

			--Checks to see if the line has the lowest word count
			if wordCount <= shortSize then
				shortest := Ada.Strings.Unbounded.Unbounded_Slice(longString, startIndex, lastSpace);
				shortLine := lineNum;
				shortSize := wordCount;	
			end if;
			--Checks to see if the line has the highest word count
			if wordCount >= longSize then
				longest := Ada.Strings.Unbounded.Unbounded_Slice(longString, startIndex, lastSpace);
				longLine := lineNum;
				longSize := wordCount;
			end if; 
			
			wordCount := 0;
			lineNum := lineNum + 1;
			currIndex := lastSpace;
			startIndex := lastSpace + 1;
			counter := 0;
		end if;
		--Handles last line
		if currIndex = Ada.Strings.Unbounded.Length(longString) then
			stdPrint(Ada.Strings.Unbounded.Slice(longString, startIndex, currIndex), lineNum);
			--Checks to see if the line has the lowest word count
			if wordCount <= shortSize then
                                shortest := Ada.Strings.Unbounded.Unbounded_Slice(longString, startIndex, currIndex);
                                shortLine := lineNum;
                                shortSize := wordCount;
                        end if;
			--Checks to see if the line has the highest word count
                        if wordCount >= longSize then
                                longest := Ada.Strings.Unbounded.Unbounded_Slice(longString, startIndex, currIndex);
                                longLine := lineNum;
                                longSize := wordCount;
                        end if;



		end if;

		currIndex := currIndex + 1;
		counter := counter + 1;	
	end loop;
--Prints the lines with the highest and lowest word count in 
--the specified format
Ada.Text_IO.Put("Long  ");
longShortPrint(Ada.Strings.Unbounded.To_String(longest), longLine); 	

Ada.Text_IO.Put("Short ");
longShortPrint(Ada.Strings.Unbounded.To_String(shortest), shortLine);

end formatting;














