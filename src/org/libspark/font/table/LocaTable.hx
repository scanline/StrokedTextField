package org.libspark.font.table;

import openfl.utils.ByteArray;

class LocaTable
{

	private var buf:ByteArray;
	private var offsets:Array<Int>;
	private var filePos:Int;

	public function new(de:DirectoryEntry, byte_ar:ByteArray)
	{
		byte_ar.position = de.getOffset();
		buf = new ByteArray();
		buf.endian = byte_ar.endian;
		var pos:Int = byte_ar.position;
		filePos = pos;
		var len:Int = de.getLength();

		byte_ar.readBytes(buf, 0, len);
	}

	public function init(numGlyphs:Int, shortEntries:Bool):Void
	{
		if (buf == null)
		{
			return;
		}

		offsets = new Array();

		if (shortEntries)
		{
			for (i in 0...numGlyphs + 1)
			{
				offsets.push(buf.readUnsignedShort() * 2);
			}
		}
		else
		{
			for (j in 0...numGlyphs + 1)
			{
				offsets.push(buf.readUnsignedInt());
			}
		}

		buf = null;
	}

	public function getOffset(i:Int):Int
	{
		if (offsets == null)
		{
			return 0;
		}
		return offsets[i];
	}

	public function getType():Int
	{
		return Table.loca;
	}
}