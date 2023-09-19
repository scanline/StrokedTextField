package org.libspark.font.table;

import openfl.utils.ByteArray;

class GlyfTable
{

	private var buf:ByteArray;
	private var descript:Array<Dynamic>;
	private var fileOffset:Int;
	public function new(de:DirectoryEntry, byte_ar:ByteArray)
	{
		byte_ar.position = de.getOffset();
		buf = new ByteArray();
		buf.endian = byte_ar.endian;
		var pos:Int = byte_ar.position;
		var len:Int = de.getLength();

		fileOffset = pos;
		byte_ar.readBytes(buf, 0, len);
	}

	public function init(numGlyphs:Int, loca:LocaTable, cmap:CmapTable):Void
	{

		if (buf == null)
		{
			return;
		}

		var emptyGlyph:Int = 0;
		descript = [];

		for (i in 0...numGlyphs)
		{
			var len:Int = loca.getOffset((i + 1)) - loca.getOffset(i);
			if (len>0)
			{

				buf.position = 0;
				buf.position = loca.getOffset(i);

				var numberOfContours:Int = (buf.readByte()<<8 | buf.readByte());

				if (numberOfContours>=0)
				{
					descript.push(new GlyfSimpleDescript(this, numberOfContours, buf));
				}
				else
				{
					descript.push(new GlyfCompositeDescript(this, buf));
				}
			}
			else
			{
				emptyGlyph++;
				descript.push(null);
			}
		}

		buf = null;

		for (j in 0...numGlyphs)
		{
			if (descript[j] == null) continue;

			descript[j].resolve();
		}
	}

	public function getDescription(i:Int):GlyfDescript
	{
		return descript[i];
	}

	public function getType():Int
	{
		return Table.glyf;
	}

}