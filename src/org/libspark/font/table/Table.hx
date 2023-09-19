package org.libspark.font.table;

class Table
{
	// Table constants
	public var BASE:Int = 0x42415345; // Baseline data [OpenType]
	public var CFF:Int = 0x43464620; // PostScript font program (compact font format) [PostScript]
	public var DSIG:Int = 0x44534947; // Digital signature
	public var EBDT:Int = 0x45424454; // Embedded bitmap data
	public var EBLC:Int = 0x45424c43; // Embedded bitmap location data
	public var EBSC:Int = 0x45425343; // Embedded bitmap scaling data
	public var GDEF:Int = 0x47444546; // Glyph definition data [OpenType]
	public var GPOS:Int = 0x47504f53; // Glyph positioning data [OpenType]
	public var GSUB:Int = 0x47535542; // Glyph substitution data [OpenType]
	public var JSTF:Int = 0x4a535446; // Justification data [OpenType]
	public var LTSH:Int = 0x4c545348; // Linear threshold table
	public var MMFX:Int = 0x4d4d4658; // Multiple master font metrics [PostScript]
	public var MMSD:Int = 0x4d4d5344; // Multiple master supplementary data [PostScript]
	public static inline var OS_2:Int = 0x4f532f32; // OS/2 and Windows specific metrics [r]
	public var PCLT:Int = 0x50434c54; // PCL5
	public var VDMX:Int = 0x56444d58; // Vertical Device Metrics table
	public static inline var cmap:Int = 0x636d6170; // character to glyph mapping [r]
	public var cvt:Int = 0x63767420; // Control Value Table
	public var fpgm:Int = 0x6670676d; // font program
	public var fvar:Int = 0x66766172; // Apple's font variations table [PostScript]
	public var gasp:Int = 0x67617370; // grid-fitting and scan conversion procedure (grayscale)
	public static inline var glyf:Int = 0x676c7966; // glyph data [r]
	public var hdmx:Int = 0x68646d78; // horizontal device metrics
	public static inline var head:Int = 0x68656164; // font header [r]
	public static inline var hhea:Int = 0x68686561; // horizontal header [r]
	public static inline var hmtx:Int = 0x686d7478; // horizontal metrics [r]
	public static inline var kern:Int = 0x6b65726e; // kerning
	public static inline var loca:Int = 0x6c6f6361; // index to location [r]
	public static inline var maxp:Int = 0x6d617870; // maximum profile [r]
	public static inline var name:Int = 0x6e616d65; // naming table [r]
	public var prep:Int = 0x70726570; // CVT Program
	public static inline var post:Int = 0x706f7374; // PostScript information [r]
	public var vhea:Int = 0x76686561; // Vertical Metrics header
	public var vmtx:Int = 0x766d7478; // Vertical Metrics

	// Platform IDs
	public static inline var platformAppleUnicode:Int = 0;
	public static inline var platformMacintosh:Int = 1;
	public static inline var platformISO:Int = 2;
	public static inline var platformMicrosoft:Int = 3;

	// Microsoft Encoding IDs
	public var encodingUndefined:Int = 0;
	public var encodingUGL:Int = 1;

	// Macvarosh Encoding IDs
	public var encodingRoman:Int = 0;
	public var encodingJapanese:Int = 1;
	public var encodingChinese:Int = 2;
	public var encodingKorean:Int = 3;
	public var encodingArabic:Int = 4;
	public var encodingHebrew:Int = 5;
	public var encodingGreek:Int = 6;
	public var encodingRussian:Int = 7;
	public var encodingRSymbol:Int = 8;
	public var encodingDevanagari:Int = 9;
	public var encodingGurmukhi:Int = 10;
	public var encodingGujarati:Int = 11;
	public var encodingOriya:Int = 12;
	public var encodingBengali:Int = 13;
	public var encodingTamil:Int = 14;
	public var encodingTelugu:Int = 15;
	public var encodingKannada:Int = 16;
	public var encodingMalayalam:Int = 17;
	public var encodingSinhalese:Int = 18;
	public var encodingBurmese:Int = 19;
	public var encodingKhmer:Int = 20;
	public var encodingThai:Int = 21;
	public var encodingLaotian:Int = 22;
	public var encodingGeorgian:Int = 23;
	public var encodingArmenian:Int = 24;
	public var encodingMaldivian:Int = 25;
	public var encodingTibetan:Int = 26;
	public var encodingMongolian:Int = 27;
	public var encodingGeez:Int = 28;
	public var encodingSlavic:Int = 29;
	public var encodingVietnamese:Int = 30;
	public var encodingSindhi:Int = 31;
	public var encodingUnvarerp:Int = 32;

