package org.libspark.font.table;

import openfl.utils.ByteArray;

class Os2Table
{

	private var version:Int;
	private var xAvgCharWidth:Float;
	private var usWeightClass:Int;
	private var usWidthClass:Int;
	private var fsType:Float;
	private var ySubscriptXSize:Float;
	private var ySubscriptYSize:Float;
	private var ySubscriptXOffset:Float;
	private var ySubscriptYOffset:Float;
	private var ySuperscriptXSize:Float;
	private var ySuperscriptYSize:Float;
	private var ySuperscriptXOffset:Float;
	private var ySuperscriptYOffset:Float;
	private var yStrikeoutSize:Float;
	private var yStrikeoutPosition:Float;
	private var sFamilyClass:Float;
	private var panose:Panose;
	private var ulUnicodeRange1:Int;
	private var ulUnicodeRange2:Int;
	private var ulUnicodeRange3:Int;
	private var ulUnicodeRange4:Int;
	private var achVendorID:Int;
	private var fsSelection:Float;
	private var usFirstCharIndex:Int;
	private var usLastCharIndex:Int;
	private var sTypoAscender:Float;
	private var sTypoDescender:Float;
	private var sTypoLineGap:Float;
	private var usWinAscent:Int;
	private var usWinDescent:Int;
	private var ulCodePageRange1:Int;
	private var ulCodePageRange2:Int;


	public function new(de:DirectoryEntry, byte_ar:ByteArray)
	{

		byte_ar.position = de.getOffset();

		version = byte_ar.readUnsignedShort();
		xAvgCharWidth = byte_ar.readShort();
		usWeightClass = byte_ar.readUnsignedShort();
		usWidthClass = byte_ar.readUnsignedShort();
		fsType = byte_ar.readShort();
		ySubscriptXSize = byte_ar.readShort();
		ySubscriptYSize = byte_ar.readShort();
		ySubscriptXOffset = byte_ar.readShort();
		ySubscriptYOffset = byte_ar.readShort();
		ySuperscriptXSize = byte_ar.readShort();
		ySuperscriptYSize = byte_ar.readShort();
		ySuperscriptXOffset = byte_ar.readShort();
		ySuperscriptYOffset = byte_ar.readShort();
		yStrikeoutSize = byte_ar.readShort();
		yStrikeoutPosition = byte_ar.readShort();
		sFamilyClass = byte_ar.readShort();

		var buf:Array<Dynamic> = [];

		for (i in 0...10)
		{
			buf.push(byte_ar.readByte());
		}
		panose = new Panose(buf);

		ulUnicodeRange1 = byte_ar.readInt();
		ulUnicodeRange2 = byte_ar.readInt();
		ulUnicodeRange3 = byte_ar.readInt();
		ulUnicodeRange4 = byte_ar.readInt();
		achVendorID = byte_ar.readInt();
		fsSelection = byte_ar.readShort();
		usFirstCharIndex = byte_ar.readUnsignedShort();
		usLastCharIndex = byte_ar.readUnsignedShort();
		sTypoAscender = byte_ar.readShort();
		sTypoDescender = byte_ar.readShort();
		sTypoLineGap = byte_ar.readShort();
		usWinAscent = byte_ar.readUnsignedShort();
		usWinDescent = byte_ar.readUnsignedShort();
		ulCodePageRange1 = byte_ar.readInt();
		ulCodePageRange2 = byte_ar.readInt();
	}

	public function getVersion():Int
	{
		return version;
	}

	public function getAvgCharWidth():Float
	{
		return xAvgCharWidth;
	}

	public function getWeightClass():Int
	{
		return usWeightClass;
	}

	public function getWidthClass():Int
	{
		return usWidthClass;
	}

	public function getLicenseType():Float
	{
		return fsType;
	}

	public function getSubscriptXSize():Float
	{
		return ySubscriptXSize;
	}

	public function getSubscriptYSize():Float
	{
		return ySubscriptYSize;
	}

	public function getSubscriptXOffset():Float
	{
		return ySubscriptXOffset;
	}

	public function getSubscriptYOffset():Float
	{
		return ySubscriptYOffset;
	}

	public function getSuperscriptXSize():Float
	{
		return ySuperscriptXSize;
	}

	public function getSuperscriptYSize():Float
	{
		return ySuperscriptYSize;
	}

	public function getSuperscriptXOffset():Float
	{
		return ySuperscriptXOffset;
	}

	public function getSuperscriptYOffset():Float
	{
		return ySuperscriptYOffset;
	}

	public function getStrikeoutSize():Float
	{
		return yStrikeoutSize;
	}

	public function getStrikeoutPosition():Float
	{
		return yStrikeoutPosition;
	}

	public function getFamilyClass():Float
	{
		return sFamilyClass;
	}

	public function getPanose():Panose
	{
		return panose;
	}

	public function getUnicodeRange1():Int
	{
		return ulUnicodeRange1;
	}

	public function getUnicodeRange2():Int
	{
		return ulUnicodeRange2;
	}

	public function getUnicodeRange3():Int
	{
		return ulUnicodeRange3;
	}

	public function getUnicodeRange4():Int
	{
		return ulUnicodeRange4;
	}

	public function getVendorID():Int
	{
		return achVendorID;
	}

	public function getSelection():Float
	{
		return fsSelection;
	}

	public function getFirstCharIndex():Int
	{
		return usFirstCharIndex;
	}

	public function getLastCharIndex():Int
	{
		return usLastCharIndex;
	}

	public function getTypoAscender():Float
	{
		return sTypoAscender;
	}

	public function getTypoDescender():Float
	{
		return sTypoDescender;
	}

	public function getTypoLineGap():Float
	{
		return sTypoLineGap;
	}

	public function getWinAscent():Int
	{
		return usWinAscent;
	}

	public function getWinDescent():Int
	{
		return usWinDescent;
	}

	public function getCodePageRange1():Int
	{
		return ulCodePageRange1;
	}

	public function getCodePageRange2():Int
	{
		return ulCodePageRange2;
	}

	public function getType():Dynamic
	{
		return Table.OS_2;
	}
}