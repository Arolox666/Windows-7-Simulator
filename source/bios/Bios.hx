package bios;

import flixel.FlxState;
import flixel.FlxG;
import flixel.FlxSprite;
import BootingState;


class Bios extends FlxState {
    override public function create() {
        super.create();
        var biosWindow = new FlxSprite();
        biosWindow.loadGraphic("assets/images/bios.png");
        add(biosWindow);
    }



    override public function update(elapsed) {
        super.update(elapsed);
        if (FlxG.keys.justPressed.F10) {
            FlxG.switchState(new BootingState());
        }
    }
}