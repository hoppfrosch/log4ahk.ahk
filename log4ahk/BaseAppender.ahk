#Include %A_LineFile%\..\SimpleLayout.ahk

class BaseAppender {
    __New(layout := "") {
        this.layout := layout ? layout : SimpleLayout()
    }

    setLayout(layout) {
        this.layout := layout
    }

    append(level, message) {
        throw Error("Die Methode 'append' muss in der abgeleiteten Klasse implementiert werden.", "NotImplementedError", -1)
    }
}