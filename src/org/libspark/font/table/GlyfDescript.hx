package org.libspark.font.table;

import openfl.utils.ByteArray;

class GlyfDescript extends Program implements IGlyphDescription
{
	public static var onCurve:Int = 0x01;
	private var xShortVector:Int = 0x02;
	private var yShortVector:Int = 0x04;
	private var repeat:Int = 0x08;
	private var xDual:Int = 0x10;
	private var yDual:Int = 0x20;

	private var parentTable:GlyfTable;
	private var numberOfContours:Int;
	private var xMin:Int;
	private var yMin:Int;
	private var xMax:Int;
	private var yMax:Int;

	public function new(_parentTable:GlyfTable, _numberOfContours:Int, bais:ByteArray)
	{
		parentTable = _parentTable;
		numberOfContours = _numberOfContours;

		xMin = bais.readShort();
		yMin = bais.readShort();
		xMax = bais.readShort();
		yMax = bais.readShort();
	}

	public function resolve():Void
	{}

	public function getNumberOfContours():Int
	{
		return numberOfContours;
	}

	public function getXMaximum():Int
	{
		return xMax;
	}

	public function getXMinimum():Int
	{
		return xMin;
	}

	public function getYMaximum():Int
	{
		return yMax;
	}

	public function getYMinimum():Int
	{
		return yMin;
	}


	public function getFlags(i:Int):Int
	{
		return 0;
	}
	public function getContourCount():Int
	{
		return 0;
	}
	public function getPointCount():Int
	{
		return 0;
	}
	public function getEndPtOfContours(i:Int):Int
	{
		return 0;
	}
	public function getXCoordinate(i:Int):Float
	{
		return 0;
	}
	public function getYCoordinate(i:Int):Float
	{
		return 0;
	}
	public function isComposite():Bool
	{
		return false;
	}
}