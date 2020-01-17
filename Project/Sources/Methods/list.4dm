//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : list
  // ID[8D792D1F67C24B8B9050DC74E37205C3]
  // Created 17-1-2020 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_OBJECT:C1216($0)
C_TEXT:C284($1)
C_OBJECT:C1216($2)

C_OBJECT:C1216($o)

If (False:C215)
	C_OBJECT:C1216(list ;$0)
	C_TEXT:C284(list ;$1)
	C_OBJECT:C1216(list ;$2)
End if 

  // ----------------------------------------------------
If (This:C1470[""]=Null:C1517)  // Constructor
	
	$o:=New object:C1471(\
		"";"list";\
		"ref";Null:C1517;\
		"success";True:C214;\
		"errors";New collection:C1472;\
		"clear";Formula:C1597(list ("clear"));\
		"load";Formula:C1597(list ("load";New object:C1471("list";$1)));\
		"isValid";Formula:C1597(list ("isValid";New object:C1471("node";$1)).result)\
		)
	
	If (Count parameters:C259>=1)
		
		$o.ref:=$o.load(String:C10($1))
		
	End if 
	
Else 
	
	$o:=This:C1470
	
	Case of 
			
			  //______________________________________________________
		: ($o=Null:C1517)
			
			ASSERT:C1129(False:C215;"OOPS, this method must be called from a member method")
			
			  //______________________________________________________
		: ($1="clear")
			
			If (Is a list:C621($o.ref))
				
				CLEAR LIST:C377($o.ref;*)
				
			End if 
			
			$o.ref:=Null:C1517
			
			  //______________________________________________________
		: ($1="load")
			
			Case of 
					
					  //______________________________________________________
				: ($2.list=Null:C1517)
					
					$o.success:=False:C215
					$o.errors.push("Missing parameter: list name or reference")
					
					  //______________________________________________________
				: (Value type:C1509($2.list)=Is text:K8:3)
					
					ARRAY LONGINT:C221($tLon_number;0x0000)
					ARRAY TEXT:C222($tTxt_names;0x0000)
					
					LIST OF CHOICE LISTS:C957($tLon_number;$tTxt_names)
					
					$o.success:=Find in array:C230($tTxt_names;$2.list)>0
					
					If ($o.success)
						
						$o.clear()
						$o.ref:=Load list:C383($2.list)
						
					Else 
						
						$o.errors.push("List not found: "+$2.list)
						
					End if 
					
					  //______________________________________________________
				: (Value type:C1509($2.list)=Is longint:K8:6)
					
					$o.success:=Is a list:C621($2.list)
					
					If ($o.success)
						
						$o.clear()
						$o.ref:=$2.list
						
					Else 
						
						$o.errors.push("List doesn't exists: "+String:C10($2.list))
						
					End if 
					
					  //______________________________________________________
				Else 
					
					$o.success:=False:C215
					$o.errors.push("Not managed type for load(): "+String:C10(Value type:C1509($2.list)))
					
					  //______________________________________________________
			End case 
			
			  //______________________________________________________
		: ($1="isValid")
			
			$o:=New object:C1471(\
				"result";False:C215)
			
			If ($2.node=Null:C1517)
				
				If (This:C1470.ref#Null:C1517)
					
					$o.result:=Is a list:C621(This:C1470.ref)
					
				End if 
				
			Else 
				
				  //#TO_DO = test a node
				
			End if 
			
			  //______________________________________________________
		Else 
			
			ASSERT:C1129(False:C215;"Unknown entry point: \""+$1+"\"")
			
			  //______________________________________________________
	End case 
End if 

  // ----------------------------------------------------
  // Return
$0:=$o

  // ----------------------------------------------------
  // End