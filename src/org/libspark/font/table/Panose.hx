package org.libspark.font.table;

class Panose
{

	private var bFamilyType:Int = 0;
	private var bSerifStyle:Int = 0;
	private var bWeight:Int = 0;
	private var bProportion:Int = 0;
	private var bContrast:Int = 0;
	private var bStrokeVariation:Int = 0;
	private var bArmStyle:Int = 0;
	private var bLetterform:Int = 0;
	private var bMidline:Int = 0;
	private var bXHeight:Int = 0;

	public function new(panose:Array<Dynamic>)
	{
		bFamilyType = panose[0];
		bSerifStyle = panose[1];
		bWeight = panose[2];
		bProportion = panose[3];
		bContrast = panose[4];
		bStrokeVariation = panose[5];
		bArmStyle = panose[6];
		bLetterform = panose[7];
		bMidline = panose[8];
		bXHeight = panose[9];
	}

	public function getFamilyType():Int
	{
		return bFamilyType;
	}

	public function getSerifStyle():Int
	{
		return bSerifStyle;
	}

	public function getWeight():Int
	{
		return bWeight;
	}

	public function getProportion():Int
	{
		return bProportion;
	}

	public function getContrast():Int
	{
		return bContrast;
	}

	public function getStrokeVariation():Int
	{
		return bStrokeVariation;
	}

	public function getArmStyle():Int
	{
		return bArmStyle;
	}

	public function getLetterForm():Int
	{
		return bLetterform;
	}

	public function getMidline():Int
	{
		return bMidline;
	}

	public function getXHeight():Int
	{
		return bXHeight;
	}
}