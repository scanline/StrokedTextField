package org.libspark.font.table;

import openfl.utils.ByteArray;

class NameRecord
{

	private var platformId:Int;
	private var encodingId:Int;
	private var languageId:Int;
	private var nameId:Int;
	private var stringLength:Int;
	private var stringOffset:Int;
	private var record:String;

	public function new(byte_ar:ByteArray)
	{
		platformId = byte_ar.readUnsignedShort();
		encodingId = byte_ar.readUnsignedShort();
		languageId = byte_ar.readUnsignedShort();
		nameId = byte_ar.readUnsignedShort();
		stringLength = byte_ar.readUnsignedShort();
		stringOffset = byte_ar.readUnsignedShort();
	}

	public function getEncodingId():Int
	{
		return encodingId;
	}

	public function getLanguageId():Int
	{
		return languageId;
	}

	public function getNameId():Int
	{
		return nameId;
	}

	public function getPlatformId():Int
	{
		return platformId;
	}

	public function getRecordString():String
	{
		return record;
	}

	public function loadString(byte_ar:ByteArray, stringStorageOffset:Int):Void
	{
		var sb:String = "";
		byte_ar.position = stringStorageOffset + stringOffset;

		if (platformId == Table.platformAppleUnicode)
		{
			for (i in 0...Math.floor(stringLength / 2))
			{
				sb += Std.string(byte_ar.readByte());
				sb += Std.string(byte_ar.readByte());
			}
		}
		else if (platformId == Table.platformMacintosh)
		{
			sb += Std.string(byte_ar.readByte());
		}
		else if (platformId == Table.platformISO)
		{
			sb += Std.string(byte_ar.readByte());

		}
		else if (platformId == Table.platformMicrosoft)
		{
			for (h in 0...Math.floor(stringLength / 2))
			{
				sb += Std.string(byte_ar.readByte());
				sb += Std.string(byte_ar.readByte());
			}
		}
		record = sb;
	}
}