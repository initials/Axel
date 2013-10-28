package com.initialsgames.src{
	import org.axgl.*;
	import org.flixel.plugin.photonstorm.*;
	import org.flixel.plugin.photonstorm.FX.CenterSlideFX
	
	import flash.net.FileReference;
	import flash.net.FileFilter;
	import flash.events.IOErrorEvent;
	import flash.events.Event;
	import flash.utils.ByteArray;
    import flash.display.StageDisplayState;

	
	
	public class WinniMenuState extends AxState
	{
		[Embed(source = "../data/logo.png")] private var ImgLogo:Class;
		[Embed(source = "../data/level1/largeCrate.png")] private var ImgLargeCrate:Class;
		[Embed(source = "../data/level1/palettes.png")] private var ImgPalettes:Class;
		[Embed(source = "../data/smallCrate.png")] private var ImgSmallCrate:Class;
		[Embed(source = "../data/smallSugarBag.png")] private var ImgSmallSugarBag:Class;
		[Embed(source = "../data/level1/sodaPack.png")] private var ImgSodaPack:Class;
		[Embed(source = "../data/level1/sugarBags.png")] private var ImgSugarBags:Class;
		//[Embed(source = "../data/tiles.png")] private var ImgTiles:Class;	
		[Embed(source = "../data/level1_tiles.png")] private var ImgTiles:Class;
	
		[Embed(source = "../data/sfx_128/Blip_Select.mp3")] protected var SndBlip:Class;	
		[Embed(source = "../data/sfx_128/initials_empire_tagtone3.mp3")] protected var SndStart:Class;	
		
		[Embed(source = "../data/sfx_128/ping.mp3")] protected var SndPing:Class;		
		[Embed(source = "../data/sfx_128/ping2.mp3")] protected var SndPing2:Class;	
	
		[Embed(source="../data/attractMode/_replay1.fgr",mimeType="application/octet-stream")] public var Attract1:Class;
		[Embed(source="../data/attractMode/_replay2.fgr",mimeType="application/octet-stream")] public var Attract2:Class;
		public var andre:PlayerMale;
		public var liselot:PlayerFemale;
		public var konamiCode:int;
		
		/**
		 * Internal tracker to scale up text describing one or two player.
		 */
		public var _scaleTracker:int;
		
		
		//[Embed(source = '../data/SLF_levelEditor/w_level1.oel', mimeType = 'application/octet-stream')] private var Level1:Class;
		
		//	Test specific variables
		private var slide:CenterSlideFX;
		private var scratch:AxSprite;
		private var glitchAmount:int;
		
		public var ground:AxTilemap;
		public var ground2:AxTileblock;
		
		public var _isFading:Boolean;
		
		
		public var collideGroup:AxGroup;
		public var collideGroup2:AxGroup;
		
		public var play:AxButton ;
		public var playBuiltInLevels:AxButton ;
		
		public var txtLevel:AxText;
		public var txtPlayersNo:AxText;
		
		public var player1Text:AxText;
		public var player2Text:AxText;
		
		
		//FileReference Class well will use to load data
		private var fr:FileReference;

		//File types which we want the user to open
		private static const FILE_TYPES:Array = [new FileFilter("Ogmo Level File", "*.oel")];
		
		public var currentLevel:AxText;
		
		public var ping:AxSound;
		public var timer:Number;
		

		//called when the user clicks the load file button
		private function onLoadFileClick():void
		{
			//create the FileReference instance
			fr = new FileReference();

			//listen for when they select a file
			fr.addEventListener(Event.SELECT, onFileSelect);

			//listen for when then cancel out of the browse dialog
			fr.addEventListener(Event.CANCEL,onCancel);

			//open a native browse dialog that filters for text files
			fr.browse(FILE_TYPES);
		}

		/************ Browse Event Handlers **************/

		//called when the user selects a file from the browse dialog
		private function onFileSelect(e:Event):void
		{
			//listen for when the file has loaded
			fr.addEventListener(Event.COMPLETE, onLoadComplete);

			//listen for any errors reading the file
			fr.addEventListener(IOErrorEvent.IO_ERROR, onLoadError);

			//load the content of the file
			fr.load();
			
			
			
		}

		//called when the user cancels out of the browser dialog
		private function onCancel(e:Event):void
		{
			trace("File Browse Canceled");
			fr = null;
		}

		/************ Select Event Handlers **************/

		//called when the file has completed loading
		private function onLoadComplete(e:Event):void
		{
			//get the data from the file as a ByteArray
			var data:ByteArray = fr.data;
			
			Registry.level = XML(data); 

			//read the bytes of the file as a string and put it in the
			//textarea
			//outputField.text = data.readUTFBytes(data.bytesAvailable);
			
			currentLevel.text = fr.name;
			
			Registry.levelName = fr.name;
			
			//clean up the FileReference instance

			fr = null;
			
			play.visible = true;
		}

		//called if an error occurs while loading the file contents
		private function onLoadError(e:IOErrorEvent):void
		{
			trace("Error loading file : " + e.text);
		}
		
		
		
		override public function create():void
		{

			// Make full screen for Winnitron Machines.
			Ax.stage.displayState = StageDisplayState.FULL_SCREEN;

			
			Ax.mouse.hide();
			
			konamiCode = 0;
			
			
			
			_isFading = false;
			
			
			Registry.level = XML(new Registry.Level1);
			
			ping = new AxSound();
			ping.loadEmbedded(SndBlip);
			ping.volume = 0.5;
			
			Ax.playMusic(Registry.SndEcho, 1.0);
			
			
			//Ax.bgColor = 0xffdedbc3;
			
			//	Make the gradient retro looking and "chunky" with the chucnkSize parameter (here set to 4)
			var gradient2:AxSprite = AxGradient.createGradientAxSprite(530, 384, [0xffcac5ac, 0xffd6d3ba, 0xffdfdcc4], 20 );
			gradient2.x = 0;
			gradient2.y = 0;
			add(gradient2);
			
			player1Text = new AxText(20,Ax.height/2,Ax.width,"Press Player 1\nbutton 1 or 2\nfor one player.");
			player1Text.size = 16;
			player1Text.alignment = "left";
			player1Text.color = 0x8000FF;
			add(player1Text);
			
			player2Text = new AxText(0,Ax.height/2,Ax.width-20,"Press Player 2\nbutton 1 or 2\nfor two players.");
			player2Text.size = 16;
			player2Text.alignment = "right";
			player2Text.color = 0x8000FF;
			
			add(player2Text);
			
			var presentsText:AxText = new AxText(0,28,Ax.width,"Initials Video Games Presents");
			presentsText.size = 8;
			presentsText.alignment = "center";
			presentsText.color = 0x8000FF;
			
			add(presentsText);
			
			
			
				
			Registry.levelType = 1;
			Registry.playersNo = 1;
			Registry.attractMode = false;
			
			
			//	Test specific
			if (Ax.getPlugin(AxSpecialFX) == null)
			{
				Ax.addPlugin(new AxSpecialFX);
			}
			
			var pic:AxSprite = new AxSprite(0, 0, ImgLogo);
			
			//	Create the Slide FX
			slide = AxSpecialFX.centerSlide();
			
			//	Here we'll create it from an embedded PNG, positioned at 0,0 and it'll do a vertical reveal to start with
			pic = slide.createFromClass(ImgLogo, 0, 0, CenterSlideFX.REVEAL_VERTICAL);
			pic.x = Ax.width / 2 - pic.width / 2;
			pic.y = (Ax.height / 2 - pic.height / 2 ) - 80;
			
			add(pic);
			
			slide.start();
			
			
			//Ax.watch(Ax.mouse, "x", "X");
			//Ax.watch(Ax.mouse, "y", "Y");
			
			collideGroup = new AxGroup();
			

			
			
			
			
			
			
				
				
			
			for ( var i:int = 0; i < 5; i++) {
				var sugarBag:AxSprite = new AxSprite(i * 80, 5 * Ax.random()*3 + Ax.height/2, ImgSugarBags);
				sugarBag.acceleration.y = 150;
				collideGroup.add(sugarBag);
				
				var largeCrate:AxSprite = new AxSprite(i * 130 , 5 * Ax.random()*3 + Ax.height/2, ImgLargeCrate);
				largeCrate.acceleration.y = 160;
				collideGroup.add(largeCrate);
				
				
			}
			
			add(collideGroup);
			
			andre = new PlayerMale(105, 100, 1, "");
			add(andre);
			
			liselot = new PlayerFemale(Ax.width - 120, 100, 2, "");
			add(liselot);
			
			andre._currentlyControlled = false;
			liselot._currentlyControlled = false;
			liselot.facing = AxEntity.LEFT;
			andre.drag.x = 0;
			liselot.drag.x = 0;
			
			collideGroup2 = new AxGroup();
			for ( i = 0; i < 4; i++) {
				
				var palettes:AxSprite = new AxSprite(i * Ax.width/3 , 5 * Ax.random()*2 + Ax.height/2, ImgPalettes);
				palettes.acceleration.y = 160;
				collideGroup2.add(palettes);
			}
				
				
				
			
			add(collideGroup2);
			
			
/*			//Design your platformer level with 1s and 0s (at 40x30 to fill 320x240 screen)
			var data:Array = new Array(
				0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
				0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
				0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
				0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
				0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
				0, 1,
				1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
				1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
				1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
				);
			
			//Create a new tilemap using our level data
			ground = new AxTilemap();
			ground.loadMap(AxTilemap.arrayToCSV(data, 51), ImgTiles, 10, 10, AxTilemap.AUTO);
			ground.y = Ax.height - 30;
			add(ground);*/
			
			
			ground2 = new AxTileblock(1, Ax.height - 40,Ax.width-2,40);
			ground2.loadTiles(ImgTiles,10,10,0,true);
			add(ground2);
			
			
			timer = 0;
			
			
			var save:AxSave = new AxSave();
			if(save.bind("Mode"))
			{
				if(save.data.plays == null)
					save.data.plays = 0 as Number;
				else
					save.data.plays++;
				Ax.log("Number of plays:       " + save.data.plays);
				Ax.log("Number of completions: " + save.data.completions);
				//save.erase();
				save.close();
			}
			
			
			
			
		}

		override public function update():void
		{
/*			if (Ax.keys.justPressed("TWO")) {
				timer = 9.9;
			}
			if (Ax.keys.justPressed("THREE")) {
				Registry.playersNo = 1;
				Registry.winniLevel = 3;
				Registry.levelType = 3;
				Registry.level = XML(new Registry.Level3); 
				Ax.switchState(new WinniPlayState());
			}
			if (Ax.keys.justPressed("FOUR")) {
				Registry.playersNo = 2;
				this.playBuiltInLevel();
			}*/			
			
			timer += Ax.elapsed;
			if(timer >= 10 && !_isFading) {
				Registry.timeLeft = Registry.timeAtStart;
				Registry.level = XML(new Registry.Level1); 
				Registry.levelName = "Demo Level 1";
				Registry.levelType = 1;
				Registry.playersNo = 1;
				Registry.isPlayingDemo = true;
				Registry.demoLevel = 1;
				Registry.winniLevel = 1;
				Registry.attractMode = true;
				var randomNo:Number = Ax.random();
								
				Ax.loadReplay((randomNo < 0.5)?(new Attract1()):(new Attract2()), new WinniPlayState(), ["Z", "X", "N", "M", "ANY", "MOUSE"], 22, onDemoComplete);
				if (randomNo > 0.5) {
					Registry.playersNo = 1;
					Registry.winniLevel = 3;
					Registry.levelType = 3;
					Registry.level = XML(new Registry.Level3); 
				}
				else {
					Registry.playersNo = 1;
					Registry.winniLevel = 1;
					Registry.levelType = 1;
					Registry.level = XML(new Registry.Level1); 

				}
			}
				
			
			Ax.collide(collideGroup,ground2);
			Ax.collide(collideGroup2,ground2);
			Ax.collide(andre,ground2);
			Ax.collide(liselot,ground2);
			
			super.update();
			
			if ((Ax.keys.justPressed(Registry.p1Action) ||   Ax.keys.justPressed(Registry.p1Jump)) && !_isFading ) {
				//Ax.fade(0xffF8CB8F, 1, playBuiltInLevel);
				Registry.playersNo = 1;
				
				_scaleTracker = 1;
				
				_isFading = true;
				andre.velocity.x = 250;
				liselot.velocity.x = -250;
				
				for (var i:int = 0; i < collideGroup.length; i++) {
					collideGroup.members[i].fadeToBlack( 1.0);
					
				}
				for (i = 0; i < collideGroup2.length; i++) {
					collideGroup2.members[i].fadeToBlack( 1.0);
					
				}
				
				Ax.play(SndStart, 1.0, false, true);
				
			}
			else if ((  Ax.keys.justPressed(Registry.p2Action) ||   Ax.keys.justPressed(Registry.p2Jump)) && !_isFading ) {
				//Ax.fade(0xffF8CB8F, 1, playBuiltInLevel);
				Registry.playersNo = 2;
				_scaleTracker = 2;
				
				
				_isFading = true;
				andre.velocity.x = 250;
				liselot.velocity.x = -250;
				
				for (i = 0; i < collideGroup.length; i++) {
					collideGroup.members[i].fadeToBlack( 1.0);
					
				}
				for (i = 0; i < collideGroup2.length; i++) {
					collideGroup2.members[i].fadeToBlack( 1.0);
					
				}
				Ax.play(SndStart, 1.0, false, true);
			}
			
			if (_scaleTracker == 1) {
				//player1Text.velocity.x =  550;
				//player1Text.velocity.y =  -250;
				//player1Text.scale.x += 0.05;
				//player1Text.scale.y += 0.05;
				player1Text.size = 24;
				player1Text.text = "ONE PLAYER MODE";
				
				player2Text.alpha -= 0.1;
				
				
			}
			
			else if (_scaleTracker == 2) {
				//player2Text.velocity.x =  -550;
				//player2Text.velocity.y =  -250;
				//player2Text.scale.x += 0.05;
				//player2Text.scale.y += 0.05;
				
				player2Text.size = 24;
				player2Text.text = "TWO PLAYER MODE";
				
				player1Text.alpha -= 0.1;
				
				
			}
			
			
/*			if (Ax.keys.justPressed("SEVEN")) {
				Ax.switchState(new WinningState());
			}*/
			
			
			
			if (andre.x > liselot.x-10) {
				
				andre.velocity.x = 0;
				liselot.velocity.x = 0;
				
				Ax.fade(0xffdedbc3, 1, playBuiltInLevel);
			}
			

			if (Ax.keys.justPressed(Registry.p2Up)) {
				if (konamiCode == 0)
					konamiCode = 1;
				else if (konamiCode == 1)
					konamiCode = 2;
				else
					konamiCode = 0;
				
				
			}
			if (Ax.keys.justPressed(Registry.p2Down)) {
				if (konamiCode == 2)
					konamiCode = 3;
				else if (konamiCode == 3)
					konamiCode = 4;
				else
					konamiCode = 0;
				
			}
			if (Ax.keys.justPressed(Registry.p2Left)) {
				if (konamiCode == 4)
					konamiCode = 5;
				else if (konamiCode == 6)
					konamiCode = 7;
				else
					konamiCode = 0;
				
				
			}
			if (Ax.keys.justPressed(Registry.p2Right)) {
				if (konamiCode == 5)
					konamiCode = 6;
				else if (konamiCode == 7)
					konamiCode = 8;
				else
					konamiCode = 0;
				
			}
			if (Ax.keys.justPressed(Registry.p2Jump)) {
				if (konamiCode == 8)
					konamiCode = 9;
				else
					konamiCode = 0;
				
				
			}
			if (Ax.keys.justPressed(Registry.p2Action)) {
				if (konamiCode == 9)
					konamiCode = 10;
				else
					konamiCode = 0;
				
			}
			if (konamiCode==10) {
				Ax.showDebugger();
				konamiCode = 0;
			}
			
		}
		
		
		public function playBuiltInLevel():void {
			Ax.playMusic(Registry.SndMega, 1.0);
			//Ax.play(SndPing2, 0.75, false, true);
			Registry.timeLeft = Registry.timeAtStart;
			Registry.level = XML(new Registry.wLevel1); 
			Registry.levelName = "Demo Level 1";
			Registry.levelType = 1;
			Registry.isPlayingDemo = true;
			Registry.demoLevel = 1;
			Registry.winniLevel = 1;
			Ax.switchState(new WinniPlayState());
			
		}
		
		
		

		override public function destroy():void
		{
			//	Important! Clear out the plugin, otherwise resources will get messed right up after a while
			AxSpecialFX.clear();
			
			super.destroy();
		}
		
		//This function is called by Ax.loadReplay() when the replay finishes.
		//Here, we initiate another fade effect.
		protected function onDemoComplete():void
		{
			Ax.fade(0xff131c1b,1,onDemoFaded);
		}
		
		//Finally, we have another function called by Ax.fade(), this time
		//in relation to the callback above.  It stops the replay, and resets the game
		//once the gameplay demo has faded out.
		protected function onDemoFaded():void
		{
			Ax.stopReplay();
			Ax.resetGame();
		}
		
		

		
	}
}
