# NoteOCR

## The purpose of this project is to enable quicker note taking.
This is accomplished by defining a region of the screen as the "source" material.
A snippet/screenshot is taken of this source region once every N seconds.
This image is processed using OCR to extract text from the image.
This text is then provided as input to an auto-completion/completion-suggestion engine.
The initial goal is to provide input to nvim-cmp, however a long-term goal of the project is to be compatible with multiple more popular engines (incl. Word, OneNote)

### Requirements
Program,MinVersion
screenshot,TODO
OpenCV,TODO
NeoVim,0.10.1

### TODO
- Provide new source for nvim-cmp
- Set nvim-cmp source priority
- OCR image --> text doc
- Lexical analysis on text to generate logical phrases.
    - punctuation-separated
    - newline-separated
    - keywords
    - phrases
- screenshot API to get pixel bounds of the screen region (and know which screen the notes are being taken from).
    - does screenshot require internet access?
    - OCR pipeline should be all offline. I don't want the stuff people are taking photos of/notes on being sent OTA.
    - config/ini which saves the xyMin, xyMax px so that we don't need user to draw the box every snip.
    - argument to just use an entire screen or draw the box.
        - screen-picker
- Package release for Arch, Docker


### Design


Arguments/Configs
    -s, --screen [N]            tells program to take snippets from a specific screen. If N is included it pre-determines the screen, else user is asked to click the screen
    -r, --region [x1 y1 x2 y2]  tells the program to use a specific region of the screen
    -m, --maxResults N          limits the number of text recommendations
    -p, --prioritize T          prioritize one of (sentence, phrase, word)
    -f, --frequency N           num Seconds to delay between screenshots. Default = 5 sec. Min = 1 sec.
    -e, --engine T              define which autocompletion engine to provide suggestions to. (This may change to filepath)




