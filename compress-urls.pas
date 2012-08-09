PROGRAM Compress_Urls;

//	This script is part of the url-compressor project (https://github.com/adbar/url-compressor).
//	It is brought to you by Adrien Barbaresi.
//	It is freely available under the GNU GPL v3 license (http://www.gnu.org/licenses/gpl.html).

var
  Input, Output: Text;
  i, flag: Integer;
  url: AnsiString;
  suburl: AnsiString;

BEGIN
IF (ParamCount <> 2) THEN
  BEGIN
  WriteLn('Incorrect parameter number : one input file and one output file only');
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
		ELSE IF (i = 19) AND (flag = 0) THEN
			BEGIN
			IF (suburl = 'http://tinyurl.com/') THEN
				BEGIN
				suburl := 'T';
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
	WriteLn (Output, suburl);
  END;

  Close (Input);
  Close (Output);
END.     
