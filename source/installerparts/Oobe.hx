package installerparts;

import flixel.FlxState;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.ui.FlxButton;
import flixel.addons.ui.FlxUIInputText;
import loading.Loading;
import saveload.SaveManager;
import flixel.util.FlxColor;
import operatingsystems.Windows7;

class Oobe extends FlxState {
    var saveUsername: Dynamic = {};
    var savePassword: Dynamic = {};
    var pcNameTextBox: FlxUIInputText;
    var usernameTextCheck: String;
    var usernameSelecting: FlxSprite;
    var usernameTextbox: FlxUIInputText;
    var nextButton: FlxButton;
    var passwordCreation: FlxSprite;
    var passwordTextbox: FlxUIInputText;
    var confirmPasswordTextbox: FlxUIInputText;
    var nextButtonFromNowOn: FlxButton;
    var useRecomendedSettings: FlxButton;
    var updates: FlxSprite;
    var timeOOBE: FlxSprite;
    var count: Int = 0;
    override public function create() {
        super.create();
        FlxG.mouse.visible = true;

        usernameSelecting = new FlxSprite();
        usernameSelecting.loadGraphic("assets/images/Installer/oobe.png");
        add(usernameSelecting);

        usernameTextbox = new FlxUIInputText(657, 537, 572, 32);
        usernameTextCheck = usernameTextbox.text;
        add(usernameTextbox);

        pcNameTextBox = new FlxUIInputText(657, 614, 572, "-PC", 32);
        add(pcNameTextBox);

        nextButton = new FlxButton(1488, 923, "", nextStep);
        nextButton.loadGraphic("assets/images/Buttons/next-aero-oobe-resolution.png");
        add(nextButton);

        nextButtonFromNowOn = new FlxButton(1488, 923, "", nextStep2);
        nextButtonFromNowOn.loadGraphic("assets/images/Buttons/next-aero-oobe-resolution.png");

        useRecomendedSettings = new FlxButton(341, 304, "", goToNextStepAfterUpdates);
        useRecomendedSettings.loadGraphic("assets/images/Buttons/recomended-settings-button.png");
    }

    function nextStep() {
        if (count == 1) {
            if (passwordTextbox.text != "") {
                if (confirmPasswordTextbox.text == passwordTextbox.text) {
                    SaveManager.savePassword(passwordTextbox.text, "assets/saves/password.json");
                    remove(nextButton);
                    remove(confirmPasswordTextbox);
                    remove(passwordTextbox);
                    remove(passwordCreation);
        
                    updates = new FlxSprite();
                    updates.loadGraphic("assets/images/Installer/oobe-updates-(will-never-get-proper-functionality-as-im-too-lazy-im-bad-dev-i-guess).png");
                    add(updates);
        
                    add(useRecomendedSettings);
                }
            }
        }

        if (usernameTextbox.text != "") {
            SaveManager.saveUsername(usernameTextbox.text, "assets/saves/username.json");
            var waitForTextRemovement = new haxe.Timer(10);
            waitForTextRemovement.run = function() {
                usernameTextbox.text = "";
            }
            remove(usernameSelecting);
            remove(usernameTextbox);
            remove(pcNameTextBox);
            remove(nextButton);
            passwordCreation = new FlxSprite();
            passwordCreation.loadGraphic("assets/images/Installer/oobe-password.png");
            add(passwordCreation);

            passwordTextbox = new FlxUIInputText(346, 440, 572, 32);
            passwordTextbox.passwordMode = true;
            add(passwordTextbox);

            confirmPasswordTextbox = new FlxUIInputText(346, 525, 572, 32);
            confirmPasswordTextbox.passwordMode = true;
            add(confirmPasswordTextbox);

            add(nextButton);

            count++;
        }
    }

    function goToNextStepAfterUpdates() {
        remove(useRecomendedSettings);
        remove(updates);

        timeOOBE = new FlxSprite();
        timeOOBE.loadGraphic("assets/images/Installer/oobe-time-and-date-(the-same-thing-as-with-updates-i-know-im-so-bad-developer-you-can-judge-me).png");
        add(timeOOBE);

        add(nextButtonFromNowOn);
    }

    function nextStep2() {
        var completing = new FlxSprite();
        completing.loadGraphic("assets/images/Installer/oobe-finalizing-(no-animation-its-hard-to-animate-on-haxe-flixel-when-you-dont-want-to-buy-adobe-animate-like-its-like-20-to-239-bucks-bro).png");
        add(completing);
        oobeCompleted.oobeInProgress = false;

        SaveManager.save(oobeCompleted, "assets/saves/oobe-in-progress.json");

        var completingTimer = new haxe.Timer(10000);
        completingTimer.run = function() {
            FlxG.switchState(new Windows7());
            completingTimer.stop();
        }
    }

    override public function update(elapsed) {
        super.update(elapsed);

        if (usernameTextbox.text != usernameTextCheck) {
            pcNameTextBox.text = usernameTextbox.text + "-PC";
        }
    }
}