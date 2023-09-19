package org.libspark.font.table;

import openfl.utils.ByteArray;

class KernSubtable
{

	/** Creates new KernSubtable */
	public function new()
	{}

	public function getKerningPairCount():Int
	{
		return 0;
	}

	public function getKerningPair(i:Int):KerningPair
	{
		return null;
	}

	public static function read(byte_ar:ByteArray):KernSubtable
	{
		var table:KernSubtable = null;
		/* int version =*/
		byte_ar.readUnsignedShort();
		/* int length  =*/
		byte_ar.readUnsignedShort();
		var coverage:Int = byte_ar.readUnsignedShort();
		var format:Int = coverage>>8;

		switch (format)
		{
			case 0:
				table = new KernSubtableFormat0(byte_ar);

			case 2:
				table = new KernSubtableFormat2(byte_ar);

			default:

		}
		return table;
	}

public function getKerning(charAIndex:Int,charBIndex:Int):Int
	{
		return 0;
	}

}