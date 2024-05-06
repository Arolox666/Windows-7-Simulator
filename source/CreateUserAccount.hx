import flixel.FlxState;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.addons.ui.FlxUIInputText;
import saveload.SaveManager;
import flixel.ui.FlxButton;
import BootingState;
import flixel.FlxG;
import flixel.util.FlxColor;
import haxe.Timer;
import saveload.SaveManagerUsername;

class CreateUserAccount extends FlxState {
    var okay: FlxButton;
    var passwordTextBox: FlxUIInputText;
    var usernameTextBox: FlxUIInputText;
    var areYouSure: FlxSprite;
    var passwordText: FlxText;
    var usernameText: FlxText;
    var retypePassword: FlxUIInputText;
    var usernameSave: Dynamic = {};
    var passwordSave: Dynamic = {};
    var yes: FlxButton;
    var no: FlxButton;
    override public function create() {
        super.create();
        FlxG.mouse.visible = true;

        var main = new FlxSprite();
        main.loadGraphic("assets/images/creating-user-account/actuall-creating-screen.png");
        add(main);
        
        areYouSure = new FlxSprite(131, 191);
        areYouSure.loadGraphic("assets/images/creating-user-account/are-you-sure.png");

        var retype = new FlxSprite(86, 88);
        retype.loadGraphic("assets/images/creating-user-account/retype-password.png");

        usernameTextBox = new FlxUIInputText(137, 353, 1669, 53);
        add(usernameTextBox);
    
        passwordTextBox = new FlxUIInputText(138, 829, 1669, 51);
        passwordTextBox.passwordMode = true;
        add(passwordTextBox);

        okay = new FlxButton(960, 1020, "Ok", addAnotherSprite);
        add(okay);

    }

    function addAnotherSprite() {
        add(areYouSure);
        remove(okay);

        passwordText = new FlxText(492, 555, "");
        passwordText.setFormat(null, 48, FlxColor.BLACK);
        passwordText.text = passwordTextBox.text;

        yes = new FlxButton(592, 817, "Yes", yesButtonFunction);
        no = new FlxButton(1395, 757, "No", noButtonFunction);

        var usernameTextTimer = new haxe.Timer(10);
        usernameTextTimer.run = function() {
            usernameText = new FlxText(492, 323, "");
            usernameText.setFormat(null, 48, FlxColor.BLACK);
            usernameText.text = usernameTextBox.text;
            add(usernameText);
            add(passwordText);
            add(yes);
            add(no);
        }
    }

    public function yesButtonFunction() {
        remove(yes);
        remove(no);
        retypePassword = new FlxUIInputText(214, 464, 1492, 133);
        retypePassword.passwordMode = true;
        var okay2 = new FlxButton(960, 802, "Ok", createFunction);

        var retypePasswordTimer = new haxe.Timer(10);
        retypePasswordTimer.run = function() {
            add(retypePassword);
            add(okay2);
            retypePasswordTimer.stop();
        }

    }

    public function noButtonFunction() {
        remove(areYouSure);
        add(okay);
        remove(passwordText);
        remove(usernameText);
        remove(yes);
        remove(no);
    }

    public function createFunction() {
        if (retypePassword.text == passwordTextBox.text) {
            usernameSave.username = usernameTextBox;
            passwordSave.password = passwordTextBox;
            SaveManagerUsername.saveTextAsJson(usernameTextBox.text, "assets/saves/username.json");
            var continueToBoot = new haxe.Timer(25);
            continueToBoot.run = function() {
                FlxG.switchState(new BootingState());
                continueToBoot.stop();
            }
        } else {
            FlxG.camera.flash(FlxColor.RED, 0.5);
        }
        
    }



    override public function update(elapsed) {
        super.update(elapsed);
    }
}