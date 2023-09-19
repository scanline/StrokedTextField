package org.libspark.font.table;

import openfl.utils.ByteArray;

class HeadTable
{

	private var versionNumber:Int;
	private var fontRevision:Int;
	private var checkSumAdjustment:Int;
	private var magicNumber:Int;
	private var flags:Int;
	private var unitsPerEm:Float;
	private var created:Float;
	private var modified:Float;
	private var xMin:Float;
	private var yMin:Float;
	private var xMax:Float;
	private var yMax:Float;
	private var macStyle:Float;
	private var lowestRecPPEM:Float;
	private var fontDirectionHint:Float;
	private var indexToLocFormat:Float;
	private var glyphDataFormat:Float;

	public function new(de:DirectoryEntry, byte_ar:ByteArray)
	{

		byte_ar.position = de.getOffset();
		versionNumber = byte_ar.readInt();
		fontRevision = byte_ar.readInt();
		checkSumAdjustment = byte_ar.readInt();
		magicNumber = byte_ar.readInt();
		flags = byte_ar.readShort();
		unitsPerEm = byte_ar.readShort();


		//created = byte_ar.readLong();
		//modified = byte_ar.readLong(); // CURRENTLY USING METHOD BELOW BUT THIS IS NOT CONVERTING TO LONG

		created = readLong(byte_ar);
		modified = readLong(byte_ar);


		xMin = byte_ar.readShort();
		yMin = byte_ar.readShort();
		xMax = byte_ar.readShort();
		yMax = byte_ar.readShort();
		macStyle = byte_ar.readShort();
		lowestRecPPEM = byte_ar.readShort();
		fontDirectionHint = byte_ar.readShort();
		indexToLocFormat = byte_ar.readShort();
		glyphDataFormat = byte_ar.readShort();

	}

	private function readLong(b:ByteArray):Int
	{
		var str:String = "";

		for (k in 0...8)
		{
			str += Std.string(b.readByte());
		}

		return Std.parseInt(str);
	}

	public function getCheckSumAdjustment():Int
	{
		return checkSumAdjustment;
	}

	public function getCreated():Float
	{
		return created;
	}

	public function getFlags():Int
	{
		return flags;
	}

	public function getFontDirectionHint():Float
	{
		return fontDirectionHint;
	}

	public function getFontRevision():Int
	{
		return fontRevision;
	}

	public function getGlyphDataFormat():Float
	{
		return glyphDataFormat;
	}

	public function getIndexToLocFormat():Float
	{
		return indexToLocFormat;
	}

	public function getLowestRecPPEM():Float
	{
		return lowestRecPPEM;
	}

	public function getMacStyle():Float
	{
		return macStyle;
	}

	public function getModified():Float
	{
		return modified;
	}

	public function getType():Int
	{
		return Table.head;
	}

	public function getUnitsPerEm():Float
	{
		return unitsPerEm;
	}

	public function getVersionNumber():Int
	{
		return versionNumber;
	}

	public function getXMax():Float
	{
		return xMax;
	}

	public function getXMin():Float
	{
		return xMin;
	}

	public function getYMax():Float
	{
		return yMax;
	}

	public function getYMin():Float
	{
		return yMin;
	}
}