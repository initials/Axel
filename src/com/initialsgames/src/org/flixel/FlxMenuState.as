package org.flixel
{
	import org.flixel.system.AxQuadTree;
	
	/**
	 * This is the basic game "state" object - e.g. in a simple game
	 * you might have a menu state and a play state.
	 * It is for all intents and purpose a fancy AxGroup.
	 * And really, it's not even that fancy.
	 * 
	 * @author	Adam Atomic
	 */
	public class AxMenuState extends AxState
	{	
		
		/**
		 * Heading for the menu.
		 */
		public var headingTxt:AxText;
		
		
		/**
		 * This function is called after the game engine successfully switches states.
		 * Override this function, NOT the constructor, to initialize or set up your game state.
		 * We do NOT recommend overriding the constructor, unless you want some crazy unpredictable things to happen!
		 */
		override public function create():void
		{
			headingTxt = new AxText(0, 15, Ax.width, "Default Heading", true);
			headingTxt.color = 0xff000000;
			add(headingTxt);
			
		}
	}
}
