package org.libspark.font.table;

import openfl.utils.ByteArray;

class KerningPair
{

	private var left:Int;
	private var right:Int;
	private var value:Int;

	public function new(byte_ar:ByteArray)
	{
		left = byte_ar.readUnsignedShort();
		right = byte_ar.readUnsignedShort();
		value = byte_ar.readShort();
	}

	public function getLeft():Int
	{
		return left;
	}

	public function getRight():Int
	{
		return right;
	}

	public function getValue():Int
	{
		return value;
	}
}