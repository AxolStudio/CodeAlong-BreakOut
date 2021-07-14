package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;

class Paddle extends FlxSprite
{
	public static inline var SPEED:Float = 300;

	public function new():Void
	{
		super();

		makeGraphic(32, 4, FlxColor.WHITE);
		immovable = true;

		spawn();
	}

	public function spawn():Void
	{
		screenCenter();
		y = FlxG.height - 8 - height;
		velocity.set();
	}

	override public function update(elapsed:Float):Void
	{
		if (FlxG.keys.anyPressed([A, LEFT, J]))
		{
			// MOVE LEFT
			velocity.x = -SPEED;
		}
		else if (FlxG.keys.anyPressed([D, RIGHT, L]))
		{
			// MOVE RIGHT
			velocity.x = SPEED;
		}

		super.update(elapsed);
		velocity.x = 0;

		if (x < 4)
			x = 4;
		if (x > FlxG.width - 4 - width)
			x = FlxG.width - 4 - width;
	}
}
