# Namer

A VFP class to verify the correctness and to control the translation of a string into a syntactically correct name of a particular domain (for instance, the name of VFP variables or fields, the name of XML elements, Windows file names, ...).

The transformation / verification is actually performed by a name processor (see NameProcessor class, below), that is attached to the Namer controller (which, in turn, provides some standard utilities to ease the coding of the name processors).

## Usage
```foxpro
DO LOCFILE("namer.prg")
m.Controller = CREATEOBJECT("Namer")
* attach the processor for XML names
m.Controller.AttachProcessor("XMLNamer", "xml-names.prg")
* set the name that is going to be translated / verified
m.Controller.SetOriginalName("#xml element name")
* get an XML correct version of the name
m.XMLElementName = m.Controller.GetName("XMLNamer")
? m.XMLElementName   && displays __xml_element_name
```

## Components
```
namer.prg
```

[Name processors](name-processors.md "Name processors") are programmed independently, and may be included in a VFP project as needed.

## Developed name processors
* JSON
* MSSQL
* MYSQL
* VFP
* Windows
* XML

## Methods for applications

### Init([m.OriginalName[, m.IsDBCS]])
Constructor allows the immediate setting of an original name (that is, a name that is going to be processed). Parameters as in SetOriginalName()
```foxpro
m.Controller = CREATEOBJECT("Namer", "Some name")
```

### SetOriginalName(m.OriginalName[, m.IsDBCS])
Sets the name that is going to be processed by name processors. An optional boolean flag may indicate that the name is a DBCS string.
```foxpro
m.Controller.SetOriginalName("Some name", .F.)
```

### GetOriginalName()
Returns the current original name.
```foxpro
m.CurrentOriginal = m.Controller.GetOriginalName()
```

### AttachProcessor(m.ProcessorClass[, m.ProcessorLibrary])
Attaches a name processor, and returns its numerical identifier (0, if failure). If the library of the name processor is given (vcx or prg), it does not have to be in scope. Attached processors may be later identified by name (the name of the class) or by the identifier returned by this method. Several processors may be attached to the same controller.
```foxpro
m.ProcId = m.Controller.AttachProcessor("MYSQLNamer", "mysql-names.prg")
```

### GetName([m.ProcessorIdentifier[, m.NoDefaultChars]])
Returns a translated/verified version of the current original name, acceptable under a particular domain (.NULL. when no translation could be performed). The identifier is either the name of the processor class, or a numeric identifier. If `NoDefaultChars`, invalid characters are deleted, instead of being replaced by default characters.
```foxpro
m.CorrectName = m.Controller.GetName("MYSQLNamer")
```

### SetProperty(m.ProcessorIdentifier, m.Property, m.Setting)
Sets a property known to the specified name processor. Processor properties are used to control particular aspects of how the processor operates.
```foxpro
m.Controller.SetProperty("MYSQLNamer", "AllowReserved", .T.)
```

### GetProperty(m.ProcessorIdentifier,  m.Property)
Returns the current setting of a processor property.
```foxpro
m.Reserved = m.Controller.GetProperty(1, "AllowReserved")
```

## Methods for name processors
Called by processors in the form `This.Host.Method()`.

### GetANSIName(m.FirstChars, m.OtherChars, m.MaxLen, m.DefaultFirstChar, m.DefaultChar)
Standard way to produce a safe translated ANSI name. Allowed characters for the first position of the name are stored in `FirstChars`, and in `OtherChars` for the other positions. The resulting name should not exceed `MaxLen` characters (0 for no limit). In case of an invalid first character, `DefaultFirstChar` should be used instead (and `DefaultChar` for other positions).

### GetDBCSName(m.FirstChars, m.OtherChars, m.MaxLen, m.DefaultFirstChar, m.DefaultChar)
Standard way to produce a safe translated DBCS name. Arguments as in `GetANSIName()`.

### CodePointRange(m.Start, m.Finish)
An utility method to create a string of allowed characters defined by two endpoints.
