package org.libspark.font.render;

import openfl.display.BitmapData;
import openfl.display.Sprite;
import openfl.display.Shape;
import openfl.errors.*;

import openfl.geom.Matrix;

import org.libspark.font.data.GlyphData;
import org.libspark.font.data.RawFont;
import org.libspark.font.data.Point;
import org.libspark.font.table.*;

class GlyphRenderer
{
	private var rawFont:RawFont;

	// beingLineStyle method variables
	private var _lineStyleThickness:Float = Math.NaN;
	private var _lineStyleColor:Int = 0;
	private var _lineStyleAlpha:Float = 1.0;
	private var _lineStylePixelHinting:Bool = false;
	private var _lineStyleScaleMode:String = "normal";
	private var _lineStyleCaps:String = null;
	private var _lineStyleJoints:String = null;
	private var _lineStyleMiterLimit:Float = 3;

	// beginFill method variables
	private var _fillColor:Int = 0x000000;
	private var _fillAlpha:Float = 1;

	// beginBitmapFill method variables
	private var _bitmapFillBitmap:BitmapData;
	private var _bitmapFillMatrix:Matrix = null;
	private var _bitmapFillRepeat:Bool = true;
	private var _bitmapFillSmooth:Bool = false;

	// beginGradientFill method variables
	private var _gradientFillType:String;
	private var _gradientFillColors:Array<UInt>;
	private var _gradientFillAlphas:Array<Float>;
	private var _gradientFillRatios:Array<Int>;
	private var _gradientFillMatrix:Matrix;
	private var _gradientFillSpreadMethod:String = "pad";
	private var _gradientFillInterpolationMethod:String = "rgb";
	private var _gradientFillFocalPointRatio:Float = 0;

	// lineGradientFill method variables
	private var _lineGradientType:String;
	private var _lineGradientColors:Array<Dynamic>;
	private var _lineGradientAlphas:Array<Dynamic>;
	private var _lineGradientRatios:Array<Dynamic>;
	private var _lineGradientMatrix:Matrix = null;
	private var _lineGradientSpreadMethod:String = "pad";
	private var _lineGradientInterpolationMethod:String = "rgb";
	private var _lineGradientFocalPointRatio:Float = 0;

	// flags so that we know when calling draw if to call the shape draw methods associated 		
	private var _hasLineGradientFill:Bool = false;
	private var _hasBitmapFill:Bool = false;
	private var _hasFill:Bool = false;
	private var _hasGradientFill:Bool = false;

	public function new(rawFont:RawFont)
	{
		this.rawFont = rawFont;
	}

