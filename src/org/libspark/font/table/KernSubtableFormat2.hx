package org.libspark.font.table;

import openfl.utils.ByteArray;

class KernSubtableFormat2 extends KernSubtable
{

	private var rowWidth:Int;
	private var leftClassTable:Int;
	private var rightClassTable:Int;
	private var array:Int;

	public function new(byte_ar:ByteArray)
	{
		super();
		rowWidth = byte_ar.readUnsignedShort();
		leftClassTable = byte_ar.readUnsignedShort();
		rightClassTable = byte_ar.readUnsignedShort();
		array = byte_ar.readUnsignedShort();
	}

	override public function getKerningPairCount():Int
	{
		return 0;
	}

	override public function getKerningPair(i:Int):KerningPair
	{
		return null;
	}

}