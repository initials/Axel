package com.initialsgames.src{
	import org.axgl.*;
	import Math;
	
	public class Enemy extends AxSprite
	{
		
		public var limitX:int;
		public var limitY:int;
		public var _talkString:String;
		public var _startingPosition:AxPoint;
		public var _limitPosition:AxPoint;
		public var _originalVelocityX:Number;
		public var _talk:Boolean;
		private var _talkCounter:Number;

		
		public function Enemy(X:int, Y:int, talkString:String)
		{
			_startingPosition = new AxPoint(X, Y);
			
			super(X, Y);
			acceleration.y = 880;
			_talkString = talkString;
			_talkCounter = 0;
			

		}
	
		override public function update():void
		{
			//trace(limitX + " " + limitY + " " + _talkString);
			
			//trace(this.isTouching(AxEntity.LEFT) + "    " + this.isTouching(AxEntity.RIGHT));
			
			if (this._facing == RIGHT  ) {
				if (this.x > limitX ) {
					this.x = limitX;
					this.velocity.x = _originalVelocityX * -1;
					facing = LEFT;
					
				}
				if (this.isTouching(AxEntity.RIGHT)) {
					this.velocity.x = _originalVelocityX * -1;
					facing = LEFT;					
				}
			}
			if (this._facing == LEFT) {
				if (this.x < _startingPosition.x  ) {
					this.x = _startingPosition.x;
					this.velocity.x = _originalVelocityX;
					facing = RIGHT;
					
				}
				if (this.isTouching(AxEntity.LEFT)) {
					//this.velocity.x = _originalVelocityX * -1;
					
					this.velocity.x = _originalVelocityX ;
					facing = RIGHT;					
				}				
			}
			
			if ((this.velocity.x > 1) || (this.velocity.x < -1) ) {
				this.play("walk");
			}
			
			if (_talk) {
				this.velocity.x = 0;
				_talkCounter += Ax.elapsed;
				this.play("talk");
			}
			
			if (_talkCounter > 2) {
				if (this._facing == LEFT)
					this.velocity.x = this._originalVelocityX*-1;
				if (this._facing == RIGHT)
					this.velocity.x = this._originalVelocityX;
										
					
				_talkCounter = 0;
				_talk = false;
			}
			
			super.update();
			
		}
			
	}
}