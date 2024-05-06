package games;

import flixel.FlxState;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.FlxG;

class Minecraft extends FlxState {
    var cursor: FlxSprite;
    var cursorRemoving: FlxText;
    var minecraft: FlxSprite;
    var loading: FlxSprite;
    override public function create(){
        super.create();
        cursorRemoving = new FlxText(0, 0, "yes");
        add(cursorRemoving);
        FlxG.mouse.visible = true;
        cursor = new FlxSprite(FlxG.mouse.x, FlxG.mouse.y);
        cursor.loadGraphic("assets/images/cursor.png");
        loading = new FlxSprite();
        loading.loadGraphic("assets/images/minecraft/mojang-studios.png");
        add(loading);
        var stuckCursor = new haxe.Timer(999);
        stuckCursor.run = function() {
            add(cursor);
        }
        var loadingTimer = new haxe.Timer(1000);
        loadingTimer.run = function() {
            minecraft = new FlxSprite();
            minecraft.loadGraphic("assets/images/minecraft/menu.png");
            add(minecraft);
            loadingTimer.stop();
            FlxG.mouse.visible = false;
            remove(cursorRemoving);
            loadingTimer.stop();
        }
        var crash = new haxe.Timer(2000);
        crash.run = function() {
            remove(minecraft);
            remove(cursor);
            remove(loading);
            var bsod = new FlxSprite();
            bsod.loadGraphic("assets/images/BSOD_ram.png");
            add(bsod);
            crash.stop();
        }
    }

    override public function update(elapsed) {
        super.update(elapsed);
    }
}