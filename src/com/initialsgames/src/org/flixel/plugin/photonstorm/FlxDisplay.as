/**
 * AxDisplay
 * -- Part of the Flixel Power Tools set
 * 
 * v1.3 Added "screenWrap", "alphaMask" and "alphaMaskAxSprite" methods
 * v1.2 Added "space" method
 * v1.1 Updated for the Flixel 2.5 Plugin system
 * 
 * @version 1.3 - June 15th 2011
 * @link http://www.photonstorm.com
 * @author Richard Davey / Photon Storm
*/

package org.flixel.plugin.photonstorm 
{
	import flash.display.BitmapData;
	import flash.display.BitmapDataChannel;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import org.axgl.*;
	
	public class AxDisplay 
	{
		
		public function AxDisplay() 
		{
		}
		
		public function pad():void
		{
			//	Pad the sprite out with empty pixels left/right/above/below it
		}
		
		public function flip():void
		{
			//	mirror / reverse?
			//	Flip image data horizontally / vertically without changing the angle
		}
		
		/**
		 * Takes two source images (typically from Embedded bitmaps) and puts the resulting image into the output AxSprite.<br>
		 * Note: It assumes the source and mask are the same size. Different sizes may result in undesired results.<br>
		 * It works by copying the source image (your picture) into the output sprite. Then it removes all areas of it that do not<br>
		 * have an alpha color value in the mask image. So if you draw a big black circle in your mask with a transparent edge, you'll<br>
		 * get a circular image appear. Look at the mask PNG files in the assets/pics folder for examples.
		 * 
		 * @param	source		The source image. Typically the one with the image / picture / texture in it.
		 * @param	mask		The mask to apply. Remember the non-alpha zero areas are the parts that will display.
		 * @param	output		The AxSprite you wish the resulting image to be placed in (will adjust width/height of image)
		 * 
		 * @return	The output AxSprite for those that like chaining
		 */
		public static function alphaMask(source:Class, mask:Class, output:AxSprite):AxSprite
		{
			var data:BitmapData = (new source).bitmapData;
			
			data.copyChannel((new mask).bitmapData, new Rectangle(0, 0, data.width, data.height), new Point, BitmapDataChannel.ALPHA, BitmapDataChannel.ALPHA);
			
			output.pixels = data;
			
			return output;
		}
		
		/**
		 * Takes the image data from two AxSprites and puts the resulting image into the output AxSprite.<br>
		 * Note: It assumes the source and mask are the same size. Different sizes may result in undesired results.<br>
		 * It works by copying the source image (your picture) into the output sprite. Then it removes all areas of it that do not<br>
		 * have an alpha color value in the mask image. So if you draw a big black circle in your mask with a transparent edge, you'll<br>
		 * get a circular image appear. Look at the mask PNG files in the assets/pics folder for examples.
		 * 
		 * @param	source		The source AxSprite. Typically the one with the image / picture / texture in it.
		 * @param	mask		The AxSprite containing the mask to apply. Remember the non-alpha zero areas are the parts that will display.
		 * @param	output		The AxSprite you wish the resulting image to be placed in (will adjust width/height of image)
		 * 
		 * @return	The output AxSprite for those that like chaining
		 */
		public static function alphaMaskAxSprite(source:AxSprite, mask:AxSprite, output:AxSprite):AxSprite
		{
			var data:BitmapData = source.pixels;
			
			data.copyChannel(mask.pixels, new Rectangle(0, 0, source.width, source.height), new Point, BitmapDataChannel.ALPHA, BitmapDataChannel.ALPHA);
			
			output.pixels = data;
			
			return output;
		}
		
		/**
		 * Checks the x/y coordinates of the source AxSprite and keeps them within the area of 0, 0, Ax.width, Ax.height (i.e. wraps it around the screen)
		 * 
		 * @param	source				The AxSprite to keep within the screen
		 */
		public static function screenWrap(source:AxSprite):void
		{
			if (source.x < 0)
			{
				source.x = Ax.width;
			}
			else if (source.x > Ax.width)
			{
				source.x = 0;
			}
			
			if (source.y < 0)
			{
				source.y = Ax.height;
			}
			else if (source.y > Ax.height)
			{
				source.y = 0;
			}
		}
		
		/**
		 * Takes the bitmapData from the given source AxSprite and rotates it 90 degrees clockwise.<br>
		 * Can be useful if you need to control a sprite under rotation but it isn't drawn facing right.<br>
		 * This change overwrites AxSprite.pixels, but will not work with animated sprites.
		 * 
		 * @param	source		The AxSprite who's image data you wish to rotate clockwise
		 */
		public static function rotateClockwise(source:AxSprite):void
		{
		}
		
		/**
		 * Aligns a set of AxSprites so there is equal spacing between them
		 * 
		 * @param	sprites				An Array of AxSprites
		 * @param	startX				The base X coordinate to start the spacing from
		 * @param	startY				The base Y coordinate to start the spacing from
		 * @param	horizontalSpacing	The amount of pixels between each sprite horizontally (default 0)
		 * @param	verticalSpacing		The amount of pixels between each sprite vertically (default 0)
		 * @param	spaceFromBounds		If set to true the h/v spacing values will be added to the width/height of the sprite, if false it will ignore this
		 */
		public static function space(sprites:Array, startX:int, startY:int, horizontalSpacing:int = 0, verticalSpacing:int = 0, spaceFromBounds:Boolean = false):void
		{
			var prevWidth:int = 0;
			var prevHeight:int = 0;
			
			for (var i:int = 0; i < sprites.length; i++)
			{
				var sprite:AxSprite = sprites[i];
				
				if (spaceFromBounds)
				{
					sprite.x = startX + prevWidth + (i * horizontalSpacing);
					sprite.y = startY + prevHeight + (i * verticalSpacing);
				}
				else
				{
					sprite.x = startX + (i * horizontalSpacing);
					sprite.y = startY + (i * verticalSpacing);
				}
			}
		}
		
		/**
		 * Centers the given AxSprite on the screen, either by the X axis, Y axis, or both
		 * 
		 * @param	source	The AxSprite to center
		 * @param	xAxis	Boolean true if you want it centered on X (i.e. in the middle of the screen)
		 * @param	yAxis	Boolean	true if you want it centered on Y
		 * 
		 * @return	The AxSprite for chaining
		 */
		public static function screenCenter(source:AxSprite, xAxis:Boolean = true, yAxis:Boolean = false):AxSprite
		{
			if (xAxis)
			{
				source.x = (Ax.width / 2) - (source.width / 2);
			}
			
			if (yAxis)
			{
				source.y = (Ax.height / 2) - (source.height / 2);
			}

			return source;
		}
		
	}

}