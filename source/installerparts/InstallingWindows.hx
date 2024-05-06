package installerparts;

import flixel.FlxState;
import flixel.text.FlxText;
import flixel.FlxSprite;
import flixel.FlxG;
import haxe.Timer;
import installerparts.Restarting;

class InstallingWindows extends FlxState {
    var procentageCopying: FlxText;
    var addProcentage: haxe.Timer;
    var copying: Int = 0;
    var installingWindows: FlxSprite;
    var expanding: Int = -100;
    var installingExpandingStep: FlxSprite;
    var installingExpandingStepText: FlxText;
    var installingFeaturesStep: FlxSprite;
    var installingFeatures: Int = -200;
    var installingFeaturesStepText: FlxText;
    var installingUpdatesStep: FlxSprite;
    var updating: Int = -300;
    var installingUpdatesStepText: FlxText;
    override public function create() {
        super.create();
        installingWindows = new FlxSprite();
        installingWindows.loadGraphic("assets/images/Installer/Installing-Windows-Parts/installing-windows-copying.png");
        add(installingWindows);

        installingExpandingStep = new FlxSprite();
        installingExpandingStep.loadGraphic("assets/images/Installer/Installing-Windows-Parts/installing-windows-expanding.png");
        installingExpandingStepText = new FlxText(877, 532, "");
        installingExpandingStepText.setFormat(null, 9, 0x0000);

        installingFeaturesStep = new FlxSprite();
        installingFeaturesStep.loadGraphic("assets/images/Installer/Installing-Windows-Parts/installing-windows-features.png");
        installingFeaturesStepText = new FlxText(820, 554, "");
        installingFeaturesStepText.setFormat(null, 9, 0x0000);

        installingUpdatesStep = new FlxSprite();
        installingUpdatesStep.loadGraphic("assets/images/Installer/Installing-Windows-Parts/installing-windows-updates.png");
        installingUpdatesStepText = new FlxText(825, 590, "");
        installingUpdatesStepText.setFormat(null, 9, 0x0000);

        procentageCopying = new FlxText(870, 496, "");
        procentageCopying.setFormat(null, 9, 0x0000);
        add(procentageCopying);


        addProcentage = new haxe.Timer(2);
        addProcentage.run = function() {

            copying++;
            expanding++;
            installingFeatures++;
            updating++;

            procentageCopying.text = "(" + copying + "%)";
            installingExpandingStepText.text = "(" + expanding + "%)";
            installingFeaturesStepText.text = "(" + installingFeatures + "%)";
            installingUpdatesStepText.text = "(" + updating + "%)";


            if (copying == 100) {
                remove(procentageCopying);
                remove(installingWindows);
                add(installingExpandingStep);
                add(installingExpandingStepText);

            } if (expanding == 100) {
                remove(installingExpandingStep);
                remove(installingExpandingStepText);
                add(installingFeaturesStep);
                add(installingFeaturesStepText);
            } if (installingFeatures == 100) {
                remove(installingFeaturesStep);
                remove(installingFeaturesStepText);
                add(installingUpdatesStep);
                add(installingUpdatesStepText);
            } if (updating == 100) {
                FlxG.switchState(new Restarting());
            }
        }

        
    }

    override public function update(elasped) {
        super.update(elasped);
    }
}