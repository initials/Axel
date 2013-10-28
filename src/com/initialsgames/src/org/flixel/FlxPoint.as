package org.flixel
{
	import flash.geom.Point;
	
	/**
	 * Stores a 2D floating point coordinate.
	 * 
	 * @author	Adam Atomic
	 */
	public class AxPoint
	{
		/**
		 * @default 0
		 */
		public var x:Number;
		/**
		 * @default 0
		 */
		public var y:Number;
		
		/**
		 * Instantiate a new point object.
		 * 
		 * @param	X		The X-coordinate of the point in space.
		 * @param	Y		The Y-coordinate of the point in space.
		 */
		public function AxPoint(X:Number=0, Y:Number=0)
		{
			x = X;
			y = Y;
		}
		
		/**
		 * Instantiate a new point object.
		 * 
		 * @param	X		The X-coordinate of the point in space.
		 * @param	Y		The Y-coordinate of the point in space.
		 */
		public function make(X:Number=0, Y:Number=0):AxPoint
		{
			x = X;
			y = Y;
			return this;
		}
		
		/**
		 * Helper function, just copies the values from the specified point.
		 * 
		 * @param	Point	Any <code>AxPoint</code>.
		 * 
		 * @return	A reference to itself.
		 */
		public function copyFrom(Point:AxPoint):AxPoint
		{
			x = Point.x;
			y = Point.y;
			return this;
		}
		
		/**
		 * Helper function, just copies the values from this point to the specified point.
		 * 
		 * @param	Point	Any <code>AxPoint</code>.
		 * 
		 * @return	A reference to the altered point parameter.
		 */
		public function copyTo(Point:AxPoint):AxPoint
		{
			Point.x = x;
			Point.y = y;
			return Point;
		}
		
		/**
		 * Helper function, just copies the values from the specified Flash point.
		 * 
		 * @param	Point	Any <code>Point</code>.
		 * 
		 * @return	A reference to itself.
		 */
		public function copyFromFlash(FlashPoint:Point):AxPoint
		{
			x = FlashPoint.x;
			y = FlashPoint.y;
			return this;
		}
		
		/**
		 * Helper function, just copies the values from this point to the specified Flash point.
		 * 
		 * @param	Point	Any <code>Point</code>.
		 * 
		 * @return	A reference to the altered point parameter.
		 */
		public function copyToFlash(FlashPoint:Point):Point
		{
			FlashPoint.x = x;
			FlashPoint.y = y;
			return FlashPoint;
		}
	}
}
