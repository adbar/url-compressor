PROGRAM Decompress_Urls;

//	This script is part of the url-compressor project (https://github.com/adbar/url-compressor).
//	It is brought to you by Adrien Barbaresi.
//	It is freely available under the GNU GPL v3 license (http://www.gnu.org/licenses/gpl.html).

var
  Input, Output: Text;
  i: Integer;
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
	suburl := '';
	FOR i := 1 to length(url) DO
		BEGIN
		suburl := Concat (suburl, url[i]);
		IF (i = 1) THEN
			BEGIN
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
			ELSE IF (suburl = 'P') THEN
				BEGIN
				suburl := 'http://ping.fm/';
				END
			ELSE IF (suburl = 'T') THEN
				BEGIN
				suburl := 'http://tinyurl.com/';
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
	WriteLn (Output, suburl);
  END;
  Close (Input);
  Close (Output);
END.
