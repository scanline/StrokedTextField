package org.libspark.font.table;

import openfl.utils.ByteArray;

class MaxpTable
{

	private var versionNumber:Int;
	private var numGlyphs:Int;
	private var maxPoInts:Int;
	private var maxContours:Int;
	private var maxCompositePoInts:Int;
	private var maxCompositeContours:Int;
	private var maxZones:Int;
	private var maxTwilightPoInts:Int;
	private var maxStorage:Int;
	private var maxFunctionDefs:Int;
	private var maxInstructionDefs:Int;
	private var maxStackElements:Int;
	private var maxSizeOfInstructions:Int;
	private var maxComponentElements:Int;
	private var maxComponentDepth:Int;

	public function new(de:DirectoryEntry, byte_ar:ByteArray)
	{

		byte_ar.position = de.getOffset();
		versionNumber = byte_ar.readInt();
		numGlyphs = byte_ar.readUnsignedShort();
		maxPoInts = byte_ar.readUnsignedShort();
		maxContours = byte_ar.readUnsignedShort();
		maxCompositePoInts = byte_ar.readUnsignedShort();
		maxCompositeContours = byte_ar.readUnsignedShort();
		maxZones = byte_ar.readUnsignedShort();
		maxTwilightPoInts = byte_ar.readUnsignedShort();
		maxStorage = byte_ar.readUnsignedShort();
		maxFunctionDefs = byte_ar.readUnsignedShort();
		maxInstructionDefs = byte_ar.readUnsignedShort();
		maxStackElements = byte_ar.readUnsignedShort();
		maxSizeOfInstructions = byte_ar.readUnsignedShort();
		maxComponentElements = byte_ar.readUnsignedShort();
		maxComponentDepth = byte_ar.readUnsignedShort();
	}

	public function getMaxComponentDepth():Int
	{
		return maxComponentDepth;
	}

	public function getMaxComponentElements():Int
	{
		return maxComponentElements;
	}

	public function getMaxCompositeContours():Int
	{
		return maxCompositeContours;
	}

	public function getMaxCompositePoInts():Int
	{
		return maxCompositePoInts;
	}

	public function getMaxContours():Int
	{
		return maxContours;
	}

	public function getMaxFunctionDefs():Int
	{
		return maxFunctionDefs;
	}

	public function getMaxInstructionDefs():Int
	{
		return maxInstructionDefs;
	}

	public function getMaxPoInts():Int
	{
		return maxPoInts;
	}

	public function getMaxSizeOfInstructions():Int
	{
		return maxSizeOfInstructions;
	}

	public function getMaxStackElements():Int
	{
		return maxStackElements;
	}

	public function getMaxStorage():Int
	{
		return maxStorage;
	}

	public function getMaxTwilightPoInts():Int
	{
		return maxTwilightPoInts;
	}

	public function getMaxZones():Int
	{
		return maxZones;
	}

	public function getNumGlyphs():Int
	{
		return numGlyphs;
	}

	public function getType():Int
	{
		return Table.maxp;
	}
}