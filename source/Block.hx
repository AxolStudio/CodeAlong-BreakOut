package;

import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.util.FlxSpriteUtil;

class Block extends FlxSprite
{
	public static inline var BLOCK_WIDTH:Int = 12;
	public static inline var BLOCK_HEIGHT:Int = 6;

	public var row:Int = -1;

	public function new(Col:Int, Row:Int):Void
	{
		super(2 + (Col * BLOCK_WIDTH), (Row + 2) * BLOCK_HEIGHT);

		row = Row;

		var c:FlxColor = FlxColor.fromHSB(60 * Row, 1, 1);

		makeGraphic(BLOCK_WIDTH, BLOCK_HEIGHT, c);
		FlxSpriteUtil.drawRect(this, 0, 0, BLOCK_WIDTH, BLOCK_HEIGHT, FlxColor.TRANSPARENT, {thickness: 1, color: c.getDarkened(.5)});
		immovable = true;
		moves = false;
	}
}