	public function drawText(glyphClip:Shape, char:String, size:Int, lineSpacing:Float, charSpacing:Float, align:String, font:RawFont, mode:String, useKerning:Bool):Void
	{
		var unitsPerEm:Float = font.head.getUnitsPerEm();
		var ascent:Float = font.os2.getWinAscent();
		var descent:Float = font.os2.getWinDescent();
		var lineGap:Float = font.os2.getTypoLineGap();
		var spaceWidth:Float = font.getSpaceAdvanceWidth();


		var penX:Float = 0;
		var penY:Float = 0;
		var glyphX:Float = 0;
		var g:GlyphData;
		glyphClip.graphics.clear();
		var lines:Array<String>=char.split("\n");
		var line:String = "";
		var lineWidths:Array<Float>=[];
		var lineWidth:Float = 0;
		var maxWidth:Float = 0;
		var horizontalStartPositions:Array<Float>=[];
		var scale:Float = size * 72 / (72 * unitsPerEm);
		for (a in 0...lines.length)
		{
			line = lines[a];
			lineWidth = 0;
			for (b in 0...line.length)
			{
				if (line.charCodeAt(b) != 32)
				{
					g = rawFont.getGlyph(line.charCodeAt(b));

					lineWidth += g.getAdvanceWidth() * scale;
					if (b<line.length - 1 && useKerning)
					{
						lineWidth += rawFont.getKerning(rawFont.getGlyphIndex(line.charCodeAt(b)), rawFont.getGlyphIndex(line.charCodeAt(b + 1))) * scale;
					}
				}
				else
				{
					lineWidth += spaceWidth * scale;
				}
			}
			maxWidth = lineWidth>maxWidth ? lineWidth:maxWidth;
			lineWidths.push(lineWidth);
		}

		switch (align)
		{
			case "center":
				for (a in 0...lineWidths.length)
				{
					horizontalStartPositions.push((maxWidth - lineWidths[a]) / 2);
				}

				case "right":
					for (a in 0...lineWidths.length)
					{
						horizontalStartPositions.push(maxWidth - lineWidths[a]);
					}

					default:
					for(a in 0...lineWidths.length)
					{
						horizontalStartPositions.push(0);
					}
		}
		var iterations:Int = mode == "outline" ? 2:1;
		for (iter in 0...iterations)
		{
			var lineCounter:Int = 0;
			penX = horizontalStartPositions[lineCounter];
			penY = 0;

			for (a in 0...char.length)
			{
				if (char.charCodeAt(a) == 10)
				{
					lineCounter++;
					penY += (ascent - descent + lineGap) * scale + lineSpacing;
					penX = horizontalStartPositions[lineCounter];
					continue;
				}


				if (char.charCodeAt(a) == 32)
				{
					penX += spaceWidth * scale;
					continue;
				}
				g = rawFont.getGlyph(char.charCodeAt(a));

				//	glyphX=penX+ (g.xMin + (a != 0 ? g.getLeftSideBearing() : 0)) * scale; //TODO

				glyphX = penX;
				var advanceWidth:Int = g.getAdvanceWidth();
				var count:Int = g.getPointCount();
				var index:Int = 0;
				var thePoint:Point;
				do {
					thePoint = cast(g.getPoint(index), Point);
					thePoint.x = thePoint.x * scale;
					thePoint.y = thePoint.y * scale;
					index++;
				}
				while (index<count);

				if (mode == "outline")
				{
					if (iter == 0)
					{
						glyphClip.graphics.lineStyle(_lineStyleThickness, _lineStyleColor, _lineStyleAlpha, _lineStylePixelHinting, _lineStyleScaleMode, _lineStyleCaps, _lineStyleJoints, _lineStyleMiterLimit);
					}
					else
					{
						glyphClip.graphics.lineStyle(Math.NaN);
						if (_hasFill)
						{
							glyphClip.graphics.beginFill(_fillColor, _fillAlpha);
						}
						if (_hasBitmapFill)
						{
							glyphClip.graphics.beginBitmapFill(_bitmapFillBitmap, _bitmapFillMatrix, _bitmapFillRepeat, _bitmapFillSmooth);
						}
						if (_hasGradientFill)
						{
							glyphClip.graphics.beginGradientFill(_gradientFillType, _gradientFillColors, _gradientFillAlphas, _gradientFillRatios, _gradientFillMatrix, _gradientFillSpreadMethod, _gradientFillInterpolationMethod, _gradientFillFocalPointRatio);
						}
					}
				}
				else
				{
					glyphClip.graphics.lineStyle(_lineStyleThickness, _lineStyleColor, _lineStyleAlpha, _lineStylePixelHinting, _lineStyleScaleMode, _lineStyleCaps, _lineStyleJoints, _lineStyleMiterLimit);
					if (_hasFill)
					{
						glyphClip.graphics.beginFill(_fillColor, _fillAlpha);
					}
					if (_hasBitmapFill)
					{
						glyphClip.graphics.beginBitmapFill(_bitmapFillBitmap, _bitmapFillMatrix, _bitmapFillRepeat, _bitmapFillSmooth);
					}
					if (_hasGradientFill)
					{
						glyphClip.graphics.beginGradientFill(_gradientFillType, _gradientFillColors, _gradientFillAlphas, _gradientFillRatios, _gradientFillMatrix, _gradientFillSpreadMethod, _gradientFillInterpolationMethod, _gradientFillFocalPointRatio);
					}
				}
				var count:Int = g.getPointCount();

				var index:Int = 0;
				var startX:Float = 0;
				var startY:Float = 0;
				var thePoint:Point;
				var lastCommand:String = "";
				var previousPointOnCurve:Bool = false;
				var tempPoint:Point;
				var tempPoint2:Point;
				var averagePoint:Point;
				var endOfContour:Bool = false;
				var lineClosed:Bool = false;
				do {
					thePoint = cast(g.getPoint(index), Point);
					lineClosed = false;
					if (index == 0 || endOfContour)
					{
						startX = thePoint.x;
						startY = thePoint.y;
						glyphClip.graphics.moveTo(thePoint.x + glyphX, thePoint.y + penY);

						index++;
						lastCommand = "MT";
						previousPointOnCurve = true;
						endOfContour = false;
						continue;
					}
					if (thePoint.onCurve)
					{
						if (previousPointOnCurve && lastCommand != "CT")
						{

							glyphClip.graphics.lineTo(thePoint.x + glyphX, thePoint.y + penY);
							lastCommand = "LT";
						}
						else if (previousPointOnCurve == false)
						{
							if (index + 2<count)
							{
								tempPoint = cast(g.getPoint(index + 1), Point);
								tempPoint2 = cast(g.getPoint(index + 2), Point);
								if (tempPoint.onCurve == false && tempPoint2.onCurve == false)
								{
									averagePoint = new Point((tempPoint.x + tempPoint2.x) / 2, (tempPoint.y + tempPoint2.y) / 2, false, false);
									lastCommand = "CT";
									glyphClip.graphics.curveTo(tempPoint.x + glyphX, tempPoint.y + penY, averagePoint.x + glyphX, averagePoint.y + penY);

									index++;
								}
							}

						}
						else
						{
							lastCommand = "LT";
							if (thePoint.endOfContour)
							{
								lineClosed = true;
								glyphClip.graphics.lineTo(thePoint.x + glyphX, thePoint.y + penY);
								glyphClip.graphics.lineTo(startX + glyphX, startY + penY);
							}
							else
							{
								glyphClip.graphics.lineTo(thePoint.x + glyphX, thePoint.y + penY);
							}
						}
						previousPointOnCurve = true;
					}
					else
					{
						if (previousPointOnCurve)
						{
							if (index + 1<count)
							{
								previousPointOnCurve = false;
								tempPoint = cast(g.getPoint(index + 1), Point);
								if (tempPoint.onCurve)
								{
									if (thePoint.endOfContour)
									{
										lineClosed = true;
										glyphClip.graphics.curveTo(thePoint.x + glyphX, thePoint.y + penY, startX + glyphX, startY + penY);
									}
									else
									{
										glyphClip.graphics.curveTo(thePoint.x + glyphX, thePoint.y + penY, tempPoint.x + glyphX, tempPoint.y + penY);
									}
									previousPointOnCurve = true;
									lastCommand = "CT";
								}
								else
								{
									averagePoint = new Point((tempPoint.x + thePoint.x) / 2, (tempPoint.y + thePoint.y) / 2, false, false);
									lastCommand = "CT";
									glyphClip.graphics.curveTo(thePoint.x + glyphX, thePoint.y + penY, averagePoint.x + glyphX, averagePoint.y + penY);
								}
							}
							else
							{
								if (thePoint.endOfContour)
								{
									lineClosed = true;
									//possible fix for arial black "m"
									glyphClip.graphics.curveTo(thePoint.x + glyphX, thePoint.y + penY, startX + glyphX, startY + penY);
								}
							}
						}
						else
						{
							if (index + 1<count)
							{
								previousPointOnCurve = false;
								tempPoint = cast(g.getPoint(index + 1), Point);
								if (tempPoint.onCurve)
								{
									if (thePoint.endOfContour)
									{
										lineClosed = true;
										glyphClip.graphics.curveTo(thePoint.x + glyphX, thePoint.y + penY, startX + glyphX, startY + penY);
									}
									else
									{

										glyphClip.graphics.curveTo(thePoint.x + glyphX, thePoint.y + penY, tempPoint.x + glyphX, tempPoint.y + penY);
									}
									lastCommand = "CT";
								}
								else
								{
									averagePoint = new Point((tempPoint.x + thePoint.x) / 2, (tempPoint.y + thePoint.y) / 2, false, false);
									lastCommand = "CT";
									glyphClip.graphics.curveTo(thePoint.x + glyphX, thePoint.y + penY, averagePoint.x + glyphX, averagePoint.y + penY);
								}
							}
							else
							{

								glyphClip.graphics.curveTo(thePoint.x + glyphX, thePoint.y + penY, startX + glyphX, startY + penY);
							}
						}

					}
					if (thePoint.endOfContour)
					{
						endOfContour = true;
						if (lastCommand == "LT" || lineClosed == false)
						{
							glyphClip.graphics.lineTo(startX + glyphX, startY + penY);
						}
					}
					index++;
				}
				while (index<count);
				if (mode != "outline" || (iter == 0 && _hasFill || _hasBitmapFill || _hasGradientFill))
				{
					glyphClip.graphics.endFill();
				}

				penX += advanceWidth * scale + charSpacing;
				//	penX += ((a != 0 ? g.getLeftSideBearing() : 0) + advanceWidth + g.getRightSideBearing()) * scale; //TODO
				if (a<char.length - 1 && useKerning)
				{
					penX += rawFont.getKerning(rawFont.getGlyphIndex(char.charCodeAt(a)), rawFont.getGlyphIndex(char.charCodeAt(a + 1))) * scale;

				}
			}

		}
	}

