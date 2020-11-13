
Class extends xml

Class constructor($variableOrFile)
	
	If (Count parameters:C259>=1)
		
		Super:C1705($variableOrFile)
		
	Else 
		
		Super:C1705()
		
		// Create an empty canvas
		This:C1470.new()
		
	End if 
	
	This:C1470.latest:=Null:C1517
	This:C1470.image:=Null:C1517
	This:C1470.store:=New collection:C1472
	
	This:C1470._notContainer:=New collection:C1472("rect"; "line"; "image"; "circle"; "ellipse"; "path"; "polygon"; "polyline"; "use")
	This:C1470._aspectRatioValues:=New collection:C1472("none"; "xMinYMin"; "xMidYMin"; "xMaxYMin"; "xMinYMid"; "xMidYMid"; "xMaxYMid"; "xMinYMax"; "xMidYMax"; "xMaxYMax")
	
	
/*================================================================
                  DOCUMENTS & STRUCTURE
================================================================*/
	
	//———————————————————————————————————————————————————————————/
	// Returns the picture described by the SVG structure
Function picture($exportType : Variant; $keepStructure : Boolean)->$picture : Picture
	
	Case of 
			
			//______________________________________________________
		: (Count parameters:C259>=2)  // $exportType & $keepStructure
			
			SVG EXPORT TO PICTURE:C1017(This:C1470.root; $picture; Num:C11($exportType))
			
			If (This:C1470.autoClose)\
				 & (Not:C34($keepStructure))
				
				This:C1470.close()
				
			End if 
			
			//______________________________________________________
		: (Count parameters:C259>=1)  // $exportType | $keepStructure
			
			If (Value type:C1509($exportType)=Is boolean:K8:9)  // $keepStructure
				
				SVG EXPORT TO PICTURE:C1017(This:C1470.root; $picture; Copy XML data source:K45:17)
				
				If (This:C1470.autoClose)\
					 & (Not:C34($exportType))
					
					This:C1470.close()
					
				End if 
				
			Else   // $exportType
				
				SVG EXPORT TO PICTURE:C1017(This:C1470.root; $picture; Num:C11($exportType))
				
				If (This:C1470.autoClose)
					
					This:C1470.close()
					
				End if 
			End if 
			
			//______________________________________________________
		Else 
			
			SVG EXPORT TO PICTURE:C1017(This:C1470.root; $picture; Copy XML data source:K45:17)
			
			If (This:C1470.autoClose)
				
				This:C1470.close()
				
			End if 
			
			//______________________________________________________
	End case 
	
	This:C1470.success:=(Picture size:C356($picture)>0)
	
	If (This:C1470.success)
		
		This:C1470.image:=$picture
		
	Else 
		
		This:C1470.image:=Null:C1517
		This:C1470.errors.push("Failed to convert SVG structure as picture.")
		
	End if 
	
	//———————————————————————————————————————————————————————————/
	// Writes the content of the SVG tree into a disk file
Function exportText($file : 4D:C1709.file; $keepStructure : Boolean)->$this : cs:C1710.xml
	
	If (Count parameters:C259=2)
		
		Super:C1706.save($file; $keepStructure)
		
	Else 
		
		Super:C1706.save($file)
		
	End if 
	
	$this:=This:C1470
	
	//———————————————————————————————————————————————————————————/
	// Writes the contents of the SVG tree into a picture file
Function exportPicture($file : 4D:C1709.file; $keepStructure : Boolean)->$this : cs:C1710.xml
	
	var $picture : Picture
	
	If (Count parameters:C259=2)
		
		$picture:=This:C1470.picture($keepStructure)
		
	Else 
		
		// Auto
		$picture:=This:C1470.picture()
		
	End if 
	
	If (This:C1470.success)
		
		WRITE PICTURE FILE:C680($file.platformPath; $picture; $file.extension)
		
	End if 
	
	$this:=This:C1470
	
	//———————————————————————————————————————————————————————————
	// Close the current tree if any & create a new svg default structure.
