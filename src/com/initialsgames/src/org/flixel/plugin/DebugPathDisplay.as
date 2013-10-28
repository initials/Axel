package org.flixel.plugin
{
	import org.axgl.*;
	
	/**
	 * A simple manager for tracking and drawing AxPath debug data to the screen.
	 * 
	 * @author	Adam Atomic
	 */
	public class DebugPathDisplay extends AxBasic
	{
		protected var _paths:Array;
		
		/**
		 * Instantiates a new debug path display manager.
		 */
		public function DebugPathDisplay()
		{
			_paths = new Array();
			active = false; //don't call update on this plugin
		}
		
		/**
		 * Clean up memory.
		 */
		override public function destroy():void
		{
			super.destroy();
			clear();
			_paths = null;
		}
		
		/**
		 * Called by <code>Ax.drawPlugins()</code> after the game state has been drawn.
		 * Cycles through cameras and calls <code>drawDebug()</code> on each one.
		 */
		override public function draw():void
		{
			if(!Ax.visualDebug || ignoreDrawDebug)
				return;	
			
			if(cameras == null)
				cameras = Ax.cameras;
			var i:uint = 0;
			var l:uint = cameras.length;
			while(i < l)
				drawDebug(cameras[i++]);
		}
		
		/**
		 * Similar to <code>AxEntity</code>'s <code>drawDebug()</code> functionality,
		 * this function calls <code>drawDebug()</code> on each <code>AxPath</code> for the specified camera.
		 * Very helpful for debugging!
		 * 
		 * @param	Camera	Which <code>AxCamera</code> object to draw the debug data to.
		 */
		override public function drawDebug(Camera:AxCamera=null):void
		{
			if(Camera == null)
				Camera = Ax.camera;
			
			var i:int = _paths.length-1;
			var path:AxPath;
			while(i >= 0)
			{
				path = _paths[i--] as AxPath;
				if((path != null) && !path.ignoreDrawDebug)
					path.drawDebug(Camera);
			}
		}
		
		/**
		 * Add a path to the path debug display manager.
		 * Usually called automatically by <code>AxPath</code>'s constructor.
		 * 
		 * @param	Path	The <code>AxPath</code> you want to add to the manager.
		 */
		public function add(Path:AxPath):void
		{
			_paths.push(Path);
		}
		
		/**
		 * Remove a path from the path debug display manager.
		 * Usually called automatically by <code>AxPath</code>'s <code>destroy()</code> function.
		 * 
		 * @param	Path	The <code>AxPath</code> you want to remove from the manager.
		 */
		public function remove(Path:AxPath):void
		{
			var index:int = _paths.indexOf(Path);
			if(index >= 0)
				_paths.splice(index,1);
		}
		
		/**
		 * Removes all the paths from the path debug display manager.
		 */
		public function clear():void
		{
			var i:int = _paths.length-1;
			var path:AxPath;
			while(i >= 0)
			{
				path = _paths[i--] as AxPath;
				if(path != null)
					path.destroy();
			}
			_paths.length = 0;
		}
	}
}