package
{
	import org.axgl.*;
	import org.flashdevelop.utils.FlashConnect;
	import Math;
	

	public class Player extends AxSprite
	{
		
		[Embed(source="../data/chars_50x50.png")] private var ImgPlayer:Class;
		public var coinVel:Number;
		public var trick:String = "";
		public var _jump:Number;
		public var _powerUpTimer:Number = 6;
		public var _wallJump:Number;
		public var _onWall:Boolean;
		public var _playerNumber:int;
		public var _doubleJump:Boolean = false;
		public var _numberOfJumps:int = 0;
		public var _onLadder:Boolean = false;
		public var _usingLadder:Boolean = false;
		
		
		
		public function Player(X:int,Y:int,playerNumber:int)
		{

			//Ax.gamepads[0].bind("UP", "DOWN", "LEFT", "RIGHT", "X", "V", "C", "B");

			super(X, Y);

			
			loadGraphic(ImgPlayer, true, true, 50);
			//if (playerNumber == 1) color = 0x00FF00;
			//if (playerNumber == 2) color = 0xFF8040;
			//var rot:AxSprite = loadRotatedGraphic(ImgBike,16,0);
			
			//basic player physics
			var runSpeed:uint = 80;
			drag.x = runSpeed*8;
			acceleration.y = 720;
			maxVelocity.x = runSpeed+80;
			maxVelocity.y = 200;
			
			
			
			//offset.x = 8;
			//offset.y = 8;
			
			
			_onWall = false;
			
			//animations
			
			if (playerNumber==1) {
				addAnimation("run", [6, 7, 8, 9, 10, 11 ], 18, true);
				addAnimation("idle", [48, 49, 50, 51], 6, true);
				
			}
			else if (playerNumber==2) {
				addAnimation("run", [12, 13, 14, 15, 16, 17 ], 18, true);
				addAnimation("idle", [2], 0, true);
				
			}
			
			play("idle", true);
			_playerNumber = playerNumber;
			
			//collideBottom = false;
			//collideTop = false;
			this.width = 6;
			
			centerOffsets();
			
			this.height = 15;
			this.offset.y = 10;
		}
		
		
		
		
/*		override public function hitSide(Contact:AxEntity,Velocity:Number):void { 
				_wallJump = 0;
				_jump = -1;
				//return super.hitSide(Contact, Velocity);
				_onWall = true;
				play("wallStall", true);
				

		}
		
		override public function hitBottom(Contact:AxEntity,Velocity:Number):void
		{
			_numberOfJumps = 0;
			_jump = 0;
			acceleration.y = 600;
			onFloor = true;
			_usingLadder = false;
			
			//Ax.log("Vel = " + velocity.y);
			
			return super.hitBottom(Contact, Velocity);
		}*/
		
		public function turnOnDoubleJump():void {
			_doubleJump = true;
			_powerUpTimer = 0;
			
		}
		
		public function jump():void {
			
			//trace("did a jump");

			var key:String = "";
			if (_playerNumber == 1)
				key = "Z";
			else if (_playerNumber == 2) 
				key = "N";
				

			
			//if ( ((Ax.keys.justPressed(key))  || (Ax.gamepads[0].A)    ) && (onWall) ) {
			if ( ((Ax.keys.justPressed(key))      ) && (_onWall) ) {
				velocity.x = -velocity.x;
				_jump = 0;
			}
			
			if( ((_jump >= 0)  ) && (Ax.keys.Z )  ) 
			{	
				Ax.log("ok jump");
				_jump += Ax.elapsed;
				if (_jump > 0.25) {
					_jump = -1;
					
				}
			}
			else {
					_jump = -1;
				
			}
				
			
			if(_jump > 0)
			{
				if(_jump < 0.065) {
					velocity.y = -180;
					//Ax.log("TOP");
				}
				else {
					velocity.y = -180;
					//Ax.log("BOTTOM");
				}
			}
			

			
/*			if (trick == "") {
				if (onFloor) {
						//this.velocity.x = -coinVel;
						play("pedal");
					}
					else {
						//this.velocity.x = 0;
						play("idle");
					}
			}
			else {
				play(trick);
			}*/
			
		}
		
		override public function update():void
		{
/*			if(Ax.keys.justPressed("SPACE") && this.isTouching(AxEntity.FLOOR))
				this.velocity.y = -this.maxVelocity.y * 6.65;*/
				
			
			var key:String = "";
			if (_playerNumber == 1)
				key = "Z";
			else if (_playerNumber == 2) 
				key = "N";
			//if (_playerNumber==1) Ax.log(velocity.y);
			
			if ( (Ax.keys.justPressed(key))  &&  ( (_numberOfJumps < 2)   )  && (_doubleJump)       ) {
				 
				_numberOfJumps++;
				velocity.y = -1000;
				 
			}
			
			jump();
			
			acceleration.x = 0;
			
			//if (_playerNumber == 1) Ax.log(velocity.y + " " + acceleration.y);
			
			if ( (_onLadder == true) && ( (AxU.abs(velocity.y) > 75 ) ) )  {
				play("climbLadder");
			}
			else if (_onLadder == true) play("stallLadder");
			else if (velocity.x == 0) play("idle");
			else play("run");
			//Ax.log(velocity.x);
			
			if (_playerNumber == 1) {
				//if( ( Ax.keys.LEFT) || (Ax.gamepads[0].LEFT) )
				if( ( Ax.keys.LEFT)  )
				{
					facing = LEFT;
					acceleration.x -= drag.x/1.6;
					//velocity.x -= 10;
				}
				//else if( ( Ax.keys.RIGHT) || (Ax.gamepads[0].LEFT) )
				else if( ( Ax.keys.RIGHT)  )
				{
					facing = RIGHT;
					acceleration.x += drag.x/1.6;
					//velocity.x += 10;
				} 
				if (_onLadder == true) {
					
					//velocity.y = 0;
					if (_usingLadder) {
						velocity.y = 0;
						acceleration.y = 0;
					}
					if ( (Ax.keys.UP)  )
					{
						_usingLadder = true;
						velocity.y = -100;
					}
					else if(Ax.keys.DOWN)
					{
						_usingLadder = true;
						velocity.y = 100;
					}
				}
				else acceleration.y = 600;
				_onLadder = false;
				
				
			}

			
			if (_playerNumber == 2) {
				//if( ( Ax.keys.LEFT) || (Ax.gamepads[0].LEFT) )
				if( ( Ax.keys.J)  )
				{
					facing = LEFT;
					acceleration.x -= drag.x;
					//velocity.x -= 10;
				}
				//else if( ( Ax.keys.RIGHT) || (Ax.gamepads[0].LEFT) )
				else if( ( Ax.keys.L)  )
				{
					facing = RIGHT;
					acceleration.x += drag.x;
					//velocity.x += 10;
				} 
				if (_onLadder == true) {
					
					//velocity.y = 0;
					if (_usingLadder) {
						velocity.y = 0;
						acceleration.y = 0;
					}
					if ( (Ax.keys.I)  )
					{
						_usingLadder = true;
						velocity.y = -100;
					}
					else if(Ax.keys.K)
					{
						_usingLadder = true;
						velocity.y = 100;
					}
				}
				else acceleration.y = 600;
				_onLadder = false;
				
				
			}
			
			
			
			
			
			
			
			if (this.scale.x > 1) this.scale.x -= .05;
			if (this.scale.y > 1) this.scale.y -= .05;
			
			
			_powerUpTimer += Ax.elapsed;
			if (_powerUpTimer > 6) {
				_doubleJump = false;
				//this.flickering = false;
				
			} else {
				//flicker(0);
			}
			
			//wrap around.
			//if (this.x < 2) this.x = Ax.width -2;
			//else if (this.x > Ax.width-2) this.x = 2;
			
			super.update();
		}
		
	}
}