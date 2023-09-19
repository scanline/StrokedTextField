package org.libspark.font.table;

import openfl.utils.ByteArray;

class CmapTable
{

	private var version:Int;
	private var numTables:Int;
	private var entries:Array<Dynamic>;
	private var formats:Array<Dynamic>;

	public function new(de:DirectoryEntry, byte_ar:ByteArray)
	{

		byte_ar.position = de.getOffset();
		var fp:Int = byte_ar.position;
		version = byte_ar.readUnsignedShort();
		numTables = byte_ar.readUnsignedShort();

		entries = [];
		for (i in 0...numTables)
		{
			entries.push(new CmapIndexEntry(byte_ar));
		}

		formats = [];
		for (j in 0...numTables)
		{
			byte_ar.position = fp + entries[j].getOffset();
			var format:Int = byte_ar.readUnsignedShort();
			formats.push(CmapFormat.create(format, byte_ar));
		}
	}

	public function getCmapFormat(platformId:Int, encodingId:Int):CmapFormat
	{
		for (i in 0...numTables)
		{
			if (entries[i].getPlatformId() == platformId && entries[i].getEncodingId() == encodingId)
			{
				return formats[i];
			}
		}
		return null;
	}

	public function getType():Int
	{
		return Table.cmap;
	}
}