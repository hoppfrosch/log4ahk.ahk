#Warn All
#Warn LocalSameAsGlobal, Off

#include %A_ScriptDir%\..\logger.ahk

; Beispiel zur Verwendung des Loggers mit SimpleLayout
simpleLogger := Logger.getInstance()
simpleLogger.setLogLevel(LogLevel.DEBUG)
simpleLogger.setLogFile("example_log.txt")
simpleLogger.setLayout(SimpleLayout())

simpleLogger.debug("Dies ist eine Debug-Nachricht.")
simpleLogger.info("Dies ist eine Info-Nachricht.")
simpleLogger.warning("Dies ist eine Warnung.")
simpleLogger.error("Dies ist eine Fehlermeldung.")
simpleLogger.severe("Dies ist eine schwere Fehlermeldung.")
