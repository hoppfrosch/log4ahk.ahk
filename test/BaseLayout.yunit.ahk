#Requires AutoHotkey v2.0-
#Warn
#SingleInstance force

#Include %A_ScriptDir%\..\Lib\Aris\Uberi\Yunit@459cde8\Yunit.ahk
#Include %A_ScriptDir%\..\Lib\Aris\Uberi\Yunit@459cde8\OutputDebug.ahk

#Include %A_ScriptDir%\..\log4ahk\BaseLayout.ahk
#Include %A_ScriptDir%\..\log4ahk\LogLevel.ahk

OutputDebug "DBGVIEWCLEAR" "`n"

Yunit.Use(YunitOutputDebug).Test(
    BaseLayoutTestSuite
)

ExitApp

class BaseLayoutTestSuite {
    Begin() {
        ; Initialisierung, falls nötig
    }

    TestNotImplementedError() {
        layout := BaseLayout()
        try {
            layout.format(LogLevel.INFO, "Test message")
            Yunit.fail("Expected an error to be thrown, but it wasn't.")
        } catch as e {
            Yunit.assert(e.What == "NotImplementedError", "Unexpected error type: " . e.What)
        }
    }

    End() {
        ; Bereinigung, falls nötig
    }
}