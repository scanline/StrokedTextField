package org.libspark.font.table;

import openfl.utils.ByteArray;

class DirectoryEntry
{

	private var tag:Int;
	private var checksum:Int;
	private var offset:Int;
	private var length:Int;
	private var table:Table;

	public function new(byte_ar:ByteArray)
	{
		tag = byte_ar.readInt();
		checksum = byte_ar.readInt();
		offset = byte_ar.readInt();
		length = byte_ar.readInt();
	}

	public function getChecksum():Int
	{
		return checksum;
	}

	public function getLength():Int
	{
		return length;
	}

	public function getOffset():Int
	{
		return offset;
	}

	public function getTag():Int
	{
		return tag;
	}
}