package installerparts;

import flixel.FlxState;
import flixel.FlxSprite;
import flixel.ui.FlxButton;
import flixel.FlxG;
import flixel.text.FlxText;
import installerparts.InstallingWindows;

class Installer extends FlxState {
    var installerImage: FlxSprite;
    var nextButton: FlxButton;
    var installNowButton: FlxButton;
    var installNowImage: FlxSprite;
    var setupIsStartingBackground: FlxSprite;
    var setupIsStartingText: FlxText;
    var fourthStep: FlxSprite;
    var checkMarkButton: FlxButton;
    var checkmark: FlxSprite;
    var nextButtonAero: FlxButton;
    var customButton: FlxButton;
    var fifthStep: FlxSprite;
    var sixthStep: FlxSprite;
    var partitionButton: FlxButton;
    var selectedPartition: FlxSprite;
    override public function create() {
        super.create();
        installerImage = new FlxSprite();
        installerImage.loadGraphic("assets/images/Installer/first_step.png");
        add(installerImage);

        nextButton = new FlxButton(1221, 729, "", goToStep2);
        nextButton.loadGraphic("assets/images/Buttons/next.png");
        add(nextButton);

        FlxG.mouse.visible = true;

        nextButtonAero = new FlxButton(1215, 731, "", nextButtonAeroFunction);
        nextButtonAero.loadGraphic("assets/images/Buttons/next-aero.png");
    }

    function goToStep2() {
        remove(installerImage);
        remove(nextButton);

        installNowImage = new FlxSprite();
        installNowImage.loadGraphic("assets/images/Installer/second_step.png");
        add(installNowImage);

        installNowButton = new FlxButton(866, 538, "", goToStep3);
        installNowButton.loadGraphic("assets/images/Buttons/install_now.png");
        add(installNowButton);
    }

    function goToStep3() {
        remove(installNowImage);
        remove(installNowButton);

        setupIsStartingBackground = new FlxSprite();
        setupIsStartingBackground.loadGraphic("assets/images/Installer/setup-is-starting-background.png");
        add(setupIsStartingBackground);

        var continueToNextStep = new haxe.Timer(500);
        continueToNextStep.run = function() {
            remove(setupIsStartingBackground);
            
            fourthStep = new FlxSprite();
            fourthStep.loadGraphic("assets/images/Installer/third_step.png");
            add(fourthStep);

            checkMarkButton = new FlxButton(658, 680, "", checkMarkAdd);
            checkMarkButton.loadGraphic("assets/images/Installer/empty-checkmark.png");
            add(checkMarkButton);
            continueToNextStep.stop();
        }

    }

    function checkMarkAdd() {
        checkmark = new FlxSprite(658, 680);
        checkmark.loadGraphic("assets/images/Installer/checkmark.png");
        add(checkmark);
        add(nextButtonAero);

        remove(checkMarkButton);
    }

    function nextButtonAeroFunction() {
        if (fourthStep != null) {
            remove(fourthStep);

            fifthStep = new FlxSprite();
            fifthStep.loadGraphic("assets/images/Installer/fourth_step.png");
            add(fifthStep);

            remove(checkmark);
            remove(nextButtonAero);
            remove(fourthStep);
            fourthStep = null;

            customButton = new FlxButton(645, 526, "", goToStep4);
            customButton.loadGraphic("assets/images/Buttons/custom.png");
            add(customButton);
        } else {
            FlxG.switchState(new InstallingWindows());
        }
    }

    function goToStep4() {
        sixthStep = new FlxSprite();
        sixthStep.loadGraphic("assets/images/Installer/fifth_step.png");
        add(sixthStep);

        partitionButton = new FlxButton(661, 440, "", selectPartition);
        partitionButton.loadGraphic("assets/images/Buttons/partition.png");
        add(partitionButton);
    }

    function selectPartition() {
        remove(partitionButton);

        add(nextButtonAero);

        selectedPartition = new FlxSprite(662, 432);
        selectedPartition.loadGraphic("assets/images/Installer/selected-partition.png");
        add(selectedPartition);
    }

    override public function update(elapsed) {
        super.update(elapsed);
    }
}