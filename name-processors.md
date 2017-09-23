# Name Processors

Name processors are attached to [Namer controllers](README.md "Namer controllers"), and perform the actual translation and verification of names of a particular domain.

The class is defined in `namer.prg`, and sub-class objects are instantiated by a namer controller when the processor is attached. Methods are invoked by the controller, not directly by application code.

## Usage
```foxpro
DO LOCFILE("namer.prg")
m.Controller = CREATEOBJECT("Namer")
* attach a processor for MSSQL
m.Controller.AttachProcessor("MSSQLNamer")
* and another one for for MySQL
m.Controller.AttachProcessor("MySQLNamer")
```

## Components
```
namer.prg
```

## Developed name processors
* [JSON](json-names.prg "JSON")
* [MSSQL](mssql-names.prg "MSSQL")
* [MYSQL](mysql-names.prg "MYSQL")
* [VFP](vfp-names.prg "VFP")
* [Windows](windows-names.prg "Windows")
* [XML](xml-names.prg "XML")

## Methods

### Init(m.Host)
The constructor receives a reference to the controller, which will allow the sub-class to call the utility methods of the controller, and access its properties.

### GetName([m.NoDefaultChars])
Returns a translated/verified version of the current original name, acceptable under a particular domain (.NULL. when no translation could be performed). If NoDefaultChars, invalid characters are deleted, instead of being replaced by default characters.

This is the method that must be coded for each particular sub-class.

### SetProperty(m.Property, m.Setting)
Sets a property. Processor properties are used to control particular aspects of how the processor operates.

### GetProperty(m.Property)
Returns the current setting of a processor property.