	public function beginFill(color:Int, alpha:Float = 1.0):Void
	{
		_fillColor = color;
		_fillAlpha = alpha;
		_hasFill = true;
		_hasGradientFill = false;
		_hasBitmapFill = false;
	}

	public function beginGradientFill(type:String, colors:Array<UInt>, alphas:Array<Float>, ratios:Array<Int>, matrix:Matrix = null, spreadMethod:String = "pad", interpolationMethod:String = "rgb", focalPointRatio:Float = 0):Void
	{
		_gradientFillType = type;
		_gradientFillColors = colors;
		_gradientFillAlphas = alphas;
		_gradientFillRatios = ratios;
		_gradientFillMatrix = matrix;
		_gradientFillSpreadMethod = spreadMethod;
		_gradientFillInterpolationMethod = interpolationMethod;
		_gradientFillFocalPointRatio = focalPointRatio;

		_hasGradientFill = true;
		_hasFill = false;
		_hasBitmapFill = false;
	}

	public function beginBitmapFill(bitmap:BitmapData, matrix:Matrix = null, repeat:Bool = true, smooth:Bool = false):Void
	{
		_bitmapFillBitmap = bitmap;
		_bitmapFillMatrix = matrix;
		_bitmapFillRepeat = repeat;
		_bitmapFillSmooth = smooth;

		_hasBitmapFill = true;
		_hasGradientFill = false;
		_hasFill = false;

	}

