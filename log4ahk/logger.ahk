#Include %A_LineFile%\..\LogLevel.ahk
#Include %A_LineFile%\..\FileAppender.ahk
#Include %A_LineFile%\..\SimpleLayout.ahk
#Include %A_LineFile%\..\PatternLayout.ahk

class Logger {
    static instance := ""

    __New(logLvl := LogLevel.INFO) {
        this.logLevel := logLvl
        this.appenders := []
        ; Standardmäßig den FileAppender verwenden
        defaultFilePath := A_ScriptDir "\default_log.txt"
        defaultLayout := SimpleLayout()
        defaultAppender := FileAppender(defaultFilePath, defaultLayout)
        this.addAppender(defaultAppender)
    }

    static getInstance() {
        if (!Logger.instance) {
            Logger.instance := Logger()
        }
        return Logger.instance
    }

    addAppender(appender) {
        this.appenders.Push(appender)
    }

    log(level, message) {
        if (level >= this.logLevel) {
            for appender in this.appenders {
                appender.append(level, message)
            }
            this.output(message)
        }
    }

    trace(message) {
        this.log(LogLevel.TRACE, message)
    }

    debug(message) {
        this.log(LogLevel.DEBUG, message)
    }

    info(message) {
        this.log(LogLevel.INFO, message)
    }

    warning(message) {
        this.log(LogLevel.WARNING, message)
    }

    error(message) {
        this.log(LogLevel.ERROR, message)
    }

    severe(message) {
        this.log(LogLevel.SEVERE, message)
    }

    output(message) {
        ToolTip(message)
    }

    setLogLevel(level) {
        this.logLevel := level
    }
}