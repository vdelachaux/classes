# str

This class implements some useful methods to test and manipulate strings

Take a look the <a href="https://github.com/vdelachaux/classes/blob/master/Project/Sources/Methods/test_str.4dm" >test_str</a> method to get some tricks

## Syntax

`$str [object] := str ({value})`

## Properties

 Properties     | Contains       | Comments 
:------------   |:-------------  |:------------- 
*value*         | [text]         |The current value of the string
*length*        | [long]         |The length of the string

## Member methods

 Methods                       | Actions
 :-------------                |:-------------
`concat(value{;separator})`|Concatenates the *value* ​​given to the original string use space if *separator* is omitted
`contains(value{;diacritical})`|Returns True if the value is present in the string (diacritical comparison if *diacritical* is True)
`distinctLetters({separator})`|Returns a concatenated string of distinct letters, sorted, from the original string, possibly separated by *separator*
`equal(value)`|Returns True if the *value* string is exactly the same as the value (diacritical)
`fixedLength(size{;filler{;alignment}})`|Returns value as fixed length string completed with \* or *filler*
`insert(value;begin {; end})`|Insert *value* at *begin* position or replace *begin*/*end* text by the *value*
`isBoolean()`|Returns True if text is "T/true" or "F/false"
`isDate()`|Returns True if the text is a date string (DOES NOT CHECK IF THE DATE IS VALID)
`isJson()`|Returns True if text is a json string ("{…}" or "[…]")
`isJsonArray()`|Returns True if text is a json array string ("[…]")
`isJsonObject()`|Returns True if text is a json object string ("{…}")
`isNum()`|Returns True if text is a numeric
`isStyled()`|Returns True if text is a styled text
`isTime()`|Returns True if text is a time string (DOES NOT CHECK IF THE TIME IS VALID)
`isUrl()`|Returns True if the text conforms to the URL grammar. (DOES NOT CHECK IF THE URL IS VALID)
`localized(resname;[text][collection])`|Returns the localized string & made replacement if any
`lowerCamelCase()`|Returns value as lower camelcase
`match(pattern)`|Returns True if value match given pattern
`occurences(value)`|Return the number of occurrences of *value*
`quoted()`|Returns the text in quotes
`replace(value;with)`|Returns the string after replacement of *value* by *with*
`setText(value)`|Set the value property of the class*
`shuffle(length)`|Returns a shuffle string extracted from value (paswword generation)
`singleQuoted()`|Returns the text in simple quotes
`spaceSeparated()`|Returns underscored value & camelcase (lower or upper) value as space separated text
`toNum()`|Return extracted numeric from value
`trim({char})`|Trims leading & trailing spaces or *char*
`trimLeading({char})`|Trims leading spaces or *char*
`trimTrailing({char})`|Trims ltrailing spaces or *char*
`unaccented()`|Replace accented characters with non accented one
`uperCamelCase()`|Returns value as upper camelcase
`urlDecode()`|Returns an URL decoded string
`urlEncode()`|Returns an URL encoded string
`wordWrap(length)`|Returns a word wrapped text based on the line *length* (default is 80 characters)
`xmlEncode()`|Returns a XML encoded string

*It is better, if you have to use the class with multiple strings, to create the class object one time, then use the 'setText ()' method to change the value of the text instead of creating the class every time
