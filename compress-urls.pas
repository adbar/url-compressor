PROGRAM Compress_Urls;

//	This script is part of the url-compressor project (https://github.com/adbar/url-compressor).
//	It is brought to you by Adrien Barbaresi.
//	It is freely available under the GNU GPL v3 license (http://www.gnu.org/licenses/gpl.html).

var
  Input, Output: Text;
  i, flag, test, level, code: Integer; //test2,
  url: AnsiString;
  suburl: AnsiString;
  Positions: array[0..30] of Byte;
  Patterns: array[0..30] of String;
  Dropin: array[0..30] of String;

BEGIN

IF (ParamCount <> 3) THEN
  BEGIN
  WriteLn('Incorrect parameter number : one input file, one output file and one level only');
  halt;
  END;
val(ParamStr(3), level, code);
IF (code <> 0) THEN
  BEGIN
  WriteLn('Incorrect compression level : can only be 1 or 2');
  halt;
  END;
IF (level < 1) OR (level > 2) THEN
  BEGIN
  WriteLn('Incorrect compression level : can only be 1 or 2');
  halt;
  END;

  Assign (Input, ParamStr(1));
  Reset (Input);
  Assign (Output, ParamStr(2));
  Rewrite (Output);

  WHILE NOT EOF (Input) DO
	BEGIN
	ReadLn (Input, url);
	flag := 0; suburl := '';
	FOR i := 1 to length(url) DO
		BEGIN
		suburl := Concat (suburl, url[i]);
		IF (i = 12) AND (flag = 0) THEN
			BEGIN
			IF (suburl = 'http://t.co/') THEN
				BEGIN
				suburl := 'A';
				flag := 1;
				END
			ELSE IF (suburl = 'http://j.mp/') THEN
				BEGIN
				suburl := 'B';
				flag := 1;
				END;
			END
		ELSE IF (i = 13) AND (flag = 0) THEN
			BEGIN
			IF (suburl = 'http://is.gd/') THEN
				BEGIN
				suburl := 'C';
				flag := 1;
				END
			ELSE IF (suburl = 'http://wp.me/') THEN
				BEGIN
				suburl := 'D';
				flag := 1;
				END;
			END
		ELSE IF (i = 14) AND (flag = 0) THEN
			BEGIN
			IF (suburl = 'http://bit.ly/') THEN
				BEGIN
				suburl := 'E';
				flag := 1;
				END
			ELSE IF (suburl = 'http://goo.gl/') THEN
				BEGIN
				suburl := 'F';
				flag := 1;
				END
			ELSE IF (suburl = 'http://xrl.us/') THEN
				BEGIN
				suburl := 'G';
				flag := 1;
				END
			ELSE IF (suburl = 'http://ur1.ca/') THEN
				BEGIN
				suburl := 'I';
				flag := 1;
				END
			ELSE IF (suburl = 'http://b1t.it/') THEN
				BEGIN
				suburl := 'M';
				flag := 1;
				END;
			END
		ELSE IF (i = 15) AND (flag = 0) THEN
			BEGIN
			IF (suburl = 'http://dlvr.it/') THEN
				BEGIN
				suburl := 'J';
				flag := 1;
				END
			ELSE IF (suburl = 'http://ping.fm/') THEN
				BEGIN
				suburl := 'P';
				flag := 1;
				END
			ELSE IF (suburl = 'http://post.ly/') THEN
				BEGIN
				suburl := 'R';
				flag := 1;
				END;
			END
		ELSE IF (i = 16) AND (flag = 0) THEN
			BEGIN
			IF (suburl = 'http://youtu.be/') THEN
				BEGIN
				suburl := 'K';
				flag := 1;
				END
			ELSE IF (suburl = 'http://on.fb.me/') THEN
				BEGIN
				suburl := 'L';
				flag := 1;
				END;
			END
		ELSE IF (i = 18) AND (flag = 0) THEN
			BEGIN
			IF (suburl = 'http://p.ost.im/p/') THEN
				BEGIN
				suburl := 'O';
				flag := 1;
				END;
			END
		ELSE IF (i = 19) AND (flag = 0) THEN
			BEGIN
			IF (suburl = 'http://tinyurl.com/') THEN
				BEGIN
				suburl := 'T';
				flag := 1;
				END;
			END
		ELSE IF (i = 22) AND (flag = 0) THEN
			BEGIN
			IF (suburl = 'http://friendfeed.com/') THEN
				BEGIN
				suburl := 'V';
				flag := 1;
				END;
			END
		ELSE IF (i = 23) AND (flag = 0) THEN
			BEGIN
			IF (suburl = 'http://arstechnica.com/') THEN
				BEGIN
				suburl := 'U';
				flag := 1;
				END;
			END
		ELSE IF (i = 31) AND (flag = 0) THEN
			BEGIN
			IF (suburl = 'http://www.youtube.com/watch?v=') THEN
				BEGIN
				suburl := 'Y';
				flag := 1;
				END;
			END
		ELSE IF (i = 32) AND (flag = 0) THEN
			BEGIN
			IF (suburl = 'https://www.youtube.com/watch?v=') THEN
				BEGIN
				suburl := 'Z';
				flag := 1;
				END;
			END;
		END;
	IF (flag = 0) THEN
		BEGIN
		suburl := '';
		FOR i := 1 to length(url) DO
			BEGIN
			suburl := Concat (suburl, url[i]);
			IF (i = 11) THEN
				BEGIN
				IF (suburl = 'http://www.') THEN
					BEGIN
					suburl := 'W';
					flag := 1;
					END;
				END
			ELSE IF (i = 12) THEN
				BEGIN
				IF (suburl = 'https://www.') THEN
					BEGIN
					suburl := 'Q';
					flag := 1;
					END;
				END;
			END;
				
		END;
	IF (flag = 0) THEN
		BEGIN
		suburl := '';
		FOR i := 1 to length(url) DO
			BEGIN
			suburl := Concat (suburl, url[i]);
			IF (i = 7) THEN
				BEGIN
				IF (suburl = 'http://') THEN
					BEGIN
					suburl := 'H';
					END;
				END
			ELSE IF (i = 8) THEN
				BEGIN
				IF (suburl = 'https://') THEN
					BEGIN
					suburl := 'S';
					END;
				END;
			END;	
		END;
	IF (level = 1) THEN
		WriteLn (Output, suburl)
	ELSE IF (level = 2) THEN
		BEGIN

		// Delete url parameters
		//test := pos('?utm_', suburl);
		//if (test > 0) THEN
		//	delete(suburl, test, length(suburl)-test);

		// TO DO : highest frequency first, read pattern list from file
		// With or without '/' ?
		Patterns[0] := '.wordpress.com'; 	Positions[0] := 14;	Dropin[0] := '*W';
		Patterns[1] := '.wikipedia.org/wiki/'; 	Positions[1] := 20;	Dropin[1] := '*V';
		Patterns[2] := '.blogspot.com';	 	Positions[2] := 13;	Dropin[2] := '*B';
		Patterns[3] := '.google.com/';	 	Positions[3] := 12;	Dropin[3] := '*G';
		Patterns[4] := '.posterous.com/';	Positions[4] := 15;	Dropin[4] := '*S';
		Patterns[5] := '.com';	 		Positions[5] := 4;	Dropin[5] := '*C';
		Patterns[6] := '.org';	 		Positions[6] := 4;	Dropin[6] := '*O';
		Patterns[7] := '.net';	 		Positions[7] := 4;	Dropin[7] := '*N';
		Patterns[8] := '.php';	 		Positions[8] := 4;	Dropin[8] := '*P';
		Patterns[9] := '.html';	 		Positions[9] := 5;	Dropin[9] := '*H';

		FOR i:= 0 to 9 DO
			BEGIN
			test := pos(Patterns[i], suburl);
			IF (test > 0) THEN
				BEGIN
				delete(suburl, test, Positions[i]);
				insert(Dropin[i], suburl, test);
				BREAK;
				END;
			END;

		Patterns[10] := '2012';	 		Positions[10] := 4;	Dropin[10] := '°2';
		Patterns[11] := '2011';	 		Positions[11] := 4;	Dropin[11] := '°1';
		Patterns[12] := '2010';	 		Positions[12] := 4;	Dropin[12] := '°0';
		Patterns[13] := '2009';	 		Positions[13] := 4;	Dropin[13] := '°9';
		Patterns[14] := '2008';	 		Positions[14] := 4;	Dropin[14] := '°8';

		FOR i:= 10 to 14 DO
			BEGIN
			test := pos(Patterns[i], suburl);
			IF (test > 0) THEN
				BEGIN
				//test2 := pos(concat(Patterns[i], '/0'), suburl);
				//IF (test > 0) THEN
				//	BEGIN
				//	delete(suburl, test, Positions[i]);
				//	insert(Dropin[i], suburl, test);
				//	END
				//ELSE
				//	BEGIN
					//dec(test);
					delete(suburl, test, Positions[i]);
					insert(Dropin[i], suburl, test);
				//	END;
				BREAK;
				END;
			END;

		//Patterns[15] := 'index';	 	Positions[15] := 5;	Dropin[15] := '*I';
		//Patterns[16] := 'article';		Positions[16] := 7;	Dropin[16] := '*A';
		//Patterns[17] := 'archive';	 	Positions[17] := 7;	Dropin[17] := '*a';

		//FOR i:= 15 to 17 DO
		//	BEGIN
		//	test := pos(Patterns[i], suburl);
		//	IF (test > 0) THEN
		//		BEGIN
		//		delete(suburl, test, Positions[i]);
		//		insert(Dropin[i], suburl, test);
		//		BREAK;
		//		END;
		//	END;
		
		// index.php
		// .co.cc 
		WriteLn (Output, suburl)
		END;
  END;
  Close (Input);
  Close (Output);
END.     
