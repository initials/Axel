package org.flixel
{
	import flash.display.Graphics;
	
	import org.flixel.plugin.DebugPathDisplay;
	
	/**
	 * This is a simple path data container.  Basically a list of points that
	 * a <code>AxEntity</code> can follow.  Also has code for drawing debug visuals.
	 * <code>AxTilemap.findPath()</code> returns a path object, but you can
	 * also just make your own, using the <code>add()</code> functions below
	 * or by creating your own array of points.
	 * 
	 * @author	Adam Atomic
	 */
	public class AxPath
	{
		/**
		 * The list of <code>AxPoint</code>s that make up the path data.
		 */
		public var nodes:Array;
		/**
		 * Specify a debug display color for the path.  Default is white.
		 */
		public var debugColor:uint;
		/**
		 * Specify a debug display scroll factor for the path.  Default is (1,1).
		 * NOTE: does not affect world movement!  Object scroll factors take care of that.
		 */
		public var debugScrollFactor:AxPoint;
		/**
		 * Setting this to true will prevent the object from appearing
		 * when the visual debug mode in the debugger overlay is toggled on.
		 * @default false
		 */
		public var ignoreDrawDebug:Boolean;

		/**
		 * Internal helper for keeping new variable instantiations under control.
		 */
		protected var _point:AxPoint;
		
		/**
		 * Instantiate a new path object.
		 * 
		 * @param	Nodes	Optional, can specify all the points for the path up front if you want.
		 */
		public function AxPath(Nodes:Array=null)
		{
			if(Nodes == null)
				nodes = new Array();
			else
				nodes = Nodes;
			_point = new AxPoint();
			debugScrollFactor = new AxPoint(1.0,1.0);
			debugColor = 0xffffff;
			ignoreDrawDebug = false;
			
			var debugPathDisplay:DebugPathDisplay = manager;
			if(debugPathDisplay != null)
				debugPathDisplay.add(this);
		}
		
		/**
		 * Clean up memory.
		 */
		public function destroy():void
		{
			var debugPathDisplay:DebugPathDisplay = manager;
			if(debugPathDisplay != null)
				debugPathDisplay.remove(this);
			
			debugScrollFactor = null;
			_point = null;
			nodes = null;
		}
		
		/**
		 * Add a new node to the end of the path at the specified location.
		 * 
		 * @param	X	X position of the new path point in world coordinates.
		 * @param	Y	Y position of the new path point in world coordinates.
		 */
		public function add(X:Number,Y:Number):void
		{
			nodes.push(new AxPoint(X,Y));
		}
		
		/**
		 * Add a new node to the path at the specified location and index within the path.
		 * 
		 * @param	X		X position of the new path point in world coordinates.
		 * @param	Y		Y position of the new path point in world coordinates.
		 * @param	Index	Where within the list of path nodes to insert this new point.
		 */
		public function addAt(X:Number, Y:Number, Index:uint):void
		{
			if(Index > nodes.length)
				Index = nodes.length;
			nodes.splice(Index,0,new AxPoint(X,Y));
		}
		
		/**
		 * Sometimes its easier or faster to just pass a point object instead of separate X and Y coordinates.
		 * This also gives you the option of not creating a new node but actually adding that specific
		 * <code>AxPoint</code> object to the path.  This allows you to do neat things, like dynamic paths.
		 * 
		 * @param	Node			The point in world coordinates you want to add to the path.
		 * @param	AsReference		Whether to add the point as a reference, or to create a new point with the specified values.
		 */
		public function addPoint(Node:AxPoint,AsReference:Boolean=false):void
		{
			if(AsReference)
				nodes.push(Node);
			else
				nodes.push(new AxPoint(Node.x,Node.y));
		}
		
		/**
		 * Sometimes its easier or faster to just pass a point object instead of separate X and Y coordinates.
		 * This also gives you the option of not creating a new node but actually adding that specific
		 * <code>AxPoint</code> object to the path.  This allows you to do neat things, like dynamic paths.
		 * 
		 * @param	Node			The point in world coordinates you want to add to the path.
		 * @param	Index			Where within the list of path nodes to insert this new point.
		 * @param	AsReference		Whether to add the point as a reference, or to create a new point with the specified values.
		 */
		public function addPointAt(Node:AxPoint,Index:uint,AsReference:Boolean=false):void
		{
			if(Index > nodes.length)
				Index = nodes.length;
			if(AsReference)
				nodes.splice(Index,0,Node);
			else
				nodes.splice(Index,0,new AxPoint(Node.x,Node.y));
		}
		
		/**
		 * Remove a node from the path.
		 * NOTE: only works with points added by reference or with references from <code>nodes</code> itself!
		 * 
		 * @param	Node	The point object you want to remove from the path.
		 * 
		 * @return	The node that was excised.  Returns null if the node was not found.
		 */
		public function remove(Node:AxPoint):AxPoint
		{
			var index:int = nodes.indexOf(Node);
			if(index >= 0)
				return nodes.splice(index,1)[0];
			else
				return null;
		}
		
		/**
		 * Remove a node from the path using the specified position in the list of path nodes.
		 * 
		 * @param	Index	Where within the list of path nodes you want to remove a node.
		 * 
		 * @return	The node that was excised.  Returns null if there were no nodes in the path.
		 */
		public function removeAt(Index:uint):AxPoint
		{
			if(nodes.length <= 0)
				return null;
			if(Index >= nodes.length)
				Index = nodes.length-1;
			return nodes.splice(Index,1)[0];
		}
		
		/**
		 * Get the first node in the list.
		 * 
		 * @return	The first node in the path.
		 */
		public function head():AxPoint
		{
			if(nodes.length > 0)
				return nodes[0];
			return null;
		}
		
		/**
		 * Get the last node in the list.
		 * 
		 * @return	The last node in the path.
		 */
		public function tail():AxPoint
		{
			if(nodes.length > 0)
				return nodes[nodes.length-1];
			return null;
		}
		
		/**
		 * While this doesn't override <code>AxBasic.drawDebug()</code>, the behavior is very similar.
		 * Based on this path data, it draws a simple lines-and-boxes representation of the path
		 * if the visual debug mode was toggled in the debugger overlay.  You can use <code>debugColor</code>
		 * and <code>debugScrollFactor</code> to control the path's appearance.
		 * 
		 * @param	Camera		The camera object the path will draw to.
		 */
		public function drawDebug(Camera:AxCamera=null):void
		{
			if(nodes.length <= 0)
				return;
			if(Camera == null)
				Camera = Ax.camera;
			
			//Set up our global flash graphics object to draw out the path
			var gfx:Graphics = Ax.flashGfx;
			gfx.clear();
			
			//Then fill up the object with node and path graphics
			var node:AxPoint;
			var nextNode:AxPoint;
			var i:uint = 0;
			var l:uint = nodes.length;
			while(i < l)
			{
				//get a reference to the current node
				node = nodes[i] as AxPoint;
				
				//find the screen position of the node on this camera
				_point.x = node.x - int(Camera.scroll.x*debugScrollFactor.x); //copied from getScreenXY()
				_point.y = node.y - int(Camera.scroll.y*debugScrollFactor.y);
				_point.x = int(_point.x + ((_point.x > 0)?0.0000001:-0.0000001));
				_point.y = int(_point.y + ((_point.y > 0)?0.0000001:-0.0000001));
				
				//decide what color this node should be
				var nodeSize:uint = 2;
				if((i == 0) || (i == l-1))
					nodeSize *= 2;
				var nodeColor:uint = debugColor;
				if(l > 1)
				{
					if(i == 0)
						nodeColor = Ax.GREEN;
					else if(i == l-1)
						nodeColor = Ax.RED;
				}
				
				//draw a box for the node
				gfx.beginFill(nodeColor,0.5);
				gfx.lineStyle();
				gfx.drawRect(_point.x-nodeSize*0.5,_point.y-nodeSize*0.5,nodeSize,nodeSize);
				gfx.endFill();

				//then find the next node in the path
				var linealpha:Number = 0.3;
				if(i < l-1)
					nextNode = nodes[i+1];
				else
				{
					nextNode = nodes[0];
					linealpha = 0.15;
				}
				
				//then draw a line to the next node
				gfx.moveTo(_point.x,_point.y);
				gfx.lineStyle(1,debugColor,linealpha);
				_point.x = nextNode.x - int(Camera.scroll.x*debugScrollFactor.x); //copied from getScreenXY()
				_point.y = nextNode.y - int(Camera.scroll.y*debugScrollFactor.y);
				_point.x = int(_point.x + ((_point.x > 0)?0.0000001:-0.0000001));
				_point.y = int(_point.y + ((_point.y > 0)?0.0000001:-0.0000001));
				gfx.lineTo(_point.x,_point.y);

				i++;
			}
			
			//then stamp the path down onto the game buffer
			Camera.buffer.draw(Ax.flashGfxSprite);
		}
		
		static public function get manager():DebugPathDisplay
		{
			return Ax.getPlugin(DebugPathDisplay) as DebugPathDisplay;
		}
	}
}