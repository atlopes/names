*
* WindowsNamer
*
* Get a name that is syntactically acceptable for Windows names (folders, files...).
* Do not accept reserved words and assume a MAX_PATH element of 260 characters.
*
DEFINE CLASS WindowsNamer AS NameProcessor

	HIDDEN Allowed
	HIDDEN Reserved
	
	FUNCTION Init
	LPARAMETERS Host AS Namer

		DODEFAULT(m.Host)

		This.Allowed = CHRTRAN(This.Host.CodePointRange(CHR(32), CHR(255)), '<>:"/\|?*', "")

		TEXT TO This.Reserved NOSHOW FLAGS 1 PRETEXT 11
			|CON|
			|PRN|
			|AUX|
			|NUL|
			|COM1|
			|COM2|
			|COM3|
			|COM4|
			|COM5|
			|COM6|
			|COM7|
			|COM8|
			|COM9|
			|LPT1|
			|LPT2|
			|LPT3|
			|LPT4|
			|LPT5|
			|LPT6|
			|LPT7|
			|LPT8|
			|LPT9|
		ENDTEXT
	
	ENDFUNC
	
	FUNCTION GetName
	LPARAMETERS NoDefaultChars AS Boolean
	
		LOCAL GetWindowsName AS String

		m.GetWindowsName = This.Host.GetANSIName("", ;
									This.Allowed, ;
									260, ;
									"", ;
									IIF(m.NoDefaultChars, "", "_"))
		
		IF "|"+UPPER(m.GetWindowsName)+"|" $ This.Reserved

			IF m.NoDefaultChars
				m.GetWindowsName = .NULL.
			ELSE
				m.GetWindowsName = LEFT("_" + m.GetWindowsName, 260)
			ENDIF

		ENDIF

		RETURN m.GetWindowsName
	
	ENDFUNC

ENDDEFINE
