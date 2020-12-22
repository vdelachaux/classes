Class constructor($path : Variant; $pathType : Integer)
	
	This:C1470._target:=Null:C1517
	
	Case of 
			
			//_____________________________
		: (Count parameters:C259>=2)
			
			This:C1470.set($path; $pathType)
			
			//_____________________________
		: (Count parameters:C259>=1)
			
			This:C1470.set($path)
			
			//_____________________________
		Else 
			
			This:C1470.update()
			
			//_____________________________
	End case 
	
	//==========================================================
Function set($path : Variant; $pathType : Integer)->$this : cs:C1710.doc
	
	var $o : Object
	
	Case of 
			
			//_____________________________
		: (Value type:C1509($path)=Is object:K8:27)  // File or Folder
			
			If (OB Instance of:C1731($path; 4D:C1709.Folder))\
				 | (OB Instance of:C1731($path; 4D:C1709.File))
				
				This:C1470._target:=$path
				
			Else 
				
				ASSERT:C1129(False:C215; Current method name:C684+" Path as object must be a File or Folder")
				
			End if 
			
			//_____________________________
		: (Value type:C1509($path)=Is text:K8:3)
			
			If (Length:C16($path)=0)
				
				This:C1470._target:=Null:C1517
				
			Else 
				
				If (Count parameters:C259>=2)
					
					$o:=Path to object:C1547($path; $pathType)
					
				Else 
					
					// Default is a system path
					$o:=Path to object:C1547($path)
					
				End if 
				
				If (Count parameters:C259>=2)
					
					If ($o.isFolder)
						
						// PathType passed: fk posix path or fk platform path
						This:C1470._target:=Folder:C1567($path; $pathType)
						
					Else 
						
						// PathType passed: fk posix path or fk platform path
						This:C1470._target:=File:C1566($path; $pathType)
						
					End if 
					
				Else 
					
					If ($o.isFolder)
						
						// Default is Fk posix path
						This:C1470._target:=Folder:C1567($path)
						
					Else 
						
						// Default is Fk posix path
						This:C1470._target:=File:C1566($path)
						
					End if 
				End if 
			End if 
			
			//_____________________________
		Else 
			
			ASSERT:C1129(False:C215; Current method name:C684+" Path must be a Text, a File or Folder")
			
			//_____________________________
	End case 
	
	This:C1470.update()
	
	$this:=This:C1470
	
	//==========================================================
Function copyTo($destinationFolder : Object; $newName : Variant; $overwrite : Integer)->$result : Object
	
	Case of 
			
			//_____________________________
		: (Count parameters:C259=0)
			
			ASSERT:C1129(False:C215; Current method name:C684+" Missing parameters")
			
			//_____________________________
		: (Count parameters:C259=1)
			
			$result:=This:C1470._target.copyTo($destinationFolder)
			
			//_____________________________
		: (Count parameters:C259=2)
			
			If (Value type:C1509($newName)=Is text:K8:3)
				
				$result:=This:C1470._target.copyTo($destinationFolder; $newName)
				
			Else 
				
				// Overwrite
				$result:=This:C1470._target.copyTo($destinationFolder; Num:C11($newName))
				
			End if 
			
			//_____________________________
		: (Count parameters:C259>=3)
			
			$result:=This:C1470._target.copyTo($destinationFolder; $newName; $overwrite)
			
			//_____________________________
	End case 
	
	//==========================================================
Function create()->$created : Boolean
	
	$created:=This:C1470._target.create()
	
	If (This:C1470.success)
		
		This:C1470.update()
		
	End if 
	
	//==========================================================
Function createAlias($destinationFolder : 4D:C1709.Folder; $aliasName : Text; $aliasType : Integer)->$result : Object
	
	Case of 
			
			//________________________
		: (Count parameters:C259>=3)
			
			$result:=This:C1470._target.createAlias($destinationFolder; $aliasName; $aliasType)
			
			//________________________
		: (Count parameters:C259=2)
			
			$result:=This:C1470._target.createAlias($destinationFolder; $aliasName)
			
			//________________________
		Else 
			
			ASSERT:C1129(False:C215; Current method name:C684+" Missing parameterr")
			
			//______________________________________________________
	End case 
	
	//==========================================================
