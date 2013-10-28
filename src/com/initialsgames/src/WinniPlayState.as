package com.initialsgames.src{
	import org.axgl.*;
	
	//import flash.events.ActivityEvent; 
/*	import flash.events.StatusEvent; 
	import flash.media.Microphone; */
 

	
	public class WinniPlayState extends PlayState
	{
		
		public var timerText:AxText;
		public var oldTime:String;
		public var timerCam:AxCamera;
		[Embed(source = "../data/sfx_128/Blip_Select.mp3")] protected var SndBlip:Class;		
		
		override public function create():void
		{
			Ax.hideDebugger();
			
			super.create();
			
			//get rid of the switch players help box for two players.
			for (var i:int = 0; i < helpBoxes.length; i++) {
				if ((helpBoxes.members[i]._helpString == "Press Down And 1 to switch characters.") && (Registry.playersNo==2)    ) {
					helpBoxes.members[i].visible = false;
					helpBoxes.members[i].x = -2000;
					helpBoxes.members[i].y = -2000;
					
				}
			
			}
			
			
			timerText = new AxText(8, Ax.height-32 ,400, Registry.timeLeft.toFixed(0), true);
			timerText.alignment = "left";
			timerText.size = 24;
			timerText.scrollFactor.x = 0;
			timerText.scrollFactor.y = 0;
			timerText.shadow = 0xee000000;
			add(timerText);
			timerText.centerOffsets();
/*			timerCam = new AxCamera(2,Ax.height-timerText.height-2, 40, 25); 
			Ax.addCamera(timerCam);
			timerCam.follow(timerText);*/
			
			helpOverlayTextP1.size = 16;
			if (Registry.playersNo == 2)
				helpOverlayTextP2.size = 16;
			
			if (Registry.attractMode) {
				//timerText.visible = false;
			}
			
			
			
		}

		override public function update():void
		{
/*			var deviceArray:Array = Microphone.names; 
			//trace("Available sound input devices:"); 
			for (var i:int = 0; i < deviceArray.length; i++) 
			{ 
				//trace(" " + deviceArray[i]); 
			}
			 
			var mic:Microphone = Microphone.getMicrophone(); 
			mic.gain = 60; 
			mic.rate = 11; 
			mic.setUseEchoSuppression(true); 
			mic.setLoopBack(true); 
			mic.setSilenceLevel(5, 1000); 
				 
			var micDetails:String = "Sound input device name: " + mic.name + '\n'; 
			micDetails += "Gain: " + mic.gain + '\n'; 
			micDetails += "Rate: " + mic.rate + " kHz" + '\n'; 
			micDetails += "Muted: " + mic.muted + '\n'; 
			micDetails += "Silence level: " + mic.silenceLevel + '\n'; 
			micDetails += "Silence timeout: " + mic.silenceTimeout + '\n'; 
			micDetails += "Echo suppression: " + mic.useEchoSuppression + '\n'; 
			
			if (mic.activityLevel > 30) {
				trace("just talked");
			}*/
			 
				
			

			
			
			//var dist:Number = AxU.getDistance(new AxPoint(player1.x, player1.y), new AxPoint(player2.x, player2.y));
			
			//allCam.alpha = (1 + (dist - 160) * (1 - 0) / (140 - 160));
			
			//cam
			
/*			if (AxU.getDistance(new AxPoint(player1.x, player1.y), new AxPoint(player2.x, player2.y)) < 200) {
				
				allCam.alpha += 0.1;
				
/*				cam.x -= 30;
				cam2.x += 30;
				cam.alpha -= 0.1;
				cam2.alpha -= 0.1;
				
				
				
				//cam.visible = false;
				//cam2.visible = false;
			}
			else {
				
				allCam.alpha -= 0.1;
				
				cam.x = 0;
				cam2.x = Ax.width;
				
				cam.alpha += 0.1;
				cam2.alpha += 0.1;
				
				//cam.visible = true;
				//cam2.visible = true;
			}*/
			
			
			if (  (Ax.keys.pressed(Registry.p1Down) &&  Ax.keys.justPressed(Registry.p1Action)) && (Registry.playersNo == 1)    ) {
				super.switchCharacters(true);
				
			}
			else 
				super.update();
			
			

			
			//timer
			
			oldTime = timerText.text;
			
			if (Registry.timeLeft>=99)
				timerText.text = "99";
			if (Registry.timeLeft<=0) {
				timerText.text = "0";
				Ax.fade(0xffffffff, 3, gameOver);
				//Ax.shake(0.05, 0.5);
				Ax.pauseSounds();
				infoText.text = "GAME OVER";
				
			}
			/*
			else if (Registry.timeLeft <= 1) {
				// TO DO:
				// Game Over;
				timerText.text = "1";
				
			}*/
			else {
				var s:String = Registry.timeLeft.toString();
				var s2:Array = s.split(".", 2);
				//timerText.text = Registry.timeLeft.toFixed(0);
				timerText.text = s2[0];
				
			}
			Registry.timeLeft -= Ax.elapsed;
			//Ax.log(Registry.timeLeft);
			//detect if timer has changed.
			if (oldTime != timerText.text) {
				//Ax.log("change,time:" + Registry.timeLeft);
				if (Registry.timeLeft < 5) {
					Ax.play(SndBlip, 0.9);
					Ax.shake(0.0025, 0.2);
					timerText.scale.x = 2;
					timerText.scale.y = 2;
/*					timerText.x += timerText.width;
					timerText.y += timerText.height;*/
					
					
				}
				
			} else {
				if (timerText.scale.x > 1) {
					timerText.scale.x -= 0.1;
					timerText.scale.y -= 0.1;
				}
				else {
					timerText.scale.x = 1;
					timerText.scale.y = 1;
				}
			}
			
		}
		
		override public function getPickUp(Sprite1:AxSprite, Sprite2:AxSprite):void
		{
			if (Sprite2 is SugarBag)
				Registry.timeLeft += 20;
			if (Sprite2 is SoftDrink)
				Registry.timeLeft += 10;			
				
			infoText.text = "";
				
				
			super.getPickUp(Sprite1, Sprite2);
			
			
			
		}
		
		override public function killCharacter(Sprite1:AxSprite,Sprite2:AxSprite):void
		{
			super.killCharacter(Sprite1, Sprite2);
			
			
			
			
		}
		
		
		
		override public function levelOver():void
		{			
			player1._currentlyControlled = false;
			player2._currentlyControlled = false;
			
			Ax.fade(0xff000000, 1, nextWinniLevel);			
			
		}
		
		
		
		public function nextWinniLevel():void {
			
			
			//trace(Registry.winniNextLevel);
			
			
			if (Registry.winniNextLevel == 1) {
				Ax.playMusic(Registry.SndMega);
				Registry.winniLevel = 1;
				Registry.levelType = 1;
				Registry.level = XML(new Registry.wLevel1); 
				Ax.switchState(new WinniPlayState);
				return;
			}
			else if (Registry.winniNextLevel == 2) {
				Ax.playMusic(Registry.SndIce);
				Registry.winniLevel = 2;
				Registry.levelType = 2;
				Registry.level = XML(new Registry.wLevel2); 
				Ax.switchState(new WinniPlayState);
				return;
			} 
			else if (Registry.winniNextLevel == 3) {
				Ax.playMusic(Registry.SndPirate);
				Registry.winniLevel = 3;
				Registry.levelType = 3;
				Registry.level = XML(new Registry.wLevel3); 
				Ax.switchState(new WinniPlayState);
				return;
			}
			else if (Registry.winniNextLevel == 4) {
				Ax.playMusic(Registry.SndMega);
				Registry.winniLevel = 4;
				Registry.levelType = 1;
				Registry.level = XML(new Registry.wLevel4); 
				Ax.switchState(new WinniPlayState);
				return;
			}
			else if (Registry.winniNextLevel == 5) {
				Registry.endingType = 1;
				Ax.playMusic(Registry.SndIce);
				Registry.winniLevel = 5;
				Registry.levelType = 2;
				Registry.level = XML(new Registry.wLevel5); 
				Ax.switchState(new WinniPlayState);
				return;
			}
			else if (Registry.winniNextLevel == 6) {
				Ax.playMusic(Registry.SndFarewell);
				Registry.winniLevel = 6;
				Registry.levelType = 1;
				Registry.level = XML(new Registry.wLevel6); 
				Ax.switchState(new WinningState);
				return;
			}
			else if (Registry.winniNextLevel == 7) {
				Ax.playMusic(Registry.SndFarewell);
				Registry.winniLevel = 7;
				Registry.levelType = 1;
				Registry.level = XML(new Registry.wLevel6); 
				Ax.switchState(new WinningState);
				return;
			}			
			else {
				Ax.switchState(new WinniMenuState);
			}
			
		}
		
		
		
				
		public function gameOver():void {
			
			if (Registry.timeLeft<=1)
				Ax.switchState(new WinniMenuState);
/*			else
				Ax.fadeStop();*/
			
		}
			
			
		
		
	}
}
