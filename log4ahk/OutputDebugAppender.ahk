#Include %A_LineFile%\..\BaseAppender.ahk

class OutputDebugAppender extends BaseAppender {
    __New(layout := "") {
        super.__New(layout)
    }

    append(level, message) {
        logMessage := this.layout.format(level, message)
        OutputDebug(logMessage)
    }
}