Function delete($option : Integer)
	
	If (This:C1470._target.exists)
		
		If (This:C1470._target.isFolder)
			
			If (Count parameters:C259>=1)
				
				This:C1470._target.delete($option)
				
			Else 
				
				This:C1470._target.delete()
				
			End if 
			
		Else 
			
			This:C1470._target.delete()
			
		End if 
		
		This:C1470.update()
		
	End if 
	
	//==========================================================
Function file($path : Text)->$file : 4D:C1709.file
	
	If (This:C1470.isFolder)
		
		$file:=This:C1470._target.file($path)
		This:C1470.update()
		
	Else 
		
		ASSERT:C1129(False:C215; Current method name:C684+" This is not a folder")
		
	End if 
	
	//==========================================================
Function files($option : Integer)->$files : Collection
	
	If (This:C1470.isFolder)
		
		If (Count parameters:C259>=1)
			
			// File list options
			$files:=This:C1470._target.files($option)
			
		Else 
			
			$files:=This:C1470._target.files()
			
		End if 
		
		This:C1470.update()
		
	Else 
		
		ASSERT:C1129(False:C215; Current method name:C684+" This is not a folder")
		
	End if 
	
	//==========================================================
Function folder($path : Text)->$folder : 4D:C1709.Folder
	
	If (This:C1470.isFolder)
		
		$folder:=This:C1470._target.folder($path)
		This:C1470.update()
		
	Else 
		
		ASSERT:C1129(False:C215; Current method name:C684+" This is not a folder")
		
	End if 
	
	//==========================================================
Function folders($option : Integer)->$folders : Collection
	
	If (This:C1470.isFolder)
		
		If (Count parameters:C259>=1)
			
			// Folder list options
			$folders:=This:C1470._target.folders($option)
			
		Else 
			
			$folders:=This:C1470._target.folders()
			
		End if 
		
		This:C1470.update()
		
	Else 
		
		ASSERT:C1129(False:C215; Current method name:C684+" This is not a folder")
		
	End if 
	
	//==========================================================
Function getContent()->$content : Blob
	
	If (This:C1470.isFile)
		
		$content:=This:C1470._target.getContent()
		
		This:C1470.update()
		
	Else 
		
		ASSERT:C1129(False:C215; Current method name:C684+" This is not a file")
		
	End if 
	
	//==========================================================
Function getIcon($size : Integer)->$icon : Picture
	
	If (Count parameters:C259>=1)
		
		// Side length for the returned picture (pixels)
		$icon:=This:C1470._target.getIcon($size)
		
	Else 
		
		$icon:=This:C1470._target.getIcon()
		
	End if 
	
	//==========================================================
Function getText()->$text : Text
	
	If (This:C1470.isFile)
		
		$text:=This:C1470._target.getText()
		
		This:C1470.update()
		
	Else 
		
		ASSERT:C1129(False:C215; Current method name:C684+" This is not a file")
		
	End if 
	
	//==========================================================
Function moveTo($destinationFolder : 4D:C1709.Folder; $newName : Text)->$moved : Object
	
	If (Count parameters:C259>=2)
		
		This:C1470._target.moveTo($destinationFolder; $newName)
		
	Else 
		
		This:C1470._target.moveTo($destinationFolder)
		
	End if 
	
	//==========================================================
Function rename($newName : Text)->$this : cs:C1710.doc
	
	If (Count parameters:C259>=1)
		
		This:C1470._target:=This:C1470._target.rename($newName)
		This:C1470.update()
		
	Else 
		
		ASSERT:C1129(False:C215; Current method name:C684+" Missing newName parameter")
		
	End if 
	
	$this:=This:C1470
	
	//==========================================================
