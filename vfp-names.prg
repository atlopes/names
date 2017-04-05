*
* VFPNamer
*
* Get a name that is syntactically acceptable for VFP names (variables, databases, columns...).
*
*
* VFPShortNamer
*
* Get a name that is syntactically acceptable for VFP fields in free tables and tag names.
*
DEFINE CLASS VFPNamer AS NameProcessor

	HIDDEN Alpha
	HIDDEN Digit
	HIDDEN Reserved
	
	MaxLen = 254

	FUNCTION Init
	LPARAMETERS Host AS Namer

		DODEFAULT(m.Host)

		This.Alpha = This.Host.CodePointRange("a", "z") + This.Host.CodePointRange("A", "Z") + "Åäåöúü" + ;
			This.Host.CodePointRange("¿", "÷") + This.Host.CodePointRange("ÿ", "ˆ") + ;
			This.Host.CodePointRange("¯", "ˇ")
		This.Digit = This.Host.CodePointRange("0", "9")

		TEXT TO This.Reserved NOSHOW FLAGS 1 PRETEXT 11
			|ABS|
			|ACLASS|
			|ACOPY|
			|ACOS|
			|ADATABASES|
			|ADBOBJECTS|
			|ADDBS|
			|ADDPROPERTY|
			|ADEL|
			|ADIR|
			|ADLLS|
			|ADOCKSTATE|
			|AELEMENT|
			|AERROR|
			|AEVENTS|
			|AFIELDS|
			|AFONT|
			|AGETCLASS|
			|AGETFILEVERSION|
			|AINS|
			|AINSTANCE|
			|ALANGUAGE|
			|ALEN|
			|ALIAS|
			|ALINES|
			|ALLTRIM|
			|AMEMBERS|
			|AMOUSEOBJ|
			|ANETRESOURCES|
			|APRINTERS|
			|APROCINFO|
			|ASC|
			|ASCAN|
			|ASELOBJ|
			|ASESSIONS|
			|ASIN|
			|ASORT|
			|ASQLHANDLES|
			|ASTACKINFO|
			|ASUBSCRIPT|
			|AT|
			|AT_C|
			|ATAGINFO|
			|ATAN|
			|ATC|
			|ATCC|
			|ATCLINE|
			|ATLINE|
			|ATN2|
			|AUSED|
			|AVCXCLASSES|
			|BAR|
			|BARCOUNT|
			|BARPROMPT|
			|BETWEEN|
			|BINDEVENT|
			|BINTOC|
			|BITAND|
			|BITCLEAR|
			|BITLSHIFT|
			|BITNOT|
			|BITOR|
			|BITRSHIFT|
			|BITSET|
			|BITTEST|
			|BITXOR|
			|BOF|
			|CANDIDATE|
			|CAPSLOCK|
			|CAST|
			|CDOW|
			|CDX|
			|CEILING|
			|CHR|
			|CHRSAW|
			|CHRTRAN|
			|CHRTRANC|
			|CLEARRESULTSET|
			|CMONTH|
			|CNTBAR|
			|CNTPAD|
			|COL|
			|COMARRAY|
			|COMCLASSINFO|
			|COMPOBJ|
			|COMPROP|
			|COMRETURNERROR|
			|COS|
			|CPCONVERT|
			|CPCURRENT|
			|CPDBF|
			|CREATEBINARY|
			|CREATEOBJECT|
			|CREATEOBJECTEX|
			|CREATEOFFLINE|
			|CTOBIN|
			|CTOD|
			|CTOT|
			|CURDIR|
			|CURSORGETPROP|
			|CURSORSETPROP|
			|CURSORTOXML|
			|CURVAL|
			|DATE|
			|DATETIME|
			|DAY|
			|DBC|
			|DBF|
			|DBGETPROP|
			|DBSETPROP|
			|DBUSED|
			|DDEABORTTRANS|
			|DDEADVISE|
			|DDEENABLED|
			|DDEEXECUTE|
			|DDEINITIATE|
			|DDELASTERROR|
			|DDEPOKE|
			|DDEREQUEST|
			|DDESETOPTION|
			|DDESETSERVICE|
			|DDESETTOPIC|
			|DDETERMINATE|
			|DEFAULTEXT|
			|DELETED|
			|DESCENDING|
			|DIFFERENCE|
			|DIRECTORY|
			|DISKSPACE|
			|DISPLAYPATH|
			|DMY|
			|DODEFAULT|
			|DOW|
			|DRIVETYPE|
			|DROPOFFLINE|
			|DTOC|
			|DTOR|
			|DTOS|
			|DTOT|
			|EDITSOURCE|
			|EMPTY|
			|EOF|
			|ERROR|
			|EVALUATE|
			|EVENTHANDLER|
			|EVL|
			|EXECSCRIPT|
			|EXP|
			|FCHSIZE|
			|FCLOSE|
			|FCOUNT|
			|FCREATE|
			|FDATE|
			|FEOF|
			|FERROR|
			|FFLUSH|
			|FGETS|
			|FIELD|
			|FILE|
			|FILETOSTR|
			|FILTER|
			|FKLABEL|
			|FKMAX|
			|FLDLIST|
			|FLOCK|
			|FLOOR|
			|FONTMETRIC|
			|FOPEN|
			|FOR|
			|FORCEEXT|
			|FORCEPATH|
			|FOUND|
			|FPUTS|
			|FREAD|
			|FSEEK|
			|FSIZE|
			|FTIME|
			|FULLPATH|
			|FUNCTION|
			|FV|
			|FWRITE|
			|GETAUTOINCVALUE|
			|GETBAR|
			|GETCOLOR|
			|GETCP|
			|GETDIR|
			|GETENV|
			|GETFILE|
			|GETFLDSTATE|
			|GETFONT|
			|GETINTERFACE|
			|GETNEXTMODIFIED|
			|GETOBJECT|
			|GETPAD|
			|GETPEM|
			|GETPICT|
			|GETPRINTER|
			|GETRESULTSET|
			|GETWORDCOUNT|
			|GETWORDNUM|
			|GETCURSORADAPTER|
			|GOMONTH|
			|HEADER|
			|HOME|
			|HOUR|
			|ICASE|
			|IDXCOLLATE|
			|IIF|
			|IMESTATUS|
			|INDBC|
			|INDEXSEEK|
			|INKEY|
			|INLIST|
			|INPUTBOX|
			|INSMODE|
			|INT|
			|ISALPHA|
			|ISBLANK|
			|ISCOLOR|
			|ISDIGIT|
			|ISEXCLUSIVE|
			|ISFLOCKED|
			|ISLEADBYTE|
			|ISLOWER|
			|ISMEMOFETCHED|
			|ISMOUSE|
			|ISNULL|
			|ISPEN|
			|ISREADONLY|
			|ISRLOCKED|
			|ISTRANSACTABLE|
			|ISUPPER|
			|JUSTDRIVE|
			|JUSTEXT|
			|JUSTFNAME|
			|JUSTPATH|
			|JUSTSTEM|
			|KEY|
			|KEYMATCH|
			|LASTKEY|
			|LEFT|
			|LEFTC|
			|LEN|
			|LENC|
			|LIKE|
			|LIKEC|
			|LINENO|
			|LOADPICTURE|
			|LOCFILE|
			|LOCK|
			|LOG|
			|LOG10|
			|LOOKUP|
			|LOWER|
			|LTRIM|
			|LUPDATE|
			|MAKETRANSACTABLE|
			|MAX|
			|MCOL|
			|MDOWN|
			|MDX|
			|MDY|
			|MEMLINES|
			|MEMORY|
			|MENU|
			|MESSAGE|
			|MESSAGEBOX|
			|MIN|
			|MINUTE|
			|MLINE|
			|MOD|
			|MONTH|
			|MRKBAR|
			|MRKPAD|
			|MROW|
			|MTON|
			|MWINDOW|
			|NDX|
			|NEWOBJECT|
			|NORMALIZE|
			|NTOM|
			|NUMLOCK|
			|NVL|
			|OBJNUM|
			|OBJTOCLIENT|
			|OBJVAR|
			|OCCURS|
			|OEMTOANSI|
			|OLDVAL|
			|ON|
			|ORDER|
			|OS|
			|PAD|
			|PADL|
			|PADR|
			|PADC|
			|PARAMETERS|
			|PAYMENT|
			|PCOL|
			|PCOUNT|
			|PEMSTATUS|
			|PI|
			|POPUP|
			|PRIMARY|
			|PRINTSTATUS|
			|PRMBAR|
			|PRMPAD|
			|PROGRAM|
			|PROMPT|
			|PROPER|
			|PROW|
			|PRTINFO|
			|PUTFILE|
			|PV|
			|QUARTER|
			|RAISEEVENT|
			|RAND|
			|RAT|
			|RATC|
			|RATLINE|
			|RDLEVEL|
			|READKEY|
			|RECCOUNT|
			|RECNO|
			|RECSIZE|
			|REFRESH|
			|RELATION|
			|REPLICATE|
			|REQUERY|
			|RGB|
			|RGBSCHEME|
			|RIGHT|
			|RIGHTC|
			|RLOCK|
			|ROUND|
			|ROW|
			|RTOD|
			|RTRIM|
			|SAVEPICTURE|
			|SCHEME|
			|SCOLS|
			|SEC|
			|SECONDS|
			|SEEK|
			|SELECT|
			|SET|
			|SETFLDSTATE|
			|SETRESULTSET|
			|SIGN|
			|SIN|
			|SKPBAR|
			|SKPPAD|
			|SOUNDEX|
			|SPACE|
			|SQLCANCEL|
			|SQLCOLUMNS|
			|SQLCOMMIT|
			|SQLCONNECT|
			|SQLDISCONNECT|
			|SQLEXEC|
			|SQLGETPROP|
			|SQLIDLEDISCONNECT|
			|SQLMORERESULTS|
			|SQLPREPARE|
			|SQLROLLBACK|
			|SQLSETPROP|
			|SQLSTRINGCONNECT|
			|SQLTABLES|
			|SQRT|
			|SROWS|
			|STR|
			|STRCONV|
			|STREXTRACT|
			|STRTOFILE|
			|STRTRAN|
			|STUFF|
			|STUFFC|
			|SUBSTR|
			|SUBSTRC|
			|SYS|
			|SYSMETRIC|
			|TABLEREVERT|
			|TABLEUPDATE|
			|TAG|
			|TAGCOUNT|
			|TAGNO|
			|TAN|
			|TARGET|
			|TEXTMERGE|
			|TIME|
			|TRANSFORM|
			|TRIM|
			|TTOC|
			|TTOD|
			|TXNLEVEL|
			|TXTWIDTH|
			|TYPE|
			|UNBINDEVENTS|
			|UNIQUE|
			|UPDATED|
			|UPPER|
			|USED|
			|VAL|
			|VARREAD|
			|VARTYPE|
			|VERSION|
			|WBORDER|
			|WCHILD|
			|WCOLS|
			|WDOCKABLE|
			|WEEK|
			|WEXIST|
			|WFONT|
			|WLAST|
			|WLCOL|
			|WLROW|
			|WMAXIMUM|
			|WMINIMUM|
			|WONTOP|
			|WOUTPUT|
			|WPARENT|
			|WREAD|
			|WROWS|
			|WTITLE|
			|WVISIBLE|
			|XMLTOCURSOR|
			|XMLUPDATEGRAM|
			|YEAR|
		ENDTEXT

	ENDFUNC
	
	FUNCTION GetName
	LPARAMETERS NoDefaultChars AS Boolean
	
		LOCAL GetVFPName AS String

		m.GetVFPName = This.Host.GetANSIName(This.Alpha + "_", ;
									This.Alpha + This.Digit + "_", ;
									This.MaxLen, ;
									IIF(m.NoDefaultChars, "", "_"), ;
									IIF(m.NoDefaultChars, "", "_"))

		IF !ISNULL(m.GetVFPName) AND ;
				("|" + UPPER(m.GetVFPName) + "|" $ This.Reserved OR ;
					(LEN(m.GetVFPName) = 4 AND "|" + UPPER(m.GetVFPName) $ This.Reserved))
		
			IF m.NoDefaultChars
				m.GetVFPName = .NULL.
			ELSE
				m.GetVFPName = LEFT("_" + m.GetVFPName, This.MaxLen)
			ENDIF

		ENDIF

		RETURN m.GetVFPName
				
	ENDFUNC

ENDDEFINE

DEFINE CLASS VFPShortNamer AS VFPNamer

	MaxLen = 10

ENDDEFINE
