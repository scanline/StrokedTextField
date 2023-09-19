package org.libspark.font.table;

import openfl.utils.ByteArray;

class CmapFormat2 extends CmapFormat
{

	private var subHeaderKeys:Array<Dynamic>=[];
	private var subHeaders1:Array<Dynamic>;
	private var subHeaders2:Array<Dynamic>;
	private var glyphIndexArray:Array<Dynamic>;

	public function new(byte_ar:ByteArray)
	{
		super(byte_ar);
		format = 2;
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
		return 0;
	}
}