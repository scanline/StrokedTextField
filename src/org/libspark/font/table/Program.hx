package org.libspark.font.table;

import openfl.utils.ByteArray;

class Program
{

	private var instructions:Array<Dynamic>;

	public function getInstructions():Array<Dynamic>
	{
		return instructions;
	}

	public function readInstructions(byte_ar:ByteArray, count:Int):Void
	{
		instructions = new Array();
		for (i in 0...count)
		{
			instructions.push((byte_ar.readByte()));
		}
	}
}