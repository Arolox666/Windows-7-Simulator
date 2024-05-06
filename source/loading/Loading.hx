package loading;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.addons.ui.FlxUIBar;
import BootingState;
import saveload.SaveManager;
import flixel.util.FlxColor;
import CreateUserAccount;

var loadUsername: Dynamic;
var loadPassword: Dynamic;
var oobeCompleted: Dynamic = {};
var oobeCompletedSave: Dynamic;

class Loading extends FlxState {
    //This whole thing is used just load the username selection screen if the game is started for the first time so xddddddddddd I
    var loadingBar:FlxUIBar;
    var loadingText:FlxText;
    var progress:Float = 0;
    var loadingSpeed:Float = 5; // Adjust the loading speed as needed
    var savedGameData: Dynamic;
    var gameUsername: Dynamic;
    var welcomeUser: FlxText;

    override public function create():Void {
        gameUsername = SaveManager.loadUsername("assets/saves/username.json");
        welcomeUser = new FlxText(0, 0, "");
        welcomeUser.setFormat(null, 20, FlxColor.WHITE, "center");
        welcomeUser.screenCenter();
        welcomeUser.text = "Welcome, " + gameUsername;
        add(welcomeUser);
        // Create loading bar
        loadingBar = new FlxUIBar(50, FlxG.height - 50, LEFT_TO_RIGHT, FlxG.width - 100, 10);
        loadingBar.createFilledBar(0xFF000000, 0xFF00FF00);
        add(loadingBar);

        // Create loading text
        loadingText = new FlxText(0, FlxG.height - 30, FlxG.width, "Loading...");
        loadingText.setFormat(null, 16, 0xFFFFFFFF, "center");
        add(loadingText);

        FlxG.mouse.visible = false;
    }

    override public function update(elapsed:Float):Void {
        super.update(elapsed);
        
        // Update loading progress
        if (progress < 100) {
            progress += elapsed * loadingSpeed;
            loadingBar.percent = Math.min(progress, 100); // Ensure progress does not exceed 100%
        } else {
            // Loading complete, transition to next state or screen
            FlxG.switchState(new BootingState());
        }
    }
}
