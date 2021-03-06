package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.math.FlxAngle;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;
import flixel.util.FlxSpriteUtil;

using flixel.util.FlxSpriteUtil;

class Ball extends FlxSprite
{
	public static inline var START_SPEED:Float = 100;

	public static inline var MAX_SPEED:Float = 400;

	public static inline var SPEED_FACT:Float = 1.02;

	public var currentSpeed:Float;

	public var ready:Bool = false;

	public function new():Void
	{
		super();
		makeGraphic(4, 4, FlxColor.RED);
		elasticity = SPEED_FACT;
		maxVelocity.set(MAX_SPEED, MAX_SPEED);
	}

	public function spawn():Void
	{
		revive();
		screenCenter();
		y = FlxG.height - 16 - height;
		velocity.set();
		ready = false;
	}

	public function launch():Void
	{
		var launchAngle:Float = FlxG.random.int(-4, 4) * 5;
		launchAngle -= 90;
		velocity.x = currentSpeed = START_SPEED;
		velocity.rotate(FlxPoint.weak(), launchAngle);
		ready = true;
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}

	public function hitPaddle(PMid:Float):Void
	{
		var bPolar:FlxPoint = FlxAngle.getPolarCoords(velocity.x, velocity.y);

		var diff:Float = ((x + (width / 2)) - PMid) / PMid;

		var newA:Float = bPolar.y + (180 * diff);
		velocity.set(bPolar.x, 0).rotate(FlxPoint.weak(), newA);
	}
}
