import openfl.utils.ByteArray;
import openfl.utils.Endian;
import openfl.display.Shape;
import openfl.display.BitmapData;
import openfl.display.DisplayObject;
import openfl.display.IGraphicsData;
import org.libspark.font.data.RawFont;
import org.libspark.font.render.GlyphRenderer;

import openfl.geom.Matrix;
import openfl.geom.Rectangle;
import openfl.display.Graphics;
import openfl.Vector;
import openfl.display.GraphicsPath;

import haxe.crypto.Sha256;

class StrokedTextField extends Shape
{
	private var rawFont:RawFont;
	public var text(get, set):String;
	private var _text = "";
	public var fontSize(get, set):Int;
	private var _fontSize:Int = 24;
	public var align(get, set):String;
	private var _align:String = "left";
	public var lineSpacing(get, set):Float;
	private var _lineSpacing:Float = 0;
	public var charSpacing(get, set):Float;
	private var _charSpacing:Float = 0;
	public var mode(get, set):String;
	private var _mode:String = "stroke";
	public var useKerning(get, set):Bool;
	private var _useKerning:Bool = true;

	private static var _fontCache:Array<RawFont>=[];

	public function new(font:openfl.utils.ByteArray):Void
	{
		super();
		font.endian = Endian.BIG_ENDIAN;
		var chunk:ByteArray = new ByteArray();
		font.position = 0;
		font.readBytes(chunk, 0, font.length>16384 ? 16384:font.length);
		var hash:String = Sha256.make(chunk).toHex();
		chunk.clear();
		var parsedFont:RawFont = null;
		for (tempRawFont in StrokedTextField._fontCache)
		{
			if (tempRawFont.Sha256 == hash)
			{
				parsedFont = tempRawFont;
				break;
			}
		}
		if (parsedFont != null)
		{
			rawFont = parsedFont;
		}
		else
		{
			rawFont = new RawFont();
			rawFont.Sha256 = hash;
			font.position = 0;
			rawFont.read(font);
		}

		StrokedTextField._fontCache.push(rawFont);

		fill(0x000000, 1);
		lineStyle(1, 0xff0000, 1);
	}

	public function get_fontSize()
	{
		return _fontSize;
	}

	public function set_fontSize(fontSize)
	{
		return _fontSize = fontSize;
	}

	public function get_align()
	{
		return _align;
	}

	public function set_align(align)
	{
		return _align = align;
	}

	public function get_lineSpacing()
	{
		return _lineSpacing;
	}

	public function set_lineSpacing(lineSpacing)
	{
		return _lineSpacing = lineSpacing;
	}

	public function get_charSpacing()
	{
		return _charSpacing;
	}

	public function set_charSpacing(charSpacing)
	{
		return _charSpacing = charSpacing;
	}

	public function get_text()
	{
		return _text;
	}

	public function set_text(text)
	{
		if (_text != text)
		{
			_text = text;
			update();
		}

		return _text;
	}

	public function get_mode()
	{
		return _mode;
	}

	public function set_useKerning(useKerning)
	{
		return _useKerning = useKerning;
	}

	public function get_useKerning()
	{
		return _useKerning;
	}

	public function set_mode(mode)
	{
		return _mode = mode;
	}

	public function update():Void
	{
		this.graphics.clear();
		rawFont.graphics.drawText(this, _text, _fontSize, _lineSpacing, _charSpacing, _align, rawFont, _mode, _useKerning);

		var bounds:Rectangle = this.getBounds(stage);

		var shapeData:Vector<IGraphicsData>=this.graphics.readGraphicsData(false);
		var graphicsPath:GraphicsPath;
		var b:Int, index:Int;
		for (a in 0...shapeData.length)
		{
			if (Std.is(shapeData[a], GraphicsPath))
			{
				graphicsPath = cast(shapeData[a], GraphicsPath);
				b = 0;
				index = 0;
				for (b in 0...graphicsPath.commands.length)
				{
					switch (graphicsPath.commands[b])
					{
						case 1:
							//moveTo
							graphicsPath.data[index++] -= bounds.x;
							graphicsPath.data[index++] -= bounds.y;

						case 2:
							//lineTo
							graphicsPath.data[index++] -= bounds.x;
							graphicsPath.data[index++] -= bounds.y;
						case 3:
							//curveTo
							graphicsPath.data[index++] -= bounds.x;
							graphicsPath.data[index++] -= bounds.y;
							graphicsPath.data[index++] -= bounds.x;
							graphicsPath.data[index++] -= bounds.y;
					}
				}
			}
		}
		this.graphics.clear();
		this.graphics.drawGraphicsData(shapeData);
	}

	public function fill(color:Int, alpha:Float = 1.0):Void
	{
		rawFont.graphics.beginFill(color, alpha);
	}

	public function gradientFill(type:String, colors:Array<UInt>, alphas:Array<Float>, ratios:Array<Int>, matrix:Matrix = null, spreadMethod:String = "pad", interpolationMethod:String = "rgb", focalPointRatio:Float = 0):Void
	{
		rawFont.graphics.beginGradientFill(type, colors, alphas, ratios, matrix, spreadMethod, interpolationMethod, focalPointRatio);
	}

	//public function lineStyle(thickness:Float = null, color:Int = 0, alpha:Float = 1.0, pixelHinting:Bool = false, scaleMode:String = "normal", caps:String = "round", joints:String = "round", miterLimit:Float = 3):Void
	public function lineStyle(thickness:Float = null, color:Int = 0, alpha:Float = 1.0):Void
	{
		//rawFont.graphics.lineStyle(thickness, color, alpha, pixelHinting, scaleMode, caps, joints, miterLimit);
		rawFont.graphics.lineStyle(thickness, color, alpha, false, "normal", "round", "round", 3);
	}

	public function bitmapFill(bitmap:BitmapData, matrix:Matrix = null, repeat:Bool = true, smooth:Bool = false):Void
	{
		rawFont.graphics.beginBitmapFill(bitmap, matrix, repeat, smooth);
	}
}