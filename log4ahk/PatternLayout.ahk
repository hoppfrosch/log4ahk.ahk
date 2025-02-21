#Include %A_LineFile%\..\LogLevel.ahk
#Include %A_LineFile%\..\BaseLayout.ahk

class PatternLayout extends BaseLayout {
    pattern := ""
    placeholders := []

    __New(pattern) {
        this.pattern := pattern
        this.extractPlaceholders()
    }

    extractPlaceholders() {
        regex := "%(?:(?<quantifier>-?\d{1,3}|\.\d{1,3}))?(?<type>[mpPd])(?:\{(?<options>.*?)\})?"
        startPos := 1
        while (match := RegExMatch(this.pattern, regex, &placeholder, startPos)) {
            this.placeholders.Push({
                fullMatch: placeholder[0],
                quantifier: placeholder.quantifier,
                type: placeholder.type,
                options: placeholder.options,
                startPos: match,
                endPos: match + StrLen(placeholder[0]) - 1
            })
            startPos := match + StrLen(placeholder[0])
        }
    }

    format(level, message) {
        formattedMessage := this.pattern
        patterns := Map(
            "d", (p) => this.replaceDate(p),
            "m", (p) => this.replaceMessage(p, message),
            "p", (p) => this.replaceLevel(p, level),
            "P", (p) => this.replacePID(p)
        )

        for placeholder in this.placeholders {
            if patterns.Has(placeholder.type) {
                replacement := patterns[placeholder.type](placeholder)
                formattedMessage := StrReplace(formattedMessage, placeholder.fullMatch, replacement)
            }
        }

        return formattedMessage
    }

    replaceDate(placeholder) {
        return FormatTime(A_Now, "yyyy/MM/dd HH:mm:ss")
    }

    replaceMessage(placeholder, message) {
        if (placeholder.options = "chomp") {
            return RTrim(message, "`n")
        }
        if (placeholder.options != "") {
            OutputDebug("[PatternLayout.replaceMessage] [WARN] Unbekannte Option " . placeholder.options . " für %m. Verwende Standard %m.`n")
        }
        return message
    }

    replaceLevel(placeholder, level) {
        levelString := LogLevel.toString(level)
        return levelString
    }

    replacePID(placeholder) {
        return DllCall("GetCurrentProcessId")
    }
}
