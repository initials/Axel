package
{
	import org.axgl.*;
	import org.flixel.plugin.photonstorm.*;
	import org.flixel.plugin.photonstorm.FX.CenterSlideFX;
	
	import flash.net.FileReference;
	import flash.net.FileFilter;

	import flash.events.IOErrorEvent;
	import flash.events.Event;

	import flash.utils.ByteArray;


	
	
	
	public class FileLoaderState extends AxState
	{
		[Embed(source = "../data/logo.png")] private var ImgLogo:Class;
		[Embed(source = "../data/largeCrate.png")] private var ImgLargeCrate:Class;
		[Embed(source = "../data/palettes.png")] private var ImgPalettes:Class;
		[Embed(source = "../data/smallCrate.png")] private var ImgSmallCrate:Class;
		[Embed(source = "../data/smallSugarBag.png")] private var ImgSmallSugarBag:Class;
		[Embed(source = "../data/sodaPack.png")] private var ImgSodaPack:Class;
		[Embed(source = "../data/sugarBags.png")] private var ImgSugarBags:Class;
		[Embed(source = "../data/tiles.png")] private var ImgTiles:Class;		
		
		//	Test specific variables
		private var slide:CenterSlideFX;
		private var scratch:AxSprite;
		private var glitchAmount:int;
		
		public var ground:AxTilemap;
		
		public var collideGroup:AxGroup;
		
		//FileReference Class well will use to load data
		private var fr:FileReference;

		//File types which we want the user to open
		private static const FILE_TYPES:Array = [new FileFilter("Ogmo Level", "*.oel")];

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

			//read the bytes of the file as a string and put it in the
			//textarea
			//outputField.text = data.readUTFBytes(data.bytesAvailable);
			Ax.log(data.readUTFBytes(data.bytesAvailable));

			//clean up the FileReference instance

			fr = null;
		}

		//called if an error occurs while loading the file contents
		private function onLoadError(e:IOErrorEvent):void
		{
			trace("Error loading file : " + e.text);
		}
	
		
		
		override public function create():void
		{
			Ax.bgColor = 0xffF8CB8F;
			
			//	Make the gradient retro looking and "chunky" with the chucnkSize parameter (here set to 4)
			var gradient2:AxSprite = AxGradient.createGradientAxSprite(512, 384, [0xffcac5ac, 0xffd6d3ba, 0xffdfdcc4], 20 );
			gradient2.x = 0;
			gradient2.y = 0;
			add(gradient2);
			
			
			var t:AxText;
			t = new AxText(0,Ax.height/2,Ax.width,"Click To Play");
			t.size = 16;
			t.alignment = "center";
			add(t);
/*
			t = new AxText(0, Ax.height/2+40, Ax.width, "arrows to control red player, wasd for blue player");
			t.size = 12;
			t.alignment = "center";
			add(t);
			
			t = new AxText(Ax.width/2-100,Ax.height-30,200,"click to test");
			t.size = 16;
			t.alignment = "center";
			add(t);*/
			
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
			
			Ax.watch(Ax.mouse, "x", "X");
			Ax.watch(Ax.mouse, "y", "Y");
			
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
				0, 0,
				1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
				1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
				1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
				);
			
			//Create a new tilemap using our level data
			ground = new AxTilemap();
			ground.loadMap(AxTilemap.arrayToCSV(data, 51), ImgTiles, 10, 10, AxTilemap.AUTO);
			ground.y = Ax.height - 30;
			add(ground);
			
			this.onLoadFileClick();
			
			
		}
		
		

		override public function update():void
		{
			
			Ax.collide(collideGroup,ground);
			
			super.update();
/*			
			glitch.changeGlitchValues(glitchAmount, 1);
			
			if (Ax.random() < .08 && glitchAmount > 1)
				glitchAmount -= 1;*/
				
			if(Ax.mouse.justPressed())
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
