package org.libspark.font.table;

import openfl.utils.ByteArray;

class CmapFormat4 extends CmapFormat
{

	public var language:Int;
	private var segCountX2:Int;
	private var searchRange:Int;
	private var entrySelector:Int;
	private var rangeShift:Int;
	private var endCode:Array<Dynamic>;
	private var startCode:Array<Dynamic>;
	private var idDelta:Array<Dynamic>;
	private var idRangeOffset:Array<Dynamic>;
	private var glyphIdArray:Array<Dynamic>;
	private var segCount:Int;
	private var first:Int;
	private var last:Int;

	public function new(byte_ar:ByteArray)
	{

		super(byte_ar);
		format = 4;
		segCountX2 = byte_ar.readUnsignedShort();
		segCount = Std.int(segCountX2 / 2);
		endCode = new Array();
		startCode = new Array();
		idDelta = new Array();
		idRangeOffset = new Array();
		searchRange = byte_ar.readUnsignedShort();
		entrySelector = byte_ar.readUnsignedShort();
		rangeShift = byte_ar.readUnsignedShort();
		last = -1;

		for (i in 0...segCount)
		{
			endCode.push(byte_ar.readUnsignedShort());
			if (endCode[i]>last) last = endCode[i];
		}

		byte_ar.readUnsignedShort(); // reservePad

		for (j in 0...segCount)
		{
			startCode.push(byte_ar.readUnsignedShort());
			if ((j == 0) || (startCode[j]<first)) first = startCode[j];
		}

		for (k in 0...segCount)
		{
			idDelta.push(byte_ar.readUnsignedShort());
		}

		for (l in 0...segCount)
		{
			idRangeOffset.push(byte_ar.readUnsignedShort());
		}

		var count:Int = Std.int((length - 16 - (segCount * 8)) / 2);
		glyphIdArray = [];

		for (m in 0...count)
		{
			glyphIdArray.push(byte_ar.readUnsignedShort());
		}
	}

	override public function getFirst():Dynamic
	{
		return first;
	}
	override public function getLast():Dynamic
	{
		return last;
	}

	override public function mapCharCode(charCode:Int):Dynamic
	{
		/*
		  Quoting :
		  http://developer.apple.com/fonts/TTRefMan/RM06/Chap6cmap.html#Surrogates

		  The original architecture of the Unicode Standard
		  allowed for all encoded characters to be represented
		  using sixteen bit code poInts. This allowed for up to
		  65,354 characters to be encoded. (Unicode code poInts
		  U+FFFE and U+FFFF are reserved and unavailable to
		  represent characters. For more details, see The Unicode
		  Standard.)

		  My comment : Isn't there a typo here ? Shouldn't we
		  rather read 65,534 ?
		  */
		if ((charCode<0) || (charCode>=0xFFFE)) return 0;

		for (i in 0...segCount)
		{
			if (endCode[i]>=charCode)
			{
				if (startCode[i]<=charCode)
				{
					if (idRangeOffset[i]>0)
					{
						return glyphIdArray[Std.int(idRangeOffset[i] / 2 + (charCode - startCode[i]) - (segCount - i))];
					}
					else
					{
						return (idDelta[i] + charCode) % 65536;
					}
				}
				else
				{
					break;
				}
			}
		}

		return 0;
	}

	override public function toString():String
	{

		var str:String = "";
		str += super.toString();
		str += ", segCOuntX2: " + segCountX2 + ", searchRange: " + searchRange + ", entrySelector: " + entrySelector;
		str += ", rangeShift: " + rangeShift + ", endCode: " + endCode + ", startCode: " + startCode + ", idDelta: " + idDelta;
		str += ", idRangeOffset: " + idRangeOffset;
		return str;
	}

	private static function IntToStr(array:Array<Dynamic>):String
	{
		var nSlots:Int = array.length;
		var workBuff:String = "";
		workBuff += "[";
		for (i in 0...nSlots)
		{
			workBuff += array[i];

			if (i<nSlots - 1)
			{
				workBuff += ",";
			}
		}
		workBuff += "]";

		return workBuff;
	}
}