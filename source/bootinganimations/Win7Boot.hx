package bootinganimations;

import flixel.FlxState;
import flixel.FlxG;
import flixel.FlxSprite;
import haxe.Timer;
import logonscreens.Win7Logon;
import saveload.SaveManager;
import installerparts.Installer;
import installerparts.Oobe;
import loading.Loading;


class Win7Boot extends FlxState {
    var loadWindows: haxe.Timer;
    var savedGameData: Dynamic;

    override public function create() {
        super.create();

        oobeCompletedSave = SaveManager.load("assets/saves/oobe-in-progress.json");

        savedGameData = SaveManager.load("assets/saves/installed.json");

        var boot = new FlxSprite();
        boot.loadGraphic("assets/images/boot.png");
        add(boot);

        loadWindows = new haxe.Timer(6000);
        loadWindows.run = function() {
            if (savedGameData.windowsInstalled == true) {
                if (oobeCompletedSave.oobeInProgress == true) {
                    FlxG.switchState(new Oobe());
                } else {
                    FlxG.switchState(new Win7Logon());
                }
            } else {
                FlxG.switchState(new Installer());
            }
            loadWindows.stop();
        }
    }


    override public function update(elapsed) {
        super.update(elapsed);
        if (FlxG.keys.justPressed.F8) {
            FlxG.switchState(new AdvancedStartupOptions());
            loadWindows.stop();
        }
    }
}