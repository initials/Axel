package com.initialsgames.src{
	import org.axgl.*;
	import org.flixel.plugin.photonstorm.*;
	import org.flixel.plugin.photonstorm.FX.CenterSlideFX
	
	import flash.net.FileReference;
	import flash.net.FileFilter;
	import flash.events.IOErrorEvent;
	import flash.events.Event;
	import flash.utils.ByteArray;
	
	
	
	public class PasswordState extends AxState
	{
		
		public var p1:Boolean;
		public var p2:Boolean;
		public var p3:Boolean;
		public var p4:Boolean;
		public var p5:Boolean;
		public var count:int;
		public var txtLevel:AxText ;
		

		override public function create():void
		{
			
			
			
			Ax.bgColor = 0xffF8CB8F;
			p1 = false;
			p2 = false;
			p3 = false;
			p4 = false;
			p5 = false;
			count = 0;
						
			
			txtLevel= new AxText(0, 14, Ax.width, "Click to start");
			txtLevel.size = 24;
			txtLevel.alignment = "left";
			add(txtLevel);
			
			Ax.mouse.show();
			
			
		}

		override public function update():void
		{
			
			
			if (Ax.mouse.justPressed() ) {
				txtLevel.text = "Enter password";
			}
			
			super.update();
			
			if (Ax.keys.justPressed("K") && count==0 ){
				p1 = true;
				count++;
			}
			if (Ax.keys.justPressed("A") && count==1) {
				p2 = true;
				count++;

			}
			if (Ax.keys.justPressed("P") && count==2) {
				p3 = true			
				count++;

				
			}
			if (Ax.keys.justPressed("U")  && count==3){
				p4 = true;
				count++;

			}
			if (Ax.keys.justPressed("T")  && count==4){
				p5 = true;
				count++;

			}	
			
			
			
			if (p1==true && p2== true && p3==true && p4==true && p5==true) {
				Ax.switchState(new MenuState());
			}
						

								
		}


		
	}
}
