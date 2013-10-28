package com.initialsgames.src{
	import org.axgl.*;
	import org.flixel.plugin.photonstorm.*;
	import org.flixel.plugin.photonstorm.FX.CenterSlideFX;
	import org.flixel.plugin.photonstorm.FX.GlitchFX;
	
	
	
	public class WinningState extends PlayState
	{
		public var winningText:AxText;
		[Embed(source = "../data/logo.png")] private var ImgLogo:Class;
		private var slide:CenterSlideFX;
		private var glitch:GlitchFX;
		public var counter:Number;
		
		
		override public function create():void
		{
			
			super.create();
			
			Ax.playMusic(Registry.SndFarewell, 1.0);
			
			winningText = new AxText(0,Ax.height/4,Ax.width,"You are a winner!\n");
			
			winningText.size = 16;
			winningText.alignment = "center";
			winningText.color = 0x8000FF;
			add(winningText);
			
			if (Registry.endingType == 0) {
				winningText.text = "You are a winner!\nTry to find the real ending.";
				
			}
			if (Registry.winniLevel == 1) {
				winningText.text = "You are a winner!\nThis is the real ending.";
			}
						
			counter = 0;
			
			
			
			var save:AxSave = new AxSave();
			if(save.bind("Mode"))
			{
				if(save.data.completions == null)
					save.data.completions = 0 as Number;
				else
					save.data.completions++;
				save.close();
			}
			
			
			
			
		}

		override public function update():void
		{
			counter += Ax.elapsed;
			if (Ax.keys.justPressed(Registry.homeKey)) {
				onQuit();			
				
			}
			
			if ((Ax.keys.justPressed(Registry.p1Action) || Ax.keys.justPressed(Registry.p2Action) || Ax.keys.justPressed(Registry.p1Jump) || Ax.keys.justPressed(Registry.p2Jump) ) && ( counter > 5)  ) 
			{
				onQuit();			
				
			}
			
			
			super.update();
			
		}
		
		
		private function onQuit():void
		{
			// Go back to the MenuState
			if (Registry.isWinnitron) {
				Ax.switchState(new WinniMenuState);
			}
			else {
				Ax.switchState(new MenuState);
			}
		}
		
		

		
		

		
	}
}
