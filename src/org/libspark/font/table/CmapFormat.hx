package org.libspark.font.table;

import openfl.utils.ByteArray;

class CmapFormat
{

	private var format:Int;
	private var length:Int;
	private var version:Int;

	public function new(byte_ar:ByteArray)
	{
		length = byte_ar.readUnsignedShort();
		version = byte_ar.readUnsignedShort();
	}

	public static function create(format:Int, byte_ar:ByteArray):Dynamic
	{

		switch (format)
		{
			case 0:
				return new CmapFormat0(byte_ar);
			case 2:
				return new CmapFormat2(byte_ar);
			case 4:
				return new CmapFormat4(byte_ar);
			case 6:
				return new CmapFormat6(byte_ar);
		}
		return null;
	}

	public function getFormat():Int
	{
		return format;
	}

	public function getLength():Int
	{
		return length;
	}

	public function getVersion():Int
	{
		return version;
	}


	public function mapCharCode(charCode:Int):Dynamic
	{
		return null;
	};
	public function getFirst():Dynamic
	{
		return null;
	};
	public function getLast():Dynamic
	{
		return null;
	};

	public function toString():String
	{
		var str:String = "";
		str += "format: " + format + ", length: " + length + ", version: " + version;

		return str;
	}
}