	public function lineGradientStyle(type:String, colors:Array<UInt>, alphas:Array<Float>, ratios:Array<Float>, matrix:Matrix = null, spreadMethod:String = "pad", interpolationMethod:String = "rgb", focalPointRatio:Float = 0):Void
	{
		_lineGradientType = type;
		_lineGradientColors = colors;
		_lineGradientAlphas = alphas;
		_lineGradientRatios = ratios;
		_lineGradientMatrix = matrix;
		_lineGradientSpreadMethod = spreadMethod;
		_lineGradientInterpolationMethod = interpolationMethod;
		_lineGradientFocalPointRatio = focalPointRatio;

		_hasLineGradientFill = true;
	}

	public function lineStyle(thickness:Float = null, color:Int = 0, alpha:Float = 1.0, pixelHinting:Bool = false, scaleMode:String = "normal", caps:String = null, joints:String = null, miterLimit:Float = 3):Void
	{
		if (thickness == null)
		{
			thickness = Math.NaN;
		}
		_lineStyleThickness = thickness;
		_lineStyleColor = color;
		_lineStyleAlpha = alpha;
		_lineStylePixelHinting = pixelHinting;
		_lineStyleScaleMode = scaleMode;
		_lineStyleCaps = caps;
		_lineStyleJoints = joints;
		_lineStyleMiterLimit = miterLimit;
	}

	public function clear():Void
	{
		// reset beingLineStyle vars
		_lineStyleThickness = Math.NaN;
		_lineStyleColor = 0;
		_lineStyleAlpha = 1.0;
		_lineStylePixelHinting = false;
		_lineStyleScaleMode = "normal";
		_lineStyleCaps = null;
		_lineStyleJoints = null;
		_lineStyleMiterLimit = 3;

		// reset beginFill vars
		_fillColor = 0x000000;
		_fillAlpha = 1;

		// reset beginBitmapFill vars
		_bitmapFillBitmap = null;
		_bitmapFillMatrix = null;
		_bitmapFillRepeat = true;
		_bitmapFillSmooth = false;

		//  reset beginGradientFill vars
		_gradientFillType = null;
		_gradientFillColors = null;
		_gradientFillAlphas = null;
		_gradientFillRatios = null;
		_gradientFillMatrix = null;
		_gradientFillSpreadMethod = "pad";
		_gradientFillInterpolationMethod = "rgb";
		_gradientFillFocalPointRatio = 0;

		// reset lineGradientFill vars
		_lineGradientType = null;
		_lineGradientColors = null;
		_lineGradientAlphas = null;
		_lineGradientRatios = null;
		_lineGradientMatrix = null;
		_lineGradientSpreadMethod = "pad";
		_lineGradientInterpolationMethod = "rgb";
		_lineGradientFocalPointRatio = 0;

		// reset the bools
		_hasLineGradientFill = false;
		_hasGradientFill = false;
		_hasFill = false;
		_hasBitmapFill = false;
	}



}