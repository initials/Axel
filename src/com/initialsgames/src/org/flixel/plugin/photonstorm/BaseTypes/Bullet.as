package org.flixel.plugin.photonstorm.BaseTypes 
{
	import org.flixel.AxPoint;
	import org.flixel.AxSprite;
	import org.flixel.plugin.photonstorm.AxMath;
	import org.flixel.plugin.photonstorm.AxVelocity;
	import org.flixel.plugin.photonstorm.AxWeapon;

	public class Bullet extends AxSprite
	{
		public var id:uint;
		private var weapon:AxWeapon;
		
		private var bulletSpeed:int;
		
		//	Acceleration or Velocity?
		public var accelerates:Boolean;
		public var xAcceleration:int;
		public var yAcceleration:int;
		
		private var animated:Boolean;
		
		public function Bullet(weapon:AxWeapon, id:uint)
		{
			super(0, 0);
			
			this.weapon = weapon;
			this.id = id;
			
			//	Safe defaults
			accelerates = false;
			animated = false;
			bulletSpeed = 0;
			
			exists = false;
		}
		
		/**
		 * Adds a new animation to the sprite.
		 * 
		 * @param	Name		What this animation should be called (e.g. "run").
		 * @param	Frames		An array of numbers indicating what frames to play in what order (e.g. 1, 2, 3).
		 * @param	FrameRate	The speed in frames per second that the animation should play at (e.g. 40 fps).
		 * @param	Looped		Whether or not the animation is looped or just plays once.
		 */
		override public function addAnimation(Name:String, Frames:Array, FrameRate:Number = 0, Looped:Boolean = true):void
		{
			super.addAnimation(Name, Frames, FrameRate, Looped);
			
			animated = true;
		}
		
		public function fire(fromX:int, fromY:int, velX:int, velY:int):void
		{
			x = fromX;
			y = fromY;
			
			if (accelerates)
			{
				acceleration.x = xAcceleration;
				acceleration.y = yAcceleration;
			}
			else
			{
				velocity.x = velX;
				velocity.y = velY;
			}
			
			if (animated)
			{
				play("fire");
			}
			
			exists = true;
		}
		
		public function fireAtMouse(fromX:int, fromY:int, speed:int):void
		{
			x = fromX;
			y = fromY;
			
			if (accelerates)
			{
				AxVelocity.accelerateTowardsMouse(this, speed, maxVelocity.x, maxVelocity.y);
			}
			else
			{
				AxVelocity.moveTowardsMouse(this, speed);
			}
			
			if (animated)
			{
				play("fire");
			}
			
			exists = true;
		}
		
		public function fireAtPosition(fromX:int, fromY:int, toX:int, toY:int, speed:int):void
		{
			x = fromX;
			y = fromY;
			
			if (accelerates)
			{
				AxVelocity.accelerateTowardsPoint(this, new AxPoint(toX, toY), speed, maxVelocity.x, maxVelocity.y);
			}
			else
			{
				AxVelocity.moveTowardsPoint(this, new AxPoint(toX, toY), speed);
			}
			
			if (animated)
			{
				play("fire");
			}
			
			exists = true;
		}
		
		public function fireAtTarget(fromX:int, fromY:int, target:AxSprite, speed:int):void
		{
			x = fromX;
			y = fromY;
			
			if (accelerates)
			{
				AxVelocity.accelerateTowardsObject(this, target, speed, maxVelocity.x, maxVelocity.y);
			}
			else
			{
				AxVelocity.moveTowardsObject(this, target, speed);
			}
			
			if (animated)
			{
				play("fire");
			}
			
			exists = true;
		}
		
		public function fireFromAngle(fromX:int, fromY:int, fireAngle:int, speed:int):void
		{
			x = fromX;
			y = fromY;
			
			var newVelocity:AxPoint = AxVelocity.velocityFromAngle(fireAngle, speed);
			
			if (accelerates)
			{
				acceleration.x = newVelocity.x;
				acceleration.y = newVelocity.y;
			}
			else
			{
				velocity.x = newVelocity.x;
				velocity.y = newVelocity.y;
			}
			
			if (animated)
			{
				play("fire");
			}
			
			exists = true;
		}
		
		public function set xGravity(gx:int):void
		{
			acceleration.x = gx;
		}
		
		public function set yGravity(gy:int):void
		{
			acceleration.y = gy;
		}
		
		public function set maxVelocityX(mx:int):void
		{
			maxVelocity.x = mx;
		}
		
		public function set maxVelocityY(my:int):void
		{
			maxVelocity.y = my;
		}
		
		override public function update():void
		{
			super.update();
			
			if (AxMath.pointInAxRect(x, y, weapon.bounds) == false)
			{
				kill();
			}
		}
		
	}

}