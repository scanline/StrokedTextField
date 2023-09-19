package org.libspark.font.data;

import org.libspark.font.table.GlyfDescript;
import org.libspark.font.table.IGlyphDescription;


class GlyphData
{

	private var leftSideBearing:Int;
	private var rightSideBearing:Int;
	private var advanceWidth:Int;
	private var points:Array<Dynamic>;
public var xMin:Int;

	public function new(gd:IGlyphDescription, lsb:Int, advance:Int)
	{
		leftSideBearing = lsb;
		advanceWidth = advance;
		rightSideBearing = advanceWidth - leftSideBearing - (gd.getXMaximum() - gd.getXMinimum());
	xMin=gd.getXMinimum();
		describe(gd);
	}

	public function getAdvanceWidth():Int
	{
		return advanceWidth;
	}

	public function getLeftSideBearing():Int
	{
		return leftSideBearing;
	}

	public function getRightSideBearing():Int
	{
		return rightSideBearing;
	}

	public function getPoint(i:Int):Point
	{
		return points[i];
	}

	public function getPointCount():Int
	{
		return points.length;
	}

	public function scale(factor:Int):Void
	{
		for (i in 0...points.length)
		{
			//points[i].x = ( points[i].x * factor ) >> 6;
			//points[i].y = ( points[i].y * factor ) >> 6;
			points[i].x = ((points[i].x<<10) * factor)>>26;
			points[i].y = ((points[i].y<<10) * factor)>>26;
		}
		leftSideBearing = Math.floor(((leftSideBearing * factor)>>6));
		advanceWidth = (advanceWidth * factor)>>6;
	}

	private function describe(gd:IGlyphDescription):Void
	{
		var endPtIndex:Int = 0;
		points = [];

		for (i in 0...gd.getPointCount())
		{
			var endPt:Bool = gd.getEndPtOfContours(endPtIndex) == i;
			if (endPt)
			{
				endPtIndex++;
			}
			points.push(new Point(gd.getXCoordinate(i), -gd.getYCoordinate(i), (gd.getFlags(i) & GlyfDescript.onCurve) != 0, endPt));



		}


		//trace(points);

	}
}