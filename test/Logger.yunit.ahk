#Requires AutoHotkey v2.0-
#Warn
#SingleInstance force

#Include %A_ScriptDir%\..\Lib\Aris\Uberi\Yunit@459cde8\Yunit.ahk
#Include %A_ScriptDir%\..\Lib\Aris\Uberi\Yunit@459cde8\OutputDebug.ahk

#Include %A_ScriptDir%\..\log4ahk\Logger.ahk

OutputDebug("DBGVIEWCLEAR`n")

Yunit.Use(YunitOutputDebug).Test(
    LoggerBasicTestSuite,
    LoggerLayoutTestSuite
)

ExitApp

class LoggerBasicTestSuite {
    Begin() {
        ; Initialisierung, falls nötig
    }

    TestSingletonInstance() {
        logInstance1 := Logger.getInstance()
        logInstance2 := Logger.getInstance()
        Yunit.assert(logInstance1 == logInstance2, "TestSingletonInstance failed")
    }

    TestSetLogLevel() {
        logInstance := Logger.getInstance()
        logInstance.setLogLevel(LogLevel.DEBUG)
        Yunit.assert(logInstance.logLevel == LogLevel.DEBUG, "TestSetLogLevel failed")
    }

    TestSetLogFile() {
        logInstance := Logger.getInstance()
        logInstance.setLogFile(A_ScriptDir "\output\test_log.txt")
        Yunit.assert(logInstance.logFile == A_ScriptDir "\output\test_log.txt", "TestSetLogFile failed")
    }

    End() {
        ; Bereinigung, falls nötig
    }
}

class LoggerLayoutTestSuite {
    Begin() {
        ; Initialisierung, falls nötig
    }

    TestSimpleLayout() {
        logInstance := Logger.getInstance()
        logInstance.setLayout(SimpleLayout())
        logInstance.setLogLevel(LogLevel.INFO)
        logInstance.setLogFile(A_ScriptDir "\output\simple_layout_test_log.txt")
        logInstance.info("Test message for SimpleLayout")
        content := FileRead(logInstance.logFile)
        expectedTime := FormatTime(A_Now, "yyyy-MM-dd HH:mm:ss")
        expectedMessage := Format("[{}] [INFO] Test message for SimpleLayout", expectedTime)
        Yunit.assert(InStr(content, expectedMessage), "TestSimpleLayout failed")
    }

    TestPatternLayout() {
        logInstance := Logger.getInstance()
        logInstance.setLayout(PatternLayout("%d [%p] %m"))
        logInstance.setLogLevel(LogLevel.INFO)
        logInstance.setLogFile(A_ScriptDir "\output\pattern_layout_test_log.txt")
        logInstance.info("Test message for PatternLayout")
        content := FileRead(logInstance.logFile)
        expectedTime := FormatTime(A_Now, "yyyy/MM/dd HH:mm:ss")
        expectedMessage := Format("{} [INFO] Test message for PatternLayout", expectedTime)
        Yunit.assert(InStr(content, expectedMessage), "TestPatternLayout failed")
    }

    End() {
        ; Bereinigung, falls nötig
    }
}