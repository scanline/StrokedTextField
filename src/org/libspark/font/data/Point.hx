package org.libspark.font.data;

class Point
{
	public var x:Float = 0;
	public var y:Float = 0;
	public var onCurve:Bool = true;
	public var endOfContour:Bool = false;
	public var touched:Bool = false;

	public function new(x:Float, y:Float, onCurve:Bool, endOfContour:Bool)
	{
		this.x = x;
		this.y = y;
		this.onCurve = onCurve;
		this.endOfContour = endOfContour;
	}
}