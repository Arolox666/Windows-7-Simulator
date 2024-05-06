import flixel.FlxState;
import flixel.FlxG;
import flixel.FlxSprite;
import boot.BootMenu;
import boot.NoOS;
import saveload.SaveManager;
import bootinganimations.Win7Boot;

class BootingState extends FlxState {
    var booting: FlxSprite;
    var bios: FlxSprite;
    var starting: haxe.Timer;
    var continueBooting: haxe.Timer;
    var savedGameData: Dynamic;
    var oobeCompletedSave: Dynamic;

    override public function create():Void {
        super.create();
    
        // Load saved game data
        savedGameData = SaveManager.load("assets/saves/installed.json");
    
        // Load BIOS image
        bios = new FlxSprite();
        bios.loadGraphic("assets/images/bios loading.png");
        add(bios);
    
        // Hide mouse cursor
        FlxG.mouse.visible = false;
    
        // Timer to continue booting after a delay
        continueBooting = new haxe.Timer(1500);
        continueBooting.run = function() {
            if (savedGameData.windowsInstalled == true) {
                FlxG.switchState(new Win7Boot());
            } else {
                FlxG.switchState(new NoOS());
            }
            continueBooting.stop();
        }
    }
    



    override public function update(elapsed:Float):Void {
        super.update(elapsed);
        if (FlxG.keys.justPressed.F12) {
            FlxG.switchState(new BootMenu());
            continueBooting.stop();
        }
    }
}
