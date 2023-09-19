package org.libspark.font.table;

import openfl.utils.ByteArray;

class HheaTable
{

	private var version:Int;
	private var ascender:Int;
	private var descender:Int;
	private var lineGap:Float;
	private var advanceWidthMax:Float;
	private var minLeftSideBearing:Float;
	private var minRightSideBearing:Float;
	private var xMaxExtent:Float;
	private var caretSlopeRise:Float;
	private var caretSlopeRun:Float;
	private var metricDataFormat:Float;
	private var numberOfHMetrics:Int;

	public function new(de:DirectoryEntry, byte_ar:ByteArray)
	{
		byte_ar.position = de.getOffset();
		version = byte_ar.readInt();
		ascender = byte_ar.readShort();
		descender = byte_ar.readShort();
		lineGap = byte_ar.readShort();
		advanceWidthMax = byte_ar.readShort();
		minLeftSideBearing = byte_ar.readShort();
		minRightSideBearing = byte_ar.readShort();
		xMaxExtent = byte_ar.readShort();
		caretSlopeRise = byte_ar.readShort();
		caretSlopeRun = byte_ar.readShort();
		for (i in 0...5)
		{
			byte_ar.readShort();
		}
		metricDataFormat = byte_ar.readShort();
		numberOfHMetrics = byte_ar.readUnsignedShort();
	}

	public function getAdvanceWidthMax():Float
	{
		return advanceWidthMax;
	}

	public function getAscender():Int
	{
		return ascender;
	}

	public function getCaretSlopeRise():Float
	{
		return caretSlopeRise;
	}

	public function getCaretSlopeRun():Float
	{
		return caretSlopeRun;
	}

	public function getDescender():Int
	{
		return descender;
	}

	public function getLineGap():Float
	{
		return lineGap;
	}

	public function getMetricDataFormat():Float
	{
		return metricDataFormat;
	}

	public function getMinLeftSideBearing():Float
	{
		return minLeftSideBearing;
	}

	public function getMinRightSideBearing():Float
	{
		return minRightSideBearing;
	}

	public function getNumberOfHMetrics():Int
	{
		return numberOfHMetrics;
	}

	public function getType():Int
	{
		return Table.hhea;
	}

	public function getXMaxExtent():Float
	{
		return xMaxExtent;
	}
}