Function setContent($content : Blob)
	
	If (This:C1470.isFile)
		
		This:C1470._target.setContent($content)
		
		This:C1470.update()
		
	Else 
		
		ASSERT:C1129(False:C215; Current method name:C684+" This is not a file")
		
	End if 
	
	//==========================================================
Function setText($text : Text)
	
	If (This:C1470.isFile)
		
		This:C1470._target.setText($text)
		
		This:C1470.update()
		
	Else 
		
		ASSERT:C1129(False:C215; Current method name:C684+" This is not a file")
		
	End if 
	
	//==========================================================
Function unsandboxed()->$this : cs:C1710.doc
	
	If (This:C1470._target#Null:C1517)
		
		If (This:C1470.isFile)
			
			// Unsandboxed file
			This:C1470._target:=File:C1566(This:C1470._target.platformPath; fk platform path:K87:2)
			
		Else 
			
			// Unsandboxed folder
			This:C1470._target:=Folder:C1567(This:C1470._target.platformPath; fk platform path:K87:2)
			
		End if 
	End if 
	
	This:C1470.update()
	
	//==========================================================
Function update()
	
	If (This:C1470._target=Null:C1517)
		
		// Init/reset
		This:C1470.creationDate:=!00-00-00!
		This:C1470.creationTime:=?00:00:00?
		This:C1470.extension:=""
		This:C1470.exists:=False:C215
		This:C1470.fullName:=""
		This:C1470.hidden:=False:C215
		This:C1470.isAlias:=False:C215
		This:C1470.isFile:=False:C215
		This:C1470.isFolder:=False:C215
		This:C1470.isPackage:=False:C215
		This:C1470.isWritable:=False:C215
		This:C1470.modificationDate:=!00-00-00!
		This:C1470.modificationTime:=?00:00:00?
		This:C1470.name:=""
		This:C1470.original:=Null:C1517
		This:C1470.parent:=Null:C1517
		This:C1470.path:=""
		This:C1470.platformPath:=""
		This:C1470.isRelative:=False:C215
		This:C1470.relativePath:=""
		This:C1470.relativePlatformPath:=""
		
	Else 
		
		This:C1470.creationDate:=This:C1470._target.creationDate
		This:C1470.creationTime:=This:C1470._target.creationTime
		This:C1470.extension:=This:C1470._target.extension
		This:C1470.exists:=This:C1470._target.exists
		This:C1470.fullName:=This:C1470._target.fullName
		This:C1470.hidden:=This:C1470._target.hidden
		This:C1470.isAlias:=This:C1470._target.isAlias
		This:C1470.isFile:=This:C1470._target.isFile
		This:C1470.isFolder:=This:C1470._target.isFolder
		This:C1470.isPackage:=Bool:C1537(This:C1470._target.isPackage)
		This:C1470.isWritable:=Choose:C955(This:C1470.isFolder; True:C214/* 🚧 */; This:C1470._target.isWritable)
		This:C1470.modificationDate:=This:C1470._target.modificationDate
		This:C1470.modificationTime:=This:C1470._target.modificationTime
		This:C1470.name:=This:C1470._target.name
		This:C1470.original:=This:C1470._target.original
		This:C1470.parent:=This:C1470._target.parent
		This:C1470.path:=This:C1470._target.path
		This:C1470.platformPath:=This:C1470._target.platformPath
		
		var $t : Text
		$t:=Get 4D folder:C485(Database folder UNIX syntax:K5:15; *)
		
		If (Position:C15($t; This:C1470.path)=1)
			
			This:C1470.isRelative:=True:C214
			This:C1470.relativePath:=Replace string:C233(This:C1470.path; $t; ""; 1)
			
			$t:=Get 4D folder:C485(Database folder:K5:14; *)
			This:C1470.relativePlatformPath:=Replace string:C233(This:C1470.platformPath; $t; ""; 1)
			
		Else 
			
			
			This:C1470.isRelative:=False:C215
			This:C1470.relativePath:=""
			This:C1470.relativePlatformPath:=""
			
		End if 
	End if 