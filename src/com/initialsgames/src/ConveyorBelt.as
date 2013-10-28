package com.initialsgames.src{
	import org.axgl.*;
	import flash.geom.Rectangle;
	import org.flixel.plugin.photonstorm.*;
	

	public class ConveyorBelt extends AxSprite
	{
		
		[Embed(source="../data/conveyorBeltBlockWithEnds.png")] private var ImgConveyorBelt:Class;
		
		/**
		* The speed at which the conveyor belt travels.
		*/
		public var _speed:Number;
		
		public function ConveyorBelt(X:int,Y:int, Speed:Number)
		{
			
			loadGraphic(ImgConveyorBelt, false, false,50,20);
			
			this.x = X;
			this.y = Y;
			_speed = Speed;
			immovable = true;
			
			AxScrollZone.add(this, new Rectangle(5, 0, 40, 20), _speed, 0, true);	
			
		}
		
		override public function update():void
		{
			AxScrollZone.updateX(this, _speed);
			
			super.update();
		}
		
		override public function destroy():void
		{
			
			//	Important! Clear out the scrolling image from the plugin, otherwise resources will get messed right up after a while
			//  AxScrollZone.clear();
			
			super.destroy();
		}
		
		public function setSpeed(Speed:Number):void {
			
		}
		
		
	}
}