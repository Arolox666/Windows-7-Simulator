package;

import flixel.FlxGame;
import openfl.display.Sprite;
import loading.Loading;

class Main extends Sprite
{
	public function new()
	{
		super();
		addChild(new FlxGame(0, 0, Loading, 60, 60, true , false));
		var gameWidth:Int = 6969;
	}
}
