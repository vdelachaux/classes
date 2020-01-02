//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // Project method : dat
  // ID[3EA8AC3B5F6D488CAF273A90C68E2886]
  // Created 2-1-2020 by Vincent de Lachaux
  // ----------------------------------------------------
  // Description:
  //
  // ----------------------------------------------------
  // Declarations
C_OBJECT:C1216($0)
C_TEXT:C284($1)
C_OBJECT:C1216($2)

C_DATE:C307($d;$Dat_1;$Dat_2)
C_TEXT:C284($t)
C_OBJECT:C1216($o)

If (False:C215)
	C_OBJECT:C1216(dat ;$0)
	C_TEXT:C284(dat ;$1)
	C_OBJECT:C1216(dat ;$2)
End if 

  // ----------------------------------------------------
If (This:C1470[""]=Null:C1517)  // Constructor
	
	If (Count parameters:C259>=1)
		
		$t:=$1
		
	End if 
	
	$o:=New object:C1471(\
		"";"dat";\
		"date";Null:C1517;\
		"setValue";Formula:C1597(dat ("setValue";New object:C1471("value";$1)));\
		"weekNumber";Formula:C1597(dat ("weekNumber";New object:C1471("date";$1)).result);\
		"anniversary";Formula:C1597(dat ("anniversary";New object:C1471("date";$1)).result);\
		"firstOfTheMonth";Formula:C1597(dat ("firstOfTheMonth";New object:C1471("date";$1)).result);\
		"lastOfTheMonth";Formula:C1597(dat ("lastOfTheMonth";New object:C1471("date";$1)).result)\
		)
	
	$o.setValue($t)
	
Else 
	
	$o:=This:C1470
	
	Case of 
			
			  //______________________________________________________
		: ($o=Null:C1517)
			
			ASSERT:C1129(False:C215;"OOPS, this method must be called from a member method")
			
			  //______________________________________________________
		: ($1="setValue")
			
			Case of 
					
					  //______________________________________________________
				: (Value type:C1509($2.value)=Is date:K8:7)
					
					$o.date:=$2.value
					
					  //______________________________________________________
				: (Value type:C1509($2.value)=Is text:K8:3)
					
					$d:=Current date:C33(*)
					
					Case of 
							
							  //………………………………………………………………………………………
						: ($2.value="today")\
							 | (Length:C16($2.value)=0)
							
							$o.date:=$d
							
							  //………………………………………………………………………………………
						: ($2.value="yesterday")
							
							$o.date:=$d-1
							
							  //………………………………………………………………………………………
						: ($2.value="tomorrow")
							
							$o.date:=$d+1
							
							  //………………………………………………………………………………………
						: ($2.value="monday")
							
							$o.date:=$d-((Day number:C114($d)+5)%7)
							
							  //………………………………………………………………………………………
						: ($2.value="christmas")  // Next christmas
							
							$o.date:=Add to date:C393(!00-00-00!;Year of:C25($d);12;25)
							
							If ($o.date<=$d)
								
								$o.date:=Add to date:C393($o.date;1;0;0)
								
							End if 
							
							  //………………………………………………………………………………………
						: ($2.value="newYear")  // Next new year
							
							$o.date:=Add to date:C393(!00-00-00!;Year of:C25($d);1;1)
							
							If ($o.date<=$d)
								
								$o.date:=Add to date:C393($o.date;1;0;0)
								
							End if 
							
							  //………………………………………………………………………………………
						: (Match regex:C1019("(?m-si)^\\d+/\\d+/\\d+$";String:C10($2.value);1))  // Date string
							
							$o.date:=Date:C102(String:C10($2.value))
							
							  //………………………………………………………………………………………
						Else 
							
							ASSERT:C1129(False:C215;"Unknown entry point for setValue(): \""+String:C10($2.value)+"\"")
							
							  //………………………………………………………………………………………
					End case 
					
					  //______________________________________________________
				Else 
					
					ASSERT:C1129(False:C215;"Wrong parameter type for setValue()")
					
					  //______________________________________________________
			End case 
			
			  //________________________________________
		Else 
			
			If ($2.date#Null:C1517)
				
				$o.setValue(String:C10($2.date))
				
			Else 
				
				If ($o.date=Null:C1517)
					
					$o.setValue()
					
				End if 
			End if 
			
			Case of 
					
					  //______________________________________________________
				: ($1="firstOfTheMonth")
					
					$o.result:=Add to date:C393($o.date;0;0;-Day of:C23($o.date)+1)
					
					  //______________________________________________________
				: ($1="lastOfTheMonth")
					
					$o.result:=Add to date:C393(!00-00-00!;Year of:C25($o.date);Month of:C24($o.date)+1;1)-1
					
					  //______________________________________________________
				: ($1="anniversary")  // Next anniversary date
					
					$o.result:=Add to date:C393(!00-00-00!;Year of:C25(Current date:C33(*))+1;Month of:C24($o.date);Day of:C23($o.date))
					
					  //______________________________________________________
				: ($1="weekNumber")
					
					  // Get Thursday of the week
					$Dat_1:=Add to date:C393($o.date-((Day number:C114($o.date)+5)%7);0;0;3)
					
					  // Get January 4 of the year
					$d:=Add to date:C393(!00-00-00!;Year of:C25($Dat_1);1;4)
					
					  // Monday of the first week
					$Dat_2:=$d-((Day number:C114($d)+5)%7)
					
					  // Result is upper rounding of the number of days between the two dates divided by 7
					$o.result:=(($Dat_1-$Dat_2)\7)+1
					
					  //______________________________________________________
				Else 
					
					ASSERT:C1129(False:C215;"Unknown entry point: \""+$1+"\"")
					
					  //______________________________________________________
			End case 
			
			  //________________________________________
	End case 
End if 

  // ----------------------------------------------------
  // Return
$0:=$o

  // ----------------------------------------------------
  // End