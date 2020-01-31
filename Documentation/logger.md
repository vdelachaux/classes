<!-- Summary -->
## Logger

Create and populate log files.

## Sample code

      /***************************************************************************************************
	      Create a log file named "test.log" into the user/library/logs folder or reset it if it exists
	   ***************************************************************************************************/
	$o:=logger ("~/Library/Logs/test.log").reset()

	$o.info("logger.info(message)")   // Since the default value of "verbose" is false, this line will not be written
	$o.warning("logger.warning(message)")  // Log a warning
	$o.error("logger.error(message)")  // Log an error

	$o.line()  // Insert a line
	$o.log("\n")  // Insert a blank line

	$o.verbose:=True  // "verbose" authorizes the logging of information

	$o.info(New object(\
	"test";"Hello world"))  // Objects are stringified

	$o.line("\n")
	$o.log("-> START")  // Insert a user trace
	$o.info(True)  // Booleans are stringified
	$o.log("<- STOP")
	$o.log("\n")

	$o.line("=-";30)  // Insert a user define line
	$o.info(Pi)  // Numeric are stringified
	$o.line("=-";30)
	$o.line("\n")

	$o.log("logger.log(message,level)";Warning message)  // Put a warning

	$o.log("\n")
	$o.trace()  // Log the call chain

	If (Shift down)

		$o.open()  // Opens the log file with the default application to browse logs, generally Console.app

	End if 

## Produced log

> 2020-01-31 11:49:42	(classes)	warning: logger.warning(message)  
> 2020-01-31 11:49:42	(classes)	error: logger.error(message)  
> ********************************************************************************  
>   
> 2020-01-31 11:49:42	(classes)	info: {  
> 	"test": "Hello world"  
> }  
> 
> -> START  
> 2020-01-31 11:49:42	(classes)	info: TRUE  
> <- STOP  
> 
> =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-  
> 2020-01-31 11:49:42	(classes)	info: 3,14159265359  
> =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-  
> 
> 2020-01-31 11:49:42	(classes)	warning: logger.log(message,level)  
> 
> 2020-01-31 11:49:42	(classes)	error: [  
> 	{  
> 		"type": "projectMethod",  
> 		"name": "logger",  
> 		"line": 338,  
> 		"database": "classes"  
> 	},  
> 	{  
> 		"type": "projectMethod",  
> 		"name": "HTU_logs",  
> 		"line": 56,  
> 		"database": "classes"  
>  }  
> ]  
> 