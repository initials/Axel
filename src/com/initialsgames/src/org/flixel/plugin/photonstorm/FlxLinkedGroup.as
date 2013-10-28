package org.flixel.plugin.photonstorm 
{
	import org.flixel.AxGroup;
	import org.flixel.AxSprite;

	public class AxLinkedGroup extends AxGroup
	{
		
		public function AxLinkedGroup(MaxSize:uint = 0)
		{
			super(MaxSize);
		}
		
		public function addX(newX:int):void
		{
			for each (var s:AxSprite in members)
			{
				s.x += newX;
			}
		}
		
		public function angle(newX:int):void
		{
			for each (var s:AxSprite in members)
			{
				s.angle += newX;
			}
		}
		
	}

}