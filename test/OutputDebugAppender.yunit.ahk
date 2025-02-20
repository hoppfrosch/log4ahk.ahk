#Requires AutoHotkey v2.0-
#Warn
#SingleInstance force

#Include %A_ScriptDir%\..\Lib\Aris\Uberi\Yunit@459cde8\Yunit.ahk
#Include %A_ScriptDir%\..\Lib\Aris\Uberi\Yunit@459cde8\OutputDebug.ahk

#Include %A_ScriptDir%\..\log4ahk\OutputDebugAppender.ahk
#Include %A_ScriptDir%\..\log4ahk\SimpleLayout.ahk
#Include %A_ScriptDir%\..\log4ahk\PatternLayout.ahk
#Include %A_ScriptDir%\..\log4ahk\LogLevel.ahk

OutputDebug("DBGVIEWCLEAR`n")

Yunit.Use(YunitOutputDebug).Test(
    OutputDebugAppenderTestSuite
)

ExitApp

class OutputDebugAppenderTestSuite {
    Begin() {
        ; Initialisierung, falls nötig
    }

    TestOutputDebugAppenderInstantiation() {
        layout := SimpleLayout()
        appender := OutputDebugAppender(layout)
        Yunit.assert(appender.layout == layout, "TestOutputDebugAppenderInstantiation failed")
    }

    TestOutputDebugAppenderDefaultLayout() {
        appender := OutputDebugAppender()
        Yunit.assert(appender.layout is SimpleLayout, "TestOutputDebugAppenderDefaultLayout failed")
    }

    TestOutputDebugAppenderSetLayout() {
        appender := OutputDebugAppender()
        newLayout := PatternLayout("%d [%p] %m")
        appender.setLayout(newLayout)
        Yunit.assert(appender.layout == newLayout, "TestOutputDebugAppenderSetLayout failed")
    }

    TestOutputDebugAppenderAppendMethod() {
        appender := OutputDebugAppender()
        try {
            appender.append(LogLevel.INFO, "Test message for OutputDebug")
            ; Assuming OutputDebug works if no error is thrown
            Yunit.assert(true, "TestOutputDebugAppenderAppendMethod failed")
        } catch as e {
            Yunit.assert(false, "TestOutputDebugAppenderAppendMethod failed with exception: " e.Message)
        }
    }

    End() {
        ; Bereinigung, falls nötig
    }
}