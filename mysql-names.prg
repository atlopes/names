*
* MySQLNamer
*
* Get a name that is syntactically acceptable for MySQL names (tables, columns...).
* Do not accept names reserved Words, unless the property AllowReserved (default .F.) is set to true.
*
* MySQLQuotedNamer
*
* Get a name that is syntactically acceptable for MySQL quoted names (elements, attributes...).
* Return properly formatted names (that is, already quoted)
*
DEFINE CLASS MySQLNamer AS NameProcessor

	HIDDEN Alpha
	HIDDEN Digit
	HIDDEN Reserved
	
	FUNCTION Init
	LPARAMETERS Host AS Namer

		DODEFAULT(m.Host)

		This.Alpha = This.Host.CodePointRange("a", "z") + This.Host.CodePointRange("A", "Z")
		This.Digit = This.Host.CodePointRange("0", "9")
		This.SetProperty("AllowReserved", .F.)

		TEXT TO This.Reserved NOSHOW FLAGS 1 PRETEXT 11
			|ACCESSIBLE|
			|ADD|
			|ALL|
			|ALTER|
			|ANALYZE|
			|AND|
			|AS|
			|ASC|
			|ASENSITIVE|
			|BEFORE|
			|BETWEEN|
			|BIGINT|
			|BINARY|
			|BLOB|
			|BOTH|
			|BY|
			|CALL|
			|CASCADE|
			|CASE|
			|CHANGE|
			|CHAR|
			|CHARACTER|
			|CHECK|
			|COLLATE|
			|COLUMN|
			|CONDITION|
			|CONSTRAINT|
			|CONTINUE|
			|CONVERT|
			|CREATE|
			|CROSS|
			|CURRENT_DATE|
			|CURRENT_TIME|
			|CURRENT_TIMESTAMP|
			|CURRENT_USER|
			|CURSOR|
			|DATABASE|
			|DATABASES|
			|DAY_HOUR|
			|DAY_MICROSECOND|
			|DAY_MINUTE|
			|DAY_SECOND|
			|DEC|
			|DECIMAL|
			|DECLARE|
			|DEFAULT|
			|DELAYED|
			|DELETE|
			|DESC|
			|DESCRIBE|
			|DETERMINISTIC|
			|DISTINCT|
			|DISTINCTROW|
			|DIV|
			|DOUBLE|
			|DROP|
			|DUAL|
			|EACH|
			|ELSE|
			|ELSEIF|
			|ENCLOSED|
			|ESCAPED|
			|EXISTS|
			|EXIT|
			|EXPLAIN|
			|FALSE|
			|FETCH|
			|FLOAT|
			|FLOAT4|
			|FLOAT8|
			|FOR|
			|FORCE|
			|FOREIGN|
			|FROM|
			|FULLTEXT|
			|GET|
			|GRANT|
			|GROUP|
			|HAVING|
			|HIGH_PRIORITY|
			|HOUR_MICROSECOND|
			|HOUR_MINUTE|
			|HOUR_SECOND|
			|IF|
			|IGNORE|
			|IN|
			|INDEX|
			|INFILE|
			|INNER|
			|INOUT|
			|INSENSITIVE|
			|INSERT|
			|INT|
			|INT1|
			|INT2|
			|INT3|
			|INT4|
			|INT8|
			|INTEGER|
			|INTERVAL|
			|INTO|
			|IO_AFTER_GTIDS|
			|IO_BEFORE_GTIDS|
			|IS|
			|ITERATE|
			|JOIN|
			|KEY|
			|KEYS|
			|KILL|
			|LEADING|
			|LEAVE|
			|LEFT|
			|LIKE|
			|LIMIT|
			|LINEAR|
			|LINES|
			|LOAD|
			|LOCALTIME|
			|LOCALTIMESTAMP|
			|LOCK|
			|LONG|
			|LONGBLOB|
			|LONGTEXT|
			|LOOP|
			|LOW_PRIORITY|
			|MASTER_BIND|
			|MASTER_SSL_VERIFY_SERVER_CERT|
			|MATCH|
			|MAXVALUE|
			|MEDIUMBLOB|
			|MEDIUMINT|
			|MEDIUMTEXT|
			|MIDDLEINT|
			|MINUTE_MICROSECOND|
			|MINUTE_SECOND|
			|MOD|
			|MODIFIES|
			|NATURAL|
			|NOT|
			|NO_WRITE_TO_BINLOG|
			|NULL|
			|NUMERIC|
			|ON|
			|OPTIMIZE|
			|OPTION|
			|OPTIONALLY|
			|OR|
			|ORDER|
			|OUT|
			|OUTER|
			|OUTFILE|
			|PARTITION|
			|PRECISION|
			|PRIMARY|
			|PROCEDURE|
			|PURGE|
			|RANGE|
			|READ|
			|READS|
			|READ_WRITE|
			|REAL|
			|REFERENCES|
			|REGEXP|
			|RELEASE|
			|RENAME|
			|REPEAT|
			|REPLACE|
			|REQUIRE|
			|RESIGNAL|
			|RESTRICT|
			|RETURN|
			|REVOKE|
			|RIGHT|
			|RLIKE|
			|SCHEMA|
			|SCHEMAS|
			|SECOND_MICROSECOND|
			|SELECT|
			|SENSITIVE|
			|SEPARATOR|
			|SET|
			|SHOW|
			|SIGNAL|
			|SMALLINT|
			|SPATIAL|
			|SPECIFIC|
			|SQL|
			|SQLEXCEPTION|
			|SQLSTATE|
			|SQLWARNING|
			|SQL_BIG_RESULT|
			|SQL_CALC_FOUND_ROWS|
			|SQL_SMALL_RESULT|
			|SSL|
			|STARTING|
			|STRAIGHT_JOIN|
			|TABLE|
			|TERMINATED|
			|THEN|
			|TINYBLOB|
			|TINYINT|
			|TINYTEXT|
			|TO|
			|TRAILING|
			|TRIGGER|
			|TRUE|
			|UNDO|
			|UNION|
			|UNIQUE|
			|UNLOCK|
			|UNSIGNED|
			|UPDATE|
			|USAGE|
			|USE|
			|USING|
			|UTC_DATE|
			|UTC_TIME|
			|UTC_TIMESTAMP|
			|VALUES|
			|VARBINARY|
			|VARCHAR|
			|VARCHARACTER|
			|VARYING|
			|WHEN|
			|WHERE|
			|WHILE|
			|WITH|
			|WRITE|
			|XOR|
			|YEAR_MONTH|
			|ZEROFILL|
		ENDTEXT
	
	ENDFUNC
	
	FUNCTION GetName
	LPARAMETERS NoDefaultChars AS Boolean
	
		LOCAL GetMySQLName AS String

		m.GetMySQLName = This.Host.GetANSIName(This.Alpha + "_$", ;
									This.Alpha + This.Digit + "_$", ;
									64, ;
									IIF(m.NoDefaultChars, "", "_"), ;
									IIF(m.NoDefaultChars, "", "_"))
		
		IF EMPTY(CHRTRAN(m.GetMySQLName,This.Digit,"")) OR ;
				(!This.GetProperty("AllowReserved") AND "|"+UPPER(m.GetMySQLName)+"|" $ This.Reserved)

			IF m.NoDefaultChars
				m.GetMySQLName = .NULL.
			ELSE
				m.GetMySQLName = LEFT("_" + m.GetMySQLName, 64)
			ENDIF

		ENDIF

		RETURN m.GetMySQLName
	
	ENDFUNC

ENDDEFINE

DEFINE CLASS MySQLQuotedNamer AS NameProcessor

	HIDDEN Allowed
	
	FUNCTION Init
	LPARAMETERS Host AS Namer

		DODEFAULT(m.Host)

		This.Allowed = CHRTRAN(This.Host.CodePointRange(CHR(1), CHR(254)), "´.", "")
	ENDFUNC
	
	FUNCTION GetName
	LPARAMETERS NoDefaultChars AS Boolean
	
		LOCAL GetMySQLName AS String
		
		m.GetMySQLName = This.Host.GetANSIName("", ;
									This.Allowed, ;
									64, ;
									"", ;
									IIF(m.NoDefaultChars, "", "_"))
	
		IF !ISNULL(m.GetMySQLName)
			m.GetMySQLName = '´' + m.GetMySQLName + '´'
		ENDIF
		
		RETURN m.GetMySQLName

	ENDFUNC

ENDDEFINE
