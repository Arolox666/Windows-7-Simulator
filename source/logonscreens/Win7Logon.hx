package logonscreens;

import flixel.FlxState;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.ui.FlxButton;
import flixel.addons.ui.FlxUIInputText;
import haxe.Timer;
import flixel.util.FlxColor;
import saveload.SaveManager;
import operatingsystems.Windows7;
import flixel.text.FlxText;

class Win7Logon extends FlxState {
    var loadUsername: Dynamic;
    var loadPassword: Dynamic;
    var passwordBox: FlxUIInputText;
    override public function create() {
        super.create();
        FlxG.sound.play("assets/sounds/startup.wav");

        loadUsername = SaveManager.loadUsername("assets/saves/username.json");
        loadPassword = SaveManager.loadPassword("assets/saves/password.json");

        FlxG.mouse.visible = true;

        var background = new FlxSprite();
        background.loadGraphic("assets/images/logonScreens/logonimage.png");
        add(background);

        var username = new FlxText(960, 601, "");
        username.text = loadUsername.username;
        username.setFormat(null, 20, FlxColor.WHITE, "center");
        
        var passwordBox = new FlxUIInputText(849, 638, 221, 21);
        passwordBox.passwordMode = true;
        add(passwordBox);
    }

    public function logon() {
        FlxG.switchState(new Windows7());
    }

    override public function update(elapsed) {
        super.update(elapsed);
        if (FlxG.keys.justPressed.ENTER) {
            if (passwordBox.text == loadPassword.password) {
                logon();
            }
        }
    }
}