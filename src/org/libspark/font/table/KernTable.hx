package org.libspark.font.table;

import openfl.utils.ByteArray;

class KernTable
{
	private var version:Int;
	private var nTables:Int;
	private var tables:Array<KernSubtable>;

	public function new(de:DirectoryEntry, byte_ar:ByteArray)
	{
		byte_ar.position = de.getOffset();
		version = byte_ar.readUnsignedShort();
		nTables = byte_ar.readUnsignedShort();
		tables = [];
		for (i in 0...nTables)
		{
			tables.push(KernSubtable.read(byte_ar));
		}
	}

	public function getSubtableCount():Int
	{
		return nTables;
	}

	public function getSubtable(i:Int):KernSubtable
	{
		return tables[i];
	}

	public function getType():Int
	{
		return Table.kern;
	}
}