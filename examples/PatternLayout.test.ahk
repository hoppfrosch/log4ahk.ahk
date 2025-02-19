#Include %A_ScriptDir%/../log4ahk/PatternLayout.ahk

class PatternLayoutTests {
    ; Teste, ob das Datum korrekt ersetzt wird
    TestReplaceDate() {
        layout := PatternLayout("%d")
        formattedMessage := layout.format("INFO", "Test message")
        expectedDate := FormatTime(A_Now, "yyyy/MM/dd HH:mm:ss")
        this.assertEqual(StrReplace(formattedMessage, expectedDate, ""), "")
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

    ; Teste, ob sowohl Datum als auch Nachricht korrekt ersetzt werden
    TestReplaceDateAndMessage() {
        layout := PatternLayout("%d %m")
        message := "Test message"
        formattedMessage := layout.format("INFO", message)
        expectedDate := FormatTime(A_Now, "yyyy/MM/dd HH:mm:ss")
        expectedMessage := expectedDate . " " . message
        this.assertEqual(formattedMessage, expectedMessage)
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
        this.TestReplaceMessage()
        this.TestReplaceMessageChomp()
        this.TestReplaceDateAndMessage()
        MsgBox("All tests passed.")
    }
}

; Erzeuge eine Instanz der Testklasse und führe die Tests aus
tests := PatternLayoutTests()
tests.RunTests()