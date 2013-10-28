package
{
	import org.axgl.*;
	import org.flixel.plugin.photonstorm.*;
	import org.flixel.plugin.photonstorm.FX.CenterSlideFX
	
	import flash.net.FileReference;
	import flash.net.FileFilter;
	import flash.events.IOErrorEvent;
	import flash.events.Event;
	import flash.utils.ByteArray;
	
	
	
	public class MenuState extends AxState
	{
		[Embed(source = "../data/logo.png")] private var ImgLogo:Class;
		[Embed(source = "../data/largeCrate.png")] private var ImgLargeCrate:Class;
		[Embed(source = "../data/level1/palettes.png")] private var ImgPalettes:Class;
		[Embed(source = "../data/smallCrate.png")] private var ImgSmallCrate:Class;
		[Embed(source = "../data/smallSugarBag.png")] private var ImgSmallSugarBag:Class;
		[Embed(source = "../data/sodaPack.png")] private var ImgSodaPack:Class;
		[Embed(source = "../data/sugarBags.png")] private var ImgSugarBags:Class;
		[Embed(source = "../data/tiles.png")] private var ImgTiles:Class;		
		[Embed(source = "../data/sfx_128/Blip_Select.mp3")] protected var SndBlip:Class;	
		
		[Embed(source = "../data/sfx_128/ping.mp3")] protected var SndPing:Class;		
		[Embed(source = "../data/sfx_128/ping2.mp3")] protected var SndPing2:Class;		
		
		
		[Embed(source = '../data/SLF_levelEditor/level1.oel', mimeType = 'application/octet-stream')] private var Level1:Class;
		
		//	Test specific variables
		private var slide:CenterSlideFX;
		private var scratch:AxSprite;
		private var glitchAmount:int;
		
		public var ground:AxTilemap;
		
		public var collideGroup:AxGroup;
		
		public var play:AxButton ;
		public var playBuiltInLevels:AxButton ;
		
		public var txtLevel:AxText;
		public var txtPlayersNo:AxText;
		
		
		//FileReference Class well will use to load data
		private var fr:FileReference;

		//File types which we want the user to open
		private static const FILE_TYPES:Array = [new FileFilter("Ogmo Level File", "*.oel")];
		
		public var currentLevel:AxText;
		
		public var ping:AxSound;
		
		

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
			
			ping = new AxSound();
			ping.loadEmbedded(SndBlip);
			ping.volume = 0.5;
			
			Ax.playMusic(Registry.SndEcho, 1.0);
			
			
			Ax.bgColor = 0xffF8CB8F;
			
			//	Make the gradient retro looking and "chunky" with the chucnkSize parameter (here set to 4)
			var gradient2:AxSprite = AxGradient.createGradientAxSprite(512, 384, [0xffcac5ac, 0xffd6d3ba, 0xffdfdcc4], 20 );
			gradient2.x = 0;
			gradient2.y = 0;
			add(gradient2);
			
			
			var t:AxText;
			t = new AxText(0,Ax.height/2,Ax.width,"Current level:");
			t.size = 16;
			t.alignment = "center";
			t.color = 0x8000FF;
			add(t);
			
			currentLevel = new AxText(0,Ax.height/2+20,Ax.width,"No level loaded.");
			currentLevel.size = 16;
			currentLevel.alignment = "center";
			currentLevel.color = 0x8000FF;

			add(currentLevel);
			

			
			
			var inst:AxText = new AxText(0, 4, Ax.width, "Click to change.");
			inst.size = 8;
			inst.alignment = "left";
			add(inst);

			txtLevel = new AxText(0, 14, Ax.width, "Level Type: Warehouse");
			txtLevel.size = 8;
			txtLevel.alignment = "left";
			add(txtLevel);
			
			txtPlayersNo = new AxText(0, 24, Ax.width, "Players: 1");
			txtPlayersNo.size = 8;
			txtPlayersNo.alignment = "left";
			add(txtPlayersNo);
			
			if (Registry.playersNo==2) {
				Registry.playersNo = 2;
				txtPlayersNo.text = "Players: 2";
			}
			else  {
				Registry.playersNo = 1;
				txtPlayersNo.text = "Players: 1";
			}
				
			if (Registry.levelType == 2) {
				txtLevel.text = "Level Type: Factory";
				Registry.levelType = 2;
			}
			else if (Registry.levelType == 3) {
				txtLevel.text = "Level Type: Management";
				Registry.levelType = 3;
			}			
			else
				Registry.levelType = 1;
				
			
			
			
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
			
			
			Ax.mouse.show();
			
			//Ax.watch(Ax.mouse, "x", "X");
			//Ax.watch(Ax.mouse, "y", "Y");
			
			collideGroup = new AxGroup();
			
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
			
			add(collideGroup);
			
			
			//Design your platformer level with 1s and 0s (at 40x30 to fill 320x240 screen)
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
			add(ground);
			
			var loadLevelBtn:AxButton = new AxButton(Ax.width / 2 - 40, Ax.height / 2 + 50, "Load Level", this.onLoadFileClick);
			//loadLevelBtn.color = 0xFFBA75;
			loadLevelBtn.soundOver = ping;
			loadLevelBtn.color = 0xC082FF;
			loadLevelBtn.label.color = 0xffffff;
			add(loadLevelBtn);
			
			play = new AxButton(Ax.width / 2 - 40, Ax.height / 2 + 80, "Play", this.switchStates);
			play.visible = false;
			play.soundOver = ping;
			play.color = 0xC082FF;
			play.label.color = 0xffffff;
			add(play);
			
			playBuiltInLevels = new AxButton(Ax.width / 2 - 40, Ax.height / 2 + 120, "Play Demo", this.playBuiltInLevel);
			
			playBuiltInLevels.visible = true;
			playBuiltInLevels.soundOver = ping;
			playBuiltInLevels.color = 0xC082FF;
			playBuiltInLevels.label.color = 0xffffff;
			add(playBuiltInLevels);			
			
			if (Registry.level != null) {
				currentLevel.text = Registry.levelName;
				play.visible = true;
			}
			
			Ax.mouse.show();

			
		}

		override public function update():void
		{
			
			if (Ax.mouse.justPressed() && Ax.mouse.y < 24) {
				Ax.play(SndBlip, 0.75, false, true);
				if (txtLevel.text == "Level Type: Warehouse") 
				{
					txtLevel.text = "Level Type: Factory";
					Registry.levelType = 2;
					
				}
				else if (txtLevel.text == "Level Type: Factory" )
				{
					txtLevel.text = "Level Type: Management";
					Registry.levelType = 3;
				}
				else if (txtLevel.text == "Level Type: Management" )
				{
					txtLevel.text = "Level Type: Warehouse";
					Registry.levelType = 1;
				}				
				
				
				
			}
			if (Ax.mouse.justPressed() && Ax.mouse.y > 25 && Ax.mouse.y < 40) {
				Ax.play(SndBlip, 0.75, false, true);
				if (txtPlayersNo.text == "Players: 2") 
				{
					txtPlayersNo.text = "Players: 1";
					Registry.playersNo = 1;
				}
				else if (txtPlayersNo.text == "Players: 1" )
				{
					txtPlayersNo.text = "Players: 2";
					Registry.playersNo = 2;
				}
			}			
			
			
			
			
			Ax.collide(collideGroup,ground);
			
			super.update();
/*			
			glitch.changeGlitchValues(glitchAmount, 1);
			
			if (Ax.random() < .08 && glitchAmount > 1)
				glitchAmount -= 1;*/
				
/*			if(Ax.mouse.justPressed())
				//Ax.switchState(new PlayState());
				this.onLoadFileClick();*/
								
		}
		
		public function switchStates():void {
			if (currentLevel.text == "No level loaded.") {
				
			}
			else {			
				//Ax.play(SndPing, 0.75, false, true);
				Registry.isPlayingDemo = false;
				Registry.demoLevel = 1;
				Ax.playMusic(Registry.SndMega, 1.0);
				Ax.switchState(new PlayState());
			}
		}
		
		public function playBuiltInLevel():void {
			//Ax.play(SndPing2, 0.75, false, true);
			Registry.level = XML(new Level1); 
			Registry.levelName = "Demo Level 1";
			Registry.levelType = 1;
			Registry.isPlayingDemo = true;
			Registry.demoLevel = 1;
			Ax.playMusic(Registry.SndMega, 1.0);
			Ax.switchState(new PlayState());
			
		}
		
		
		

		override public function destroy():void
		{
			//	Important! Clear out the plugin, otherwise resources will get messed right up after a while
			AxSpecialFX.clear();
			
			super.destroy();
		}

		
	}
}
