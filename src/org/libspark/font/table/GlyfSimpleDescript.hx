package org.libspark.font.table;

import openfl.utils.ByteArray;

class GlyfSimpleDescript extends GlyfDescript
{

	private var endPtsOfContours:Array<Int>;
	private var flags:Array<Dynamic>;
	private var xCoordinates:Array<Float>;
	private var yCoordinates:Array<Dynamic>;
	private var count:Int;

	public function new(parentTable:GlyfTable, numberOfContours:Int, bais:ByteArray)
	{

		super(parentTable, numberOfContours, bais);

		endPtsOfContours = [];

		for (i in 0...numberOfContours)
		{
			endPtsOfContours.push(Std.int((bais.readUnsignedByte()<<8 | bais.readUnsignedByte())));
		}




		// The last end point index reveals the total number of points
		count = endPtsOfContours[numberOfContours - 1] + 1;


		flags = [];
		xCoordinates = [];
		yCoordinates = [];

		var instructionCount:Int = Std.int((bais.readUnsignedByte()<<8 | bais.readUnsignedByte()));
		readInstructions(bais, instructionCount);
		readFlags(count, bais);
		readCoords(count, bais);
	}

	override public function getEndPtOfContours(i:Int):Int
	{
		return endPtsOfContours[i];
	}

	override public function getFlags(i:Int):Int
	{
		return flags[i];
	}

	override public function getXCoordinate(i:Int):Float
	{
		return xCoordinates[i];
	}

	override public function getYCoordinate(i:Int):Float
	{
		return yCoordinates[i];
	}

	override public function isComposite():Bool
	{
		return false;
	}

	override public function getPointCount():Int
	{
		return count;
	}

	override public function getContourCount():Int
	{
		return getNumberOfContours();
	}
	/*
		public int getComponentIndex(int c) {
		return 0;
		}
	
		public int getComponentCount() {
		return 1;
		}
		 */

	private function readCoords(count:Int, bais:ByteArray):Void
	{

		var x:Float = 0;
		var y:Float = 0;

		for (i in 0...count)
		{

			if ((flags[i] & xDual) != 0)
			{
				if ((flags[i] & xShortVector) != 0)
				{

					x += Std.parseFloat(Std.string(bais.readUnsignedByte()));
				}
			}
			else
			{
				if ((flags[i] & xShortVector) != 0)
				{

					x += -Std.parseFloat(Std.string(bais.readUnsignedByte()));

				}
				else
				{



					var xPos:Int = ((bais.readUnsignedByte()<<8) | (bais.readUnsignedByte()));

					if (xPos>60000)
					{
						xPos = 65536 - xPos;
						x -= xPos;

					}
					else
					{
						x += xPos;
					}


				}
			}
			xCoordinates.push(x);

		}

		for (j in 0...count)
		{
			if ((flags[j] & yDual) != 0)
			{
				if ((flags[j] & yShortVector) != 0)
				{

					y += Std.parseFloat(Std.string(bais.readUnsignedByte()));

				}
			}
			else
			{
				if ((flags[j] & yShortVector) != 0)
				{

					y += -Std.parseFloat(Std.string(bais.readUnsignedByte()));

				}
				else
				{

					var yPos:Int = ((bais.readUnsignedByte()<<8) | (bais.readUnsignedByte()));

					if (yPos>60000)
					{
						yPos = 65536 - yPos;
						y -= yPos;

					}
					else
					{
						y += yPos;
					}

				}
			}
			yCoordinates.push(y);
		}

	}

	private function readFlags(flagCount:Int, bais:ByteArray):Void
	{

		var index:Int = 0;
		do {
			flags.push((bais.readUnsignedByte()));
			if ((flags[index] & repeat) != 0)
			{
				var repeats:Int = bais.readUnsignedByte();
				for (i in 1...repeats + 1)
				{
					//trace("repeat");
					flags[index + i] = flags[index];
				}
				index += repeats;
			}
			index++;
		}
		while (index<flagCount);

	}
}