	// ISO Encoding IDs
	public var encodingASCII:Int = 0;
	public var encodingISO10646:Int = 1;
	public var encodingISO8859_1:Int = 2;

	// Microsoft Language IDs
	public var languageSQI:Int = 0x041c;
	public var languageEUQ:Int = 0x042d;
	public var languageBEL:Int = 0x0423;
	public var languageBGR:Int = 0x0402;
	public var languageCAT:Int = 0x0403;
	public var languageSHL:Int = 0x041a;
	public var languageCSY:Int = 0x0405;
	public var languageDAN:Int = 0x0406;
	public var languageNLD:Int = 0x0413;
	public var languageNLB:Int = 0x0813;
	public var languageENU:Int = 0x0409;
	public var languageENG:Int = 0x0809;
	public var languageENA:Int = 0x0c09;
	public var languageENC:Int = 0x1009;
	public var languageENZ:Int = 0x1409;
	public var languageENI:Int = 0x1809;
	public var languageETI:Int = 0x0425;
	public var languageFIN:Int = 0x040b;
	public var languageFRA:Int = 0x040c;
	public var languageFRB:Int = 0x080c;
	public var languageFRC:Int = 0x0c0c;
	public var languageFRS:Int = 0x100c;
	public var languageFRL:Int = 0x140c;
	public var languageDEU:Int = 0x0407;
	public var languageDES:Int = 0x0807;
	public var languageDEA:Int = 0x0c07;
	public var languageDEL:Int = 0x1007;
	public var languageDEC:Int = 0x1407;
	public var languageELL:Int = 0x0408;
	public var languageHUN:Int = 0x040e;
	public var languageISL:Int = 0x040f;
	public var languageITA:Int = 0x0410;
	public var languageITS:Int = 0x0810;
	public var languageLVI:Int = 0x0426;
	public var languageLTH:Int = 0x0427;
	public var languageNOR:Int = 0x0414;
	public var languageNON:Int = 0x0814;
	public var languagePLK:Int = 0x0415;
	public var languagePTB:Int = 0x0416;
	public var languagePTG:Int = 0x0816;
	public var languageROM:Int = 0x0418;
	public var languageRUS:Int = 0x0419;
	public var languageSKY:Int = 0x041b;
	public var languageSLV:Int = 0x0424;
	public var languageESP:Int = 0x040a;
	public var languageESM:Int = 0x080a;
	public var languageESN:Int = 0x0c0a;
	public var languageSVE:Int = 0x041d;
	public var languageTRK:Int = 0x041f;
	public var languageUKR:Int = 0x0422;

	// Macintosh Language IDs
	public var languageEnglish:Int = 0;
	public var languageFrench:Int = 1;
	public var languageGerman:Int = 2;
	public var languageItalian:Int = 3;
	public var languageDutch:Int = 4;
	public var languageSwedish:Int = 5;
	public var languageSpanish:Int = 6;
	public var languageDanish:Int = 7;
	public var languagePortuguese:Int = 8;
	public var languageNorwegian:Int = 9;
	public var languageHebrew:Int = 10;
	public var languageJapanese:Int = 11;
	public var languageArabic:Int = 12;
	public var languageFinnish:Int = 13;
	public var languageGreek:Int = 14;
	public var languageIcelandic:Int = 15;
	public var languageMaltese:Int = 16;
	public var languageTurkish:Int = 17;
	public var languageYugoslavian:Int = 18;
	public var languageChinese:Int = 19;
	public var languageUrdu:Int = 20;
	public var languageHindi:Int = 21;
	public var languageThai:Int = 22;

	// Name IDs
	public var nameCopyrightNotice:Int = 0;
	public var nameFontFamilyName:Int = 1;
	public var nameFontSubfamilyName:Int = 2;
	public var nameUniqueFontIdentifier:Int = 3;
	public var nameFullFontName:Int = 4;
	public var nameVersionString:Int = 5;
	public var namePostscriptName:Int = 6;
	public var nameTrademark:Int = 7;
}