package org.libspark.font.table;

import openfl.utils.ByteArray;

class CmapFormat0 extends CmapFormat
{

	private var glyphIdArray:Array<Dynamic>=[];
	private var first:Int;
	private var last:Int;

	public function new(byte_ar:ByteArray)
	{

		super(byte_ar);
		format = 0;
		first = -1;

		for (i in 0...256)
		{
			glyphIdArray[i] = byte_ar.readUnsignedByte();

			if (glyphIdArray[i]>0)
			{
				if (first == -1) first = i;
				last = i;
			}
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
		if (0<=charCode && charCode<256)
		{
			return glyphIdArray[charCode];
		}
		else
		{
			return 0;
		}
	}
}