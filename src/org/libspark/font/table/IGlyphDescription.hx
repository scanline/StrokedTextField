package org.libspark.font.table;

interface IGlyphDescription
{

	function getEndPtOfContours(i:Int):Int;
	function getFlags(i:Int):Int;
	function getXCoordinate(i:Int):Float;
	function getYCoordinate(i:Int):Float;
	function getXMaximum():Int;
	function getXMinimum():Int;
	function getYMaximum():Int;
	function getYMinimum():Int;
	function isComposite():Bool;
	function getPointCount():Int;
	function getContourCount():Int;
	//  public int getComponentIndex(int c);
	//  public int getComponentCount();
}