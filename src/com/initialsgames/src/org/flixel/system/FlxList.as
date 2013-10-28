package org.flixel.system
{
	import org.flixel.AxEntity;
	
	/**
	 * A miniature linked list class.
	 * Useful for optimizing time-critical or highly repetitive tasks!
	 * See <code>AxQuadTree</code> for how to use it, IF YOU DARE.
	 */
	public class AxList
	{
		/**
		 * Stores a reference to a <code>AxEntity</code>.
		 */
		public var object:AxEntity;
		/**
		 * Stores a reference to the next link in the list.
		 */
		public var next:AxList;
		
		/**
		 * Creates a new link, and sets <code>object</code> and <code>next</code> to <code>null</code>.
		 */
		public function AxList()
		{
			object = null;
			next = null;
		}
		
		/**
		 * Clean up memory.
		 */
		public function destroy():void
		{
			object = null;
			if(next != null)
				next.destroy();
			next = null;
		}
	}
}