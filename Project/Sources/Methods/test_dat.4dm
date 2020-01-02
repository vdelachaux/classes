//%attributes = {}
C_DATE:C307($d)
C_LONGINT:C283($i;$l)
C_OBJECT:C1216($o)

$d:=Current date:C33(*)

  // --------------------------------------
  // Initialization
$o:=dat   // Default is today
ASSERT:C1129($o.date=$d)

$o:=dat ("today")
ASSERT:C1129($o.date=$d)

$o:=dat ("yesterday")
ASSERT:C1129($o.date=($d-1))

$o:=dat ("tomorrow")
ASSERT:C1129($o.date=($d+1))

$o:=dat ("monday")  // Monday of the current week
ASSERT:C1129(Day number:C114($o.date)=Monday:K10:13)

  // --------------------------------------
  // setValue()
$o:=dat   // Default is today

$o:=$o.setValue("today")
ASSERT:C1129($o.date=$d)

$o:=$o.setValue("yesterday")
ASSERT:C1129($o.date=($d-1))

$o:=$o.setValue("tomorrow")
ASSERT:C1129($o.date=($d+1))

$o:=$o.setValue("monday")
ASSERT:C1129(Day number:C114($o.date)=Monday:K10:13)

$o:=$o.setValue($d)
ASSERT:C1129($o.date=$d)

$o:=$o.setValue(!1958-08-08!)
ASSERT:C1129($o.date=!1958-08-08!)

  // --------------------------------------
  // weekNumber()
$o:=dat (String:C10(!2020-01-01!))
ASSERT:C1129($o.weekNumber()=1)

$o:=dat (String:C10(!2017-01-01!))
ASSERT:C1129($o.weekNumber()=52)

ASSERT:C1129(dat .weekNumber(!2020-01-01!)=1)
ASSERT:C1129(dat .weekNumber(!2017-01-01!)=52)

$o:=dat 

For ($i;1900;2050;1)
	
	$l:=$o.setValue(Add to date:C393(!00-00-00!;$i;1;1)).weekNumber()
	ASSERT:C1129($l>=1)
	ASSERT:C1129($l<=53)
	
End for 

ASSERT:C1129($o.setValue(!1997-12-30!).weekNumber()=1)

  // --------------------------------------
  // firstOfTheMonth()
ASSERT:C1129(dat .firstOfTheMonth(!1958-08-08!)=!1958-08-01!)

  // --------------------------------------
  // lastOfTheMonth()
ASSERT:C1129(dat .lastOfTheMonth(!1958-08-08!)=!1958-08-31!)
ASSERT:C1129(dat .lastOfTheMonth(!1958-02-01!)=!1958-02-28!)
ASSERT:C1129(dat .lastOfTheMonth(!1960-02-01!)=!1960-02-29!)

  // --------------------------------------
  //             TIPS & TRICKS
  // --------------------------------------

  // First day of the month
$d:=dat .firstOfTheMonth()

  // Today's week number
$l:=dat .weekNumber()

  // Don't miss my next birthday!
$d:=dat .setValue(!1958-08-08!).anniversary()

  // Next Christmas date
$o:=dat ("christmas")

  // Next New year date
$o:=dat ("newYear")