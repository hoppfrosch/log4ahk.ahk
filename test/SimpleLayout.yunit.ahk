#Requires AutoHotkey v2.0-
#Warn
#SingleInstance force

; #include <%A_ScriptDir%/../Lib/Aris/Uberi> ; Uberi/Yunit@459cde8

#Include %A_ScriptDir%\..\Lib\Aris\Uberi\Yunit@459cde8\Yunit.ahk
#Include %A_ScriptDir%\..\Lib\Aris\Uberi\Yunit@459cde8\OutputDebug.ahk

#Include %A_ScriptDir%\..\log4ahk\SimpleLayout.ahk

OutputDebug "DBGVIEWCLEAR" "`n"

Yunit.Use(YunitOutputDebug).Test(
    SimpleLayoutBaseTestSuite,
    SimpleLayoutFormatTestSuite
)

ExitApp

class SimpleLayoutBaseTestSuite {
    Begin() {
        ; Initialisierung, falls nötig
    }

    End() {
        ; Bereinigung, falls nötig
    }
}

class SimpleLayoutFormatTestSuite {
    Begin() {
        ; Initialisierung, falls nötig
    }

    TestFormat() {
        layout := SimpleLayout()
        level := LogLevel.INFO
        message := "Test message"
        formattedMessage := layout.format(level, message)
        expectedTime := FormatTime(A_Now, "yyyy-MM-dd HH:mm:ss")
        expectedMessage := Format("[{}] [{}] {}", expectedTime, LogLevel.toString(level), message)
        Yunit.assert(formattedMessage == expectedMessage, "TestFormat failed")
    }

    End() {
        ; Bereinigung, falls nötig
    }
}