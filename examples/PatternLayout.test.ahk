#Include %A_ScriptDir%/../log4ahk/PatternLayout.ahk

class PatternLayoutTests {
    ; Teste, ob das Datum korrekt ersetzt wird
    TestReplaceDate() {
        layout := PatternLayout("%d")
        formattedMessage := layout.format("INFO", "Test message")
        expectedDate := FormatTime(A_Now, "yyyy/MM/dd HH:mm:ss")
        this.assertEqual(StrReplace(formattedMessage, expectedDate, ""), "")
    }

    ; Teste, ob das Logging-Level korrekt ersetzt wird
    TestReplaceLevel() {
        layout := PatternLayout("%p")
        level := "INFO"
        formattedMessage := layout.format(level, "Test message")
        this.assertEqual(formattedMessage, level)
    }

    ; Teste, ob das erste Zeichen des Logging-Levels korrekt ersetzt wird
    TestReplaceLevelFirstLetter() {
        layout := PatternLayout("%p{1}")
        level := "INFO"
        formattedMessage := layout.format(level, "Test message")
        this.assertEqual(formattedMessage, "I")
    }

    ; Teste, ob das Logging-Level auf eine bestimmte Länge abgeschnitten wird
    TestReplaceLevelCustomLength() {
        layout := PatternLayout("%p{2}")
        level := "INFO"
        formattedMessage := layout.format(level, "Test message")
        this.assertEqual(formattedMessage, "IN")
    }

    ; Teste, ob das Logging-Level auf eine maximale Länge von 9 Zeichen aufgefüllt wird
    TestReplaceLevelMaxLength() {
        layout := PatternLayout("%p{9}")
        level := "INFO"
        formattedMessage := layout.format(level, "Test message")
        this.assertEqual(formattedMessage, "INFO     ")
    }

    ; Teste, ob die Nachricht korrekt ersetzt wird
    TestReplaceMessage() {
        layout := PatternLayout("%m")
        message := "Test message"
        formattedMessage := layout.format("INFO", message)
        this.assertEqual(formattedMessage, message)
    }

    ; Teste, ob die Nachricht ohne abschließenden Zeilenumbruch korrekt ersetzt wird
    TestReplaceMessageChomp() {
        layout := PatternLayout("%m{chomp}")
        message := "Test message`n"
        formattedMessage := layout.format("INFO", message)
        this.assertEqual(formattedMessage, "Test message")
    }

    ; Teste, ob die Nachricht mit unbekannter Option korrekt ersetzt wird und eine Warnung ausgegeben wird
    TestReplaceMessageUnknownOption() {
        layout := PatternLayout("%m{unknown}")
        message := "Test message"
        formattedMessage := layout.format("INFO", message)
        this.assertEqual(formattedMessage, message)
        ; Hier sollte eine Warnung ausgegeben werden (dies kann nicht direkt im Test überprüft werden)
    }

    ; Teste, ob sowohl Datum als auch Nachricht korrekt ersetzt werden
    TestReplaceDateAndMessage() {
        layout := PatternLayout("%d %m")
        message := "Test message"
        formattedMessage := layout.format("INFO", message)
        expectedDate := FormatTime(A_Now, "yyyy/MM/dd HH:mm:ss")
        expectedMessage := expectedDate . " " . message
        this.assertEqual(formattedMessage, expectedMessage)
    }

    ; Teste, ob Datum, Logging-Level und Nachricht korrekt ersetzt werden
    TestReplaceDateLevelAndMessage() {
        layout := PatternLayout("%d %p %m")
        level := "INFO"
        message := "Test message"
        formattedMessage := layout.format(level, message)
        expectedDate := FormatTime(A_Now, "yyyy/MM/dd HH:mm:ss")
        expectedMessage := expectedDate . " " . level . " " . message
        this.assertEqual(formattedMessage, expectedMessage)
    }

    ; Teste, ob die Versionsnummer korrekt ist
    TestVersion() {
        layout := PatternLayout("%d %p %m")
        this.assertEqual(layout.version, "1.0.0")
    }

    ; Hilfsmethode: Überprüfe, ob zwei Werte gleich sind
    assertEqual(actual, expected) {
        if (actual != expected) {
            MsgBox("Test failed. Expected: " . expected . " but got: " . actual)
            ExitApp
        }
    }

    ; Führe alle Tests aus
    RunTests() {
        this.TestReplaceDate()
        this.TestReplaceLevel()
        this.TestReplaceLevelFirstLetter()
        this.TestReplaceLevelCustomLength()
        this.TestReplaceLevelMaxLength()
        this.TestReplaceMessage()
        this.TestReplaceMessageChomp()
        this.TestReplaceMessageUnknownOption()
        this.TestReplaceDateAndMessage()
        this.TestReplaceDateLevelAndMessage()
        this.TestVersion()
        MsgBox("All tests passed.")
    }
}

; Erzeuge eine Instanz der Testklasse und führe die Tests aus
tests := PatternLayoutTests()
tests.RunTests()