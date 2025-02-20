#Include %A_LineFile%\..\BaseAppender.ahk

class FileAppender extends BaseAppender {
    __New(filePath, layout := "") {
        this.filePath := filePath
        super.__New(layout)
        this.ensureLogFileExists()
    }

    append(level, message) {
        logMessage := this.layout.format(level, message)
        FileAppend(logMessage "`n", this.filePath)
    }

    ensureLogFileExists() {
        if !FileExist(this.filePath) {
            FileAppend("", this.filePath)
        }
    }
}