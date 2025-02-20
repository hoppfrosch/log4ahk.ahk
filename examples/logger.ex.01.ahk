#Warn All
#Warn LocalSameAsGlobal, Off

#include %A_ScriptDir%\..\log4ahk.ahk

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

; Beispiel zur Verwendung des Loggers mit PatternLayout
patternLogger := Logger.getInstance()
patternLogger.setLogLevel(LogLevel.DEBUG)
patternLogger.setLogFile("pattern_log.txt")
patternLogger.setLayout(PatternLayout("%d [%p] %m"))

patternLogger.debug("Dies ist eine Debug-Nachricht.")
patternLogger.info("Dies ist eine Info-Nachricht.")
patternLogger.warning("Dies ist eine Warnung.")
patternLogger.error("Dies ist eine Fehlermeldung.")
patternLogger.severe("Dies ist eine schwere Fehlermeldung.")
