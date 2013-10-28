/*
 * Copyright (c) 2011 Initials Video Games
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */ 
 
 /*
 * Crate.as
 * Created On: 27/08/2011 8:34 PM
 */
 
package 
{
	import org.axgl.*;

	public class Crate extends AxSprite
	{
		[Embed(source="../data/smallCrate.png")] private var ImgSmallCrate:Class;
		
		public function Crate(X:int,Y:int)
		{
			super(X, Y);
			
			loadGraphic(ImgSmallCrate, true, false, 32, 23);			
			
			addAnimation("Idle", [0,1], 4 , true);
			
			play("Idle");
			
			drag.x = 200;
			drag.y = 100;
			acceleration.y = 800;
			
			width = 24;
			centerOffsets();
			

		}

		override public function update():void
		{
			super.update();

		}
	}
}