package boot;

import flixel.FlxState;
import flixel.FlxG;
import flixel.FlxSprite;
import boot.LoadingFiles;

class BootMenu extends FlxState {
    override public function create() {
        super.create();
        var bootMenu = new FlxSprite(798, 445);
        bootMenu.loadGraphic("assets/images/boot-menu.png");
        add(bootMenu);
    }

    override public function update(elapsed) {
        super.update(elapsed);
        if (FlxG.keys.justPressed.ONE) {
            FlxG.switchState(new NoOS());
        }

        if (FlxG.keys.justPressed.TWO) {
            FlxG.switchState(new NoOS());
        }

        if (FlxG.keys.justPressed.THREE) {
            FlxG.switchState(new LoadingFiles());
        }

        if (FlxG.keys.justPressed.FOUR) {
            FlxG.switchState(new NoOS());
        }
    }
}