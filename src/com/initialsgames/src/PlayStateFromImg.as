package
{
	import flash.geom.Rectangle;
	import org.axgl.*;
	import flash.display.BitmapData;
	
	import org.flixel.plugin.photonstorm.*;
	
	public class PlayStateFromImg extends AxState
	{
		public var level:AxTilemap;
		public var extraMap:AxTilemap;
		public var levelBlocks:AxGroup;
		public var bubbles:AxEmitter;
		
		public var conveyorBelts:AxGroup;
		public var softDrinks:AxGroup;
		public var crates:AxGroup;
		
		public var players:AxGroup;
		public var player1:Character;
		public var player2:Character;

		public var score:AxText;
		public var status:AxText;
		
		public var bags2:AxSprite;
		
		public var map:AxTilemap;		
		
		private var pic:AxSprite;
		[Embed(source = "../data/conveyorBeltBlockWithEnds.png")] private var ImgConveyorBelt:Class;
		[Embed(source = "../data/warehouse_back.png")] private var Warehouse:Class;
		[Embed(source = "../data/shelfLayer.png")] private var ImgShelves:Class;
		[Embed(source = "../data/level1_leftSideMG.png")] private var ImgBags1:Class;
		[Embed(source = "../data/level1_rightSideMG.png")] private var ImgBags2:Class;
		[Embed(source = "../data/maps/map01.png") ] private var ImgMap:Class;
		[Embed(source = "../data/level1_windows.png") ] private var ImgWindows:Class;
		
		[Embed(source = "../data/tiles.png")] private var ImgTiles:Class;
		[Embed(source = "../data/tilesBrownBase.png")] private var ImgTilesBrownBase:Class;
		[Embed(source = "../data/bubble.png")] private var ImgBubbles:Class;
		
		
		override public function create():void
		{
			//Ax.framerate = 60;
			//Ax.flashFramerate = 60;
			
			//	If the AxScrollZone Plugin isn't already in use, we add it here
			if (Ax.getPlugin(AxScrollZone) == null)
			{
				Ax.addPlugin(new AxScrollZone);
			}


			// set the background color to white
			Ax.bgColor = 0xffffffff;
		
			
			//	Make the gradient retro looking and "chunky" with the chucnkSize parameter (here set to 4)
			var gradient2:AxSprite = AxGradient.createGradientAxSprite(1024, 768, [0xffcac5ac, 0xffd6d3ba, 0xffdfdcc4], 4 );
			gradient2.x = 0;
			gradient2.y = 0;
			add(gradient2);
			
			var windows:AxTileblock = new AxTileblock(0, 200, Ax.width, 54);
			windows.loadTiles(ImgWindows, 58, 54, 2);
			windows.scrollFactor.x = 0.2;
			windows.scrollFactor.y = 0.2;
			add(windows);

			var shelves:AxSprite = new AxSprite(50, 120, ImgShelves);
			shelves.scrollFactor.x = 0.25;
			shelves.scrollFactor.y = 0.25;
			add(shelves);
			
			var bags1:AxSprite = new AxSprite(10, Ax.height - 20, ImgBags1);
			bags1.scrollFactor.x = 0.55;
			bags1.scrollFactor.y = 0.55;
			add(bags1);
			
			bags2 = new AxSprite(288 , 312, ImgBags2);
			bags2.scrollFactor.x = 0.55;
			bags2.scrollFactor.y = 0.55;
			//bags2.x = 550 - bags2.width;
			//bags2.y = 550 - bags2.height;
			add(bags2);
			
			levelBlocks = new AxGroup();

			//Create a new tilemap using our level data
			//load in black pixels as baselevel
			level = new AxTilemap();
			level.loadMap(AxTilemap.imageToCSV(ImgMap),ImgTiles,10,10,AxTilemap.AUTO);
			levelBlocks.add(level);
			
			var mapSprite:AxSprite = new AxSprite(0, 0, ImgMap);

			// set colors for the world map to read
			var clrBrownTiles:uint = 0xff603913;	//brown Tiles (For tiles with brown bottom)
			var clrRedTiles:uint = 0xffff0000;	//Red - spikes or hazards
			var clrSoftDrinks:uint = 0xff00ff00;	//Green - Lemonades!!!
			var clrConveyorBelts:uint = 0xff0000ff;	//Blue - Conveyor Belts
			var emptyColor:uint = 0xffffffff;
			var clrCrate:uint = 0xfff7941d;
			
			
			var blockLocations:Array = mapSprite.getArrayForColor(clrBrownTiles, false);
			extraMap = new AxTilemap().loadMap(AxTilemap.arrayToCSV(blockLocations,60),ImgTilesBrownBase,10,10,AxTilemap.AUTO);
			levelBlocks.add(extraMap);
			add(levelBlocks);
			
			var softDrinkLocations:Array = mapSprite.replaceColor(clrSoftDrinks,emptyColor,true);
			softDrinks = new AxGroup();
			addSoftDrinks(softDrinkLocations);
			
			var conveyorLocations:Array = mapSprite.replaceColor(clrConveyorBelts,emptyColor,true);
			conveyorBelts = new AxGroup();
			addConveyorBelts(conveyorLocations);			
			
			var crateLocations:Array = mapSprite.replaceColor(clrCrate,emptyColor,true);
			crates = new AxGroup();
			addCrates(crateLocations);
			
			add(conveyorBelts);
			add(softDrinks);
			add(crates);
			
			bubbles = new AxEmitter();
			bubbles.makeParticles(ImgBubbles, 100, 32, true, 0);
			bubbles.setRotation(0,0);
			bubbles.setYSpeed(-30,-15);
			bubbles.setXSpeed(-40,40);
			bubbles.gravity = -30;
			add(bubbles);
			
			
			
			//Create the two players
			player1 = new PlayerMale(20, 20 ,1 );
			//player1.maxVelocity.x = 200;   // Theses are pysics settings,
			//player1.maxVelocity.y = 400;  // controling how the players behave
			//player1.acceleration.y = 600; // in the game
			//player1.drag.x = player1.maxVelocity.x*4;
			add(player1);

			player2 = new PlayerFemale(30, 20, 2 );
			//player2.maxVelocity.x = player1.maxVelocity.x; // Same thing than player 1
			//player2.maxVelocity.y = player1.maxVelocity.y;
			//player2.acceleration.y = player1.acceleration.y;
			//player2.drag.x = player2.maxVelocity.x*4;
			add(player2);
			
			players = new AxGroup(2);
			players.add(player1);
			players.add(player2);

			// Then we setup two cameras to follow each of the two players

			var cam:AxCamera = new AxCamera(0,0, Ax.width/2, Ax.height); // we put the first one in the top left corner
			cam.follow(player2, AxCamera.STYLE_PLATFORMER);
			// this sets the limits of where the camera goes so that it doesn't show what's outside of the tilemap
			cam.setBounds(0,0,level.width, level.height, true);
			//cam.color = 0xeeFFCCCC; // add a light red tint to the camera to differentiate it from the other
			Ax.addCamera(cam);

			// Almost the same thing as the first camera
			cam = new AxCamera(Ax.width,0, Ax.width/2, Ax.height);    // and the second one in the top middle of the screen
			cam.follow(player1, AxCamera.STYLE_PLATFORMER);
			cam.setBounds(0,0,level.width, level.height, true);
			cam.color = 0xFFE6E6; // Add a light blue tint to the camera
			Ax.addCamera(cam);

			// add quit button
			var quitBtn:AxButton = new AxButton(1000, 1000, "Quit", onQuit); //put the button out of screen so we don't see in the two other cameras
			add(quitBtn);
			
			// Create a camera focused on the quit button.
			// We do this because we don't want the quit button to be
			// tinted by the other cameras.
/*			cam = new AxCamera(2, 2, quitBtn.width, quitBtn.height);
			cam.follow(quitBtn);
			Ax.addCamera(cam);*/
			
			Ax.camera.setBounds(0, 0, 600, 600, true);
			Ax.camera.follow(level, AxCamera.STYLE_PLATFORMER);
			
			
			
			
		}
		
		public function playerOnConveyorBelt(Object1:AxEntity, Object2:AxEntity):void {
			(Object2 as Character).velocity.x = ((Object1 as ConveyorBelt)._speed) * 90;
			(Object2 as Character)._onConveyor = true;
			
		}
		
		public function getSoftDrink(Object1:AxEntity, Object2:AxEntity):void {
			bubbles.at(Object2);
			bubbles.start(true, 5, 1, 10);
			(Object2 as SoftDrink).kill();
			
			
		}		
		
		override public function update():void
		{
			
			Ax.collide(levelBlocks, players);
			
			Ax.collide(conveyorBelts, players, playerOnConveyorBelt );
			
			Ax.overlap(players, softDrinks, getSoftDrink);
			
			Ax.collide(players, crates);
			Ax.collide(levelBlocks, crates);
			Ax.collide(conveyorBelts, crates );
			
			
			//how to reverse a conveyor
/*			if (Ax.keys.justPressed("D")) {
				cb._speed *= -1;
			}*/
			if (Ax.keys.pressed("Q")) {
				player1.acceleration.y ++;
				trace ("p1.acc.y=" + player1.acceleration.y);
			}
			if (Ax.keys.pressed("W")) {
				player1.acceleration.y --;
				trace ("p1.acc.y=" + player1.acceleration.y);
				
			}		
			if (Ax.keys.pressed("E")) {
				player1.maxVelocity.y ++;
				trace ("p1.maxV.y=" + player1.maxVelocity.y);			
			}
			
			if (Ax.keys.pressed("R")) {
				level.setTile(player1.x / 10, (player1.y / 10 ) + 2, 0, true);
			}
			
			
			
			if (Ax.keys.ESCAPE) {
				onQuit();			
				
			}
			
			
			super.update();
			
		}

		// function called when the quit button is pressed
		private function onQuit():void
		{
			// Go back to the MenuState
			Ax.switchState(new MenuState);
		}
		
		override public function destroy():void
		{
			//	Important! Clear out the scrolling image from the plugin, otherwise resources will get messed right up after a while
			AxScrollZone.clear();
			
			super.destroy();
		}
		
		public function addConveyorBelts(Locations:Array):void
		{
			var l:int = Locations.length;
			while(l--)
				conveyorBelts.add(new ConveyorBelt(Locations[l].x*10,Locations[l].y*10,0.5));
		}
		public function addSoftDrinks(Locations:Array):void
		{
			var l:int = Locations.length;
			while(l--)
				softDrinks.add(new SoftDrink(Locations[l].x*10,(Locations[l].y*10)-3));
		}	
		
		public function addCrates(Locations:Array):void
		{
			var l:int = Locations.length;
			while(l--)
				crates.add(new Crate(Locations[l].x*10,(Locations[l].y*10)-13));
		}
		
		
	}
}
