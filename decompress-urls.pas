PROGRAM Decompress_Urls;

//	This script is part of the url-compressor project (https://github.com/adbar/url-compressor).
//	It is brought to you by Adrien Barbaresi.
//	It is freely available under the GNU GPL v3 license (http://www.gnu.org/licenses/gpl.html).

var
  Input, Output: Text;
  i, test, level, code: Integer;
  url: AnsiString;
  suburl: AnsiString;
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
			ELSE IF (suburl = 'U') THEN
				BEGIN
				suburl := 'http://arstechnica.com/';
				END
			ELSE IF (suburl = 'V') THEN
				BEGIN
				suburl := 'http://friendfeed.com/';
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
	IF (level = 1) THEN
		WriteLn (Output, suburl)
	ELSE IF (level = 2) THEN
		BEGIN
		// TO DO : highest frequency first, read from file ?
		// With or without '/' ?
		Patterns[0] := '.wordpress.com'; 	Dropin[0] := '*W';
		Patterns[1] := '.wikipedia.org/wiki/'; 	Dropin[1] := '*V';
		Patterns[2] := '.blogspot.com';	 	Dropin[2] := '*B';
		Patterns[3] := '.google.com/';	 	Dropin[3] := '*G';
		Patterns[4] := '.posterous.com/';	Dropin[4] := '*S';
		Patterns[5] := '.com';	 		Dropin[5] := '*C';
		Patterns[6] := '.org';	 		Dropin[6] := '*O';
		Patterns[7] := '.net';	 		Dropin[7] := '*N';
		Patterns[8] := '.php';	 		Dropin[8] := '*P';
		Patterns[9] := '.html';	 		Dropin[9] := '*H';

		FOR i:= 0 to 9 DO
			BEGIN
			test := pos(Dropin[i], suburl);
			IF (test > 0) THEN
				BEGIN
				delete(suburl, test, 2);
				insert(Patterns[i], suburl, test);
				BREAK;
				END;
			END;

		Patterns[10] := '2012';	 		Dropin[10] := '°2';
		Patterns[11] := '2011';			Dropin[11] := '°1';
		Patterns[12] := '2010';	 		Dropin[12] := '°0';
		Patterns[13] := '2009';	 		Dropin[13] := '°9';
		Patterns[14] := '2008';	 		Dropin[14] := '°8';

		FOR i:= 10 to 14 DO
			BEGIN
			test := pos(Dropin[i], suburl);
			IF (test > 0) THEN
				BEGIN
				//inc(test);
				delete(suburl, test, 3);
				insert(Patterns[i], suburl, test);
				BREAK;
				END;
			END;

		WriteLn (Output, suburl)
		END;
  END;
  Close (Input);
  Close (Output);
END.
