//%attributes = {}
If (Shift down:C543)
	
	C_TEXT:C284($Dom_group;$Dom_rect;$Dom_svg;$Dom_text)
	
	SVG_SET_OPTIONS (SVG_Get_options  ?+ 5)
	
	  // Create a new document of dimensions 400 x 400 with a "gold" background color and an opacity of 25%
	$Dom_svg:=SVG_New 
	SVG_SET_DIMENSIONS ($Dom_svg;400;400)
	SVG_SET_VIEWPORT_FILL ($Dom_svg;"gold";25)
	
	  // Create a rectangle at x = 10, y = 10, with a width of 100 and a height of 20 without filling
	$Dom_rect:=SVG_New_rect ($Dom_svg;10;10;100;20)
	SVG_SET_FILL_BRUSH ($Dom_rect;"none")
	
	  // Create a rectangle at x = 120, y = 10, with a width of 100 and a height of 20,
	  // a blue border of 2px and a white background
	$Dom_rect:=SVG_New_rect ($Dom_svg;120;10;100;20;0;0;"blue";"white";2)
	
	  // Create a rectangle at x = 230, y = 10, with a width of 100 and a height of 20,
	  // a green dotted border of 2px and a orange background
	$Dom_rect:=SVG_New_rect ($Dom_svg;230;10;100;20;0;0;"green";"orangered:50";2)
	SVG_SET_STROKE_DASHARRAY ($Dom_rect;2;2)
	
	  // Create, in a new group id= "test", a rounded square at x = 20, y = 40,
	  // with a width of 50, a blue border of 1px and a yellow background
	$Dom_group:=SVG_New_group ($Dom_svg;"test")
	$Dom_rect:=SVG_New_rect ($Dom_group;20;40;50;50;10;10;"blue";"yellow")
	
	  // Put the text "Hello world" at x = 120, y = 100 with automatic width & height,
	  // font size 24px with Lucida on macOS or Segoe on Windows, bold + italic style and gray color
	$Dom_text:=SVG_New_textArea ($Dom_svg;"Hello World ";120;100;-1;-1)
	SVG_SET_FONT_FAMILY ($Dom_text;"'lucida grande','segoe UI',sans-serif")
	SVG_SET_FONT_STYLE ($Dom_text;Bold:K14:2+Italic:K14:3)
	SVG_SET_FONT_SIZE ($Dom_text;24)
	SVG_SET_FONT_COLOR ($Dom_text;"dimgray")
	
	  // Save the document as svg on Desktop
	SVG_SAVE_AS_TEXT ($Dom_svg;Folder:C1567(fk desktop folder:K87:19).file("test svg.xml").platformPath)
	
	  // Don't miss to clear memory
	SVG_CLEAR ($Dom_svg)
	
Else 
	
	C_OBJECT:C1216($svg)
	
	  // Create a new document of dimensions 400 x 400 with a "gold" background color and an opacity of 25%
	$svg:=svg ("solid:gold").setDimensions(400).setFill(Null:C1517;25)
	
	  // Create a rectangle at x = 10, y = 10, with a width of 100 and a height of 20 without filling
	$svg.rect(10;10;100;20)
	
	  // Create a rectangle at x = 120, y = 10, with a width of 100 and a height of 20,
	  // a blue border of 2px and a white background
	$svg.rect(120;10;100;20;New object:C1471(\
		"stroke";"blue";\
		"fill";"white";\
		"stroke-width";2))
	
	  // Create a rectangle at x = 230, y = 10, with a width of 100 and a height of 20,
	  // a green dotted border of 2px and a orange background
	$svg.rect(230;10;100;20)\
		.setStroke(New object:C1471("color";"green";"width";2;"dasharray";"2,2";"opacity";80))\
		.setFill("orangered";50)
	
	  // Create, in a new group id= "test", a rounded square at x = 20, y = 40,
	  // with a width of 50, a blue border of 1px and a yellow background
	$svg.roundedRect(0;0;New object:C1471("target";$svg.group("test").latest))\
		.setDimensions(50)\
		.setFill("yellow")\
		.setStroke("blue")\
		.setPosition(20;40)
	
	  // Put the text "Hello world" at x = 120, y = 100 with automatic width & height,
	  // font size 24px with Lucida on macOS or Segoe on Windows, bold + italic style and gray color
	$svg.textArea("Hello World ")\
		.setFont(New object:C1471("color";"dimgray";"style";Bold:K14:2+Italic:K14:3;"size";24))\
		.setPosition(120;100)
	
	  // Save the document as svg on Desktop
	$svg.saveText(Folder:C1567(fk desktop folder:K87:19).file("test svg.xml"))
	
	  // Memory is automatically released !
	
End if 