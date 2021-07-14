package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxSpriteUtil;

class TitleSplash extends FlxSubState
{
	public var ready:Bool = false;

	public function new(Callback:Void->Void):Void
	{
		super();
		closeCallback = Callback;
	}

	override public function create():Void
	{
		var back:FlxSprite = new FlxSprite();
		back.makeGraphic(Std.int(FlxG.width * .8), Std.int(FlxG.height * .8), FlxColor.BLACK);
		FlxSpriteUtil.drawRect(back, 0, 0, back.width, back.height, FlxColor.TRANSPARENT, {thickness: 1, color: FlxColor.GRAY});
		back.screenCenter();
		add(back);

		var title:FlxText = new FlxText(0, 0, 0, "CA:BREAKOUT", 12);
		title.screenCenter();
		title.y -= title.height + 8;
		add(title);

		var txtPlay:FlxText = new FlxText(0, 0, 0, "Press ANY KEY to Play");
		txtPlay.screenCenter();
		txtPlay.y += txtPlay.height;
		add(txtPlay);

		ready = true;

		super.create();
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);

		if (ready)
		{
			if (FlxG.keys.anyJustPressed([ANY]))
			{
				ready = false;
				close();
			}
		}
	}
}
