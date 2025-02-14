#Warn All
#Warn LocalSameAsGlobal, Off

#include %A_ScriptDir%\..\logger.ahk

; Erstelle eine Instanz des Loggers mit dem Log-Level DEBUG
mylogger := Logger(Logger.DEBUG)
; Setze die Log-Datei
mylogger.setLogFile("my_log.txt")

; Protokolliere Nachrichten auf verschiedenen Log-Leveln
;logger.trace("Dies ist eine TRACE-Nachricht")
;logger.debug("Dies ist eine DEBUG-Nachricht")
;logger.info("Dies ist eine INFO-Nachricht")
;logger.warning("Dies ist eine WARNING-Nachricht")
mylogger.error("Dies ist eine ERROR-Nachricht")
;logger.severe("Dies ist eine SEVERE-Nachricht")
