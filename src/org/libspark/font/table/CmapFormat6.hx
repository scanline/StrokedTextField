package org.libspark.font.table;

import openfl.utils.ByteArray;

class CmapFormat6 extends CmapFormat
{

	public function new(byte_ar:ByteArray)
	{
		super(byte_ar);
		format = 6;
	}

	override public function getFirst():Dynamic
	{
		return 0;
	}
	override public function getLast():Dynamic
	{
		return 0;
	}

	override public function mapCharCode(charCode:Int):Dynamic
	{
		trace("NOT IMPLEMENTED!");
		return 0;
	}
}