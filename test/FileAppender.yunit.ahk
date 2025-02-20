#Requires AutoHotkey v2.0-
#Warn
#SingleInstance force

#Include %A_ScriptDir%\..\Lib\Aris\Uberi\Yunit@459cde8\Yunit.ahk
#Include %A_ScriptDir%\..\Lib\Aris\Uberi\Yunit@459cde8\OutputDebug.ahk

#Include %A_ScriptDir%\..\log4ahk\FileAppender.ahk
#Include %A_ScriptDir%\..\log4ahk\SimpleLayout.ahk
#Include %A_ScriptDir%\..\log4ahk\PatternLayout.ahk
#Include %A_ScriptDir%\..\log4ahk\LogLevel.ahk

OutputDebug("DBGVIEWCLEAR`n")

Yunit.Use(YunitOutputDebug).Test(
    FileAppenderTestSuite
)

ExitApp

class FileAppenderTestSuite {
    Begin() {
        ; Initialisierung, falls nötig
    }

    TestFileAppenderInstantiation() {
        layout := SimpleLayout()
        appender := FileAppender(A_ScriptDir "\output\test_log.txt", layout)
        Yunit.assert(appender.layout == layout, "TestFileAppenderInstantiation failed")
        Yunit.assert(appender.filePath == A_ScriptDir "\output\test_log.txt", "TestFileAppenderInstantiation failed")
    }

    TestFileAppenderDefaultLayout() {
        appender := FileAppender(A_ScriptDir "\output\test_log.txt")
        Yunit.assert(appender.layout is SimpleLayout, "TestFileAppenderDefaultLayout failed")
    }

    TestFileAppenderSetLayout() {
        appender := FileAppender(A_ScriptDir "\output\test_log.txt")
        newLayout := PatternLayout("%d [%p] %m")
        appender.setLayout(newLayout)
        Yunit.assert(appender.layout == newLayout, "TestFileAppenderSetLayout failed")
    }

    TestFileAppenderAppendMethod() {
        appender := FileAppender(A_ScriptDir "\output\test_log_append.txt")
        appender.append(LogLevel.INFO, "Test message for append")
        content := FileRead(A_ScriptDir "\output\test_log_append.txt")
        expectedTime := FormatTime(A_Now, "yyyy-MM-dd HH:mm:ss")
        expectedMessage := Format("[{}] [INFO] Test message for append", expectedTime)
        Yunit.assert(InStr(content, expectedMessage), "TestFileAppenderAppendMethod failed")
    }

    End() {
        ; Bereinigung, falls nötig
        if (FileExist(A_ScriptDir "\output\test_log.txt")) {
            FileDelete(A_ScriptDir "\output\test_log.txt")
        }
        if (FileExist(A_ScriptDir "\output\test_log_append.txt")) {
            FileDelete(A_ScriptDir "\output\test_log_append.txt")
        }
    }
}