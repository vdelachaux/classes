//%attributes = {}
C_OBJECT:C1216($menu;$subMenu)

  // Create a main menu
$menu:=cs:C1710.menu.new()

  // Append a first item
$menu.append("Item 1";"item1")

  // Append a line
$menu.line()

  // Append a second item with check mark
$menu.append("Item 2";"item2";True:C214)

  // Append a line
$menu.line()

  // Create a sub menu with 2 items
$subMenu:=cs:C1710.menu.new().append("Sub menu Item 1";"subitem1").append("Sub menu Item 2";"subitem2")

  // Append the sub menu to the main menu (memory is automatically released)
$menu.append("Sub menu";$subMenu)

  // Append fonts submenu with styles & windows submenu
$menu.append("Fonts";cs:C1710.menu.new().fonts(True:C214)).line().append("Windows";cs:C1710.menu.new().windows())

  // Append the standard edit menu
$menu.append(":xliff:CommonMenuEdit";cs:C1710.menu.new().edit())

  // Display as popup with third line selected (memory is automatically released)
$menu.popup("item2")

  // Do something according to the user's choice
Case of 
		
		  //________________________________________
	: (Not:C34($menu.selected))
		
		  // No item selected
		
		  //________________________________________
	: ($menu.choice="item1")
		
		  // …
		
		  //________________________________________
	: ($menu.choice="item2")
		
		  // …
		
		  //________________________________________
	: ($menu.choice="subitem1")
		
		  // …
		
		  //________________________________________
	: ($menu.choice="subitem2")
		
		  // …
		
		  //________________________________________
End case 