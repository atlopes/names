*
* JSONNamer
*
* Get a name that is syntactically acceptable for JSON names.
* It's more restritive than the actual standard.
*
DEFINE CLASS JSONNamer AS NameProcessor

	HIDDEN Alpha
	HIDDEN Digit
	
	FUNCTION Init
	LPARAMETERS Host AS Namer
	
		DODEFAULT(m.Host)

		This.Alpha = This.Host.CodePointRange("a", "z") + This.Host.CodePointRange("A", "Z")
		This.Digit = This.Host.CodePointRange("0", "9")
	ENDFUNC
	
	FUNCTION GetName
	LPARAMETERS NoDefaultChars AS Boolean

		RETURN This.Host.GetANSIName(This.Alpha, ;
									This.Alpha + This.Digit + "-", ;
									0, ;
									IIF(m.NoDefaultChars, "", "-"), ;
									IIF(m.NoDefaultChars, "", "-"))
	
	ENDFUNC

ENDDEFINE
