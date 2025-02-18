#Include %A_ScriptDir%\..\logger.ahk

class CustomLayout {
    ; Methode zum Formatieren der Log-Nachricht
    format(level, message) {
        levelString := Logger().levelToString(level)
        return Format("CUSTOM LAYOUT - {}: {}", levelString, message)
    }
}

class LoggerTests {
    ; Setup-Methode, um die Testumgebung vorzubereiten
    Setup() {
        this.logger := Logger.getInstance()
        this.logger.setLogFile("test_log.txt")
        this.ClearLogFile()
    }

    ; Methode zum Löschen der Log-Datei
    ClearLogFile() {
        if FileExist("test_log.txt") {
            FileDelete("test_log.txt") ; Lösche die Test-Log-Datei, wenn sie existiert
        }
        ; Stelle sicher, dass die Logdatei existiert
        this.logger.ensureLogFileExists()
    }

    ; Test für die Singleton-Instanz
    TestSingleton() {
        this.Setup()
        logger1 := Logger.getInstance()
        logger2 := Logger.getInstance()
        this.Assert(logger1 == logger2, "Logger.getInstance() sollte immer die gleiche Instanz zurückgeben")
    }

    ; Test für das Setzen des Log-Levels
    TestSetLogLevel() {
        this.Setup()
        this.logger.setLogLevel(Logger.DEBUG)
        this.Assert(this.logger.logLevel == Logger.DEBUG, "Das Log-Level sollte auf DEBUG gesetzt sein")
    }

    ; Test für das Schreiben einer Log-Nachricht
    TestLogMessage() {
        this.Setup()
        this.logger.setLogLevel(Logger.INFO)
        this.logger.info("Dies ist eine INFO-Nachricht")
        logContent := FileRead("test_log.txt")
        this.AssertInStr(logContent, "[INFO] Dies ist eine INFO-Nachricht", "Die Log-Datei sollte die INFO-Nachricht enthalten")
    }

    ; Test für das Überspringen von Nachrichten unterhalb des Log-Levels
    TestSkipLowerLevelMessages() {
        this.Setup()
        this.logger.setLogLevel(Logger.WARNING)
        ; Schreibe eine Nachricht, die unterhalb des aktuellen Log-Levels liegt
        this.logger.info("Dies ist eine INFO-Nachricht")
        logContent := FileRead("test_log.txt")
        this.AssertNotInStr(logContent, "[INFO] Dies ist eine INFO-Nachricht", "Die Log-Datei sollte die INFO-Nachricht nicht enthalten")
    }

    ; Test für die Verwendung eines benutzerdefinierten Layouts
    TestCustomLayout() {
        this.Setup()
        layout := CustomLayout()
        this.logger.setLayout(layout)
        this.logger.setLogLevel(Logger.INFO)
        this.logger.info("Dies ist eine INFO-Nachricht mit benutzerdefiniertem Layout")
        logContent := FileRead("test_log.txt")
        this.AssertInStr(logContent, "CUSTOM LAYOUT - INFO: Dies ist eine INFO-Nachricht mit benutzerdefiniertem Layout", "Die Log-Datei sollte die Nachricht im benutzerdefinierten Layout enthalten")
    }

    ; Test für die Verwendung des PatternLayouts
    TestPatternLayout() {
        this.Setup()
        layout := PatternLayout("%d - %m")
        this.logger.setLayout(layout)
        this.logger.setLogLevel(Logger.INFO)
        this.logger.info("Dies ist eine INFO-Nachricht mit PatternLayout")
        logContent := FileRead("test_log.txt")
        this.AssertInStr(logContent, Format("{} - Dies ist eine INFO-Nachricht mit PatternLayout", FormatTime(A_Now, "yyyy/MM/dd HH:mm:ss")), "Die Log-Datei sollte die Nachricht im PatternLayout enthalten")
    }

    ; Hilfsmethoden für die Assertions
    Assert(condition, message) {
        if (!condition) {
            MsgBox "Assertion Failed: " message
            ExitApp
        }
    }

    AssertInStr(haystack, needle, message) {
        if !InStr(haystack, needle) {
            MsgBox "Assertion Failed: " message
            ExitApp
        }
    }

    AssertNotInStr(haystack, needle, message) {
        if InStr(haystack, needle) {
            MsgBox "Assertion Failed: " message
            ExitApp
        }
    }
}

; Starte die Tests
tests := LoggerTests()
tests.TestSingleton()
tests.TestSetLogLevel()
tests.TestLogMessage()
tests.TestSkipLowerLevelMessages()
tests.TestCustomLayout()
tests.TestPatternLayout()

MsgBox "Alle Tests bestanden!"
ExitApp