package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.util.FlxColor;

class PlayState extends FlxState
{
	public var paddle:Paddle;
	public var ball:Ball;

	public var walls:FlxGroup;

	public var ceiling:FlxSprite;
	public var leftWall:FlxSprite;
	public var rightWall:FlxSprite;

	public var gameStarted:Bool = false;

	override public function create()
	{
		add(walls = new FlxGroup());

		walls.add(ceiling = new FlxSprite());
		walls.add(leftWall = new FlxSprite());
		walls.add(rightWall = new FlxSprite());

		ceiling.makeGraphic(FlxG.width, 2, FlxColor.GRAY);
		leftWall.makeGraphic(2, FlxG.height, FlxColor.GRAY);
		rightWall.makeGraphic(2, FlxG.height, FlxColor.GRAY);
		rightWall.x = FlxG.width - rightWall.width;

		ceiling.immovable = leftWall.immovable = rightWall.immovable = true;
		ceiling.moves = leftWall.moves = rightWall.moves = false;

		add(paddle = new Paddle());

		add(ball = new Ball());

		super.create();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		if (!gameStarted)
		{
			gameStarted = true;

			ball.spawn();
			ball.launch();
		}
		else
		{
			FlxG.collide(ball, walls);
			FlxG.collide(ball, paddle);
		}
	}
}
