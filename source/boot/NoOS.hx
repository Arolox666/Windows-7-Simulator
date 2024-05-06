package boot;

import flixel.FlxState;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.text.FlxText;
import BootingState;

class NoOS extends FlxState {
    var hintText: FlxText;
    var msgBox: haxe.Timer;
    var blinkingCursorAdd: haxe.Timer;
    var blinkingCursorRemove: haxe.Timer;
    var cursor: FlxSprite;
    override public function create() {
        super.create();
        var blank = new FlxSprite();
        blank.loadGraphic("assets/images/no-os-found.png");
        add(blank);

        cursor = new FlxSprite(15, 59);
        cursor.loadGraphic("assets/images/blinkingCursor.png");

        blinkingCursorAdd = new haxe.Timer(500);
        blinkingCursorAdd.run = function() {
            add(cursor);
        }

        blinkingCursorRemove = new haxe.Timer(1000);
        blinkingCursorRemove.run = function() {
            remove(cursor);
        }

        hintText = new FlxText(0, 420, "To Install OS Press F12 While In BIOS Loading (The Screen With Haxe Systems Writen In It) And Select ''CD-ROM Drive''. Press Delete To Restart");
        hintText.setFormat(null, 22, 0xffffff, "left");
        add(hintText);
    }

    override public function update(elapsed) {
        super.update(elapsed);
        if (FlxG.keys.pressed.DELETE) {
            FlxG.switchState(new BootingState());
            blinkingCursorAdd.stop();
            blinkingCursorRemove.stop();
            if (cursor != null) {
                remove(cursor);
            }
        }
    }
}