Function new($attributes : Object)->$this : cs:C1710.svg
	
	var $node; $t : Text
	
	This:C1470.close()  // Release memory
	
	$node:=DOM Create XML Ref:C861("svg"; "http://www.w3.org/2000/svg")
	This:C1470.success:=Bool:C1537(OK)
	
	If (This:C1470.success)
		
		This:C1470.root:=$node
		
		DOM SET XML ATTRIBUTE:C866($node; \
			"xmlns:xlink"; "http://www.w3.org/1999/xlink")
		
		DOM SET XML DECLARATION:C859($node; "UTF-8"; True:C214)
		XML SET OPTIONS:C1090($node; XML indentation:K45:34; Choose:C955(Is compiled mode:C492; XML no indentation:K45:36; XML with indentation:K45:35))
		
		This:C1470.success:=Bool:C1537(OK)
		
		If (This:C1470.success)
			
			// Default values
			DOM SET XML ATTRIBUTE:C866(This:C1470.root; \
				"viewport-fill"; "none"; \
				"fill"; "none"; \
				"stroke"; "black"; \
				"font-family"; "'lucida grande','segoe UI',sans-serif"; \
				"font-size"; 12; \
				"text-rendering"; "geometricPrecision"; \
				"shape-rendering"; "crispEdges"; \
				"preserveAspectRatio"; "none")
			
		End if 
	End if 
	
	This:C1470.success:=Bool:C1537(OK) & (This:C1470.root#Null:C1517)
	
	If (This:C1470.success)
		
		If (Count parameters:C259>=1)
			
			If ($attributes#Null:C1517)
				
				For each ($t; $attributes)
					
					Case of 
							
							//_______________________
						: ($t="keepReference")
							
							This:C1470.autoClose:=Bool:C1537($attributes[$t])
							
							//_______________________
						Else 
							
							DOM SET XML ATTRIBUTE:C866(This:C1470.root; \
								$t; $attributes[$t])
							
							//______________________
					End case 
				End for each 
				
			Else 
				
				// <NOTHING MORE TO DO>
				
			End if 
			
		Else 
			
			// <NOTHING MORE TO DO>
			
		End if 
		
	Else 
		
		This:C1470.errors.push("Failed to create SVG structure.")
		
	End if 
	
	$this:=This:C1470
	
	//———————————————————————————————————————————————————————————
Function group($id : Text; $attachTo)->$this : cs:C1710.svg
	
	var $parent : Text
	
	If (Count parameters:C259>=2)
		
		$parent:=This:C1470._attachTo($attachTo)
		
		This:C1470.latest:=Super:C1706.create($parent; "g")
		Super:C1706.setAttribute(This:C1470.latest; "id"; $id)
		This:C1470.push()
		
	Else 
		
		If (This:C1470.isReference($id))
			
			This:C1470.latest:=Super:C1706.create(This:C1470._attachTo($id); "g")
			
		Else 
			
			This:C1470.latest:=Super:C1706.create(This:C1470._attachTo(); "g")
			Super:C1706.setAttribute(This:C1470.latest; "id"; $id)
			This:C1470.push()
			
		End if 
	End if 
	
	$this:=This:C1470
	
	//———————————————————————————————————————————————————————————
	// Adds item to parent item
Function attachTo($parent)->$this : cs:C1710.svg
	
	var $id; $node; $applyTo : Text
	
	If (Count parameters:C259>=1)
		
		$applyTo:=This:C1470._attachTo($parent)
		
	Else 
		
		// Auto
		$applyTo:=This:C1470._attachTo()
		
	End if 
	
	$node:=This:C1470.latest
	
	// Keeps id and removes it, if any, to avoid duplicate one
	$id:=String:C10(This:C1470.attributePop($node; "id"))
	
	This:C1470.latest:=Super:C1706.clone($node; $applyTo)
	This:C1470.remove($node)
	
	// Restore id, if any
	If (Length:C16($id)>0)
		
		This:C1470.id($id)
		
	End if 
	
	$this:=This:C1470
	
	//———————————————————————————————————————————————————————————
	// Store the last created element as symbol
Function symbol($id : Text; $applyTo)->$this : cs:C1710.svg
	
	var $defs; $node; $source; $symbol : Text
	
	If (This:C1470._requiredParams(Count parameters:C259; 1))
		
		$defs:=This:C1470._defs()
		
		If (This:C1470.success)
			
			If (Count parameters:C259>=2)
				
				$source:=This:C1470._applyTo($applyTo)
				
			Else 
				
				// Auto
				$source:=This:C1470._applyTo()
				
			End if 
			
			$symbol:=Super:C1706.create($defs; "symbol")
			
			If (This:C1470.success)
				
				Super:C1706.setAttribute($symbol; "id"; $id)
				
				If (This:C1470.success)
					
					This:C1470.store.push(New object:C1471(\
						"id"; $id; \
						"dom"; $symbol))
					
					Super:C1706.setAttribute($symbol; "preserveAspectRatio"; "xMidYMid")
					
					$node:=Super:C1706.clone($source; $symbol)
					This:C1470.remove($source)
					
				End if 
				
			Else 
				
				This:C1470.success:=False:C215
				This:C1470.errors.push(Current method name:C684+" - Failed to create the symbol: "+$id)
				
			End if 
			
		Else 
			
			This:C1470.success:=False:C215
			This:C1470.errors.push(Current method name:C684+" - Failed to locate/create the \"defs\" element")
			
		End if 
	End if 
	
	// Restore the target preceding the creation of the symbol
	This:C1470.latest:=Choose:C955(This:C1470._current=Null:C1517; This:C1470.root; This:C1470._current)
	
	$this:=This:C1470
	
	//———————————————————————————————————————————————————————————
	// Place an occurence of the symbol
Function use($id; $attachTo)->$this : cs:C1710.svg
	
	var $node; $parent : Text
	
	If (This:C1470._requiredParams(Count parameters:C259; 1))
		
		$node:=This:C1470.findById($id)
		
		If (This:C1470.success)
			
			If (Count parameters:C259>=2)
				
				$parent:=This:C1470._attachTo($attachTo)
				
			Else 
				
				// Auto
				$parent:=This:C1470._attachTo()
				
			End if 
			
			This:C1470.latest:=Super:C1706.create($parent; "use")
			
			If (This:C1470.success)
				
				Super:C1706.setAttribute(This:C1470.latest; "xlink:href"; $id)
				
			End if 
			
		Else 
			
			This:C1470.errors.push(Current method name:C684+" - The id \""+$id+"\" doesn't exist!")
			
		End if 
	End if 
	
	$this:=This:C1470
	
	//———————————————————————————————————————————————————————————/
	// ⚠️ Overrides the method of the inherited class
Function clone($source : Text; $attachTo)->$this : cs:C1710.svg
	
	var $parent; $applyTo : Text
	
	If (This:C1470._requiredParams(Count parameters:C259; 1))
		
		If (Count parameters:C259>=2)
			
			$parent:=This:C1470._attachTo($attachTo)
			
		Else 
			
			// Auto
			$parent:=This:C1470._attachTo()
			
		End if 
		
		$applyTo:=This:C1470._applyTo($source)
		
		If (This:C1470.getAttributes($applyTo).id#Null:C1517)
			
			This:C1470.errors.push(Current method name:C684+" - As the id must be unique, it has been removed.")
			
		End if 
		
		This:C1470.latest:=Super:C1706.clone($applyTo; $parent)
		
	End if 
	
	$this:=This:C1470
	
	
/*================================================================
                       BASICS ELEMENTS
================================================================*/
	
	//———————————————————————————————————————————————————————————
Function rect($height : Real; $WidthOrNode : Variant; $attachTo)->$this : cs:C1710.svg
	
	var $parent : Text
	var $width : Integer
	
	If (This:C1470._requiredParams(Count parameters:C259; 1))
		
		$width:=$height  // Square by default
		
		If (Count parameters:C259>=1)
			
			If (Value type:C1509($WidthOrNode)=Is real:K8:4)
				
				$width:=$WidthOrNode
				
				If (Count parameters:C259>=3)
					
					$parent:=This:C1470._attachTo($attachTo)
					
				Else 
					
					// Auto
					$parent:=This:C1470._attachTo()
					
				End if 
				
			Else 
				
				$parent:=This:C1470._attachTo($WidthOrNode)
				
			End if 
		End if 
		
		This:C1470.latest:=Super:C1706.create($parent; "rect"; New object:C1471(\
			"width"; $height; \
			"height"; $width))
		
	End if 
	
	$this:=This:C1470
	
	//———————————————————————————————————————————————————————————
Function square($side : Real; $attachTo)->$this : cs:C1710.svg
	
	var $parent : Text
	
	If (This:C1470._requiredParams(Count parameters:C259; 1))
		
		If (Count parameters:C259>=2)
			
			$parent:=This:C1470._attachTo($attachTo)
			
		Else 
			
			// Auto
			$parent:=This:C1470._attachTo()
			
		End if 
		
		This:C1470.latest:=Super:C1706.create($parent; "rect"; New object:C1471(\
			"width"; $side; \
			"height"; $side))
		
	End if 
	
	$this:=This:C1470
	
	//———————————————————————————————————————————————————————————
Function circle($radius : Real; $cx : Real; $cy : Real; $attachTo)->$this : cs:C1710.svg
	
	var $parent : Text
	var $x; $y : Real
	
	If (This:C1470._requiredParams(Count parameters:C259; 1))
		
		If (Count parameters:C259>=4)
			
			$parent:=This:C1470._attachTo($attachTo)
			
		Else 
			
			// Auto
			$parent:=This:C1470._attachTo()
			
		End if 
		
		If (Count parameters:C259>=2)
			
			$x:=$cx
			$y:=$cx
			
			If (Count parameters:C259>=3)
				
				$y:=$cy
				
			End if 
		End if 
		
		This:C1470.latest:=Super:C1706.create($parent; "circle"; New object:C1471(\
			"cx"; $x; \
			"cy"; $y; \
			"r"; $radius))
		
	End if 
	
	$this:=This:C1470
	
	//———————————————————————————————————————————————————————————
Function ellipse($radiusX : Real; $radiusY : Real; $cx : Real; $cy : Real; $attachTo)->$this : cs:C1710.svg
	
	var $parent : Text
	
	If (This:C1470._requiredParams(Count parameters:C259; 3))
		
		If (Count parameters:C259>=5)
			
			$parent:=This:C1470._attachTo($attachTo)
			
		Else 
			
			// Auto
			$parent:=This:C1470._attachTo()
			
		End if 
		
		If (Count parameters:C259>=4)
			
			This:C1470.latest:=Super:C1706.create($parent; "ellipse"; New object:C1471(\
				"cx"; $cx; \
				"cy"; $cy; \
				"rx"; $radiusX; \
				"ry"; $radiusY))
			
		Else 
			
			This:C1470.latest:=Super:C1706.create($parent; "ellipse"; New object:C1471(\
				"cx"; $cx; \
				"cy"; $cx; \
				"rx"; $radiusX; \
				"ry"; $radiusY))
			
		End if 
	End if 
	
	$this:=This:C1470
	
	//———————————————————————————————————————————————————————————
Function imageEmbedded($picture : Picture; $attachTo)->$this : cs:C1710.svg
	
	var $parent; $t : Text
	var $height; $width : Integer
	var $x : Blob
	
	If (This:C1470._requiredParams(Count parameters:C259; 1))
		
		If (Count parameters:C259>=2)
			
			$parent:=This:C1470._applyTo($attachTo)
			
		Else 
			
			// Auto
			$parent:=This:C1470._applyTo()
			
		End if 
		
		This:C1470.success:=(Picture size:C356($picture)>0)
		
		If (This:C1470.success)
			
			// Encode in base64
			PICTURE TO BLOB:C692($picture; $x; ".png")
			This:C1470.success:=Bool:C1537(OK)
			
			If (This:C1470.success)
				
				BASE64 ENCODE:C895($x; $t)
				CLEAR VARIABLE:C89($x)
				
				// Put the encoded image
				PICTURE PROPERTIES:C457($picture; $width; $height)
				
				This:C1470.latest:=Super:C1706.create($parent; "image"; New object:C1471(\
					"xlink:href"; "data:;base64,"+$t; \
					"x"; 0; \
					"y"; 0; \
					"width"; $width; \
					"height"; $height))
				
			End if 
			
		Else 
			
			This:C1470.errors.push("Given picture is empty")
			
		End if 
	End if 
	
	$this:=This:C1470
	
	//———————————————————————————————————————————————————————————
Function line($x1 : Real; $y1 : Real; $x2 : Real; $y2 : Real; $attachTo)->$this : cs:C1710.svg
	
	var $parent : Text
	
	If (This:C1470._requiredParams(Count parameters:C259; 4))
		
		If (Count parameters:C259=5)
			
			$parent:=This:C1470._attachTo($attachTo)
			
		Else 
			
			// Auto
			$parent:=This:C1470._attachTo()
			
		End if 
		
		This:C1470.latest:=Super:C1706.create($parent; "line"; New object:C1471(\
			"x1"; $x1; \
			"y1"; $y1; \
			"x2"; $x2; \
			"y2"; $y2))
		
	End if 
	
	$this:=This:C1470
	
	//———————————————————————————————————————————————————————————
Function imageRef($file : 4D:C1709.File; $attachTo)->$this : cs:C1710.svg
	
	var $parent; $t : Text
	var $p : Picture
	var $height; $width : Integer
	
	If (This:C1470._requiredParams(Count parameters:C259; 1))
		
		If (Count parameters:C259>=2)
			
			$parent:=This:C1470._applyTo($attachTo)
			
		Else 
			
			// Auto
			$parent:=This:C1470._applyTo()
			
		End if 
		
		This:C1470.success:=Bool:C1537($file.exists)
		
		If (This:C1470.success)
			
			$t:=$file.platformPath
			READ PICTURE FILE:C678($t; $p)
			This:C1470.success:=Bool:C1537(OK)
			
			If (This:C1470.success)
				
				PICTURE PROPERTIES:C457($p; $width; $height)
				CLEAR VARIABLE:C89($p)
				
				This:C1470.success:=Bool:C1537(OK)
				
				If (This:C1470.success)
					
					$t:="file:/"+"/"\
						+Choose:C955(Is Windows:C1573; "/"; "")\
						+Replace string:C233($file.path; " "; "%20")
					
					This:C1470.latest:=Super:C1706.create($parent; "image"; New object:C1471(\
						"xlink:href"; $t; \
						"x"; 0; \
						"y"; 0; \
						"width"; $width; \
						"height"; $height))
					
				End if 
			End if 
			
			If (Not:C34(This:C1470.success))
				
				This:C1470.errors.push("Failed to create image \""+String:C10($file.path)+"\"")
				
			End if 
			
		Else 
			
			This:C1470.errors.push("File not found \""+String:C10($file.path)+"\"")
			
		End if 
	End if 
	
	$this:=This:C1470
	
	//———————————————————————————————————————————————————————————
Function textArea($text : Text; $attachTo)->$this : cs:C1710.svg
	
	var $node; $parent; $substring; $t : Text
	var $indx : Integer
	
	If (Count parameters:C259>=2)
		
		$parent:=This:C1470._applyTo($attachTo)
		
	Else 
		
		// Auto
		$parent:=This:C1470._applyTo()
		
	End if 
	
	This:C1470.latest:=Super:C1706.create($parent; "textArea"; New object:C1471(\
		"x"; 0; \
		"y"; 0; \
		"width"; "auto"; \
		"height"; "auto"))
	
	If (This:C1470.success)\
		 & (Length:C16($text)>0)
		
		$t:=Replace string:C233(String:C10($text); "\r\n"; "\r")
		
		Repeat 
			
			$indx:=Position:C15("\r"; $t)
			
			If ($indx=0)
				
				$indx:=Position:C15("\n"; $t)
				
			End if 
			
			If ($indx>0)
				
				$substring:=Substring:C12($t; 1; $indx-1)
				
				If (Length:C16($substring)>0)
					
					$node:=DOM Append XML child node:C1080(This:C1470.latest; XML DATA:K45:12; $substring)
					
				End if 
				
				$node:=DOM Append XML child node:C1080(This:C1470.latest; XML ELEMENT:K45:20; "tbreak")
				
				$t:=Delete string:C232($t; 1; Length:C16($substring)+1)
				
			Else 
				
				If (Length:C16($t)>0)
					
					$node:=DOM Append XML child node:C1080(This:C1470.latest; XML DATA:K45:12; $t)
					
				End if 
			End if 
		Until ($indx=0)\
			 | (OK=0)
		
		This:C1470.success:=Bool:C1537(OK)
		
	End if 
	
	$this:=This:C1470
	
	//———————————————————————————————————————————————————————————
	// Creates a set of connected straight line segments,
	// generally resulting in an open shape usually without fill
Function polyline($points : Variant; $attachTo)->$this : cs:C1710.svg
	
	If (Count parameters:C259>=2)
		
		This:C1470.latest:=Super:C1706.create(This:C1470._attachTo($attachTo); "polyline")
		
	Else 
		
		This:C1470.latest:=Super:C1706.create(This:C1470._attachTo(); "polyline")
		
	End if 
	
	If (This:C1470.success)
		
		Super:C1706.setAttribute(This:C1470.latest; "fill"; "none")
		
		If (Count parameters:C259>=1)
			
			This:C1470.points($points; This:C1470.latest)
			
		End if 
	End if 
	
	$this:=This:C1470
	
	//———————————————————————————————————————————————————————————
	// Defines a closed shape consisting of connected lines.
Function polygon($points : Variant; $attachTo)->$this : cs:C1710.svg
	
	If (Count parameters:C259>=2)
		
		This:C1470.latest:=Super:C1706.create(This:C1470._attachTo($attachTo); "polygon")
		
	Else 
		
		This:C1470.latest:=Super:C1706.create(This:C1470._attachTo(); "polygon")
		
	End if 
	
	If (This:C1470.success)
		
		If (Count parameters:C259>=1)
			
			This:C1470.points($points; This:C1470.latest)
			
		End if 
	End if 
	
	$this:=This:C1470
	
	//———————————————————————————————————————————————————————————
	// Populate the "points" property of a polyline, polygon
Function points($points : Variant; $applyTo)->$this : cs:C1710.svg
	
	var $name; $node : Text
	var $i : Integer
	
	If (This:C1470._requiredParams(Count parameters:C259; 1))
		
		If (Count parameters:C259>=2)
			
			$node:=This:C1470._applyTo($applyTo)
			
		Else 
			
			// Auto
			$node:=This:C1470._applyTo()
			
		End if 
		
		DOM GET XML ELEMENT NAME:C730($node; $name)
		
		Case of 
				
				//…………………………………………………………………………………………………
			: ($name="polyline")\
				 | ($name="polygon")
				
				Case of 
						//______________________________________________________
					: (Value type:C1509($points)=Is collection:K8:32)
						
						For ($i; 0; $points.length-1; 1)
							
							$points[$i]:=$points[$i].join(",")
							
						End for 
						
						Super:C1706.setAttribute($node; "points"; $points.join(" "))
						
						//______________________________________________________
					: (Value type:C1509($points)=Is text:K8:3)
						
						Super:C1706.setAttribute($node; "points"; $points)
						
						//______________________________________________________
					Else 
						
						// #ERROR
						
						//______________________________________________________
				End case 
				
				//…………………………………………………………………………………………………
			: ($name="path")
				
				// #TO_DO
				
				//…………………………………………………………………………………………………
			Else 
				
				// #ERROR
				
				//…………………………………………………………………………………………………
		End case 
	End if 
	
	$this:=This:C1470
	
	//———————————————————————————————————————————————————————————
	// Absolute moveTo
Function M($points : Variant; $applyTo)->$this : cs:C1710.svg
	
	var $name; $node : Text
	
	If (This:C1470._requiredParams(Count parameters:C259; 1))
		
		If (Count parameters:C259>=2)
			
			$node:=This:C1470._applyTo($applyTo)
			
		Else 
			
			// Auto
			$node:=This:C1470._applyTo()
			
		End if 
		
		DOM GET XML ELEMENT NAME:C730($node; $name)
		
		Case of 
				
				//______________________________________________________
			: (Value type:C1509($points)=Is collection:K8:32)
				
				Case of 
						
						//…………………………………………………………………………………………………
					: ($name="polyline")\
						 | ($name="polygon")
						
						Super:C1706.setAttribute($node; "points"; String:C10($points[0]; "&xml")+","+String:C10($points[1]; "&xml"))
						
						//…………………………………………………………………………………………………
					: ($name="path")
						
						// #TO_DO
						
						//…………………………………………………………………………………………………
					Else 
						
						// #ERROR
						
						//…………………………………………………………………………………………………
				End case 
				
				//______________________________________________________
			: (Value type:C1509($points)=Is text:K8:3)
				
				Super:C1706.setAttribute($node; "points"; $points)
				
				//______________________________________________________
			Else 
				
				// #ERROR
				
				//______________________________________________________
		End case 
	End if 
	
	$this:=This:C1470
	
	//———————————————————————————————————————————————————————————
	// Absolute lineTo
Function L($points : Variant; $applyTo)->$this : cs:C1710.svg
	
	var $name; $node; $t : Text
	var $i : Integer
	
	If (This:C1470._requiredParams(Count parameters:C259; 1))
		
		If (Count parameters:C259>=2)
			
			$node:=This:C1470._applyTo($applyTo)
			
		Else 
			
			// Auto
			$node:=This:C1470._applyTo()
			
		End if 
		
		DOM GET XML ELEMENT NAME:C730($node; $name)
		
		Case of 
				
				//______________________________________________________
			: (Value type:C1509($points)=Is collection:K8:32)
				
				Case of 
						
						//…………………………………………………………………………………………………
					: ($name="polyline")\
						 | ($name="polygon")
						
						If ($points.length%2=0)
							
							For ($i; 0; $points.length-1; 2)
								
								$t:=$t+String:C10($points[$i]; "&xml")+" "+String:C10($points[$i+1]; "&xml")
								
							End for 
							
							Super:C1706.setAttribute($node; "points"; String:C10(This:C1470.getAttribute($node; "points"))+" "+$t)
							
						Else 
							
							// #ERROR
							
						End if 
						
						//…………………………………………………………………………………………………
					: ($name="path")
						
						// #TO_DO
						
						//…………………………………………………………………………………………………
					Else 
						
						// #ERROR
						
						//…………………………………………………………………………………………………
				End case 
				
				//______________________________________________________
			: (Value type:C1509($points)=Is text:K8:3)
				
				Super:C1706.setAttribute($node; "points"; String:C10(This:C1470.getAttribute($node; "points"))+" "+$points)
				
				//______________________________________________________
			Else 
				
				// #ERROR
				
				//______________________________________________________
		End case 
	End if 
	
	$this:=This:C1470
	
	//———————————————————————————————————————————————————————————
	// Relative moveTo
Function m
	
	//#TO_DO
	
	//———————————————————————————————————————————————————————————
	// Relative lineTo
Function l
	
	//#TO_DO
	
	//———————————————————————————————————————————————————————————
	// Populate the "d" property of a path
Function d
	
	//#TO_DO
	
/*================================================================
                         ATTRIBUTES
================================================================*/
	
	//———————————————————————————————————————————————————————————
Function preserveAspectRatio($value : Text; $applyTo)->$this : cs:C1710.svg
	
	var $node : Text
	
	If (Count parameters:C259>=2)
		
		$node:=This:C1470._applyTo($applyTo)
		
	Else 
		
		// Auto
		$node:=This:C1470._applyTo()
		
	End if 
	
	If (This:C1470._aspectRatioValues.indexOf($value)#-1)
		
		Super:C1706.setAttribute($node; "preserveAspectRatio"; $value)
		
	Else 
		
		Super:C1706.setAttribute($node; "preserveAspectRatio"; "xMidYMid")  // Set to default
		
	End if 
	
	//———————————————————————————————————————————————————————————
Function id($id : Text; $applyTo)->$this : cs:C1710.svg
	
	var $node : Text
	
	$node:=This:C1470.findById($id)
	
	If (This:C1470.success)
		
		This:C1470.errors.push(Current method name:C684+" - The id \""+$id+"\" already exist!")
		
	Else 
		
		If (Count parameters:C259>=2)
			
			$node:=This:C1470._applyTo($applyTo)
			
		Else 
			
			// Auto
			$node:=This:C1470._applyTo()
			
		End if 
		
		Super:C1706.setAttribute($node; "id"; $id)
		This:C1470.push()
		
	End if 
	
	$this:=This:C1470
	
	//———————————————————————————————————————————————————————————
Function dimensions($width : Real; $height : Real; $unit : Text)->$this : cs:C1710.svg
	
	var $node; $name : Text
	
	$node:=This:C1470._applyTo()
	DOM GET XML ELEMENT NAME:C730($node; $name)
	
	Case of 
			
			//______________________________________________________
		: ($name="textArea")
			
			Case of 
					
					//……………………………………………………………………………………………………
				: (Count parameters:C259=0)
					
					Super:C1706.setAttributes($node; New object:C1471(\
						"width"; "auto"; \
						"height"; "auto"))
					
					//……………………………………………………………………………………………………
				: (Count parameters:C259>=3)
					
					Super:C1706.setAttributes($node; New object:C1471(\
						"width"; Choose:C955($width=0; "auto"; String:C10($width; "&xml")+String:C10($unit)); \
						"height"; Choose:C955($height=0; "auto"; String:C10($height; "&xml")+String:C10($unit))))
					
					//……………………………………………………………………………………………………
				: (Count parameters:C259>=2)
					
					Super:C1706.setAttributes($node; New object:C1471(\
						"width"; Choose:C955($width=0; "auto"; String:C10($width; "&xml")); \
						"height"; Choose:C955($height=0; "auto"; String:C10($height; "&xml"))))
					
					//……………………………………………………………………………………………………
				: (Count parameters:C259>=1)
					
					Super:C1706.setAttribute($node; "width"; Choose:C955($width=0; "auto"; String:C10($width; "&xml")))
					
					//……………………………………………………………………………………………………
			End case 
			
			//______________________________________________________
		: ($name="line")\
			 | ($name="circle")\
			 | ($name="ellipse")
			
			// #TO_DO
			
			//______________________________________________________
		Else 
			
			Case of 
					
					//……………………………………………………………………………………………………
				: (Count parameters:C259>=3)
					
					Super:C1706.setAttributes($node; New object:C1471(\
						"width"; String:C10($width; "&xml")+String:C10($unit); \
						"height"; String:C10($height; "&xml")+String:C10($unit)))
					
					//……………………………………………………………………………………………………
				: (Count parameters:C259>=2)
					
					Super:C1706.setAttributes($node; New object:C1471(\
						"width"; String:C10($width; "&xml"); \
						"height"; String:C10($height; "&xml")))
					
					//……………………………………………………………………………………………………
				: (Count parameters:C259>=1)
					
					Super:C1706.setAttribute($node; "width"; String:C10($width; "&xml"))
					
					//……………………………………………………………………………………………………
			End case 
			
			//______________________________________________________
	End case 
	
	$this:=This:C1470
	
/*———————————————————————————————————————————————————————————*/
Function position($x : Real; $y : Variant; $unit : Text)->$this : cs:C1710.svg
	
	var $element; $node : Text
	
	$node:=This:C1470._applyTo()
	$element:=This:C1470.getName($node)
	
	Case of 
			
			//______________________________________________________
		: ($element="svg")\
			 | ($element="g")
			
			This:C1470.success:=False:C215
			This:C1470.errors.push(Current method name:C684+" You can't set position for the element"+$element+"!")
			
			//______________________________________________________
		: ($element="circle")\
			 | ($element="ellipse")
			
			Case of 
					
					//…………………………………………………………………………………………………
				: (Count parameters:C259=3)
					
					If (Value type:C1509($y)=Is real:K8:4)
						
						Super:C1706.setAttributes($node; New object:C1471(\
							"cx"; String:C10($x; "&xml")+$unit; \
							"cy"; String:C10($y; "&xml")+$unit))
						
					Else 
						
						Super:C1706.setAttributes($node; New object:C1471(\
							"cx"; String:C10($x; "&xml")+$unit; \
							"cy"; String:C10(Num:C11($y); "&xml")+$unit))
						
					End if 
					
					//…………………………………………………………………………………………………
				: (Count parameters:C259=2)
					
					If (Value type:C1509($y)=Is real:K8:4)
						
						Super:C1706.setAttributes($node; New object:C1471(\
							"cx"; $x; \
							"cy"; $y))
						
					Else 
						
						Super:C1706.setAttributes($node; New object:C1471(\
							"cx"; String:C10($x; "&xml")+String:C10($y); \
							"cy"; String:C10($x; "&xml")+String:C10($y)))
						
					End if 
					
					//…………………………………………………………………………………………………
				: (Count parameters:C259=1)
					
					Super:C1706.setAttributes($node; New object:C1471(\
						"cx"; $x; \
						"cy"; $x))
					
					//…………………………………………………………………………………………………
				Else 
					
					This:C1470.success:=False:C215
					This:C1470.errors.push(Current method name:C684+" Missing parameter")
					
					//…………………………………………………………………………………………………
			End case 
			
			//______________________________________________________
		: ($element="line")
			
			Case of 
					
					//…………………………………………………………………………………………………
				: (Count parameters:C259=3)
					
					If (Value type:C1509($y)=Is real:K8:4)
						
						Super:C1706.setAttributes($node; New object:C1471(\
							"x1"; String:C10($x; "&xml")+$unit; \
							"y1"; String:C10($y; "&xml")+$unit))
						
					Else 
						
						Super:C1706.setAttributes($node; New object:C1471(\
							"x1"; String:C10($x; "&xml")+$unit; \
							"y1"; String:C10(Num:C11($y); "&xml")+$unit))
						
					End if 
					
					//…………………………………………………………………………………………………
				: (Count parameters:C259=2)
					
					If (Value type:C1509($y)=Is real:K8:4)
						
						Super:C1706.setAttributes($node; New object:C1471(\
							"x1"; $x; \
							"y1"; $y))
						
					Else 
						
						Super:C1706.setAttributes($node; New object:C1471(\
							"x1"; String:C10($x; "&xml")+String:C10($y); \
							"y1"; String:C10($x; "&xml")+String:C10($y)))
						
					End if 
					
					//…………………………………………………………………………………………………
				: (Count parameters:C259=1)
					
					Super:C1706.setAttributes($node; New object:C1471(\
						"x1"; $x; \
						"y1"; $x))
					
					//…………………………………………………………………………………………………
				Else 
					
					This:C1470.success:=False:C215
					This:C1470.errors.push(Current method name:C684+" Missing parameter")
					
					//…………………………………………………………………………………………………
			End case 
			
			//______________________________________________________
		Else 
			
			Case of 
					
					//…………………………………………………………………………………………………
				: (Count parameters:C259=3)
					
					If (Value type:C1509($y)=Is real:K8:4)
						
						Super:C1706.setAttributes($node; New object:C1471(\
							"x"; String:C10($x; "&xml")+$unit; \
							"y"; String:C10($y; "&xml")+$unit))
						
					Else 
						
						Super:C1706.setAttributes($node; New object:C1471(\
							"x"; String:C10($x; "&xml")+$unit; \
							"y"; String:C10(Num:C11($y); "&xml")+$unit))
						
					End if 
					
					//…………………………………………………………………………………………………
				: (Count parameters:C259=2)
					
					If (Value type:C1509($y)=Is real:K8:4)
						
						Super:C1706.setAttributes($node; New object:C1471(\
							"x"; $x; \
							"y"; $y))
						
					Else 
						
						Super:C1706.setAttributes($node; New object:C1471(\
							"x"; String:C10($x; "&xml")+String:C10($y); \
							"y"; String:C10($x; "&xml")+String:C10($y)))
						
					End if 
					
					//…………………………………………………………………………………………………
				: (Count parameters:C259=1)
					
					Super:C1706.setAttributes($node; New object:C1471(\
						"x"; $x; \
						"y"; $x))
					
					//…………………………………………………………………………………………………
				Else 
					
					This:C1470.success:=False:C215
					This:C1470.errors.push(Current method name:C684+" Missing parameter")
					
					//…………………………………………………………………………………………………
			End case 
			
			//______________________________________________________
	End case 
	
	$this:=This:C1470
	
	//———————————————————————————————————————————————————————————
Function translate($x : Real; $y : Real; $applyTo)->$this : cs:C1710.svg
	
	var $node; $t; $transform : Text
	var $indx : Integer
	var $c : Collection
	
	If (Count parameters:C259>=3)
		
		$node:=This:C1470._applyTo($applyTo)
		
	Else 
		
		// Auto
		$node:=This:C1470._applyTo()
		
	End if 
	
	$transform:="translate("+String:C10($x; "&xml")+","+String:C10($y; "&xml")+")"
	
	$t:=This:C1470.getAttribute($node; "transform")
	
	If (Length:C16($t)>0)
		
		$c:=Split string:C1554($t; " ")
		$indx:=$c.indexOf("translate(@")
		
		If ($indx#-1)
			
			$c[$indx]:=$transform
			
		Else 
			
			$c.push($transform)
			
		End if 
		
		$transform:=$c.join(" ")
		
	Else 
		
		This:C1470.errors.remove(This:C1470.errors.length-1)
		
	End if 
	
	Super:C1706.setAttribute($node; "transform"; $transform)
	
	$this:=This:C1470
	
	//———————————————————————————————————————————————————————————
Function rotate($angle : Integer; $cx : Variant; $cy : Real; $applyTo)->$this : cs:C1710.svg
	
	var $node; $t; $transform : Text
	var $indx : Integer
	var $c : Collection
	
	If (Count parameters:C259>=4)
		
		$node:=This:C1470._applyTo($applyTo)
		$transform:="rotate("+String:C10($angle)+" "+String:C10($cx; "&xml")+" "+String:C10($cy; "&xml")+")"
		
	Else 
		
		If (Count parameters:C259=3)
			
			// Auto
			$node:=This:C1470._applyTo()
			$transform:="rotate("+String:C10($angle)+" "+String:C10($cx; "&xml")+" "+String:C10($cy; "&xml")+")"
			
		Else 
			
			If (Count parameters:C259=2)
				
				If (Value type:C1509($cx)=Is text:K8:3)
					
					$node:=This:C1470._applyTo($cx)
					
				Else 
					
					$node:=This:C1470._applyTo()
					
				End if 
				
			Else 
				
				$node:=This:C1470._applyTo()
				
			End if 
			
			$transform:="rotate("+String:C10($angle)+")"
			
		End if 
	End if 
	
	$t:=This:C1470.getAttribute($node; "transform")
	
	If (Length:C16($t)>0)
		
		$c:=Split string:C1554($t; " ")
		$indx:=$c.indexOf("rotate(@")
		
		If ($indx#-1)
			
			$c[$indx]:=$transform
			
		Else 
			
			$c.push($transform)
			
		End if 
		
		$transform:=$c.join(" ")
		
	Else 
		
		This:C1470.errors.remove(This:C1470.errors.length-1)
		
	End if 
	
	Super:C1706.setAttribute($node; "transform"; $transform)
	
	$this:=This:C1470
	
	//———————————————————————————————————————————————————————————
Function scale($x : Real; $applyTo)->$this : cs:C1710.svg
	
	var $node; $t; $transform : Text
	var $indx : Integer
	var $c : Collection
	
	If (Count parameters:C259>=2)
		
		$node:=This:C1470._applyTo($applyTo)
		
	Else 
		
		// Auto
		$node:=This:C1470._applyTo()
		
	End if 
	
	//"scale(0.97)"
	$transform:="scale("+String:C10($x; "&xml")+")"
	
	$t:=This:C1470.getAttribute($node; "transform")
	
	If (Length:C16($t)>0)
		
		$c:=Split string:C1554($t; " ")
		$indx:=$c.indexOf("scale(@")
		
		If ($indx#-1)
			
			$c[$indx]:=$transform
			
		Else 
			
			$c.push($transform)
			
		End if 
		
		$transform:=$c.join(" ")
		
	Else 
		
		This:C1470.errors.remove(This:C1470.errors.length-1)
		
	End if 
	
	Super:C1706.setAttribute($node; "transform"; $transform)
	
	$this:=This:C1470
	
	//———————————————————————————————————————————————————————————
Function moveHorizontally($x : Real; $applyTo)->$this : cs:C1710.svg
	
	If (Count parameters:C259>=2)
		
		This:C1470.translate($x; 0; This:C1470._applyTo($applyTo))
		
	Else 
		
		This:C1470.translate($x; 0; This:C1470._applyTo())
		
	End if 
	
	$this:=This:C1470
	
	//———————————————————————————————————————————————————————————
Function moveVertically($y : Real; $applyTo)->$this : cs:C1710.svg
	
	If (Count parameters:C259>=2)
		
		This:C1470.translate(0; $y; This:C1470._applyTo($applyTo))
		
	Else 
		
		This:C1470.translate(0; $y; This:C1470._applyTo())
		
	End if 
	
	$this:=This:C1470
	
	//———————————————————————————————————————————————————————————
Function font($attributes : Object; $applyTo)->$this : cs:C1710.svg
	
	var $node : Text
	
	If (Count parameters:C259>=2)
		
		$node:=This:C1470._applyTo($applyTo)
		
	Else 
		
		// Auto
		$node:=This:C1470._applyTo()
		
	End if 
	
	If ($attributes.font#Null:C1517)
		
		This:C1470.fontFamily($attributes.font; $node)
		
	End if 
	
	If ($attributes.size#Null:C1517)
		
		This:C1470.fontSize($attributes.size; $node)
		
	End if 
	
	If ($attributes.color#Null:C1517)
		
		This:C1470.fill($attributes.color; $node)
		
	End if 
	
	If ($attributes.style#Null:C1517)
		
		This:C1470.fontStyle($attributes.style; $node)
		
	End if 
	
	If ($attributes.alignment#Null:C1517)
		
		This:C1470.alignment($attributes.alignment; $node)
		
	End if 
	
	If ($attributes.rendering#Null:C1517)
		
		This:C1470.textRendering($attributes.rendering; $node)
		
	End if 
	
	$this:=This:C1470
	
	//———————————————————————————————————————————————————————————
Function fontFamily($fonts : Text; $applyTo)->$this : cs:C1710.svg
	
	If (Count parameters:C259>=2)
		
		Super:C1706.setAttribute(This:C1470._applyTo($applyTo); "font-family"; $fonts)
		
	Else 
		
		Super:C1706.setAttribute(This:C1470._applyTo(); "font-family"; $fonts)
		
	End if 
	
	$this:=This:C1470
	
	//———————————————————————————————————————————————————————————
Function fontSize($size : Integer; $applyTo)->$this : cs:C1710.svg
	
	If (Count parameters:C259>=2)
		
		Super:C1706.setAttribute(This:C1470._applyTo($applyTo); "font-size"; $size)
		
	Else 
		
		Super:C1706.setAttribute(This:C1470._applyTo(); "font-size"; $size)
		
	End if 
	
	$this:=This:C1470
	
	//———————————————————————————————————————————————————————————
Function fontStyle($style : Integer; $applyTo)->$this : cs:C1710.svg
	
	var $node : Text
	
	If (Count parameters:C259>=2)
		
		$node:=This:C1470._applyTo($applyTo)
		
	Else 
		
		// Auto
		$node:=This:C1470._applyTo()
		
	End if 
	
	If ($style=Normal:K14:15)
		
		Super:C1706.setAttributes($node; New object:C1471(\
			"text-decoration"; "none"; \
			"font-style"; "normal"; \
			"font-weight"; "normal"))
		
	Else 
		
		If ($style>=8)  // Line-through
			
			Super:C1706.setAttribute($node; "text-decoration"; "line-through")
			
			$style:=$style-8
			
		End if 
		
		If (This:C1470.success)\
			 & ($style>=Underline:K14:4)
			
			Super:C1706.setAttribute($node; "text-decoration"; "underline")
			
			$style:=$style-Underline:K14:4
			
		End if 
		
		If (This:C1470.success)\
			 & ($style>=Italic:K14:3)
			
			Super:C1706.setAttribute($node; "font-style"; "italic")
			
			$style:=$style-Italic:K14:3
			
		End if 
		
		If (This:C1470.success)\
			 & ($style=Bold:K14:2)
			
			Super:C1706.setAttribute($node; "font-weight"; "bold")
			
		End if 
	End if 
	
	$this:=This:C1470
	
	//———————————————————————————————————————————————————————————
Function alignment($alignment : Integer; $applyTo)->$this : cs:C1710.svg
	
	var $node; $type : Text
	
	If (Count parameters:C259>=2)
		
		$node:=This:C1470._applyTo($applyTo)
		
	Else 
		
		// Auto
		$node:=This:C1470._applyTo()
		
	End if 
	
	DOM GET XML ELEMENT NAME:C730($node; $type)
	
	Case of 
			
			//…………………………………………………………………………………………
		: ($alignment=Align center:K42:3)
			
			If ($type="textArea")
				
				Super:C1706.setAttribute($node; "text-align"; "center")
				
			Else 
				
				Super:C1706.setAttribute($node; "text-anchor"; "middle")
				
			End if 
			
			//…………………………………………………………………………………………
		: ($alignment=Align right:K42:4)
			
			If ($type="textArea")
				
				Super:C1706.setAttribute($node; "text-align"; "end")
				
			Else 
				
				Super:C1706.setAttribute($node; "text-anchor"; "end")
				
			End if 
			
			//…………………………………………………………………………………………
		: ($alignment=Align left:K42:2)\
			 | ($alignment=Align default:K42:1)
			
			If ($type="textArea")
				
				Super:C1706.setAttribute($node; "text-align"; "start")
				
			Else 
				
				Super:C1706.setAttribute($node; "text-anchor"; "start")
				
			End if 
			
			//…………………………………………………………………………………………
		: ($alignment=5)\
			 & ($type="textArea")
			
			Super:C1706.setAttribute($node; "text-align"; "justify")
			
			//…………………………………………………………………………………………
		Else 
			
			If ($type="textArea")
				
				Super:C1706.setAttribute($node; "text-align"; "inherit")
				
			Else 
				
				Super:C1706.setAttribute($node; "text-anchor"; "inherit")
				
			End if 
			
			//…………………………………………………………………………………………
	End case 
	
	$this:=This:C1470
	
	//———————————————————————————————————————————————————————————
Function textRendering($rendering : Text; $applyTo)->$this : cs:C1710.svg
	
	var $node : Text
	
	If (Count parameters:C259>=2)
		
		$node:=This:C1470._applyTo($applyTo)
		
	Else 
		
		// Auto
		$node:=This:C1470._applyTo()
		
	End if 
	
	If (New collection:C1472("auto"; "optimizeSpeed"; "optimizeLegibility"; "geometricPrecision"; "inherit").indexOf($rendering)#-1)
		
		Super:C1706.setAttribute($node; "text-rendering"; $rendering)
		
	Else 
		
		This:C1470.success:=False:C215
		This:C1470.errors.push("Unknown value ("+$rendering+") for text-rendering.")
		
	End if 
	
	$this:=This:C1470
	
	//———————————————————————————————————————————————————————————/
	// ⚠️ Overrides the method of the inherited class
Function setAttribute($name : Text; $value : Variant; $applyTo)->$this : cs:C1710.svg
	
	If (Count parameters:C259=3)
		
		Super:C1706.setAttribute(This:C1470._applyTo($applyTo); $name; $value)
		
	Else 
		
		Super:C1706.setAttribute(This:C1470._applyTo(); $name; $value)
		
	End if 
	
	$this:=This:C1470
	
	//———————————————————————————————————————————————————————————/
	// ⚠️ Overrides the method of the inherited class
Function setAttributes($attributes : Variant; $value : Variant; $applyTo)->$this : cs:C1710.svg
	
	var $node; $t : Text
	var $o : Object
	var $c : Collection
	
	Case of 
			
			//______________________________________________________
		: (Value type:C1509($attributes)=Is object:K8:27)
			
			If ($attributes#Null:C1517)
				
				$node:=This:C1470._applyTo($attributes)
				
				$c:=OB Entries:C1720($attributes)
				
				For each ($t; New collection:C1472("target"; "left"; "top"; "width"; "height"; "codec"))
					
					$c:=$c.query("key != :1"; $t)
					
				End for each 
				
				Super:C1706.setAttributes($node; $c)
				
			End if 
			
			//______________________________________________________
		: (Value type:C1509($attributes)=Is collection:K8:32)
			
			$o:=$attributes.query("key=target").pop()
			
			If ($o#Null:C1517)
				
				$node:=This:C1470._applyTo($o.value)
				
			Else 
				
				// Auto
				$node:=This:C1470._applyTo()
				
			End if 
			
			For each ($t; New collection:C1472("target"; "left"; "top"; "width"; "height"; "codec"))
				
				$attributes:=$attributes.query("key != :1"; $t)
				
			End for each 
			
			Super:C1706.setAttributes($node; $c)
			
			//______________________________________________________
		: (Value type:C1509($attributes)=Is text:K8:3)
			
			If (Count parameters:C259=3)
				
				Super:C1706.setAttribute($applyTo; $attributes; $value)
				
			Else 
				
				If (This:C1470.isReference($attributes))
					
					Super:C1706.setAttributes($attributes; $value)
					
				Else 
					
					Super:C1706.setAttributes(This:C1470._applyTo(); $attributes; $value)
					
				End if 
			End if 
			
			//______________________________________________________
		Else 
			
			This:C1470.success:=False:C215
			
			//______________________________________________________
	End case 
	
	$this:=This:C1470
	
	//———————————————————————————————————————————————————————————/
	// ⚠️ Overrides the method of the inherited class
Function setValue($value : Text; $applyTo; $CDATA : Boolean)->$this : cs:C1710.svg
	
	var $node : Text
	var $isCDATA : Boolean
	
	If (Count parameters:C259>=2)
		
		If (Count parameters:C259>=3)
			
			$isCDATA:=$CDATA
			$node:=This:C1470._applyTo(String:C10($applyTo))
			
		Else 
			
			If (Value type:C1509($applyTo)=Is text:K8:3)
				
				$node:=This:C1470._applyTo($applyTo)
				
			Else 
				
				$node:=This:C1470._applyTo()
				$isCDATA:=Bool:C1537($applyTo)
				
			End if 
		End if 
		
	Else 
		
		$node:=This:C1470._applyTo()
		
	End if 
	
	If ($isCDATA)
		
		Super:C1706.setValue($node; $value; True:C214)
		
	Else 
		
		Super:C1706.setValue($node; $value)
		
	End if 
	
	$this:=This:C1470
	
	//———————————————————————————————————————————————————————————
	// Sets shape stroke and fill color.
Function color($color : Text; $applyTo)->$this : cs:C1710.svg
	
	var $node : Text
	
	If (Count parameters:C259>=2)
		
		$node:=This:C1470._applyTo($applyTo)
		
	Else 
		
		// Auto
		$node:=This:C1470._applyTo()
		
	End if 
	
	Super:C1706.setAttribute($node; "fill"; $color)
	Super:C1706.setAttribute($node; "stroke"; $color)
	
	$this:=This:C1470
	
	//———————————————————————————————————————————————————————————/
	// Sets opacity of stroke and fill.
Function opacity($opacity : Real; $applyTo)->$this : cs:C1710.svg
	
	var $node : Text
	
	If (Count parameters:C259>=2)
		
		$node:=This:C1470._applyTo($applyTo)
		
	Else 
		
		// Auto
		$node:=This:C1470._applyTo()
		
	End if 
	
	This:C1470.fillOpacity($opacity; $node)
	This:C1470.strokeOpacity($opacity; $node)
	
	$this:=This:C1470
	
	//———————————————————————————————————————————————————————————/
	// Sets the fill attributes
Function fill($value; $applyTo)->$this : cs:C1710.svg
	
	var $node : Text
	
	If (Count parameters:C259>=2)
		
		$node:=This:C1470._applyTo($applyTo)
		
	Else 
		
		// Auto
		$node:=This:C1470._applyTo()
		
	End if 
	
	Case of 
			
			//______________________________________________________
		: (Value type:C1509($value)=Is text:K8:3)  // Set color
			
			If ($node=This:C1470.root)
				
				Super:C1706.setAttribute($node; "viewport-fill"; $value)
				
			Else 
				
				Super:C1706.setAttribute($node; "fill"; $value)
				
			End if 
			
			//______________________________________________________
		: (Value type:C1509($value)=Is boolean:K8:9)  // Set visibility
			
			If ($node=This:C1470.root)
				
				If ($value)
					
					If (String:C10(This:C1470.getAttribute($node; "viewport-fill"))="none")
						
						This:C1470.removeAttribute($node; "viewport-fill")
						
					End if 
					
				Else 
					
					Super:C1706.setAttribute($node; "viewport-fill"; "none")
					
				End if 
				
			Else 
				
				If ($value)
					
					If (String:C10(This:C1470.getAttribute($node; "fill"))="none")
						
						This:C1470.removeAttribute($node; "fill")
						
					End if 
					
				Else 
					
					Super:C1706.setAttribute($node; "fill"; "none")
					
				End if 
			End if 
			
			//______________________________________________________
		: (Value type:C1509($value)=Is object:K8:27)  // Multiple attributes
			
			If ($value.color#Null:C1517)
				
				If ($node=This:C1470.root)
					
					Super:C1706.setAttribute($node; "viewport-fill"; $value.color)
					
				Else 
					
					Super:C1706.setAttribute($node; "fill"; $value.color)
					
				End if 
			End if 
			
			If ($value.opacity#Null:C1517)
				
				If ($node=This:C1470.root)
					
					Super:C1706.setAttribute($node; "viewport-fill-opacity"; $value.opacity)
					
				Else 
					
					Super:C1706.setAttribute($node; "fill-opacity"; $value.opacity)
					
				End if 
			End if 
			
			//______________________________________________________
		Else 
			
			This:C1470.success:=False:C215
			This:C1470.errors.push(Current method name:C684+" - Bad parameter type")
			
			//______________________________________________________
	End case 
	
	$this:=This:C1470
	
	//———————————————————————————————————————————————————————————/
Function fillColor($color : Text; $applyTo)->$this : cs:C1710.svg
	
	var $node : Text
	
	If (Count parameters:C259>=2)
		
		$node:=This:C1470._applyTo($applyTo)
		
	Else 
		
		// Auto
		$node:=This:C1470._applyTo()
		
	End if 
	
	If ($node=This:C1470.root)
		
		Super:C1706.setAttribute($node; "viewport-fill"; $color)
		
	Else 
		
		Super:C1706.setAttribute($node; "fill"; $color)
		
	End if 
	
	$this:=This:C1470
	
	//———————————————————————————————————————————————————————————/
Function fillOpacity($opacity : Real; $applyTo)->$this : cs:C1710.svg
	
	var $node : Text
	
	If (Count parameters:C259>=2)
		
		$node:=This:C1470._applyTo($applyTo)
		
	Else 
		
		// Auto
		$node:=This:C1470._applyTo()
		
	End if 
	
	If ($node=This:C1470.root)
		
		Super:C1706.setAttribute($node; "viewport-fill-opacity"; $opacity)
		
	Else 
		
		Super:C1706.setAttribute($node; "fill-opacity"; $opacity)
		
	End if 
	
	$this:=This:C1470
	
	//———————————————————————————————————————————————————————————
	// Sets the stroke attributes
Function stroke($value; $applyTo)->$this : cs:C1710.svg
	
	var $node : Text
	
	If (Count parameters:C259>=2)
		
		$node:=This:C1470._applyTo($applyTo)
		
	Else 
		
		// Auto
		$node:=This:C1470._applyTo()
		
	End if 
	
	Case of 
			
			//______________________________________________________
		: (Value type:C1509($value)=Is text:K8:3)  // Set color
			
			Super:C1706.setAttribute($node; "stroke"; $value)
			
			//______________________________________________________
		: (Value type:C1509($value)=Is boolean:K8:9)  // Set visibility
			
			If ($value)
				
				If (String:C10(This:C1470.getAttribute($node; "stroke"))="none")
					
					This:C1470.removeAttribute($node; "stroke")
					
				End if 
				
				If (Num:C11(This:C1470.getAttribute($node; "stroke-width"))=0)
					
					This:C1470.removeAttribute($node; "stroke-width")
					
				End if 
				
			Else 
				
				Super:C1706.setAttribute($node; "stroke"; "none")
				
			End if 
			
			//______________________________________________________
		: (Value type:C1509($value)=Is real:K8:4)  // Set width
			
			Super:C1706.setAttribute($node; "stroke-width"; $value)
			
			//______________________________________________________
		: (Value type:C1509($value)=Is object:K8:27)  // Multiple attributes
			
			If ($value.color#Null:C1517)
				
				Super:C1706.setAttribute($node; "stroke"; $value.color)
				
			End if 
			
			If ($value.width#Null:C1517)
				
				Super:C1706.setAttribute($node; "stroke-width"; $value.width)
				
			End if 
			
			If ($value.opacity#Null:C1517)
				
				Super:C1706.setAttribute($node; "stroke-opacity"; $value.opacity)
				
			End if 
			
			//______________________________________________________
		Else 
			
			This:C1470.success:=False:C215
			This:C1470.errors.push(Current method name:C684+" - Bad parameter type")
			
			//______________________________________________________
	End case 
	
	$this:=This:C1470
	
	//———————————————————————————————————————————————————————————/
Function strokeColor($color : Text; $applyTo)->$this : cs:C1710.svg
	
	If (Count parameters:C259>=2)
		
		Super:C1706.setAttribute(This:C1470._applyTo($applyTo); "stroke"; $color)
		
	Else 
		
		Super:C1706.setAttribute(This:C1470._applyTo(); "stroke"; $color)
		
	End if 
	
	$this:=This:C1470
	
	//———————————————————————————————————————————————————————————/
Function strokeWidth($width : Real; $applyTo)->$this : cs:C1710.svg
	
	If (Count parameters:C259>=2)
		
		Super:C1706.setAttribute(This:C1470._applyTo($applyTo); "stroke-width"; $width)
		
	Else 
		
		Super:C1706.setAttribute(This:C1470._applyTo(); "stroke-width"; $width)
		
	End if 
	
	$this:=This:C1470
	
	//———————————————————————————————————————————————————————————/
Function strokeOpacity($opacity : Real; $applyTo)->$this : cs:C1710.svg
	
	If (Count parameters:C259>=2)
		
		Super:C1706.setAttribute(This:C1470._applyTo($applyTo); "stroke-opacity"; $opacity)
		
	Else 
		
		Super:C1706.setAttribute(This:C1470._applyTo(); "stroke-opacity"; $opacity)
		
	End if 
	
	$this:=This:C1470
	
	//———————————————————————————————————————————————————————————/
Function visible($visible : Boolean; $applyTo)->$this : cs:C1710.svg
	
	If (Count parameters:C259>=2)
		
		Super:C1706.setAttribute(This:C1470._applyTo($applyTo); "visibility"; Choose:C955($visible; "visible"; "hidden"))
		
	Else 
		
		Super:C1706.setAttribute(This:C1470._applyTo(); "visibility"; Choose:C955($visible; "visible"; "hidden"))
		
	End if 
	
	$this:=This:C1470
	
	//———————————————————————————————————————————————————————————/
	// Attach a style sheet
Function styleSheet($file : 4D:C1709.File)->$this : cs:C1710.svg
	
	var $t : Text
	
	This:C1470.success:=OB Instance of:C1731($file; 4D:C1709.File)
	
	If (This:C1470.success)
		
		This:C1470.success:=$file.exists
		
		If (This:C1470.success)
			
			$t:="xml-stylesheet href=\"file:///"+Convert path system to POSIX:C1106($file.platformPath; *)+"\" type=\"text/css\""
			$t:=DOM Append XML child node:C1080(DOM Get XML document ref:C1088(This:C1470.root); XML processing instruction:K45:9; $t)
			This:C1470.success:=Bool:C1537(OK)
			
		Else 
			
			This:C1470.errors.push("File not found: "+$file.path)
			
		End if 
		
	Else 
		
		This:C1470.errors.push("$1 must be a 4D File")
		
	End if 
	
	$this:=This:C1470
	
	//———————————————————————————————————————————————————————————/
	// Set the node class
Function class($class : Text; $applyTo)->$this : cs:C1710.svg
	
	If (Count parameters:C259=2)
		
		Super:C1706.setAttribute(This:C1470._applyTo($applyTo); "class"; $class)
		
	Else 
		
		Super:C1706.setAttribute(This:C1470._applyTo(); "class"; $class)
		
	End if 
	
	$this:=This:C1470
	
	//———————————————————————————————————————————————————————————/
	// Add a value to the node class
Function addClass($class : Text; $applyTo)->$this : cs:C1710.svg
	
	var $node; $t : Text
	
	If (Count parameters:C259=2)
		
		$node:=This:C1470._applyTo($applyTo)
		
	Else 
		
		// Auto
		$node:=This:C1470._applyTo()
		
	End if 
	
	$t:=String:C10(This:C1470.getAttribute($node; "class"))
	
	If (Length:C16($t)>0)
		
		If (Split string:C1554($t; " ").indexOf($class)=-1)
			
			$t:=$t+" "+$class
			
		End if 
		
	Else 
		
		$t:=$class
		
	End if 
	
	Super:C1706.setAttribute($node; "class"; $t)
	
	$this:=This:C1470
	
	//———————————————————————————————————————————————————————————/
	// Fix the radius of a rounded rectangle
Function rounded($radius : Integer; $applyTo)->$this : cs:C1710.svg
	
	var $name; $node : Text
	
	If (Count parameters:C259=2)
		
		$node:=This:C1470._applyTo($applyTo)
		
	Else 
		
		// Auto
		$node:=This:C1470._applyTo()
		
	End if 
	
	$name:=This:C1470.getName($node)
	
	If ($name="rect")\
		 | ($name="g")
		
		Super:C1706.setAttribute($node; "rx"; $radius)
		
	Else 
		
		This:C1470.success:=False:C215
		This:C1470.errors.push(Current method name:C684+"cant set radius for an object "+$name)
		
	End if 
	
	$this:=This:C1470
	
	
/*================================================================
                         UTILITIES
================================================================*/
	
	//———————————————————————————————————————————————————————————
	// Keep the dom reference for future use
Function push($name : Text)->$this : cs:C1710.svg
	
	var $id : Text
	
	If (Count parameters:C259>=1)
		
		This:C1470.success:=(This:C1470.store.query("id=:1"; $name).pop()=Null:C1517)
		
		If (This:C1470.success)
			
			This:C1470.store.push(New object:C1471(\
				"id"; $name; \
				"dom"; This:C1470.latest))
			
		Else 
			
			This:C1470.errors.push("The element \""+$name+"\" already exists")
			
		End if 
		
	Else 
		
		// Use the id, if available
		$id:=String:C10(This:C1470.getAttribute(This:C1470.latest; "id"))
		
		If (Length:C16($id)>0)
			
			var $o : Object
			$o:=This:C1470.store.query("id = :1"; $id).pop()
			
			If ($o=Null:C1517)
				
				// Create
				This:C1470.store.push(New object:C1471(\
					"id"; $id; \
					"dom"; This:C1470.latest))
				
			Else 
				
				// Update
				$o.dom:=This:C1470.latest
				
			End if 
			
		Else 
			
			This:C1470.store.push(New object:C1471(\
				"id"; Generate UUID:C1066; \
				"dom"; This:C1470.latest))
			
		End if 
	End if 
	
	$this:=This:C1470
	
	//———————————————————————————————————————————————————————————
	// Retrieve a stored dom reference
Function fetch($name : Text)->$dom : Text
	
	var $o : Object
	
	If (Count parameters:C259>=1)
		
		$o:=This:C1470.store.query("id = :1"; $name).pop()
		
	Else 
		
		// Auto
		$o:=New object:C1471(\
			"dom"; This:C1470.latest)
		
	End if 
	
	This:C1470.success:=($o#Null:C1517)
	
	If (This:C1470.success)
		
		$dom:=$o.dom
		
	Else 
		
		This:C1470.errors.push("The element \""+$name+"\" doesn't exists")
		
	End if 
	
	//———————————————————————————————————————————————————————————/
	// Tests if the node belongs to a class
Function isOfClass($class : Text; $applyTo)->$isOfclass : Boolean
	
	var $node : Text
	
	If (Count parameters:C259>=2)
		
		$node:=This:C1470._applyTo($applyTo)
		
	Else 
		
		// Auto
		$node:=This:C1470._applyTo()
		
	End if 
	
	$isOfclass:=(Position:C15($class; String:C10(This:C1470.getAttribute($node; "class")))#0)
	
	//———————————————————————————————————————————————————————————/
	// Display the SVG image & tree into the SVG Viewer
Function preview($keepStructure : Boolean)
	
	// #TO_DO: Should test if the component is available
	EXECUTE METHOD:C1007("SVGTool_SHOW_IN_VIEWER"; *; This:C1470.root)
	
	If (Count parameters:C259>=1)
		
		If (This:C1470.autoClose)\
			 & (Not:C34($keepStructure))
			
			This:C1470.close()
			
		End if 
		
	Else 
		
		If (This:C1470.autoClose)
			
			This:C1470.close()
			
		End if 
	End if 
	
	//———————————————————————————————————————————————————————————
	// Returns the passed text width
Function getTextWidth($string : Text; $fontAttributes : Object)->$width : Integer
	
	var $picture : Picture
	var $height : Integer
	var $o : Object
	
	If (Count parameters:C259>=2)
		
		$o:=cs:C1710.svg.new().textArea($string).font($fontAttributes)
		
	Else 
		
		// Keep the default font that should be: Times New Roman 12 pts.
		$o:=cs:C1710.svg.new().textArea($string)
		
	End if 
	
	$picture:=$o.picture()
	PICTURE PROPERTIES:C457($picture; $width; $height)
	
	
/*================================================================
                         PRIVATES
================================================================*/
	
	//———————————————————————————————————————————————————————————
Function _applyTo($applyTo)->$node : Text
	
	var $o : Object
	
	This:C1470.success:=True:C214
	
	Case of 
			
			//______________________________________________________
		: (Count parameters:C259=0)
			
			$node:=Choose:C955(This:C1470.latest#Null:C1517; This:C1470.latest; This:C1470.root)
			
			//______________________________________________________
		: (Value type:C1509($applyTo)=Is undefined:K8:13)
			
			$node:=Choose:C955(This:C1470.latest#Null:C1517; This:C1470.latest; This:C1470.root)
			
			//______________________________________________________
		: (Value type:C1509($applyTo)=Is text:K8:3)
			
			Case of 
					
					//_______________________________
				: ($applyTo="root")
					
					$node:=This:C1470.root
					
					//_______________________________
				: ($applyTo="latest")
					
					$node:=Choose:C955(This:C1470.latest#Null:C1517; This:C1470.latest; This:C1470.root)
					
					//_______________________________
				: ($applyTo="parent")\
					 | ($applyTo="append")
					
					If (This:C1470.latest=Null:C1517)
						
						$node:=This:C1470.root
						
					Else 
						
						// Get the parent
						$node:=This:C1470.parent(This:C1470.latest)
						
					End if 
					
					//_______________________________
				: (This:C1470.isReference($applyTo))
					
					$node:=$applyTo  // The given reference
					
					//_______________________________
				Else 
					
					// Find a memorized target
					$o:=This:C1470.store.query("id=:1"; $applyTo).pop()
					
					If ($o#Null:C1517)
						
						$node:=$o.dom
						
					Else 
						
						This:C1470.success:=False:C215
						This:C1470.errors.push("The element \""+$applyTo+"\" doesn't exists")
						
					End if 
					
					//_______________________________
			End case 
			
			//______________________________________________________
		: (Value type:C1509($applyTo)=Is object:K8:27)
			
			If ($applyTo.target#Null:C1517)
				
				$node:=String:C10($applyTo.target)
				
			Else 
				
				This:C1470._applyTo("latest")
				
			End if 
			
			//______________________________________________________
		Else 
			
			This:C1470.success:=False:C215
			This:C1470.errors.push("Unmanaged type")
			
			//______________________________________________________
	End case 
	
	//———————————————————————————————————————————————————————————
	// Get an available container
Function _attachTo($applyTo)->$node : Text
	
	// Keep a backup of the current item reference.
	// We might need it, if the created element is assigned to a symbol
	This:C1470._current:=This:C1470.latest
	
	If (Count parameters:C259>=1)
		
		$node:=This:C1470._applyTo($applyTo)
		
	Else 
		
		// Current
		$node:=This:C1470._applyTo()
		
	End if 
	
	If ($node#This:C1470.root)
		
		If (This:C1470._notContainer.indexOf(This:C1470.getName($node))#-1)
			
			$node:=This:C1470.parent($node)
			
		End if 
	End if 
	
	//———————————————————————————————————————————————————————————
	// Looks for element "defs", create if not exists
Function _defs()->$reference
	
	var $node; $root : Text
	var $c : Collection
	
	$c:=This:C1470.findByName("defs")
	
	If (This:C1470.success)
		
		$reference:=$c[0]
		
	Else 
		
		$root:=DOM Create XML Ref:C861("root")
		This:C1470.success:=Bool:C1537(OK)
		
		If (This:C1470.success)
			
			$node:=Super:C1706.create($root; "defs")
			
			If (This:C1470.success)
				
				$reference:=Super:C1706.insert(This:C1470.root; $node)
				
			End if 
			
			DOM CLOSE XML:C722($root)
			
		End if 
	End if 
	