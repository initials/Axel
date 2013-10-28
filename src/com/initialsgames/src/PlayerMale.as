package com.initialsgames.src{
	import org.axgl.*;
	
	public class PlayerMale extends Character
	{
		
		[Embed(source = "../data/chars_50x50.png")] private var ImgPlayer:Class;
		
		[Embed(source = "../data/sfx_128/whoosh.mp3")] protected var SndWhoosh:Class;
		
		public var airDash:Number;
		
		public function PlayerMale(X:int,Y:int,playerNumber:int, talkString:String)
		{
			super(X, Y, playerNumber, talkString);
			
			_playerNumber = playerNumber;			
			
			loadGraphic(ImgPlayer, true, true, 50,80);
						
			//animations
			
			addAnimation("run", [6, 7, 8, 9, 10, 11 ], 18, true);
			//addAnimation("idle", [48, 49, 50, 51], 6, true);
			addAnimation("idle", [51], 0, true);
			addAnimation("not_controlled", [1], 0, true);
			
			addAnimation("onConveyor", [10, 11], 24, true);
			addAnimation("jump", [10, 11], 2, true);
			addAnimation("death", [60, 60, 61, 61, 62, 62, 63, 63], 12, false);
			
			addAnimation("piggyback", [72, 73,74,75,76,77], 12, true);
			addAnimation("piggyback_idle", [78], 0, false);
			addAnimation("piggyback_jump", [76,77,76], 4, true);
			addAnimation("piggyback_dash", [80], 0, false);
			addAnimation("talk", [51,48,51,49,51,50], 6, true);

			
			play("idle", true);
			
			
			
			//this.height = 15;
			//this.offset.y = 10;
			//this.width = 6;

			
			this.width = 10;
			this.height = 41;        
			this.offset.x = 20;
			this.offset.y = 39;
					
			
			//centerOffsets();
					
		}
		
		

		

		
		override public function update():void
		{			
			//trace(this.x, this.y);
			
			if ( (Ax.keys.pressed(Registry.p1Action)|| Ax.joystick.j1ButtonXPressed) && this._curAnim.name!="death" && this._currentlyControlled && !Ax.keys.pressed(Registry.p1Down) && (levelOver==false) ) { // && ! this._curAnim.name=="death"
				this._talk = false;
				airDash += Ax.elapsed;
				if (Ax.keys.justPressed(Registry.p1Action) || Ax.joystick.j1ButtonXJustPressed) {
					Ax.play(SndWhoosh, 0.1, false, true);
					
				}
				if (airDash<=0.5) {
					if (this._facing==RIGHT)
						this.velocity.x = 500;
					else if (this._facing == LEFT)
						this.velocity.x = -500;
				}
			}
			else {
				airDash = 0;
			}
			
			if (this.dead) {
				airDash = 0;
			}
			
			super.update();
		}
	
	}
}