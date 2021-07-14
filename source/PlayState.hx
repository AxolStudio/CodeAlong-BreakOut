package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.text.FlxText;
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
	public var ballReady:Bool = false;

	public var blocks:FlxTypedGroup<Block>;

	public var txtScore:FlxText;
	public var txtLives:FlxText;

	public var gameOver:Bool = false;

	override public function create()
	{
		if (Globals.newGame)
		{
			Globals.score = 0;
			Globals.lives = 3;
		}

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

		add(blocks = new FlxTypedGroup<Block>());

		for (r in 0...6)
		{
			for (c in 0...13)
			{
				blocks.add(new Block(c, r));
			}
		}

		add(paddle = new Paddle());

		add(ball = new Ball());

		add(txtScore = new FlxText(2, 1, 0, ""));
		txtScore.color = FlxColor.WHITE;

		add(txtLives = new FlxText(FlxG.width - 52, 1, 50, ""));
		txtLives.alignment = FlxTextAlign.RIGHT;
		txtLives.color = FlxColor.WHITE;

		txtScore.visible = txtLives.visible = false;

		FlxG.camera.fade(FlxColor.BLACK, .2, true, () ->
		{
			if (Globals.newGame)
			{
				showTitleSplash();
			}
			else
			{
				startGame();
			}
		});

		super.create();
	}

	public function showTitleSplash():Void
	{
		openSubState(new TitleSplash(startGame));
	}

	public function ballHitBlock(Bl:Ball, Bk:Block):Void
	{
		Globals.score += 100 * (6 - Bk.row);
		Bk.kill();
	}

	public function ballHitPaddle(B:Ball, P:Paddle):Void
	{
		B.hitPaddle(P.x + (P.width / 2));
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		if (gameOver) {}
		else if (!gameStarted) {}
		else
		{
			if (!ball.ready)
			{
				if (FlxG.keys.anyJustPressed([SPACE, W, I, UP]))
				{
					ball.launch();
				}
			}
			else
			{
				FlxG.collide(ball, walls);
				FlxG.collide(ball, paddle, ballHitPaddle);
				FlxG.collide(ball, blocks, ballHitBlock);

				if (ball.y > FlxG.height)
				{
					Globals.lives--;
					if (Globals.lives > 0)
						ball.spawn();
					else
					{
						gameOver = true;
						Globals.newGame = true;
						openSubState(new GameOver(reload));
					}
				}

				if (blocks.countLiving() == 0)
				{
					ball.kill();
					reload();
				}
			}
		}

		txtScore.text = StringTools.lpad(Std.string(Globals.score), "0", 10);
		txtLives.text = '\u25A0 x ${Globals.lives}';
	}

	public function reload():Void
	{
		FlxG.camera.fade(FlxColor.BLACK, .2, false, () ->
		{
			FlxG.resetState();
		});
	}

	public function startGame():Void
	{
		gameStarted = true;

		ball.spawn();

		txtScore.visible = txtLives.visible = true;
	}
}
