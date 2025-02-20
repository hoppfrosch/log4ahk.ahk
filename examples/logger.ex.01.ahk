#Requires AutoHotkey v2.0-
#Warn
#SingleInstance force

#Include %A_ScriptDir%\..\log4ahk\Logger.ahk

loggerInstance := Logger.getInstance()
loggerInstance.setLogLevel(LogLevel.DEBUG)

; Log some messages
loggerInstance.trace("This is a TRACE message")
loggerInstance.debug("This is a DEBUG message")
loggerInstance.info("This is an INFO message")
loggerInstance.warning("This is a WARNING message")
loggerInstance.error("This is an ERROR message")
loggerInstance.severe("This is a SEVERE message")

; Custom appender example
customAppender := FileAppender(A_ScriptDir "\custom_log.txt", PatternLayout("%d [%p] %m"))
loggerInstance.addAppender(customAppender)
loggerInstance.info("This is an INFO message for the custom appender")

MsgBox "Logging complete. Check the output directory for log files."