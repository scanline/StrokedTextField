package org.libspark.font.table;

import openfl.utils.ByteArray;


class GlyfCompositeComp
{

	public static var ARG_1_AND_2_ARE_WORDS:Int = 0x0001;
	public static var ARGS_ARE_XY_VALUES:Int = 0x0002;
	public static var ROUND_XY_TO_GRID:Int = 0x0004;
	public static var WE_HAVE_A_SCALE:Int = 0x0008;
	public static var MORE_COMPONENTS:Int = 0x0020;
	public static var WE_HAVE_AN_X_AND_Y_SCALE:Int = 0x0040;
	public static var WE_HAVE_A_TWO_BY_TWO:Int = 0x0080;
	public static var WE_HAVE_INSTRUCTIONS:Int = 0x0100;
	public static var USE_MY_METRICS:Int = 0x0200;

	private var firstIndex:Int;
	private var firstContour:Int;
	private var argument1:Int;
	private var argument2:Int;
	private var flags:Int;
	private var glyphIndex:Int;
	private var xscale:Float = 1.0;
	private var yscale:Float = 1.0;
	private var scale01:Float = 0.0;
	private var scale10:Float = 0.0;
	private var xtranslate:Int = 0;
	private var ytranslate:Int = 0;
	private var point1:Int = 0;
	private var point2:Int = 0;

	public function new(bais:ByteArray)
	{
		flags = (((bais.readByte()<<8) | bais.readByte()));
		glyphIndex = ((bais.readByte()<<8) | bais.readByte());

		if ((flags & ARG_1_AND_2_ARE_WORDS) != 0)
		{
			argument1 = ((bais.readByte()<<8 | bais.readByte()));
			argument2 = ((bais.readByte()<<8 | bais.readByte()));
		}
		else
		{
			argument1 = (bais.readByte());
			argument2 = (bais.readByte());
		}

		if ((flags & ARGS_ARE_XY_VALUES) != 0)
		{
			xtranslate = argument1;
			ytranslate = argument2;
		}
		else
		{
			point1 = argument1;
			point2 = argument2;
		}

		if ((flags & WE_HAVE_A_SCALE) != 0)
		{
			var i:Int = ((bais.readByte()<<8 | bais.readByte()));
			xscale = yscale = i / 0x4000;
		}
		else if ((flags & WE_HAVE_AN_X_AND_Y_SCALE) != 0)
		{
			var j:Int = ((bais.readByte()<<8 | bais.readByte()));
			xscale = j / 0x4000;
			j = ((bais.readByte()<<8 | bais.readByte()));
			yscale = j / 0x4000;
		}
		else if ((flags & WE_HAVE_A_TWO_BY_TWO) != 0)
		{
			/*   var k:Int= ((bais.readByte()<<8 | bais.readByte()));
			   xscale = k/0x4000;
			   k = ((bais.readByte()<<8 | bais.readByte()));
			   scale01 = i/0x4000;
			   k = ((bais.readByte()<<8 | bais.readByte()));
			   scale10 = i/0x4000;
			   k = ((bais.readByte()<<8 | bais.readByte()));
			   yscale = i/0x4000;*/
			trace("TODO: This block is missing!");
		}
	}

	public function setFirstIndex(idx:Int):Void
	{
		firstIndex = idx;
	}

	public function getFirstIndex():Int
	{
		return firstIndex;
	}

	public function setFirstContour(idx:Int):Void
	{
		firstContour = idx;
	}
	public function getFirstContour():Int
	{
		return firstContour;
	}

	public function getArgument1():Int
	{
		return argument1;
	}

	public function getArgument2():Int
	{
		return argument2;
	}

	public function getFlags():Int
	{
		return flags;
	}

	public function getGlyphIndex():Int
	{
		return glyphIndex;
	}

	public function getScale01():Float
	{
		return scale01;
	}

	public function getScale10():Float
	{
		return scale10;
	}

	public function getXScale():Float
	{
		return xscale;
	}

	public function getYScale():Float
	{
		return yscale;
	}

	public function getXTranslate():Int
	{
		return xtranslate;
	}

	public function getYTranslate():Int
	{
		return ytranslate;
	}

	public function scaleX(x:Float, y:Float):Int
	{
		return Math.round(((x * xscale + y * scale10)));
	}

	public function scaleY(x:Float, y:Float):Int
	{
		return Math.round(((x * scale01 + y * yscale)));
	}
}