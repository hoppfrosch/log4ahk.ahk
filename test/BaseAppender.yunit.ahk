#Requires AutoHotkey v2.0-
#Warn
#SingleInstance force

#Include %A_ScriptDir%\..\Lib\Aris\Uberi\Yunit@459cde8\Yunit.ahk
#Include %A_ScriptDir%\..\Lib\Aris\Uberi\Yunit@459cde8\OutputDebug.ahk

#Include %A_ScriptDir%\..\log4ahk\BaseAppender.ahk
#Include %A_ScriptDir%\..\log4ahk\SimpleLayout.ahk
#Include %A_ScriptDir%\..\log4ahk\PatternLayout.ahk
#Include %A_ScriptDir%\..\log4ahk\LogLevel.ahk

OutputDebug("DBGVIEWCLEAR`n")

Yunit.Use(YunitOutputDebug).Test(
    BaseAppenderTestSuite
)

ExitApp

class BaseAppenderTestSuite {
    Begin() {
        ; Initialisierung, falls nötig
    }

    TestBaseAppenderInstantiation() {
        layout := SimpleLayout()
        appender := BaseAppender(layout)
        Yunit.assert(appender.layout == layout, "TestBaseAppenderInstantiation failed")
    }

    TestBaseAppenderDefaultLayout() {
        appender := BaseAppender()
        Yunit.assert(appender.layout is SimpleLayout, "TestBaseAppenderDefaultLayout failed")
    }

    TestBaseAppenderSetLayout() {
        appender := BaseAppender()
        newLayout := PatternLayout("%d [%p] %m")
        appender.setLayout(newLayout)
        Yunit.assert(appender.layout == newLayout, "TestBaseAppenderSetLayout failed")
    }

    TestBaseAppenderAppendMethod() {
        appender := BaseAppender()
        try {
            appender.append(LogLevel.INFO, "Test message")
        } catch as e {
            Yunit.assert(e.What == "NotImplementedError", "TestBaseAppenderAppendMethod failed")
        }
    }

    End() {
        ; Bereinigung, falls nötig
    }
}