package org.libspark.font.table;

import openfl.utils.ByteArray;


class HmtxTable
{

	private var buf:ByteArray;
	private var hMetrics:Array<Int>;
	private var leftSideBearing:Array<Dynamic>;


	public function new(de:DirectoryEntry, byte_ar:ByteArray)
	{
		byte_ar.position = de.getOffset();
		buf = new ByteArray();
		buf.endian = byte_ar.endian;
		var pos:Int = byte_ar.position;
		var len:Int = de.getLength();

		byte_ar.readBytes(buf, 0, len);
	}

	public function init(numberOfHMetrics:Int, lsbCount:Int):Void
	{
		if (buf == null)
		{
			return;
		}

		hMetrics = [];

		for (i in 0...numberOfHMetrics)
		{
			hMetrics.push(buf.readUnsignedInt()); // first two bytes==advanceWidth ; second two bytes leftSideBearing
		}


		if (lsbCount>0)
		{
			leftSideBearing = [];
			for (j in 0...lsbCount)
			{
				leftSideBearing.push(buf.readShort());
			}
		}
		buf = null;
	}

	public function getAdvanceWidth(i:Int):Int
	{

		if (hMetrics == null)
		{
			return 0;
		}

		if (i<hMetrics.length)
		{
			return hMetrics[i]>>16;
		}
		else
		{
			return hMetrics[hMetrics.length - 1]>>16;
		}
	}

	public function getLeftSideBearing(i:Int):Int
	{

		if (hMetrics == null)
		{
			return 0;
		}

		if (i<hMetrics.length)
		{
			var number:Int = (hMetrics[i] & 0xffff);
			return (number<<16)>>16; // return as signed 16 bit value
		}
		else
		{
			return leftSideBearing[i - hMetrics.length];
		}
	}

	public function getType():Int
	{
		return Table.hmtx;
	}
}