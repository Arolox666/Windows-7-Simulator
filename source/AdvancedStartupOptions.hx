import flixel.FlxState;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.FlxG;
import safemodesystems.Windows7SM;

class AdvancedStartupOptions extends FlxState{
    override public function create() {
        super.create();
        var advancedBootOptions = new FlxSprite();
        advancedBootOptions.loadGraphic("assets/images/abo.png");
        add(advancedBootOptions);

        var warning = new FlxText(900, 200, "Function for moving up and down with arrow keys not implemented yet just press enter to boot into safe mode to get a taste of what is coming soon!!!");
        add(warning);
    }

    override public function update(elapsed){
        super.update(elapsed);
        if (FlxG.keys.justPressed.ENTER) {
            FlxG.switchState(new Windows7SM());
        }
    }
}