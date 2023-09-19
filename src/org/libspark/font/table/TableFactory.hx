package org.libspark.font.table;

import openfl.utils.ByteArray;

class TableFactory
{
	public static function create(de:DirectoryEntry, byte_ar:ByteArray):Dynamic
	{
		var t:Table = null;
		switch (de.getTag())
		{
			/*
			case Table.BASE:
			case Table.CFF:
			case Table.DSIG:
			case Table.EBDT:
			case Table.EBLC:
			case Table.EBSC:
			case Table.GDEF:
			case Table.GPOS: t = new GposTable(de, byte_ar);
			case Table.GSUB: t = new GsubTable(de, byte_ar);		
			case Table.JSTF:
			case Table.LTSH:
			case Table.MMFX:
			case Table.MMSD:
				*/

			case Table.OS_2:
			return new Os2Table(de, byte_ar);


			/*
			case Table.PCLT:
			case Table.VDMX:
				
				*/

			case Table.cmap:
			return new CmapTable(de, byte_ar);

			/*
			case Table.cvt: t = new CvtTable(de, byte_ar);
			case Table.fpgm: t = new FpgmTable(de, byte_ar);
			case Table.fvar:
			case Table.gasp:
				*/

			case Table.glyf:
			return new GlyfTable(de, byte_ar);


			/*
			case Table.hdmx:
				*/

			case Table.head:
			return new HeadTable(de, byte_ar);

			case Table.hhea:
			return new HheaTable(de, byte_ar);

			case Table.hmtx:
			return new HmtxTable(de, byte_ar);


			
			case Table.kern: 
			return new KernTable(de, byte_ar);
				

			case Table.loca:
			return new LocaTable(de, byte_ar);

			case Table.maxp:
			return new MaxpTable(de, byte_ar);

			case Table.name:
			return new NameTable(de, byte_ar);

			/*
			case Table.prep: t = new PrepTable(de, byte_ar);
				*/
			case Table.post:
			return new PostTable(de, byte_ar);


			/*
			case Table.vhea:
			case Table.vmtx:
				*/
		}

		return t;
	}
}