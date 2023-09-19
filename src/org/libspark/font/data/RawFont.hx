package org.libspark.font.data;

import openfl.utils.ByteArray;
import org.libspark.font.render.GlyphRenderer;
import org.libspark.font.table.*;

class RawFont
{
	public var hhea(get, never):HheaTable;
	public var maxp(get, never):MaxpTable;
	public var head(get, never):HeadTable;
	public var loca(get, never):LocaTable;
	public var hmtx(get, never):HmtxTable;
	public var cmap(get, never):CmapTable;
	public var os2(get, never):Os2Table;
	public var kern(get, never):KernTable;
	public var graphics(get, never):GlyphRenderer;

	private var _os2:Os2Table;
	private var _cmap:CmapTable;
	private var _glyf:GlyfTable;
	private var _head:HeadTable;
	private var _hhea:HheaTable;
	private var _hmtx:HmtxTable;
	private var _loca:LocaTable;
	private var _maxp:MaxpTable;
	private var _name:NameTable;
	private var _post:PostTable;
	private var _kern:KernTable;

	private var tableDir:TableDirectory;
	private var tables:Array<Dynamic>;

	private var _glyphRenderer:GlyphRenderer;

	public var Sha256:String = "";

	public function new()
	{
		_glyphRenderer = new GlyphRenderer(this);
	}


	public function read(byte_ar:ByteArray):Void
	{
		tableDir = new TableDirectory(byte_ar);
		tables = [];

		for (i in 0...tableDir.getNumTables())
		{
			tables.push(TableFactory.create(tableDir.getEntry(i), byte_ar));
		}

		_os2 = getTable(Table.OS_2);
		_cmap = getTable(Table.cmap);
		_glyf = getTable(Table.glyf);
		_head = getTable(Table.head);
		_hhea = getTable(Table.hhea);
		_hmtx = getTable(Table.hmtx);
		_loca = getTable(Table.loca);
		_maxp = getTable(Table.maxp);
		_name = getTable(Table.name);
		_post = getTable(Table.post);
		_kern = getTable(Table.kern);

		_hmtx.init(hhea.getNumberOfHMetrics(), maxp.getNumGlyphs() - hhea.getNumberOfHMetrics());
		_loca.init(maxp.getNumGlyphs(), head.getIndexToLocFormat() == 0);
		_glyf.init(maxp.getNumGlyphs(), loca, cmap);
	}

	public function getGlyph(i:Int):Dynamic
	{
		var map:CmapFormat = cmap.getCmapFormat(3, 1);

		var index:Int = map.mapCharCode(i);
		//trace("request", map.mapCharCode(i), i, Type.typeof(map));
		return (_glyf.getDescription(index) != null) ? new GlyphData(_glyf.getDescription(index), hmtx.getLeftSideBearing(index), hmtx.getAdvanceWidth(index)):null;
	}

	public function getGlyphIndex(i:Int):Int
	{
		var map:CmapFormat = cmap.getCmapFormat(3, 1);

		var index:Int = map.mapCharCode(i);
		return (_glyf.getDescription(index) != null) ? index: - 1;
	}

	public function getKerning(charAIndex:Int, charBIndex:Int):Int
	{
		if (_kern != null && _kern.getSubtableCount()>0)
		{
			return cast(_kern.getSubtable(0), KernSubtable).getKerning(charAIndex, charBIndex);
		}
		return 0;
	}

	public function getSpaceAdvanceWidth():Int
	{
		var map:CmapFormat = cmap.getCmapFormat(3, 1);
		var index:Int = map.mapCharCode(32);
		return hmtx.getAdvanceWidth(index);
	}

	public function getNumGlyphs():Int
	{
		return maxp.getNumGlyphs();
	}

	public function getAscent():Int
	{
		return hhea.getAscender();
	}

	public function getDescent():Int
	{
		return hhea.getDescender();
	}

	public function get_os2():Os2Table
	{
		return _os2;
	}

	public function get_cmap():CmapTable
	{
		return _cmap;
	}

	public function get_head():HeadTable
	{
		return _head;
	}

	public function get_hhea():HheaTable
	{
		return _hhea;
	}

	public function get_hmtx():HmtxTable
	{
		return _hmtx;
	}

	public function get_loca():LocaTable
	{
		return _loca;
	}

	public function get_maxp():MaxpTable
	{
		return _maxp;
	}

	public function get_name():NameTable
	{
		return _name;
	}

	public function get_post():PostTable
	{
		return _post;
	}

	public function get_kern():KernTable
	{
		return _kern;
	}

	public function getTableDirectory():TableDirectory
	{
		return tableDir;
	}

	public function getTable(tableType:Dynamic):Dynamic
	{
		for (i in 0...tables.length)
		{
			if ((tables[i] != null) && (tables[i].getType() == tableType))
			{
				return tables[i];
			}
		}
		return null;
	}

	public function get_graphics():GlyphRenderer
	{
		return _glyphRenderer;
	}
}