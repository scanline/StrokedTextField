package org.libspark.font.table;

import openfl.utils.ByteArray;

class TableDirectory
{

	private var version:Int = 0;
	private var numTables:Int = 0;
	private var searchRange:Float = 0;
	private var entrySelector:Float = 0;
	private var rangeShift:Float = 0;
	private var _entries:Array<DirectoryEntry>;

	public function new(byt_ar:ByteArray)
	{

		version = byt_ar.readInt();
		numTables = byt_ar.readShort();
		searchRange = byt_ar.readShort();
		entrySelector = byt_ar.readShort();
		rangeShift = byt_ar.readShort();

		_entries = [];

		for (i in 0...numTables)
		{
			_entries.push(new DirectoryEntry(byt_ar));
		}

		var modified:Bool = true;

		while (modified)
		{
			modified = false;

			for (j in 0...numTables - 1)
			{
				if (_entries[j].getOffset()>_entries[j + 1].getOffset())
				{
					var temp:DirectoryEntry = _entries[j];
					_entries[j] = _entries[j + 1];
					_entries[j + 1] = temp;
					modified = true;
				}
			}
		}

	}


	public function getEntry(index:Int):DirectoryEntry
	{
		return _entries[index];
	}

	public function getEntryByTag(tag:Int):DirectoryEntry
	{
		for (i in 0...numTables)
		{
			if (_entries[i].getTag() == tag)
			{
				return _entries[i];
			}
		}
		return null;
	}

	public function getEntrySelector():Float
	{
		return entrySelector;
	}

	public function getNumTables():Int
	{
		return numTables;
	}

	public function getRangeShift():Float
	{
		return rangeShift;
	}

	public function getSearchRange():Float
	{
		return searchRange;
	}

	public function getVersion():Int
	{
		return version;
	}
}