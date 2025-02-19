#Requires AutoHotkey v2.0-
#Warn
#SingleInstance force

; #include <%A_ScriptDir%/../Lib/Aris/Uberi> ; Uberi/Yunit@459cde8

#Include %A_ScriptDir%\..\Lib\Aris\Uberi\Yunit@459cde8\Yunit.ahk
#Include %A_ScriptDir%\..\Lib\Aris\Uberi\Yunit@459cde8\OutputDebug.ahk

#Include %A_ScriptDir%\..\log4ahk\PatternLayout.ahk

OutputDebug "DBGVIEWCLEAR" "`n"

Yunit.Use(YunitOutputDebug).Test(
    PatternLayoutBaseTestSuite,
    PatternLayoutDateTestSuite,
    PatternLayoutLevelTestSuite,
    PatternLayoutMessageTestSuite
)

ExitApp

class PatternLayoutBaseTestSuite {
    Begin() {
        ; Initialisierung, falls nötig
    }

    TestVersion() {
        layout := PatternLayout("%d %p %m")
        Yunit.assert(layout.version == "1.0.0", "TestVersion failed")
    }

    End() {
        ; Bereinigung, falls nötig
    }
}

class PatternLayoutDateTestSuite {
    Begin() {
        ; Initialisierung, falls nötig
    }

    TestReplaceDate() {
        layout := PatternLayout("%d")
        formattedMessage := layout.format(LogLevel.INFO, "Test message")
        expectedDate := FormatTime(A_Now, "yyyy/MM/dd HH:mm:ss")
        Yunit.assert(StrReplace(formattedMessage, expectedDate, "") == "", "TestReplaceDate failed")
    }

    TestReplaceDateAndMessage() {
        layout := PatternLayout("%d %m")
        message := "Test message"
        formattedMessage := layout.format(LogLevel.INFO, message)
        expectedDate := FormatTime(A_Now, "yyyy/MM/dd HH:mm:ss")
        expectedMessage := expectedDate . " " . message
        Yunit.assert(formattedMessage == expectedMessage, "TestReplaceDateAndMessage failed")
    }

    TestReplaceDateLevelAndMessage() {
        layout := PatternLayout("%d %p %m")
        level := LogLevel.INFO
        message := "Test message"
        formattedMessage := layout.format(level, message)
        expectedDate := FormatTime(A_Now, "yyyy/MM/dd HH:mm:ss")
        expectedMessage := expectedDate . " " . LogLevel.toString(level) . " " . message
        Yunit.assert(formattedMessage == expectedMessage, "TestReplaceDateLevelAndMessage failed")
    }

    End() {
        ; Bereinigung, falls nötig
    }
}

class PatternLayoutLevelTestSuite {
    Begin() {
        ; Initialisierung, falls nötig
    }

    TestReplaceLevel() {
        layout := PatternLayout("%p")
        level := LogLevel.INFO
        formattedMessage := layout.format(level, "Test message")
        Yunit.assert(formattedMessage == LogLevel.toString(level), "TestReplaceLevel failed")
    }

    TestReplaceLevelFirstLetter() {
        layout := PatternLayout("%p{1}")
        level := LogLevel.INFO
        formattedMessage := layout.format(level, "Test message")
        Yunit.assert(formattedMessage == "I", "TestReplaceLevelFirstLetter failed")
    }

    TestReplaceLevelCustomLength() {
        layout := PatternLayout("%p{2}")
        level := LogLevel.INFO
        formattedMessage := layout.format(level, "Test message")
        Yunit.assert(formattedMessage == "IN", "TestReplaceLevelCustomLength failed")
    }

    TestReplaceLevelMaxLength() {
        layout := PatternLayout("%p{9}")
        level := LogLevel.INFO
        formattedMessage := layout.format(level, "Test message")
        Yunit.assert(formattedMessage == "INFO     ", "TestReplaceLevelMaxLength failed")
    }

    End() {
        ; Bereinigung, falls nötig
    }
}

class PatternLayoutMessageTestSuite {
    Begin() {
        ; Initialisierung, falls nötig
    }

    TestReplaceMessage() {
        layout := PatternLayout("%m")
        message := "Test message"
        formattedMessage := layout.format(LogLevel.INFO, message)
        Yunit.assert(formattedMessage == message, "TestReplaceMessage failed")
    }

    TestReplaceMessageChomp() {
        layout := PatternLayout("%m{chomp}")
        message := "Test message`n"
        formattedMessage := layout.format(LogLevel.INFO, message)
        Yunit.assert(formattedMessage == "Test message", "TestReplaceMessageChomp failed")
    }

    TestReplaceMessageUnknownOption() {
        layout := PatternLayout("%m{unknown}")
        message := "Test message"
        formattedMessage := layout.format(LogLevel.INFO, message)
        Yunit.assert(formattedMessage == message, "TestReplaceMessageUnknownOption failed")
        ; Hier sollte eine Warnung ausgegeben werden (dies kann nicht direkt im Test überprüft werden)
    }

    End() {
        ; Bereinigung, falls nötig
    }
}