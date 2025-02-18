class PatternLayout {
    pattern := ""

    __New(pattern) {
        this.pattern := pattern
    }

    format(level, message) {
        formattedMessage := StrReplace(this.pattern, "%d", FormatTime(A_Now, "yyyy/MM/dd HH:mm:ss"))
        formattedMessage := StrReplace(formattedMessage, "%m", message)
        return formattedMessage
    }
}