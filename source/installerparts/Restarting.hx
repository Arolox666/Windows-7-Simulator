package installerparts;

import flixel.FlxState;
import flixel.FlxSprite;
import flixel.ui.FlxButton;
import haxe.Timer;
import flixel.FlxG;
import BootingState;
import sys.io.File;
import haxe.Json;
import saveload.SaveManager;

class Restarting extends FlxState {
    var gameData: Dynamic = {}; // Initialize gameData as an empty object

    var wait: haxe.Timer;

    override public function create() {
        super.create();

        var restart = new FlxSprite();
        restart.loadGraphic("assets/images/Installer/restarting_step.png");
        add(restart);

        var restartNowButton = new FlxButton(1202, 730, "", restartFunction);
        restartNowButton.loadGraphic("assets/Buttons/restart.png");
        add(restartNowButton);

        wait = new haxe.Timer(10000);
        wait.run = function() {
            restartFunction();
        };
    }

    function restartFunction() {
        gameData.windowsInstalled = true;
        SaveManager.save(gameData, "assets/saves/installed.json");
        wait.stop();
        FlxG.switchState(new BootingState());
    }

    override public function update(elapsed) {
        super.update(elapsed);
    }
}