package com.initialsgames.src
{
	import org.axgl.*;
	
	
	import org.flixel.plugin.photonstorm.*;
	import org.flixel.plugin.photonstorm.FX.CenterSlideFX
	
	import flash.net.FileReference;
	import flash.desktop.NativeApplication;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	
	
	public class PCMenuState extends AxState
	{
		[Embed(source = "../data/largeCrate.png")] private var ImgLargeCrate:Class;
		[Embed(source = "../data/level1/palettes.png")] private var ImgPalettes:Class;
		[Embed(source = "../data/smallCrate.png")] private var ImgSmallCrate:Class;
		[Embed(source = "../data/smallSugarBag.png")] private var ImgSmallSugarBag:Class;
		[Embed(source = "../data/sodaPack.png")] private var ImgSodaPack:Class;
		[Embed(source = "../data/sugarBags.png")] private var ImgSugarBags:Class;
		[Embed(source = "../data/tiles.png")] private var ImgTiles:Class;		
		[Embed(source = "../data/bubble.png")] private var ImgLeaves:Class;
		
		[Embed(source = "../data/level1/sugarBagsAndCrates.png")] private var ImgSugarBagsAndCrate:Class;
		[Embed(source = "../data/level1/L1_Shelf.png")] private var ImgShelf:Class;
		
		[Embed(source = "../data/sfx_128/ping.mp3")] protected var SndPing:Class;		
		[Embed(source = "../data/sfx_128/ping2.mp3")] protected var SndPing2:Class;		
		
		[Embed(source = '../data/SLF_levelEditor/level1.oel', mimeType = 'application/octet-stream')] private var Level1:Class;
		
		private var loader:URLLoader;
		
		
		//	Test specific variables
		private var slide:CenterSlideFX;
		private var scratch:AxSprite;
		private var glitchAmount:int;
		
		public var ground:AxTilemap;
		
		public var collideGroup:AxGroup;
		
		public var buttonsGroup:AxGroup;
		
		public var playBtn:AxButton ;
		public var optionsBtn:AxButton ;
		public var helpBtn:AxButton ;
		public var creditsBtn:AxButton ;
		public var customBtn:AxButton ;
		public var oldSchoolBtn:AxButton ;
		
		public var txtLevel:AxText;
		public var txtPlayersNo:AxText;
		
		private var _bubbles:AxEmitter;
		
		public var ping:AxSound;
		public var ping2:AxSound;
		
		private var bgBags:AxSprite;
		private var bgShelf:AxSprite;
		
		private var versionText:AxText ;
		private var latestText:AxText ;
		
		override public function create():void
		{
			Registry.oldSchoolMode = false;
			
			ping = new AxSound();
			ping.loadEmbedded(Registry.SndBlip);
			ping.volume = 0.5;
			
			ping2 = new AxSound();
			ping2.loadEmbedded(Registry.SndPing);			
			
			
			Ax.playMusic(Registry.SndEcho, 1.0);
			
			
			Ax.bgColor = 0xffF8CB8F;
			
			//	Make the gradient retro looking and "chunky" with the chucnkSize parameter (here set to 4)
			var gradient2:AxSprite = AxGradient.createGradientAxSprite(Ax.width, Ax.height, [0xffcac5ac, 0xffdedbc3 , 0xffdfdcc4], 10 ); //0xffd6d3ba
			gradient2.x = 0;
			gradient2.y = 0;
			add(gradient2);
			
			
			
			//Bubbles
			var gibs:AxEmitter = new AxEmitter(0,Ax.height);
			gibs.setSize(Ax.width,0);
			gibs.setXSpeed(-15,15);
			gibs.setYSpeed(-5,-20);
			gibs.setRotation(0,0);
			gibs.gravity = -20;
			gibs.makeParticles(ImgLeaves,100,8,true,0);
			add(gibs);
			gibs.start(false, 0, 0.05);	
			
			
			bgBags = new AxSprite(0, 0, ImgSugarBagsAndCrate);
			bgBags.y = Ax.height - bgBags.height;
			add(bgBags);
			
			bgShelf = new AxSprite(110, 110, ImgShelf);
			bgShelf.x = Ax.width - bgShelf.width;			
			bgShelf.y = Ax.height - bgShelf.height;
			add(bgShelf);			
			
			//	Test specific
			if (Ax.getPlugin(AxSpecialFX) == null)
			{
				Ax.addPlugin(new AxSpecialFX);
			}
			
			var pic:AxSprite = new AxSprite(0, 0, Registry.ImgLogo);
			
			//	Create the Slide FX
			slide = AxSpecialFX.centerSlide();
			
			//	Here we'll create it from an embedded PNG, positioned at 0,0 and it'll do a vertical reveal to start with
			pic = slide.createFromClass(Registry.ImgLogo, 0, 0, CenterSlideFX.REVEAL_VERTICAL);
			pic.x = Ax.width / 2 - pic.width / 2;
			pic.y = (Ax.height / 2 - pic.height / 2 ) - 110;
			
			add(pic);
			
			slide.start();
			

			//Ax.watch(Ax.mouse, "x", "X");
			//Ax.watch(Ax.mouse, "y", "Y");
			
/*			collideGroup = new AxGroup();
			
			for ( var i:int = 0; i < 10; i++) {
				var sugarBag:AxSprite = new AxSprite(i * 30 * Ax.random()*10, -i * 50 * Ax.random()*10, ImgSugarBags);
				sugarBag.acceleration.y = 150;
				collideGroup.add(sugarBag);
				
				var palettes:AxSprite = new AxSprite(i * 30 * Ax.random()*10, -i * 50 * Ax.random()*10, ImgPalettes);
				palettes.acceleration.y = 160;
				collideGroup.add(palettes);
				
				var largeCrate:AxSprite = new AxSprite(i * 30 * Ax.random()*10, -i * 50 * Ax.random()*10, ImgLargeCrate);
				largeCrate.acceleration.y = 160;
				collideGroup.add(largeCrate);
				
				
			}
			
			add(collideGroup);*/
			
			
			//Design your platformer level with 1s and 0s (at 40x30 to fill 320x240 screen)
/*			var data:Array = new Array(
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
			
			if (Registry.mouseEnabled)
				Ax.mouse.show();
			else
				Ax.mouse.hide();
			
			buttonsGroup = new AxGroup();
			
			playBtn = new AxButton(Ax.width / 2 - 40, Ax.height / 2 - 20 , "Play", this.onLevelSelect);
			playBtn.soundOver = ping;
			playBtn.soundDown = ping2;
			playBtn.color = 0xC082FF;
			playBtn.label.color = 0xffffff;
			buttonsGroup.add(playBtn);
			
			playBtn.highlightedText = "Factory Floor";

			playBtn.status = AxButton.HIGHLIGHT;
			
			
			
			optionsBtn = new AxButton(Ax.width / 2 - 40, Ax.height / 2 + 10, "options", this.onOptions );
			optionsBtn.soundOver = ping;
			optionsBtn.soundDown = ping2;
			optionsBtn.color = 0xC082FF;
			optionsBtn.label.color = 0xffffff;
			buttonsGroup.add(optionsBtn);	
			optionsBtn.highlightedText = "Output Ratio";

			helpBtn = new AxButton(Ax.width / 2 - 40, Ax.height / 2 + 40, "help", this.onHelp);
			helpBtn.soundOver = ping;
			helpBtn.soundDown = ping2;			
			helpBtn.color = 0xC082FF;
			helpBtn.label.color = 0xffffff;
			buttonsGroup.add(helpBtn);			
			helpBtn.highlightedText = "Customer Service";

			creditsBtn = new AxButton(Ax.width / 2 - 40, Ax.height / 2 + 70, "credits", this.onCredits);
			creditsBtn.soundOver = ping;
			creditsBtn.soundDown = ping2;
			creditsBtn.color = 0xC082FF;
			creditsBtn.label.color = 0xffffff;
			buttonsGroup.add(creditsBtn);
			creditsBtn.highlightedText = "Ingredients";
			
			
			customBtn = new AxButton(Ax.width / 2 - 40, Ax.height / 2 + 100, "custom level", this.onCustom);
			customBtn.soundOver = ping;
			customBtn.soundDown = ping2;
			customBtn.color = 0xC082FF;
			customBtn.label.color = 0xffffff;
			buttonsGroup.add(customBtn);
			
			oldSchoolBtn = new AxButton(Ax.width / 2 - 40, Ax.height / 2 + 130, "old school", this.onOldSchool);
			oldSchoolBtn.soundOver = ping;
			oldSchoolBtn.soundDown = ping2;
			oldSchoolBtn.color = 0xC082FF;
			oldSchoolBtn.label.color = 0xffffff;
			buttonsGroup.add(oldSchoolBtn);
			oldSchoolBtn.highlightedText = "3 Lives";
			
			add(buttonsGroup);
			
			var save:AxSave = new AxSave();
			if(save.bind("SLF"))
			{
				// Register defaults for level progress.
				
				var ar1:Array = new Array("wh   ", "1", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0");
				var ar2:Array = new Array("fc   ", "1", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0");
				var ar3:Array = new Array("mgmt ", "1", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0");
				var ar4:Array = new Array("xwh  ", "1", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0");
				var ar5:Array = new Array("xfc  ", "1", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0");
				var ar6:Array = new Array("xmgmt", "1", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0");
				

				if(save.data.warehouseLevelsComplete == null) 
					save.data.warehouseLevelsComplete = ar1 as Array;
				if(save.data.factoryLevelsComplete == null) 
					save.data.factoryLevelsComplete = ar2 as Array;
				if(save.data.mgmtLevelsComplete == null) 
					save.data.mgmtLevelsComplete = ar3 as Array;
				if(save.data.hcwarehouseLevelsComplete == null) 
					save.data.hcwarehouseLevelsComplete = ar4 as Array;
				if(save.data.hcfactoryLevelsComplete == null) 
					save.data.hcfactoryLevelsComplete = ar5 as Array;
				if(save.data.hcmgmtLevelsComplete == null) 
					save.data.hcmgmtLevelsComplete = ar6 as Array;
					
				//register defaults for talking progress
					
				var tar1:Array = new Array("wh-talk   ", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0");
				var tar2:Array = new Array("fc-talk   ", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0");
				var tar3:Array = new Array("mgmt-talk ", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0");
				var tar4:Array = new Array("xwh-talk  ", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0");
				var tar5:Array = new Array("xfc-talk  ", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0");
				var tar6:Array = new Array("xmgmt-talk", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0");
				

				if(save.data.warehouseLevelsTalk == null) 
					save.data.warehouseLevelsTalk = tar1 as Array;
				if(save.data.factoryLevelsTalk == null) 
					save.data.factoryLevelsTalk= tar2 as Array;
				if(save.data.mgmtLevelsTalk == null) 
					save.data.mgmtLevelsTalk = tar3 as Array;
				if(save.data.hcwarehouseLevelsTalk == null) 
					save.data.hcwarehouseLevelsTalk = tar4 as Array;
				if(save.data.hcfactoryLevelsTalk == null) 
					save.data.hcfactoryLevelsTalk = tar5 as Array;
				if(save.data.hcmgmtLevelsTalk == null) 
					save.data.hcmgmtLevelsTalk = tar6 as Array;					

					
				//register defaults for talking t0 Andre progress
					
				var taar1:Array = new Array("wh-talk-andre   ", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0");
				var taar2:Array = new Array("fc-talk-andre   ", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0");
				var taar3:Array = new Array("mgmt-talk-andre ", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0");
				var taar4:Array = new Array("xwh-talk-andre  ", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0");
				var taar5:Array = new Array("xfc-talk-andre  ", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0");
				var taar6:Array = new Array("xmgmt-talk-andre", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0");
				

				if(save.data.warehouseLevelsTalkAndre == null) 
					save.data.warehouseLevelsTalkAndre = taar1 as Array;
				if(save.data.factoryLevelsTalkAndre == null) 
					save.data.factoryLevelsTalkAndre= taar2 as Array;
				if(save.data.mgmtLevelsTalkAndre == null) 
					save.data.mgmtLevelsTalkAndre = taar3 as Array;
				if(save.data.hcwarehouseLevelsTalkAndre == null) 
					save.data.hcwarehouseLevelsTalkAndre = taar4 as Array;
				if(save.data.hcfactoryLevelsTalkAndre == null) 
					save.data.hcfactoryLevelsTalkAndre = taar5 as Array;
				if(save.data.hcmgmtLevelsTalkAndre == null) 
					save.data.hcmgmtLevelsTalkAndre = taar6 as Array;	
					
					
				// register defaults for caps
				
				var car1:Array = new Array("whcap   ", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0");
				var car2:Array = new Array("fccap   ", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0");
				var car3:Array = new Array("mgmtcap ", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0");
				var car4:Array = new Array("xwhcap  ", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0");
				var car5:Array = new Array("xfccap  ", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0");
				var car6:Array = new Array("xmgmtcap", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0");
				

				if(save.data.warehouseCap == null) 
					save.data.warehouseCap = car1 as Array;
				if(save.data.factoryCap == null) 
					save.data.factoryCap = car2 as Array;
				if(save.data.mgmtCap == null) 
					save.data.mgmtCap = car3 as Array;
				if(save.data.hcwarehouseCap == null) 
					save.data.hcwarehouseCap = car4 as Array;
				if(save.data.hcfactoryCap == null) 
					save.data.hcfactoryCap = car5 as Array;
				if(save.data.hcmgmtCap == null) 
					save.data.hcmgmtCap = car6 as Array;
					
					
					
				
					
				if(save.data.plays == null) 
					save.data.plays = 0 as Number;
					
				else
					save.data.plays++;
					
				Ax.log("Number of plays:       " + save.data.plays );
				//save.erase();
				save.close();
			}
			
			var headingTxt:AxText = new AxText(Ax.width/2 - 40 , Ax.height-34, Ax.width/2, "Arrow keys to move\n"+Registry.p1Action+"=Action/Enter\n"+Registry.p1Jump+"=Jump/Enter", true);
			headingTxt.color = 0x8000FF;
			headingTxt.size = 8;
			headingTxt.alignment = "left";
			add(headingTxt);
			
			if (Registry.DEMO) {
				headingTxt.text = "--DEMO MODE--\n" + headingTxt.text;
			}
			
/*			loader = new URLLoader;
			loader.load( new URLRequest( "http://superlemonadefactory.initialsgames.com/log.xml" ) );
			loader.addEventListener( Event.COMPLETE, onLoaded );
			loader.addEventListener( IOErrorEvent.IO_ERROR, loadError );*/
			
			//Get the version number
			var xml : XML = NativeApplication.nativeApplication.applicationDescriptor;
			var ns : Namespace = xml.namespace();
			var version : String = xml.ns::versionNumber;
			Registry.version = version;
			//Ax.log("Version " + version);
			
			versionText = new AxText(0 , Ax.height-34, Ax.width, "", true);
			versionText.color = 0x8000FF;
			versionText.size = 8;
			versionText.alignment = "right";
			versionText.text = "Version: " + version;
			add(versionText);	
			
			//latestText = new AxText(0 , Ax.height-22, Ax.width, Registry.newVersionText, true);
/*			latestText = new AxText(0 , Ax.height-22, Ax.width, "", true);
			latestText.color = 0x8000FF;
			latestText.size = 8;
			latestText.alignment = "right";
			add(latestText);	*/			
			
		}

		override public function update():void
		{
						
			if (!fading && !Ax.mouse.visible)
				this.handleButtons();

			
			//Ax.collide(collideGroup,ground);
			
			super.update();
			
			//latestText.text = Registry.newVersionText;
			
		}
		
		
		public function handleButtons():void {
			if (Ax.keys.justPressed(Registry.p1Down)  || Ax.joystick.j1Stick1DownJustPressed ) {
				currentButton++;
				Ax.play(Registry.SndBlip, 0.3);
				
			}
			
			else if (Ax.keys.justPressed(Registry.p1Up) || Ax.joystick.j1Stick1UpJustPressed ) {
				currentButton--;
				Ax.play(Registry.SndBlip, 0.3);
			}
			
			if (Ax.keys.justPressed(Registry.p1Action) ||  Ax.keys.justPressed(Registry.p1Switch) || Ax.keys.justPressed(Registry.p1Jump) || Ax.joystick.j1ButtonAJustPressed  ) {
				Ax.play(Registry.SndPing,Registry.pingVolume);
				this.beginFade();
			}
			
			if (currentButton < 0) {
				currentButton = buttonsGroup.length-1;
			}
			else if (currentButton > buttonsGroup.length-1) {
				currentButton = 0;
			}
			
			
			for (var i:int = 0; i < buttonsGroup.length; i++) { 
				if (i == currentButton) {
					(buttonsGroup.members[i] as AxButton).status = AxButton.HIGHLIGHT;
				}
				else {
					(buttonsGroup.members[i] as AxButton).status = AxButton.NORMAL;
				}
			}
			
			
		}
		
		protected function beginFade():void
		{
			fading = true;
			Ax.fade(0xff000000, 0.4, completeFade);
		}
		
		protected function completeFade():void
		{
			switch(currentButton) {
				case 0:
					Registry.oldSchoolMode = false;
					Ax.switchState(new PCLevelSelectState());
					break;
				case 1:
					Ax.switchState(new PCOptionsState());
					break;		
				case 2:
					Ax.switchState(new PCHelpState());
					break;
				case 3:
					Ax.switchState(new PCCreditsState());
					break;	
				case 4:
					Ax.switchState(new PCCustomLevelState());
					break;			
				case 5:
					Ax.playMusic(Registry.SndMega, 1.0);
					Registry.oldSchoolLivesF = 3;
					Registry.oldSchoolLivesM = 3;
					//Registry.restartMusic = true;
					Registry.oldSchoolMode = true;
					Registry.level = XML(new Registry.Level1);
					Registry.levelType = 1;
					Registry.levelNumber = 1;
					Registry.hardCore = false;
					Ax.switchState(new PCPlayState());
					break;						
			}
		}		
		
		public function onLevelSelect():void 
		{
			//Ax.switchState(new PCLevelSelectState());
			Ax.fade(0xff000000, 0.4, completeFade);
			currentButton = 0;
		}
		
		public function onOptions():void 
		{
			Ax.fade(0xff000000, 0.4, completeFade);
			currentButton = 1;
		}
		
		public function onHelp():void 
		{
			//Ax.switchState(new PCHelpState());
			Ax.fade(0xff000000, 0.4, completeFade);
			currentButton = 2;
		}
		
		public function onCredits():void 
		{
			//Ax.switchState(new PCCreditsState());
			Ax.fade(0xff000000, 0.4, completeFade);
			currentButton = 3;
		}		
		
		public function onCustom():void 
		{
			//Ax.switchState(new PCCustomLevelState());
			Ax.fade(0xff000000, 0.4, completeFade);
			currentButton = 4;
		}		
		
		public function onOldSchool():void 
		{
			//Ax.switchState(new PCCustomLevelState());
			Ax.fade(0xff000000, 0.4, completeFade);
			currentButton = 5;
		}	
		
/*		private function onLoaded( e:Event ):void
		{	
			loader.removeEventListener( Event.COMPLETE, onLoaded );
			loader.removeEventListener( IOErrorEvent.IO_ERROR, loadError );
			var xml:XML = new XML( loader.data );
			loader = null;

			
			
			if (xml.versionNumber != Registry.version)
			{
				Registry.newVersionText = "New version available.\nCheck SLF website.";
			}
			else {
				Registry.newVersionText = "Up to date";
				
			}
		}
		
		private function loadError( e:IOErrorEvent ):void
		{
			Registry.newVersionText = "No connection.";
			
			loader.removeEventListener( Event.COMPLETE, onLoaded );
			loader.removeEventListener( IOErrorEvent.IO_ERROR, loadError );
			loader.close();
			loader = null;
		}*/
		
		
		
		

		
		

		override public function destroy():void
		{
			//	Important! Clear out the plugin, otherwise resources will get messed right up after a while
			AxSpecialFX.clear();
			
			super.destroy();
		}

		
	}
}
