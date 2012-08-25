PROGRAM Decompress_Urls;

//	This script is part of the url-compressor project (https://github.com/adbar/url-compressor).
//	It is brought to you by Adrien Barbaresi.
//	It is freely available under the GNU GPL v3 license (http://www.gnu.org/licenses/gpl.html).


{$codepage UTF-8}

uses
  SysUtils;

var
  Input, Output: Text;
  i, test, level, code: Integer;
  url: AnsiString;
  suburl: AnsiString;
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
  WriteLn('Incorrect decompression level : can only be 1 or 2');
  halt;
  END;
IF (level < 1) OR (level > 2) THEN
  BEGIN
  WriteLn('Incorrect decompression level : can only be 1 or 2');
  halt;
  END;
  Assign (Input, ParamStr(1));
  Reset (Input);
  Assign (Output, ParamStr(2));
  Rewrite (Output);

  WHILE NOT EOF (Input) DO
	BEGIN
	ReadLn (Input, url);
	suburl := '';
	FOR i := 1 to length(url) DO
		BEGIN
		suburl := Concat (suburl, url[i]);
		IF (i = 1) THEN
			BEGIN
			// TO DO : order by frequency
			IF (suburl = 'A') THEN
				BEGIN
				suburl := 'http://t.co/';
				END
			ELSE IF (suburl = 'B') THEN
				BEGIN
				suburl := 'http://j.mp/';
				END
			ELSE IF (suburl = 'C') THEN
				BEGIN
				suburl := 'http://is.gd/';
				END
			ELSE IF (suburl = 'D') THEN
				BEGIN
				suburl := 'http://wp.me/';
				END
			ELSE IF (suburl = 'E') THEN
				BEGIN
				suburl := 'http://bit.ly/';
				END
			ELSE IF (suburl = 'F') THEN
				BEGIN
				suburl := 'http://goo.gl/';
				END
			ELSE IF (suburl = 'G') THEN
				BEGIN
				suburl := 'http://xrl.us/';
				END
			ELSE IF (suburl = 'I') THEN
				BEGIN
				suburl := 'http://ur1.ca/';
				END
			ELSE IF (suburl = 'J') THEN
				BEGIN
				suburl := 'http://dlvr.it/';
				END
			ELSE IF (suburl = 'K') THEN
				BEGIN
				suburl := 'http://youtu.be/';
				END
			ELSE IF (suburl = 'L') THEN
				BEGIN
				suburl := 'http://on.fb.me/';
				END
			ELSE IF (suburl = 'M') THEN
				BEGIN
				suburl := 'http://b1t.it/';
				END
			ELSE IF (suburl = 'O') THEN
				BEGIN
				suburl := 'http://p.ost.im/p/';
				END
			ELSE IF (suburl = 'Ô') THEN
				BEGIN
				suburl := 'http://blog.';
				END
			ELSE IF (suburl = 'P') THEN
				BEGIN
				suburl := 'http://ping.fm/';
				END
			ELSE IF (suburl = 'R') THEN
				BEGIN
				suburl := 'http://post.ly/';
				END
			ELSE IF (suburl = 'T') THEN
				BEGIN
				suburl := 'http://tinyurl.com/';
				END
			//ELSE IF (suburl = 'U') THEN
			//	BEGIN
			//	suburl := 'http://arstechnica.com/';
			//	END
			ELSE IF (suburl = 'V') THEN
				BEGIN
				suburl := 'http://friendfeed.com/';
				END
			ELSE IF (suburl = 'X') THEN
				BEGIN
				suburl := 'http://ow.ly/';
				END
			ELSE IF (suburl = 'Y') THEN
				BEGIN
				suburl := 'http://www.youtube.com/watch?v=';
				END
			ELSE IF (suburl = 'Z') THEN
				BEGIN
				suburl := 'https://www.youtube.com/watch?v=';
				END
			// the rest
			ELSE IF (suburl = 'W') THEN
				BEGIN
				suburl := 'http://www.';
				END
			ELSE IF (suburl = 'Q') THEN
				BEGIN
				suburl := 'https://www.';
				END
			ELSE IF (suburl = 'H') THEN
				BEGIN
				suburl := 'http://';
				END
			ELSE IF (suburl = 'S') THEN
				BEGIN
				suburl := 'https://';
				END;
			END;
		END;
	
	IF (level = 2) THEN
		BEGIN
		// TO DO : highest frequency first, read from file ?
		// With or without '/' ?
		Patterns[0] := '.wordpress.com'; 	Dropin[0] := 'ÿ'; //*W
		Patterns[1] := '.wikipedia.org/wiki/'; 	Dropin[1] := 'û'; //*V
		Patterns[2] := '.blogspot.com';	 	Dropin[2] := 'þ'; //*B
		Patterns[3] := '.google.com/';	 	Dropin[3] := '©'; //*G
		Patterns[4] := '.posterous.com/';	Dropin[4] := '£'; //*S
		Patterns[5] := '.com';	 		Dropin[5] := '¹'; //*C
		Patterns[6] := '.org';	 		Dropin[6] := 'ô'; //*O
		Patterns[7] := '.net';	 		Dropin[7] := 'µ'; //*N
		Patterns[8] := '.de';	 		Dropin[8] := 'É'; //*N

		FOR i:= 0 to 8 DO
			BEGIN
			test := AnsiPos(Dropin[i], suburl);
			IF (test > 0) THEN
				BEGIN
				delete(suburl, test, 1);
				insert(Patterns[i], suburl, test);
				BREAK;
				END;
			END;

		Patterns[10] := '.php';	 	Dropin[10] := '×'; //*P
		Patterns[11] := '.html';	Dropin[11] := 'ð'; //*H

		FOR i:= 10 to 11 DO
			BEGIN
			test := AnsiPos(Dropin[i], suburl);
			IF (test > 0) THEN
				BEGIN
				delete(suburl, test, 1);
				insert(Patterns[i], suburl, test);
				BREAK;
				END;
			END;

		Patterns[20] := '2012/0';	Dropin[20] := 'ø';
		Patterns[21] := '2012'; 	Dropin[21] := 'Ð';
		Patterns[22] := '2011/0';	Dropin[22] := '¿';
		Patterns[23] := '2011';	 	Dropin[23] := '¡';
		Patterns[24] := '2010/0';	Dropin[24] := '÷';
		Patterns[25] := '2010';	 	Dropin[25] := 'õ';
		Patterns[26] := '2009/0';	Dropin[26] := '>';
		Patterns[27] := '2009';	 	Dropin[27] := '`';
		Patterns[28] := '2008/0';	Dropin[28] := '²';
		Patterns[29] := '2008';	 	Dropin[29] := '«';
		Patterns[30] := '200';	 	Dropin[30] := '»';

		FOR i:= 20 to 30 DO
			BEGIN
			test := AnsiPos(Dropin[i], suburl);
			IF (test > 0) THEN
				BEGIN
				delete(suburl, test, 1);
				insert(Patterns[i], suburl, test);
				test := AnsiPos(Dropin[i], suburl);
				IF (test > 0) THEN
					BEGIN
					delete(suburl, test, 1);
					insert(Patterns[i], suburl, test);
					END;
				BREAK;
				END;
			END;


		Patterns[40] := 'index';	Dropin[40] := 'î'; //*I
		Patterns[41] := 'article';	Dropin[41] := 'æ'; //*A
		Patterns[42] := 'archive';	Dropin[42] := 'â'; //*a

		FOR i:= 40 to 42 DO
			BEGIN
			test := AnsiPos(Dropin[i], suburl);
			IF (test > 0) THEN
				BEGIN
				delete(suburl, test, 1);
				insert(Patterns[i], suburl, test);
				BREAK;
				END;
			END;

		Patterns[50] := 'blog';	 	Dropin[50] := '¨';
		Patterns[51] := 'news';		Dropin[51] := '¶';
		Patterns[52] := '/statuses/';	Dropin[52] := 'Æ';
		Patterns[53] := '/post/';	Dropin[53] := '¥';
		Patterns[54] := '/content/';	Dropin[54] := 'Ç';

		FOR i:= 50 to 54 DO
			BEGIN
			test := AnsiPos(Dropin[i], suburl);
			IF (test > 0) THEN
				BEGIN
				delete(suburl, test, 1);
				insert(Patterns[i], suburl, test);
				BREAK;
				END;
			END;

		test := AnsiPos('ß', suburl);
		IF (test > 0) THEN
			BEGIN
			delete(suburl, test, 1);
			insert('ation', suburl, test);
			END;
		test := AnsiPos('¢', suburl);
		IF (test > 0) THEN
			BEGIN
			delete(suburl, test, 1);
			insert('tion', suburl, test);
			END;

		END;
	WriteLn (Output, suburl)
  END;
  Close (Input);
  Close (Output);
END.
