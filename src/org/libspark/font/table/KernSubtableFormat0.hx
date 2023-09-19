package org.libspark.font.table;

import openfl.utils.ByteArray;

class KernSubtableFormat0 extends KernSubtable
{

	private var nPairs:Int;
	private var searchRange:Int;
	private var entrySelector:Int;
	private var rangeShift:Int;
	private var kerningPairs:Array<KerningPair>;

	public function new(byte_ar:ByteArray)
	{
		super();
		nPairs = byte_ar.readUnsignedShort();
		searchRange = byte_ar.readUnsignedShort();
		entrySelector = byte_ar.readUnsignedShort();
		rangeShift = byte_ar.readUnsignedShort();
		kerningPairs = [];
		for (i in 0...nPairs)
		{
			kerningPairs[i] = new KerningPair(byte_ar);
		}
	}

	override public function getKerning(charAIndex:Int, charBIndex:Int):Int
	{
		for (kerningPair in kerningPairs)
		{
			if (kerningPair.getLeft() == charAIndex && kerningPair.getRight() == charBIndex)
			{
				//trace(kerningPair.getLeft(),kerningPair.getRight(),kerningPair.getValue());
			return kerningPair.getValue();
			}
		}
		return 0;
	}

	override public function getKerningPairCount():Int
	{
		return nPairs;
	}

	override public function getKerningPair(i:Int):KerningPair
	{
		return kerningPairs[i];
	}
}