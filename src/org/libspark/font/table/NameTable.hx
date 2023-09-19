package org.libspark.font.table;

import openfl.utils.ByteArray;

class NameTable
{

	private var formatSelector:Int;
	private var numberOfNameRecords:Int;
	private var stringStorageOffset:Int;
	private var records:Array<Dynamic>;

	public function new(de:DirectoryEntry, byte_ar:ByteArray)
	{

		byte_ar.position = de.getOffset();
		formatSelector = byte_ar.readUnsignedShort();
		numberOfNameRecords = byte_ar.readUnsignedShort();
		stringStorageOffset = byte_ar.readUnsignedShort();
		records = [];
		for (i in 0...numberOfNameRecords)
		{
			records.push(new NameRecord(byte_ar));
		}

		for (j in 0...numberOfNameRecords)
		{
			records[j].loadString(byte_ar, de.getOffset() + stringStorageOffset);
		}
	}

	public function getRecord(nameId:Int):String
	{
		for (i in 0...numberOfNameRecords)
		{
			if (records[i].getNameId() == nameId)
			{
				return records[i].getRecordString();
			}
		}
		return "";
	}

	public function getType():Int
	{
		return Table.name;
	}
}