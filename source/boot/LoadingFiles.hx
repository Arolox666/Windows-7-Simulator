package boot;

import flixel.FlxState;
import flixel.FlxSprite;
import haxe.Timer;
import flixel.FlxG;
import bootinganimations.Win7Boot;

class LoadingFiles extends FlxState {
    var loadingBar: FlxSprite;
    var moveTo2ndStageOfLoading: haxe.Timer;
    var moveTo3rdStageOfLoading: haxe.Timer;
    var moveTo4thStageOfLoading: haxe.Timer;
    var moveTo5thStageOfLoading: haxe.Timer;
    var switchState: haxe.Timer;
    override public function create() {
        super.create();
        var loadingFiles = new FlxSprite();
        loadingFiles.loadGraphic("assets/images/loading_files.png");
        add(loadingFiles);

        loadingBar = new FlxSprite(107, 896);
        loadingBar.loadGraphic("assets/images/Loading-Bars/loading_files1.png");
        add(loadingBar);

        moveTo2ndStageOfLoading = new haxe.Timer(1000);
        moveTo2ndStageOfLoading.run = function() {
            loadingBar.loadGraphic("assets/images/Loading-Bars/loading_files2.png");
            moveTo2ndStageOfLoading.stop();
        }
        moveTo3rdStageOfLoading = new haxe.Timer(2500);
        moveTo3rdStageOfLoading.run = function() {
            loadingBar.loadGraphic("assets/images/Loading-Bars/loading_files3.png");
            moveTo3rdStageOfLoading.stop();
        }
        moveTo4thStageOfLoading = new haxe.Timer(4000);
        moveTo4thStageOfLoading.run = function() {
            loadingBar.loadGraphic("assets/images/Loading-Bars/loading_files4.png");
            moveTo4thStageOfLoading.stop();
        }
        moveTo5thStageOfLoading = new haxe.Timer(5500);
        moveTo5thStageOfLoading.run = function() {
            loadingBar.loadGraphic("assets/images/Loading-Bars/loading_files5.png");
            moveTo5thStageOfLoading.stop();
        }
        switchState = new haxe.Timer(6000);
        switchState.run = function() {
            FlxG.switchState(new Win7Boot());
            switchState.stop();
        }
    }

    override public function update(elapsed) {
        super.update(elapsed);
    }
}