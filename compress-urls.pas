PROGRAM Compress_Urls;

//	This script is part of the url-compressor project (https://github.com/adbar/url-compressor).
//	It is brought to you by Adrien Barbaresi.
//	It is freely available under the GNU GPL v3 license (http://www.gnu.org/licenses/gpl.html).

var
  Input, Output: Text;
  i, flag, test, level, code: Integer;
  url: AnsiString;
  suburl: AnsiString;
  Positions: array[0..100] of Byte;
  Patterns: array[0..100] of String;
  Dropin: array[0..100] of String;


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
			IF (suburl = 'http://blog.') THEN
				BEGIN
				suburl := 'Ô';
				flag := 1;
				END
			ELSE IF (suburl = 'http://t.co/') THEN
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
				END
			ELSE IF (suburl = 'http://ow.ly/') THEN
				BEGIN
				suburl := 'X';
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
		//ELSE IF (i = 23) AND (flag = 0) THEN
		//	BEGIN
		//	IF (suburl = 'http://arstechnica.com/') THEN
		//		BEGIN
		//		suburl := 'U';
		//		flag := 1;
		//		END;
		//	END
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

	IF (level = 2) THEN
		BEGIN

		// Delete url parameters
		//test := AnsiPos('?utm_', suburl);
		//if (test > 0) THEN
		//	delete(suburl, test, length(suburl)-test);

		// TO DO : highest frequency first, read pattern list from file
		// With or without '/' ?
		Patterns[0] := '.wordpress.com'; 	Positions[0] := 14;	Dropin[0] := 'ÿ'; //*W
		Patterns[1] := '.wikipedia.org/wiki/'; 	Positions[1] := 20;	Dropin[1] := 'û'; //*V
		Patterns[2] := '.blogspot.com';	 	Positions[2] := 13;	Dropin[2] := 'þ'; //*B
		Patterns[3] := '.google.com/';	 	Positions[3] := 12;	Dropin[3] := '©'; //*G
		Patterns[4] := '.posterous.com/';	Positions[4] := 15;	Dropin[4] := '£'; //*S
		Patterns[5] := '.com';	 		Positions[5] := 4;	Dropin[5] := '¹'; //*C
		Patterns[6] := '.org';	 		Positions[6] := 4;	Dropin[6] := 'ô'; //*O
		Patterns[7] := '.net';	 		Positions[7] := 4;	Dropin[7] := 'µ'; //*N
		Patterns[8] := '.de';	 		Positions[8] := 3;	Dropin[8] := 'É'; //*N

		FOR i:= 0 to 8 DO
			BEGIN
			test := AnsiPos(Patterns[i], suburl);
			IF (test > 0) THEN
				BEGIN
				delete(suburl, test, Positions[i]);
				insert(Dropin[i], suburl, test);
				BREAK;
				END;
			END;

		Patterns[10] := '.php';	 		Positions[10] := 4;	Dropin[10] := '×'; //*P
		Patterns[11] := '.html';	 	Positions[11] := 5;	Dropin[11] := 'ð'; //*H

		FOR i:= 10 to 11 DO
			BEGIN
			test := AnsiPos(Patterns[i], suburl);
			IF (test > 0) THEN
				BEGIN
				delete(suburl, test, Positions[i]);
				insert(Dropin[i], suburl, test);
				BREAK;
				END;
			END;

		Patterns[20] := '2012/0';	 	Positions[20] := 6;	Dropin[20] := 'ø';
		Patterns[21] := '2012'; 		Positions[21] := 4;	Dropin[21] := 'Ð';
		Patterns[22] := '2011/0';	 	Positions[22] := 6;	Dropin[22] := '¿';
		Patterns[23] := '2011';	 		Positions[23] := 4;	Dropin[23] := '¡';
		Patterns[24] := '2010/0';	 	Positions[24] := 6;	Dropin[24] := '÷';
		Patterns[25] := '2010';	 		Positions[25] := 4;	Dropin[25] := 'õ';
		Patterns[26] := '2009/0';	 	Positions[26] := 6;	Dropin[26] := '>';
		Patterns[27] := '2009';	 		Positions[27] := 4;	Dropin[27] := '`';
		Patterns[28] := '2008/0';	 	Positions[28] := 6;	Dropin[28] := '²';
		Patterns[29] := '2008';	 		Positions[29] := 4;	Dropin[29] := '«';
		Patterns[30] := '200';	 		Positions[30] := 3;	Dropin[30] := '»';

		// /10/ /11/ /12/ ?

		FOR i:= 20 to 30 DO
			BEGIN
			test := AnsiPos(Patterns[i], suburl);
			IF (test > 0) THEN
				BEGIN
				delete(suburl, test, Positions[i]);
				insert(Dropin[i], suburl, test);
				test := AnsiPos(Dropin[i], suburl);
				IF (test > 0) THEN
					BEGIN
					delete(suburl, test, 1);
					insert(Patterns[i], suburl, test);
					END;
				BREAK;
				END;
			END;

		Patterns[40] := 'index';	 	Positions[40] := 5;	Dropin[40] := 'î'; //*I
		Patterns[41] := 'article';		Positions[41] := 7;	Dropin[41] := 'æ'; //*A
		Patterns[42] := 'archive';	 	Positions[42] := 7;	Dropin[42] := 'â'; //*a

		FOR i:= 40 to 42 DO
			BEGIN
			test := AnsiPos(Patterns[i], suburl);
			IF (test > 0) THEN
				BEGIN
				delete(suburl, test, Positions[i]);
				insert(Dropin[i], suburl, test);
				BREAK;
				END;
			END;

		Patterns[50] := 'blog';	 	Positions[50] := 4;	Dropin[50] := '¨';
		Patterns[51] := 'news';		Positions[51] := 4;	Dropin[51] := '¶';
		Patterns[52] := '/statuses/';	Positions[52] := 10;	Dropin[52] := 'Æ';
		Patterns[53] := '/post/';	Positions[53] := 6;	Dropin[53] := '¥';
		Patterns[54] := '/content/';	Positions[54] := 9;	Dropin[54] := 'Ç';

		FOR i:= 50 to 54 DO
			BEGIN
			test := AnsiPos(Patterns[i], suburl);
			IF (test > 0) THEN
				BEGIN
				delete(suburl, test, Positions[i]);
				insert(Dropin[i], suburl, test);
				BREAK;
				END;
			END;

		test := AnsiPos('ation', suburl);
		IF (test > 0) THEN
			BEGIN
			delete(suburl, test, 5);
			insert('ß', suburl, test);
			END;
		test := AnsiPos('tion', suburl);
		IF (test > 0) THEN
			BEGIN
			delete(suburl, test, 4);
			insert('¢', suburl, test);
			END;

		END;
	WriteLn (Output, suburl)
  END;
  Close (Input);
  Close (Output);
END.     
