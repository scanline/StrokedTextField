package org.libspark.font.table;

import openfl.utils.ByteArray;

class GlyfCompositeDescript extends GlyfDescript
{

	private var components:Array<Dynamic> = [];

	private var beingResolved:Bool = false;
	private var resolved:Bool = false;

	public function new(parentTable:GlyfTable, bais:ByteArray)
	{
		super(parentTable, -1, bais);

		var comp:GlyfCompositeComp;
		do {
			comp = new GlyfCompositeComp(bais);
			components.push(comp);
		} while ((comp.getFlags() & GlyfCompositeComp.MORE_COMPONENTS) != 0);

		if ((comp.getFlags() & GlyfCompositeComp.WE_HAVE_INSTRUCTIONS) != 0)
		{
			readInstructions(bais, (bais.readByte()<<8 | bais.readByte()));
		}
	}

	override public function resolve():Void
	{
		if (resolved) return;
		if (beingResolved)
		{
			throw ("Circular reference in GlyfCompositeDesc");
			return;
		}
		beingResolved = true;

		var firstIndex:Int = 0;
		var firstContour:Int = 0;


		/* TODO** write an iterator for this
		
        var i:Iterator= components.iterator();
        while (i.hasNext()) {
            var comp:GlyfCompositeComp= GlyfCompositeComp(i.next());
            comp.setFirstIndex(firstIndex);
            comp.setFirstContour(firstContour);

            var desc:GlyfDescript;
            desc = parentTable.getDescription(comp.getGlyphIndex());
            if (desc != null) {
                desc.resolve();
                firstIndex   += desc.getPointCount();
                firstContour += desc.getContourCount();
            }
        }
		
		*/
		resolved = true;
		beingResolved = false;
	}

	override public function getEndPtOfContours(i:Int):Int
	{
		var c:GlyfCompositeComp = getCompositeCompEndPt(i);
		if (c != null)
		{
			var gd:IGlyphDescription = parentTable.getDescription(c.getGlyphIndex());
			return gd.getEndPtOfContours(i - c.getFirstContour()) + c.getFirstIndex();
		}
		return 0;
	}

	override public function getFlags(i:Int):Int
	{
		var c:GlyfCompositeComp = getCompositeComp(i);
		if (c != null)
		{
			var gd:IGlyphDescription = parentTable.getDescription(c.getGlyphIndex());
			return gd.getFlags(i - c.getFirstIndex());
		}
		return 0;
	}

	override public function getXCoordinate(i:Int):Float
	{
		var c:GlyfCompositeComp = getCompositeComp(i);
		if (c != null)
		{
			var gd:IGlyphDescription = parentTable.getDescription(c.getGlyphIndex());
			var n:Int = i - c.getFirstIndex();
			var x:Float = gd.getXCoordinate(n);
			var y:Float = gd.getYCoordinate(n);
			var x1:Float = Math.floor(c.scaleX(x, y));
			x1 += c.getXTranslate();
			return x1;
		}
		return 0;
	}

	override public function getYCoordinate(i:Int):Float
	{
		var c:GlyfCompositeComp = getCompositeComp(i);
		if (c != null)
		{
			var gd:IGlyphDescription = parentTable.getDescription(c.getGlyphIndex());
			var n:Int = i - c.getFirstIndex();
			var x:Float = gd.getXCoordinate(n);
			var y:Float = gd.getYCoordinate(n);
			var y1:Float = Math.floor(c.scaleY(x, y));
			y1 += c.getYTranslate();
			return y1;
		}
		return 0;
	}

	override public function isComposite():Bool
	{
		return true;
	}

	override public function getPointCount():Int
	{
		if (!resolved)
			throw ("getPointCount called on unresolved GlyfCompositeDescript");

		var c:GlyfCompositeComp = cast(components[components.length - 1], GlyfCompositeComp);
		return c.getFirstIndex() + parentTable.getDescription(c.getGlyphIndex()).getPointCount();
	}

	override public function getContourCount():Int
	{
		if (!resolved)
			throw ("getContourCount called on unresolved GlyfCompositeDescript");

		var c:GlyfCompositeComp = cast(components[components.length - 1], GlyfCompositeComp);
		return c.getFirstContour() + parentTable.getDescription(c.getGlyphIndex()).getContourCount();
	}

	public function getComponentIndex(i:Int):Int
	{
		return cast(components[i], GlyfCompositeComp).getFirstIndex();
	}

	public function getComponentCount():Int
	{
		return components.length;
	}

	private function getCompositeComp(i:Int):GlyfCompositeComp
	{
		var c:GlyfCompositeComp;
		for (n in 0...components.length)
		{
			c = cast(components[n], GlyfCompositeComp);
			var gd:IGlyphDescription = parentTable.getDescription(c.getGlyphIndex());
			if (c.getFirstIndex()<=i && i<(c.getFirstIndex() + gd.getPointCount()))
			{
				return c;
			}
		}
		return null;
	}

	private function getCompositeCompEndPt(i:Int):GlyfCompositeComp
	{
		var c:GlyfCompositeComp;
		for (j in 0...components.length)
		{
			c = cast(components[j], GlyfCompositeComp);
			var gd:IGlyphDescription = parentTable.getDescription(c.getGlyphIndex());
			if (c.getFirstContour()<=i && i<(c.getFirstContour() + gd.getContourCount()))
			{
				return c;
			}
		}
		return null;
	}
}