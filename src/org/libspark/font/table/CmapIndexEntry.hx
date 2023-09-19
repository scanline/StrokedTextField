package org.libspark.font.table;

import openfl.utils.ByteArray;

class CmapIndexEntry
{

	private var platformId:Int;
	private var encodingId:Int;
	private var offset:Int;

	public function new(byte_ar:ByteArray)
	{

		platformId = byte_ar.readUnsignedShort();
		encodingId = byte_ar.readUnsignedShort();
		offset = byte_ar.readInt();
	}

	public function getEncodingId():Int
	{
		return encodingId;
	}

	public function getOffset():Int
	{
		return offset;
	}

	public function getPlatformId():Int
	{
		return platformId;
	}

	public function toString():String
	{

		return "[CMAPINDEXENTRY " + encodingId + " " + platformId + " ]";
	}
}