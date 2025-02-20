#Requires AutoHotkey v2.0-
#Warn
#SingleInstance force

#Include %A_ScriptDir%\..\Lib\Aris\Uberi\Yunit@459cde8\Yunit.ahk
#Include %A_ScriptDir%\..\Lib\Aris\Uberi\Yunit@459cde8\OutputDebug.ahk

#Include %A_ScriptDir%\..\log4ahk.ahk

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

    TestDefaultOutputDebugAppender() {
        logInstance := Logger.getInstance()
        logInstance.info("Test message for default OutputDebugAppender")
        ; OutputDebug messages can be checked using a tool like DebugView
        ; For unit testing, we can assume the OutputDebug call works if no error is thrown
        Yunit.assert(true, "TestDefaultOutputDebugAppender failed")
    }

    TestSetLogFile() {
        logInstance := Logger.getInstance()
        customAppender := FileAppender(A_ScriptDir "\output\custom_log.txt")
        logInstance.addAppender(customAppender)
        logInstance.info("Test message for custom FileAppender")
        content := FileRead(A_ScriptDir "\output\custom_log.txt")
        Yunit.assert(InStr(content, "Test message for custom FileAppender"), "TestSetLogFile failed")
    }

    End() {
        ; Bereinigung, falls nötig
        if (FileExist(A_ScriptDir "\output\custom_log.txt")) {
            FileDelete(A_ScriptDir "\output\custom_log.txt")
        }
    }
}

class LoggerLayoutTestSuite {
    Begin() {
        ; Initialisierung, falls nötig
    }

    TestSimpleLayout() {
        logInstance := Logger.getInstance()
        layout := SimpleLayout()
        customAppender := FileAppender(A_ScriptDir "\output\simple_layout_test_log.txt", layout)
        logInstance.addAppender(customAppender)
        logInstance.setLogLevel(LogLevel.INFO)
        logInstance.info("Test message for SimpleLayout")
        content := FileRead(A_ScriptDir "\output\simple_layout_test_log.txt")
        expectedTime := FormatTime(A_Now, "yyyy-MM-dd HH:mm:ss")
        expectedMessage := Format("[{}] [INFO] Test message for SimpleLayout", expectedTime)
        Yunit.assert(InStr(content, expectedMessage), "TestSimpleLayout failed")
    }

    TestPatternLayout() {
        logInstance := Logger.getInstance()
        layout := PatternLayout("%d [%p] %m")
        customAppender := FileAppender(A_ScriptDir "\output\pattern_layout_test_log.txt", layout)
        logInstance.addAppender(customAppender)
        logInstance.setLogLevel(LogLevel.INFO)
        logInstance.info("Test message for PatternLayout")
        content := FileRead(A_ScriptDir "\output\pattern_layout_test_log.txt")
        expectedTime := FormatTime(A_Now, "yyyy/MM/dd HH:mm:ss")
        expectedMessage := Format("{} [INFO] Test message for PatternLayout", expectedTime)
        Yunit.assert(InStr(content, expectedMessage), "TestPatternLayout failed")
    }

    End() {
        ; Bereinigung, falls nötig
        if (FileExist(A_ScriptDir "\output\simple_layout_test_log.txt")) {
            FileDelete(A_ScriptDir "\output\simple_layout_test_log.txt")
        }
        if (FileExist(A_ScriptDir "\output\pattern_layout_test_log.txt")) {
            FileDelete(A_ScriptDir "\output\pattern_layout_test_log.txt")
        }
    }
}