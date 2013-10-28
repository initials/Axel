package com.initialsgames.src{
	import flash.external.ExternalInterface;
	import org.axgl.*;
	import flash.utils.getDefinitionByName;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	

	public class PlayState extends AxState
	{
		public var _hud:HUD;
		
		private var followWidth:int = 0;
		private var followHeight:int = 0;
		
		public var levelOverCount:Number = 0;
		
		[Embed(source = '../data/SLF_levelEditor/level21.oel', mimeType = 'application/octet-stream')] private var Level2:Class;
		[Embed(source = '../data/SLF_levelEditor/level3.oel', mimeType = 'application/octet-stream')] private var Level3:Class;
		[Embed(source="../data/C64.ttf",fontFamily="commodore",embedAsCFF="false")] protected var c64:String;

		
		[Embed(source = "../data/conveyorBeltBlockWithEnds.png")] private var ImgConveyorBelt:Class;
		[Embed(source = "../data/warehouse_back.png")] private var Warehouse:Class;
		[Embed(source = "../data/shelfLayer.png")] private var ImgShelves:Class;
		[Embed(source = "../data/level1_leftSideMG.png")] private var ImgBags1:Class;
		[Embed(source = "../data/level1_rightSideMG.png")] private var ImgBags2:Class;		
		
		[Embed(source = "../data/level1_windows.png") ] private var level1_windows:Class;
		[Embed(source = "../data/level1/noticeBoard.png") ] private var noticeBoard:Class;
		[Embed(source = "../data/level1/cratesBox.png") ] private var cratesBox:Class;
		[Embed(source = "../data/level1/L1_Shelf.png") ] private var L1_Shelf:Class;
		[Embed(source = "../data/level1/level1_shelfTile.png") ] private var level1_shelfTile:Class;
		[Embed(source = "../data/level1/sodaPack.png") ] private var sodaPack:Class;
		[Embed(source = "../data/level1/sugarBags.png") ] private var sugarBags:Class;
		[Embed(source = "../data/level1/sugarBagsAndCrates.png") ] private var sugarBagsAndCrates:Class;
		[Embed(source = "../data/level1/palettes.png") ] private var palettes:Class;
		
		[Embed(source = "../data/level1/level1_specialBlock.png") ] private var level1_specialBlock:Class;
		[Embed(source = "../data/level1/level1_specialPlatform.png") ] private var level1_specialPlatform:Class;
		[Embed(source = "../data/level1/level1_bgSmoothGrad.png") ] private var level1_bgSmoothGrad:Class;
		
		[Embed(source = "../data/level1/spike0.png") ] private var spike0:Class;
		[Embed(source = "../data/level1/spike1.png") ] private var spike1:Class;
		[Embed(source = "../data/level1/spike2.png") ] private var spike2:Class;
		[Embed(source = "../data/level1/spike3.png") ] private var spike3:Class;
		
		[Embed(source = "../data/level2/level2_specialBlock.png") ] private var level2_specialBlock:Class;
		[Embed(source = "../data/level2/level2_specialPlatform.png") ] private var level2_specialPlatform:Class;
		
		[Embed(source = "../data/level2/level2_spike0.png") ] private var level2_spike0:Class;
		[Embed(source = "../data/level2/level2_spike1.png") ] private var level2_spike1:Class;
		[Embed(source = "../data/level2/level2_spike2.png") ] private var level2_spike2:Class;
		[Embed(source = "../data/level2/level2_spike3.png") ] private var level2_spike3:Class;
		
		[Embed(source = "../data/level2/level2_gradient.png") ] private var level2_gradient:Class;
		
		[Embed(source = "../data/level2/level2_braceLeft.png") ] private var level2_braceLeft:Class;
		[Embed(source = "../data/level2/level2_braceRight.png") ] private var level2_braceRight:Class;
		[Embed(source = "../data/level2/level2_chainTile.png") ] private var level2_chainTile:Class;
		[Embed(source = "../data/level2/level2_FMG3.png") ] private var level2_FMG3:Class;
		[Embed(source = "../data/level2/level2_greenPipe.png") ] private var level2_greenPipe:Class;
		[Embed(source = "../data/level2/level2_metalPipe.png") ] private var level2_metalPipe:Class;
		[Embed(source = "../data/level2/level2_MG2.png") ] private var level2_MG2:Class;
		[Embed(source = "../data/level2/level2_pipe1.png") ] private var level2_pipe1:Class;
		[Embed(source = "../data/level2/level2_tank.png") ] private var level2_tank:Class;
		[Embed(source = "../data/level2/level2_window.png") ] private var level2_window:Class;
		
		[Embed(source = "../data/level3/level3_window.png") ] private var level3_window:Class;
		
		[Embed(source = "../data/level3/bookCase.png") ] private var bookCase:Class;
		[Embed(source = "../data/level3/filingCab1.png") ] private var filingCab1:Class;
		[Embed(source = "../data/level3/filingCab2.png") ] private var filingCab2:Class;
		[Embed(source = "../data/level3/plant1.png") ] private var plant1:Class;
		[Embed(source = "../data/level3/plant2.png") ] private var plant2:Class;
		
		[Embed(source = "../data/level3/level3_cloud.png") ] private var level3_cloud:Class;
		[Embed(source = "../data/level3/level3_desk1.png") ] private var level3_desk1:Class;
		[Embed(source = "../data/level3/level3_desk2.png") ] private var level3_desk2:Class;
		[Embed(source = "../data/level3/level3_desk3.png") ] private var level3_desk3:Class;
		
		[Embed(source = "../data/level3/level3_MG_pylon.png") ] private var level3_MG_pylon:Class;
		[Embed(source = "../data/level3/level3_gradient.png") ] private var level3_gradient:Class;
		
		[Embed(source = "../data/level3/level3_painting1.png") ] private var level3_painting1:Class;
		[Embed(source = "../data/level3/level3_painting2.png") ] private var level3_painting2:Class;
		[Embed(source = "../data/level3/level3_painting3.png") ] private var level3_painting3:Class;		
		[Embed(source = "../data/level3/level3_salesChart.png") ] private var level3_salesChart:Class;	
		
		[Embed(source = "../data/level1/level1_specialPlatformSmall.png") ] private var level1_specialPlatformSmall:Class;	
		[Embed(source = "../data/level2/level2_specialPlatformSmall.png") ] private var level2_specialPlatformSmall:Class;	
		[Embed(source = "../data/level3/level3_specialPlatformSmall.png") ] private var level3_specialPlatformSmall:Class;	
		
		[Embed(source = "../data/pickups/andreCheckPoint.png") ] private var andreCheckPoint:Class;		
		[Embed(source = "../data/pickups/liselotCheckPoint.png") ] private var liselotCheckPoint:Class;		
		
		[Embed(source = "../data/level3/level3_specialBlock.png") ] private var level3_specialBlock:Class;
		[Embed(source = "../data/level3/level3_specialPlatform.png") ] private var level3_specialPlatform:Class;
		
		[Embed(source = "../data/level3/level3_spike0.png") ] private var level3_spike0:Class;
		[Embed(source = "../data/level3/level3_spike1.png") ] private var level3_spike1:Class;
		[Embed(source = "../data/level3/level3_spike2.png") ] private var level3_spike2:Class;
		[Embed(source = "../data/level3/level3_spike3.png") ] private var level3_spike3:Class;	
		
		[Embed(source = "../data/tiles.png")] private var ImgAutoTiles:Class;
		[Embed(source = "../data/level1_tiles.png")] private var ImgTiles:Class;
		[Embed(source = "../data/speechBubbleTiles.png")] private var ImgSpeechTiles:Class;
		[Embed(source = "../data/level2/level2_tiles.png")] private var ImgTiles2:Class;
		[Embed(source = "../data/level3/level3_tiles.png")] private var ImgTiles3:Class;
		[Embed(source = "../data/tilesBrownBase.png")] private var ImgTilesBrownBase:Class;
		[Embed(source = "../data/bubble.png")] private var ImgBubbles:Class;
		[Embed(source = "../data/pickups/crateShards.png")] private var ImgCrateShards:Class;
		
		[Embed(source = "../data/sfx_128/SndOnShoulders.mp3")] protected var SndOnShoulders:Class;		
		[Embed(source = "../data/sfx_128/whoosh.mp3")] protected var SndWhoosh:Class;		
		[Embed(source = "../data/sfx_128/SndExp.mp3")] protected var SndExp:Class;		
		[Embed(source = "../data/sfx_128/SwitchCharacters.mp3")] protected var SwitchCharacters:Class;		
		[Embed(source = "../data/sfx_128/deathSFX.mp3")] protected var SndDeath:Class;
		[Embed(source = "../data/sfx_128/initials_empire_tagtone1.mp3")] protected var SndTagTone1:Class;
		[Embed(source = "../data/sfx_128/initials_empire_tagtone4.mp3")] protected var SndTagTone4:Class;
		[Embed(source = "../data/sfx_128/powerUp.mp3")] protected var SndPowerUp:Class;
		[Embed(source = "../data/sfx_128/checkPoint.mp3")] protected var SndCheckPoint:Class;
		
		private var map:AxTilemap;
		private var map2:AxTilemap;
		
		public var pickUps:AxGroup;
		public var crates:AxGroup;
		public var levelBlocks:AxGroup;
		public var hazards:AxGroup;
		public var helpBoxes:AxGroup;
		public var enemies:AxGroup;
		public var exits:AxGroup;
		public var plants:AxGroup;
		public var filingCabs:AxGroup;
		public var checkPoints:AxGroup;
		public var talkCharacters:AxGroup;
		public var largeCrates:AxGroup;
		
		// game over buttons and fade out
		
		public var playBtn:AxButton;
		public var menuBtn:AxButton;
		
		public var restartBtn:AxButton;
		public var pauseInstructions:AxText;
		
		
		private var gameOverDarken:AxSprite;
		private var gameOverScreen:Boolean;
		private var box:AxSprite;
		private var b:AxTileblock;
		private var speechBlock:AxTileblock;
		private var speechText:AxText;
		private var speechBubble:AxGroup;
		public var players:AxGroup;
		public var player1:Character;
		public var player2:Character;
		public var army:EnemyArmy;
		public var chef:EnemyChef;
		public var inspector:EnemyInspector;
		public var worker:EnemyWorker;
		
		public var exit:Exit;
	
		public var largeCrate:LargeCrate;
		
		public var checkPoint:CheckPoint;
		
		public var helpBox:HelpBox;
		public var plant:Plant;
		public var filingCab:FilingCabinet;
		
		public var helpOverlayP1:AxSprite;
		public var helpOverlayP2:AxSprite;
		public var helpOverlayTextP1:AxText;
		public var helpOverlayTextP2:AxText;
		
		public var infoText:AxText;
		public var levelWidth:int;
		public var levelHeight:int;
		
		public var bgSprite:AxSprite;
		public var bgTile:AxTileblock;
		public var cam:AxCamera;
		public var cam2:AxCamera;
		public var allCam:AxCamera;
		
		public var bubbles:AxEmitter;
		public var crateShards:AxEmitter;
		public var helpCamP1:AxCamera;
		public var helpCamP2:AxCamera;
		public var levelFinished:Boolean;
		public var deathSound:AxSound;
		public var hasCollectedCap:Boolean;
		public var hasTalkedToEnemy:Boolean;
		public var hasTalkedToAndre:Boolean;
		
		public function loadCharacter(item:XML, toLoad:String):void {
			//trace(toLoad + " " + item + " hi ");
			
			if (toLoad == "player") {
				player1 = new PlayerMale(item.@x, item.@y , 1, item.@talkString );
				player1._currentlyControlled = true;
				players.add(player1);
				
				followWidth = item.@followWidth;
				followHeight = item.@followHeight;
				
				player1.startsFirst = item.@startsFirst;
				player1._talkString = item.@talkString;
			}			
			else if (toLoad == "liselot") {
				player2 = new PlayerFemale(item.@x, item.@y , 2, item.@talkString );
				player2._currentlyControlled = false;
				players.add(player2);
			}				
			else if (toLoad == "army") {
				army = new EnemyArmy(item.@x, item.@y, item.@talkString);
				army.velocity.x = item.@speed;
				army._originalVelocityX = item.@speed;
				
				enemies.add(army);
				talkCharacters.add(army);
				
				for each(var x:XML in item.*) {
					army.limitX = x.@x;
					army.limitY = x.@y;
				}
			}	
			else if (toLoad == "worker") {
				worker = new EnemyWorker(item.@x, item.@y, item.@talkString);
				worker.velocity.x = item.@speed;
				worker._originalVelocityX = item.@speed;
				
				enemies.add(worker);
				talkCharacters.add(worker);
				
				for each(var y:XML in item.*) {
					worker.limitX = y.@x;
					worker.limitY = y.@y;
				}
				
			}
			else if (toLoad == "chef") {
				chef = new EnemyChef(item.@x, item.@y, item.@talkString);
				chef.velocity.x = item.@speed;
				chef._originalVelocityX = item.@speed;
				
				enemies.add(chef);
				talkCharacters.add(chef);
				
				for each(var x2:XML in item.*) {
					chef.limitX = x2.@x;
					chef.limitY = x2.@y;
				}
				
				// Ax.watch(chef.velocity, "x", "vx");
				
			}
			else if (toLoad == "inspector") {
				inspector = new EnemyInspector(item.@x, item.@y, item.@talkString);
				inspector.velocity.x = item.@speed;
				inspector._originalVelocityX = item.@speed;
				enemies.add(inspector);
				talkCharacters.add(inspector);
				
				for each(var x3:XML in item.*) {
					inspector.limitX = x3.@x;
					inspector.limitY = x3.@y;
				}
			}
			else {
				Ax.log(toLoad + " is causing a problem in the Characters layer.");
				trace(toLoad + " is causing a problem in the Characters layer.");
			}
		}
		
		
		
		public function loadMovingPlatform(item:XML, toLoad:String):void {
			
			var img:Class;
			if (toLoad == "level1_specialPlatformSmall") img = level1_specialPlatformSmall;
			else if (toLoad == "level2_specialPlatformSmall") img = level2_specialPlatformSmall;
			else if (toLoad == "level3_specialPlatformSmall") img = level3_specialPlatformSmall;
			else if (toLoad == "level1_specialPlatform") img = level1_specialPlatform;
			else if (toLoad == "level2_specialPlatform") img = level2_specialPlatform;
			else if (toLoad == "level3_specialPlatform") img = level3_specialPlatform;
			else if (toLoad == "level1_specialBlock") img = level1_specialBlock;
			else if (toLoad == "level2_specialBlock") img = level2_specialBlock;
			else if (toLoad == "level3_specialBlock") img = level3_specialBlock;			
			else {
				if (toLoad == "level1_specialPlatform") img = level1_specialPlatform;
				Ax.log("You have a problem with the moving platform layer, item: " + toLoad);
			}
			
			var xo:int;
			var yo:int;
			var n:XML;
			var xx:int;
			var yy:int;
			
			bgSprite = new AxSprite(item.@x, item.@y, img);
			bgSprite.path = new AxPath();
			
			//bgSprite.loadGraphic(img, false, false, 40);
			if ((toLoad == "level1_specialPlatformSmall") || (toLoad == "level2_specialPlatformSmall") || (toLoad == "level3_specialPlatformSmall") )
			{
				bgSprite.loadGraphic(img, false, false, 40);
				xo = item.@x;
				xo += 20;
				yo = item.@y;
				yo += 10;
				
				bgSprite.path.add(xo, yo);
				
				//add each node to the AxPath
				for each(n in item.node)
				{
					xx = n.@x;
					xx += 20;
					yy = n.@y;
					yy += 10;
					bgSprite.path.add(xx,yy);
				}
			}
			
			else if ((toLoad == "level1_specialPlatform") || (toLoad == "level2_specialPlatform") || (toLoad == "level3_specialPlatform"))
			{
				bgSprite.loadGraphic(img, false, false, 100, 20);
				
				xo = item.@x;
				xo += 50;
				yo = item.@y;
				yo += 10;
				
				bgSprite.path.add(xo, yo);	
				
				//add each node to the AxPath
				for each(n in item.node)
				{
					xx = n.@x;
					xx += 50;
					yy = n.@y;
					yy += 10;
					bgSprite.path.add(xx,yy);
				}				
				
			}
			else if ((toLoad == "level1_specialBlock") || (toLoad == "level2_specialBlock") || (toLoad == "level3_specialBlock") )
			{
				bgSprite.loadGraphic(img, false, false, 40, 40);
				
				xo = item.@x;
				xo += 20;
				yo = item.@y;
				yo += 20;
				
				bgSprite.path.add(xo, yo);	
				
				//add each node to the AxPath
				for each(n in item.node)
				{
					xx = n.@x;
					xx += 20;
					yy = n.@y;
					yy += 20;
					bgSprite.path.add(xx,yy);
				}				
				
			}
			
			// And, finaly, follow the path
			
			if (item.@movementType==1)
				bgSprite.followPath(bgSprite.path, item.@speed, AxEntity.PATH_FORWARD);
			else if (item.@movementType==2)
				bgSprite.followPath(bgSprite.path, item.@speed, AxEntity.PATH_BACKWARD);
			else if (item.@movementType==3)
				bgSprite.followPath(bgSprite.path, item.@speed, AxEntity.PATH_LOOP_FORWARD);
			else if (item.@movementType==4)
				bgSprite.followPath(bgSprite.path, item.@speed, AxEntity.PATH_LOOP_BACKWARD);				
			else if (item.@movementType==5)
				bgSprite.followPath(bgSprite.path, item.@speed, AxEntity.PATH_YOYO);				
			else if (item.@movementType==6)
				bgSprite.followPath(bgSprite.path, item.@speed, AxEntity.PATH_HORIZONTAL_ONLY);				
			else if (item.@movementType==7)
				bgSprite.followPath(bgSprite.path, item.@speed, AxEntity.PATH_VERTICAL_ONLY);		
			else 
				Ax.log("Path type out of bounds");
			
			bgSprite.immovable = true;
			bgSprite.solid = true;
			
			levelBlocks.add(bgSprite);
		}
		
		
		public function loadItem(item:XML, toLoad:String, overrideScrollFactor:int):void 
		{
			var img:Class;
			var _type:int;
			
			if (toLoad == "cratesBox") img = cratesBox;
			else if (toLoad == "level1_windows") img = level1_windows;
			else if (toLoad == "palettes") img = palettes;
			else if (toLoad == "L1_Shelf") img = L1_Shelf;
			else if (toLoad == "level1_shelfTile") img = level1_shelfTile;
			else if (toLoad == "sodaPack") img = sodaPack;
			else if (toLoad == "sugarBags") img = sugarBags;
			else if (toLoad == "sugarBagsAndCrates") img = sugarBagsAndCrates;
			else if (toLoad == "noticeBoard") img = noticeBoard;
			
			else if (toLoad == "spike0") img = spike0;
			else if (toLoad == "spike1") img = spike1;
			else if (toLoad == "spike2") img = spike2;
			else if (toLoad == "spike3") img = spike3;
			
			else if (toLoad == "level1_specialBlock") img = level1_specialBlock;
			else if (toLoad == "level1_specialPlatform") img = level1_specialPlatform;
			
			else if (toLoad == "level1_specialPlatformSmall") img = level1_specialPlatformSmall;
			else if (toLoad == "level2_specialPlatformSmall") img = level2_specialPlatformSmall;
			else if (toLoad == "level3_specialPlatformSmall") img = level3_specialPlatformSmall;
			
			else if (toLoad == "level2_spike0") img = level2_spike0;
			else if (toLoad == "level2_spike1") img = level2_spike1;
			else if (toLoad == "level2_spike2") img = level2_spike2;
			else if (toLoad == "level2_spike3") img = level2_spike3;
			
			else if (toLoad == "level2_specialBlock") img = level2_specialBlock;
			else if (toLoad == "level2_specialPlatform") img = level2_specialPlatform;
			
			else if (toLoad == "level3_spike0") img = level3_spike0;
			else if (toLoad == "level3_spike1") img = level3_spike1;
			else if (toLoad == "level3_spike2") img = level3_spike2;
			else if (toLoad == "level3_spike3") img = level3_spike3;
			else if (toLoad == "level3_specialBlock") img = level3_specialBlock;
			else if (toLoad == "level3_specialPlatform") img = level3_specialPlatform;	
			else if (toLoad == "level2_braceLeft") img = level2_braceLeft;			
			else if (toLoad == "level2_braceRight") img = level2_braceRight;			
			else if (toLoad == "level2_chainTile") img = level2_chainTile;			
			else if (toLoad == "level2_FMG3") img = level2_FMG3;			
			else if (toLoad == "level2_greenPipe") img = level2_greenPipe;			
			else if (toLoad == "level2_metalPipe") img = level2_metalPipe;			
			else if (toLoad == "level2_MG2") img = level2_MG2;			
			else if (toLoad == "level2_pipe1") img = level2_pipe1;			
			else if (toLoad == "level2_tank") img = level2_tank;			
			else if (toLoad == "level2_window") img = level2_window;	
			
			else if (toLoad == "level3_window") img = level3_window;	
			else if (toLoad == "bookCase") img = bookCase;	
			
			// others now handled by special cases.
			
			//else if (toLoad == "filingCab1") img = filingCab1;	
			//else if (toLoad == "filingCab2") img = filingCab2;	
			//else if (toLoad == "plant1") img = plant1;	
			//else if (toLoad == "plant2") img = plant2;	
			
			else if (toLoad == "level3_cloud") img = level3_cloud;	
			else if (toLoad == "level3_desk1") img = level3_desk1;	
			else if (toLoad == "level3_desk2") img = level3_desk2;	
			else if (toLoad == "level3_desk3") img = level3_desk3;	
			else if (toLoad == "level3_MG_pylon") img = level3_MG_pylon;	
			else if (toLoad == "level3_painting1") img = level3_painting1;	
			else if (toLoad == "level3_painting2") img = level3_painting2;	
			else if (toLoad == "level3_painting3") img = level3_painting3;	
			else if (toLoad == "level3_salesChart") img = level3_salesChart;		
			
			else if (toLoad == "LargeCrate") {
				largeCrate = new LargeCrate(item.@x, item.@y);
				levelBlocks.add(largeCrate);
				largeCrates.add(largeCrate);
				return;
				
			}
			
			else if (toLoad == "AndreCheckPoint") {
				checkPoint = new CheckPoint(item.@x, item.@y, 0);
				checkPoints.add(checkPoint);
				return;
				
			}
			else if (toLoad == "LiselotCheckPoint") {
				checkPoint = new CheckPoint(item.@x, item.@y, 1);
				checkPoints.add(checkPoint);
				return;
				
			}			
			else if (toLoad == "helpBox") {
				//if (!Registry.oldSchoolMode) {
					helpBox = new HelpBox(item.@x, item.@y, item.@helpString);
					helpBox.scrollFactor.x = 1;
					helpBox.scrollFactor.y = 1;
					helpBoxes.add(helpBox);
					return;
				//}
			}
			else if (toLoad == "plant1" || toLoad == "plant2") {
				
				if (toLoad == "plant1")
					_type = 1;
				else if (toLoad == "plant2")
					_type = 2;
					
				plant = new Plant(item.@x, item.@y, _type);
				if (overrideScrollFactor == 1)
					plant.scrollFactor.x = 1;
				else
					plant.scrollFactor.x = item.@scrollFactor;
					
				plant.scrollFactor.y = 1;
				plants.add(plant);
				return;
			}				
			else if (toLoad == "filingCab1" || toLoad == "filingCab2") {
				
				if (toLoad == "filingCab1")
					_type = 1;
				else if (toLoad == "filingCab2")
					_type = 2;
					
				filingCab = new FilingCabinet(item.@x, item.@y, _type);
				if (overrideScrollFactor == 1)
					filingCab.scrollFactor.x = 1;
				else
					filingCab.scrollFactor.x = item.@scrollFactor;
					
				filingCab.scrollFactor.y = 1;
				filingCabs.add(filingCab);
				return;
			}			
			
			else {
				Ax.log(toLoad + " is causing a problem. ");
				return;
			};
			
			if (item.@width!=undefined) {
				//trace("success kid" + item + item.@width) ;
				bgTile = new AxTileblock(item.@x, item.@y, item.@width, item.@height);
				bgTile.loadTiles(img, 0, 0, 0, false);
				
				if (item.@scrollFactor != undefined)
					if (overrideScrollFactor==1)
						bgTile.scrollFactor.x = 1;
					else
						bgTile.scrollFactor.x = item.@scrollFactor;
					
				add(bgTile);
				if (toLoad=="spike0" || toLoad=="spike1" || toLoad=="spike2" || toLoad=="spike3" || toLoad=="level2_spike0" || toLoad=="level2_spike1" || toLoad=="level2_spike2" || toLoad=="level2_spike3" || toLoad=="level3_spike0" || toLoad=="level3_spike1" || toLoad=="level3_spike2" || toLoad=="level3_spike3" )
					hazards.add(bgTile);
				else
					add(bgTile);
				
				
			}
			else {
				bgSprite = new AxSprite(item.@x, item.@y, img)
				
				if (item.@scrollFactor != undefined) {
					if (overrideScrollFactor==1)
						bgSprite.scrollFactor.x = 1;
					else
						bgSprite.scrollFactor.x = item.@scrollFactor;
				}
					
				if (toLoad == "level1_specialBlock" || toLoad == "level1_specialPlatform" || toLoad == "level2_specialBlock" || toLoad == "level2_specialPlatform" || toLoad == "level3_specialBlock" || toLoad == "level3_specialPlatform"  ) {
					bgSprite.solid = true;
					bgSprite.moves = false;
					bgSprite.immovable = true;
					levelBlocks.add(bgSprite);
				}
				if (toLoad == "level1_specialPlatformSmall" || toLoad == "level2_specialPlatformSmall" ||  toLoad == "level3_specialPlatformSmall"  ) {
					bgSprite.loadGraphic(img, false, false, 40);
					bgSprite.solid = true;
					bgSprite.moves = false;
					bgSprite.immovable = true;
					bgSprite.width = 40;
					levelBlocks.add(bgSprite);
				}
				else
					add(bgSprite);			
			}
		}

		override public function create():void
		{
			Ax.mouse.hide();
			
			levelFinished = false;
			hasCollectedCap = false;
			hasTalkedToAndre = false;
			hasTalkedToEnemy = false;
			
			var bg:AxTileblock;
			
			deathSound = new AxSound();
			
			if (Registry.levelType==1) {
				Ax.bgColor = 0xffF8CB8F;
				
				bg = new AxTileblock(0, 0, Ax.width, Ax.height);
				bg.loadTiles(level1_bgSmoothGrad, 1, 512, 0);
				bg.scrollFactor.x = bg.scrollFactor.y = 0;
				
				add(bg);
				
			}
			if (Registry.levelType==2) {
				Ax.bgColor = 0xff92D588;
				
				bg = new AxTileblock(0, 0, Ax.width, Ax.height);
				bg.loadTiles(level2_gradient, 1, 512, 0);
				bg.scrollFactor.x = bg.scrollFactor.y = 0;
				
				add(bg);
			}
			if (Registry.levelType==3) {
				Ax.bgColor = 0xffE3C179;
				
				bg = new AxTileblock(0, 0, Ax.width, Ax.height);
				bg.loadTiles(level3_gradient, 1, 512, 0);
				bg.scrollFactor.x = bg.scrollFactor.y = 0;
				
				add(bg);
			}			
			
						
			levelWidth = Registry.level.width;
			levelHeight = Registry.level.height;
			
			levelBlocks = new AxGroup();
			hazards = new AxGroup();
			helpBoxes = new AxGroup();
			plants = new AxGroup();
			filingCabs = new AxGroup();
			checkPoints = new AxGroup();
			largeCrates = new AxGroup();
			
				
				
			
			for each(var p:XML in Registry.level.BGLayer1.*) {
				//trace(p.name());
				this.loadItem(p, p.name().toString(),0);
			}
			for each(p in Registry.level.BGLayer2.*) {
				//trace(p.name());
				this.loadItem(p, p.name().toString(),0);
			}	
			
			for each(p in Registry.level.movingPlatforms.*) {
				this.loadMovingPlatform(p, p.name().toString());
			}
			
			for each(p in Registry.level.extraPlatforms.*) {
				//trace(p.name());
				this.loadItem(p, p.name().toString(),0);
			}	
			

			
			
			//Load an Ogmo level File
			//var level:OgmoLevel = new OgmoLevel(Registry.level);
			
			// Set rectTiles
			var t:XML;
			var u:XML;
			
			
			
			

			for each (t in Registry.level.solids)
			{
				//figure out the map dimesions based on the xml and set variables			
				//Ax.log(t);
				
				for each (u in t.rect) {
			
					b = new AxTileblock(u.@x, u.@y, u.@w, u.@h);
					if (Registry.levelType==1)
						b.loadTiles(ImgTiles, 10, 10, 0, true);
					else if (Registry.levelType==2)
						b.loadTiles(ImgTiles2, 10, 10, 0, true);
					else if (Registry.levelType==3)
						b.loadTiles(ImgTiles3, 10, 10, 0, true);
					else 
						Ax.log("Problems selecting tiles to load");
						
					b.solid = true;
					b.immovable = true;
					levelBlocks.add(b);
				}
			}
			
			
			add(helpBoxes);
			
			add(plants);
			
			add(filingCabs);
			
			add(levelBlocks);
			
			add(hazards);
			
			add(checkPoints);
			
			crates = new AxGroup();
			
			pickUps = new AxGroup();
			
			exits = new AxGroup();

			for each (t in Registry.level.objects)
			{
				for each (u in t.L1_SmallCrate) {
					crates.add(new Crate(u.@x,u.@y-13));
				}
				
				for each (u in t.Bottle) {
					pickUps.add(new SoftDrink(u.@x,u.@y));
				}
				for each (u in t.smallSugarBag) {
					pickUps.add(new SugarBag(u.@x, u.@y));
				}
				for each (u in t.exit) {
					exits.add(exit= new Exit(u.@x, u.@y-20,u.@nextLevel));
				}
				for each (u in t.andreCheckPoint) {
					checkPoint = new CheckPoint(u.@x, u.@y, 0);
					checkPoints.add(checkPoint);				
				}				
				for each (u in t.liselotCheckPoint) {
					checkPoint = new CheckPoint(u.@x, u.@y, 1);
					checkPoints.add(checkPoint);
				}
			}
			
			add(pickUps);
			add(exits);
			add(crates);
			
			enemies = new AxGroup();			
			
			players = new AxGroup(2);
			
			talkCharacters = new AxGroup();
			
			for each(p in Registry.level.characters.*) {
				//trace(p.name().toString() +  " jsut adddddded ");
				this.loadCharacter(p, p.name().toString());
			}	
						
			players.add(player1);
			players.add(player2);
			
			talkCharacters.add(player1);
			
			add(enemies);
			add(players);
			
			
			//fake level blocks
			for each (t in Registry.level.fakesolids)
			{
				for each (u in t.rect) {
					b = new AxTileblock(u.@x, u.@y, u.@w, u.@h);
					if (Registry.levelType==1)
						b.loadTiles(ImgTiles, 10, 10, 0, true);
					else if (Registry.levelType==2)
						b.loadTiles(ImgTiles2, 10, 10, 0, true);
					else if (Registry.levelType==3)
						b.loadTiles(ImgTiles3, 10, 10, 0, true);
					else 
						Ax.log("Problems selecting tiles to load");
						
					b.solid = true;
					b.immovable = true;
					add(b);
				}
			}
			
			for each(p in Registry.level.BGLayer3.*) {
				//trace(p.name());
				this.loadItem(p, p.name().toString(),1);
			}
			
			bubbles = new AxEmitter();
			bubbles.makeParticles(ImgBubbles, 100, 32, true, 0);
			bubbles.setRotation(0,0);
			bubbles.setYSpeed(-80,-15);
			bubbles.setXSpeed(-40,40);
			bubbles.gravity = -30;
			add(bubbles);
			
			crateShards = new AxEmitter();
			crateShards.makeParticles(ImgCrateShards, 100, 32, true, 0);
			crateShards.setRotation(-90,90);
			crateShards.setYSpeed(-150,15);
			crateShards.setXSpeed(-140,140);
			crateShards.gravity = 300;
			crateShards.setSize(80, 60);
			add(crateShards);
			
			for each(p in Registry.level.FGLayer1.*) {
				//trace(p.name());
				this.loadItem(p, p.name().toString(),0);
			}
			
			if (Registry.playersNo == 2) {
				//2 players -- 
				//vertical split set up
				if (Registry.splitScreenType==1) {
					cam = new AxCamera(0,0, Ax.width/2, Ax.height); // we put the first one in the top left corner
					cam.follow(player1, AxCamera.STYLE_PLATFORMER);
					// this sets the limits of where the camera goes so that it doesn't show what's outside of the tilemap
					if (followWidth!=0 && followHeight!=0)
						cam.setBounds(0, 0, followWidth, followHeight, true);
					else
						cam.setBounds(0, 0, levelWidth, levelHeight, true);
					//cam.color = 0xeeFFCCCC; // add a light red tint to the camera to differentiate it from the other
					Ax.addCamera(cam);
					
					// Almost the same thing as the first camera
					cam2 = new AxCamera(Ax.width,0, Ax.width/2, Ax.height);    // and the second one in the top middle of the screen
					cam2.follow(player2, AxCamera.STYLE_PLATFORMER);
					
					
					if (followWidth!=0 && followHeight!=0)
						cam2.setBounds(0, 0, followWidth, followHeight, true);
					else
						cam2.setBounds(0, 0, levelWidth, levelHeight, true);
						
					cam2.color = 0xFFE6E6; // Add a light blue tint to the camera
					Ax.addCamera(cam2);
				}
				
				
				//horizontal
				else if (Registry.splitScreenType==2) {
					cam = new AxCamera(0,0, Ax.width, Ax.height/2); // we put the first one in the top left corner
					cam.follow(player1, AxCamera.STYLE_PLATFORMER);
					// this sets the limits of where the camera goes so that it doesn't show what's outside of the tilemap
					if (followWidth!=0 && followHeight!=0)
						cam.setBounds(0, 0, followWidth, followHeight, true);
					else
						cam.setBounds(0, 0, levelWidth, levelHeight, true);
					//cam.color = 0xeeFFCCCC; // add a light red tint to the camera to differentiate it from the other
					Ax.addCamera(cam);
					
					// Almost the same thing as the first camera
					cam = new AxCamera(0,Ax.height, Ax.width, Ax.height/2);    // and the second one in the top middle of the screen
					cam.follow(player2, AxCamera.STYLE_PLATFORMER);
					if (followWidth!=0 && followHeight!=0)
						cam.setBounds(0, 0, followWidth, followHeight, true);
					else
						cam.setBounds(0, 0, levelWidth, levelHeight, true);
					
					cam.color = 0xFFE6E6; // Add a light blue tint to the camera
					Ax.addCamera(cam);
					
/*					var bar:AxSprite = new AxSprite(0, Ax.height / 2 - 2, null);
					bar.makeGraphic(4, Ax.height, 0xff000000);
					add(bar);*/
					
				}
				
				
				
/*				allCam = new AxCamera(0,0, Ax.width, Ax.height); // we put the first one in the top left corner
				allCam.follow(player1, AxCamera.STYLE_PLATFORMER);
				// this sets the limits of where the camera goes so that it doesn't show what's outside of the tilemap
				allCam.setBounds(0,0,levelWidth, levelHeight, true);
				//cam.color = 0xeeFFCCCC; // add a light red tint to the camera to differentiate it from the other
				allCam.alpha = 0;
				Ax.addCamera(allCam);	
				Ax.watch(allCam, "alpha", "alpha");*/
			}
			
			// 1 player -- 
			else {
				cam = new AxCamera(0,0, Ax.width, Ax.height); // we put the first one in the top left corner
				cam.follow(player1, AxCamera.STYLE_PLATFORMER);
				// this sets the limits of where the camera goes so that it doesn't show what's outside of the tilemap
				if (followWidth!=0 && followHeight!=0)
					cam.setBounds(0, 0, followWidth, followHeight, true);
				else
					cam.setBounds(0, 0, levelWidth, levelHeight, true);
				//cam.color = 0xeeFFCCCC; // add a light red tint to the camera to differentiate it from the other
				Ax.addCamera(cam);
				
			}
			
			
			if (Registry.playersNo==1) {
				helpOverlayP1 = new HelpOverlay(30, 10);
				helpOverlayP1.visible = false;
				helpOverlayP1.scrollFactor.x = 0;
				helpOverlayP1.scrollFactor.y = 0;
				add(helpOverlayP1);
				
				helpOverlayTextP1 = new AxText(50, 12, 380, "", true);
				helpOverlayTextP1.alignment = "left";
				helpOverlayTextP1.visible = false;
				helpOverlayTextP1.size = 16;
				helpOverlayTextP1.scrollFactor.x = 0;
				helpOverlayTextP1.scrollFactor.y = 0;
				add(helpOverlayTextP1);
			}
			else if (Registry.playersNo==2) {
				helpOverlayP2 = new HelpOverlaySmall(10000, 10000);
				helpOverlayP2.scrollFactor.x = 1;
				helpOverlayP2.scrollFactor.y = 1;
				add(helpOverlayP2);
				
				helpOverlayTextP2 = new AxText(10020, 10005, 216, "", true);
				helpOverlayTextP2.alignment = "left";
				helpOverlayTextP2.size = 8;
				helpOverlayTextP2.antialiasing = false;
				helpOverlayTextP2.scrollFactor.x = 1;
				helpOverlayTextP2.scrollFactor.y = 1;
				
				add(helpOverlayTextP2);
				
				helpOverlayP1 = new HelpOverlaySmall(10256, 10000);
				helpOverlayP1.scrollFactor.x = 1;
				helpOverlayP1.scrollFactor.y = 1;
				add(helpOverlayP1);
				
				helpOverlayTextP1 = new AxText(10276, 10005, 216, "", true);
				helpOverlayTextP1.alignment = "left";
				helpOverlayTextP1.size = 8;
				helpOverlayTextP1.antialiasing = false;
				helpOverlayTextP1.scrollFactor.x = 1;
				helpOverlayTextP1.scrollFactor.y = 1;
				add(helpOverlayTextP1);
				
				
				
				
				
				helpCamP2 = new AxCamera(0,0, Ax.width/2, 50); 
				Ax.addCamera(helpCamP2);
				helpCamP2.follow(helpOverlayP2);
				
				helpCamP1 = new AxCamera(Ax.width,0, Ax.width/2, 50); 
				Ax.addCamera(helpCamP1);
				helpCamP1.follow(helpOverlayP1);				
				
				
/*				helpCamP2 = new AxCamera(10+Ax.width/2,10, Ax.width/2, 50); // we put the first one in the top left corner
				Ax.addCamera(helpCamP2);	*/			
				
				
			}		
			
			speechBlock = new AxTileblock( 0, 0, 180, 300);
			//speechBlock.height = 600;
			speechBlock.loadTiles(ImgSpeechTiles, 10, 10, 0, true);
			add(speechBlock);
			
			speechText = new AxText(0, 0, 175, "", true);
			speechText.setFormat("commodore", 8);
			speechText.alignment = "left";
			speechText.size = 8;
			speechText.color = 0xFF000000;
			add(speechText);
			
			infoText = new AxText(30, Ax.height-80, Ax.width, "", true);
			infoText.alignment = "left";
			infoText.size = 24;
			infoText.color = 0x8000FF;
			infoText.shadow = 0xFFFFFFFF;
			infoText.scrollFactor.x = infoText.scrollFactor.y = 0;
			add(infoText);
			
			if (Registry.attractMode) {
				
				infoText.text = "ATTRACT MODE";
			}
			
			Ax.debug = true;
			

			
			// bar between two splits
			
			if (Registry.playersNo == 2) {
				var bar:AxSprite = new AxSprite(Ax.width / 2 - 4, 0, null);
				bar.makeGraphic(8, Ax.height, 0xff000000);
				bar.scrollFactor.x = bar.scrollFactor.y = 0;
				add(bar);
			}
			
			gameOverDarken = new AxSprite(0, 0, null);
			gameOverDarken.makeGraphic(Ax.width, Ax.height, 0xff000000);
			gameOverDarken.alpha = 0.5;
			gameOverDarken.visible = false;
			gameOverDarken.scrollFactor.x = gameOverDarken.scrollFactor.y = 0;
			add(gameOverDarken);
			
			playBtn = new AxButton(100, 20, "Play Again", resetLevel);
			playBtn.visible = false;
			playBtn.scrollFactor.x = playBtn.scrollFactor.y = 0;
			playBtn.color = Registry.WAREHOUSE_PURPLE;
			playBtn.label.color = 0xffffffff;
			add(playBtn);
			playBtn.status = AxButton.HIGHLIGHT;
			
			restartBtn = new AxButton(100, 20, "Restart Level", resetLevel);
			restartBtn.visible = false;
			restartBtn.scrollFactor.x = restartBtn.scrollFactor.y = 0;
			restartBtn.color = Registry.WAREHOUSE_PURPLE;
			restartBtn.label.color = 0xffffffff;
			add(restartBtn);
			restartBtn.status = AxButton.HIGHLIGHT;
			
			if (Registry.oldSchoolMode) {
				restartBtn.regularText = "Restart Game";
				restartBtn.highlightedText = "Restart Game";
				
				
			}
			
			menuBtn = new AxButton(300, 20, "To Menu", goToMenu);
			menuBtn.visible = false;
			menuBtn.scrollFactor.x = menuBtn.scrollFactor.y = 0;
			menuBtn.color = Registry.WAREHOUSE_PURPLE;
			menuBtn.label.color = 0xffffffff;
			add(menuBtn);
			
			if (Registry.playersNo == 2) {
				menuBtn.x = 100;
				menuBtn.y = 50;
			}
			
			pauseInstructions = new AxText(100, 0 , Ax.width/2, "Press P to resume.", true);
			pauseInstructions.visible = false;
			pauseInstructions.alignment = "left";
			pauseInstructions.size = 8;
			pauseInstructions.color = 0xffffff;
			pauseInstructions.shadow = 0x000000;
			pauseInstructions.scrollFactor.x = pauseInstructions.scrollFactor.y = 0;
			add(pauseInstructions);
			
			if (Ax.usingJoystick) {
				pauseInstructions.text = "Press P or START to resume";
			}
			
			_hud = new HUD();
			add(_hud);
			
			if (player1.startsFirst == 0 && Registry.playersNo==1 ) {
				switchCharacters(false,0,false);
			}
			gameOverScreen = false;
			currentButton = 0;
			
		}

		override public function update():void
		{
			
			/* 
			 * remove from final build! --  -----------------------------------------
			 */
			
			/*
			if (Ax.debug==true) {
				if (Ax.keys.justPressed("SEVEN")) 
				{
					player1.reset(exits.members[0].x - 0, exits.members[0].y);
					player2.reset(exits.members[0].x - 0, exits.members[0].y);
				}
				else if (Ax.keys.justPressed("EIGHT")) 
				{
					Registry.levelNumber = 11;
					Registry.levelType = 3;
					Registry.hardCore = true;
					
				}
			}
			*/
				
			
			
			// --------------------------------------------------------------------
			
			if (Ax.keys.justPressed("P") || (Ax.joystick.j1ButtonStartJustPressed)   || (Ax.joystick.j2ButtonStartJustPressed) ) {
				Ax.paused = !Ax.paused;
				
				if (Ax.paused) {
					Ax.music.pause();
					pauseInstructions.visible = true;
					menuBtn.visible = true;
					restartBtn.visible = true;
					gameOverDarken.visible = true;
				}
				else {
					Ax.music.play();
					pauseInstructions.visible = false;
					menuBtn.visible = false;
					restartBtn.visible = false;
					gameOverDarken.visible = false;
				}
				
			}
			
			
			if (followWidth != 0 && followWidth!=levelWidth) {
				if (player1.x > followWidth || player2.x > followWidth) {
					if (Registry.playersNo == 2) {
						cam2.setBounds(0, 0, levelWidth, levelHeight, true);
					}
					cam.setBounds(0, 0, levelWidth, levelHeight, true);
				}
			}
			
			
			
			if (!levelFinished && !Ax.keys.pressed(Registry.p1Jump) && !Ax.joystick.j1ButtonAPressed ) {
				Registry.canJump = true;
				//Ax.log("resetor");
				
			}
			
			
			if (gameOverScreen) {
				if (currentButton == 0) {
					playBtn.status = AxButton.HIGHLIGHT;
					menuBtn.status = AxButton.NORMAL;
					
				}
				else if (currentButton == 1) {
					playBtn.status = AxButton.NORMAL;
					menuBtn.status = AxButton.HIGHLIGHT;
					
				}
				
				if (Ax.keys.justPressed(Registry.p1Left) || Ax.keys.justPressed(Registry.p1Right) || Ax.joystick.j1Stick1LeftJustPressed  || Ax.joystick.j1Stick1RightJustPressed || Ax.keys.justPressed(Registry.p1Down) || Ax.keys.justPressed(Registry.p1Up) || Ax.joystick.j1Stick1DownJustPressed  || Ax.joystick.j1Stick1UpJustPressed) 
				{
					Ax.play(Registry.SndBlip, 0.5, false);
					
					if (currentButton == 1) {
						currentButton = 0;
					}
					else if (currentButton == 0) {
						currentButton = 1;
					}
				}				
				
				if (Ax.keys.justPressed(Registry.p1Action) || Ax.keys.justPressed(Registry.p1Switch) || Ax.keys.justPressed(Registry.p1Jump) || Ax.joystick.j1ButtonAJustPressed || Ax.joystick.j1ButtonBJustPressed  ) 
				{
					Ax.play(Registry.SndPing, 0.5);
					
					if (currentButton == 0) {
						if (!Registry.oldSchoolMode)
							this.resetLevel();
						else {
							Registry.levelNumber = 1;
							
							Registry.level = XML(new Registry.Level1);
							
							Ax.switchState(new PCPlayState());
						}
					}
					else if (currentButton == 1) {
						this.goToMenu(false);
					}
					return;
					
				}
			}
			
			
			Ax.collide(enemies, levelBlocks);
						
			Ax.collide(player1, crates);
			
			if (!player2._isPiggyBacking) {
				Ax.collide(player2, crates);
			}
			
			Ax.collide(enemies, crates);
						
			Ax.collide(player1, levelBlocks, checkForLargeCrate);
			
			
						
			Ax.overlap(players, pickUps, getPickUp);
			
			Ax.overlap(players, plants, blowLeaves);
			
			Ax.overlap(players, filingCabs, openCabs);
			
			if ((Registry.playersNo==1 && player1._currentlyControlled) || Registry.playersNo==2){
				Ax.overlap(player1, hazards, killCharacter);
				if (!player1.flickering)
					Ax.overlap(player1, enemies, killCharacter);	
			}
			
			if ( (player2._isPiggyBacking==false && Registry.playersNo==1 && player2._currentlyControlled ) || Registry.playersNo==2) {
				if (!player2.flickering)
					Ax.overlap(player2, enemies, killCharacter);
			}
			
			if ( player2._isPiggyBacking==false ) {
				Ax.overlap(player2, hazards, killCharacter);
				Ax.collide(player2, levelBlocks );
			}
			
			//Only piggy back if level is still playing
			//Don't want to allow player input when level over.
			
			//if (Ax.joystick.j1ButtonYJustPressed) { Ax.log("Just pressed Y"); }
			
			
			if (levelFinished==false)
				Ax.overlapWithOffset(player1, player2, 40,0,piggyback);				
				
			if ((Ax.joystick.j1ButtonYJustPressed || Ax.keys.justPressed(Registry.p1Piggyback)  || Ax.keys.justPressed(Registry.p2Piggyback) )&& Ax.overlapWithOffset(player1, player2, 40,0) ) {
				if (!player1._isPiggyBacking &&  !player2._isPiggyBacking )
					Ax.play(SndOnShoulders, 0.45);
				
				//Ax.log("ok, has pressed Y");
					
				if (player1._isPiggyBacking == true)
				{
					//Ax.log("\nif part 1");
					
					player1._isPiggyBacking = false;
					player2._isPiggyBacking = false;
				}
				else {
					//Ax.log("\nif part 2");
					cam.follow(player1, AxCamera.STYLE_PLATFORMER);
					
					player1._currentlyControlled = true;
					player2._currentlyControlled = false;
					
					player1._isPiggyBacking = true;
					player2._isPiggyBacking = true;
					//Ax.log((Sprite1 as PlayerMale)._isPiggyBacking + " " + (Sprite2 as PlayerFemale)._isPiggyBacking);
				}	
			}
				
			
			Ax.collide(levelBlocks, crates);
			
			Ax.overlap(players, checkPoints, touchedCheckPoint);
				
			var ok:Boolean = false;
			
			if ( ((Ax.keys.justPressed(Registry.p1Action) || Ax.joystick.j1ButtonXJustPressed) && Registry.playersNo==1 && levelFinished==false && player2._currentlyControlled) || ((Ax.keys.justPressed(Registry.p2Action) || Ax.joystick.j2ButtonXJustPressed ) && Registry.playersNo==2 && (levelFinished==false))  ) {
				for (i = 0; i < talkCharacters.length; i++) {
				//trace(i + " " + enemies.members[i]);
					if (AxU.getDistance(new AxPoint(player2.x, player2.y), new AxPoint(talkCharacters.members[i].x, talkCharacters.members[i].y)) < 80 && !ok ) {
						//Ax.log((enemies.members[i] as Enemy)._talkString);
						
						if (talkCharacters.members[i] is Character) {
							hasTalkedToAndre = true;
							speechBlock.visible = true;
							speechText.visible = true;
							speechBlock.x = (talkCharacters.members[i] as PlayerMale).x-20;
							speechBlock.y = (talkCharacters.members[i] as PlayerMale).y-80;
							speechText.x = (talkCharacters.members[i] as PlayerMale).x-15;
							speechText.y = (talkCharacters.members[i] as PlayerMale).y-75;					
							speechText.text = (talkCharacters.members[i] as PlayerMale)._talkString;
							
							speechBlock.height = speechText.height + 11;
							//speechBlock.width += 10;
							
							speechBlock.loadTiles(ImgSpeechTiles, 10, 10, 0, true);
							
							(talkCharacters.members[i] as PlayerMale)._talk = true;
							
							(talkCharacters.members[i] as PlayerMale).play("talk");
						}
						else {
							player1._talk = false;
							hasTalkedToEnemy = true;
							speechBlock.visible = true;
							speechText.visible = true;
							speechBlock.x = (talkCharacters.members[i] as Enemy).x-20;
							speechBlock.y = (talkCharacters.members[i] as Enemy).y-80;
							speechText.x = (talkCharacters.members[i] as Enemy).x-15;
							speechText.y = (talkCharacters.members[i] as Enemy).y-75;					
							speechText.text = (talkCharacters.members[i] as Enemy)._talkString;
							
							speechBlock.height = speechText.height + 11;
							//speechBlock.width += 10;
							
							speechBlock.loadTiles(ImgSpeechTiles, 10, 10, 0, true);
							
							(talkCharacters.members[i] as Enemy)._talk = true;
							
							(talkCharacters.members[i] as Enemy).play("talk");	
							
						}
						
						if (speechBlock.x > levelWidth - speechBlock.width) {
							speechBlock.x = levelWidth - speechBlock.width;
							speechText.x = speechBlock.x + 5;
							
						}
						
						
						ok = true;
						
						
						
					}
				}
				if (ok == false) {
					speechBlock.visible = false;
					speechText.visible = false;
				}
			}
			
			var canHideTalk:Boolean = false;
			for (var i:int = 0; i < talkCharacters.length; i++) {
				if (talkCharacters.members[i]._talk == true) {
					canHideTalk = true;
				}
			}
			if (canHideTalk == false) {
				speechBlock.visible = false;
				speechText.visible = false;
			}
			
			if (Registry.playersNo==2) {
				if (!Ax.overlap(player2, helpBoxes, showHelp)) {
	/*				helpOverlayP1.visible = false;
					helpOverlayTextP1.visible = false;*/
					helpCamP1.visible = false;
				}
				if (!Ax.overlap(player1, helpBoxes, showHelp)) {
	/*				helpOverlayP2.visible = false;
					helpOverlayTextP2.visible = false;*/
					helpCamP2.visible = false;
				}			
			}
			else if (Registry.playersNo == 1) {
				if (player2._currentlyControlled) {
					if (!Ax.overlap(player2, helpBoxes, showHelp)) {
						helpOverlayP1.visible = false;
						helpOverlayTextP1.visible = false;				
						
					}
				}
				else if (player1._currentlyControlled) {
					if (!Ax.overlap(player1, helpBoxes, showHelp)) {
						helpOverlayP1.visible = false;
						helpOverlayTextP1.visible = false;				
						
					}
				}
			}
			if (!Ax.paused)
				super.update();
			else {
				
				// While paused.
				
				if (Ax.keys.justPressed(Registry.p1Left) || Ax.keys.justPressed(Registry.p1Right) || Ax.joystick.j1Stick1LeftJustPressed  || Ax.joystick.j1Stick1RightJustPressed) {
					
					Ax.play(Registry.SndBlip, 0.6);
					
					if (restartBtn.status == AxButton.HIGHLIGHT) {
						menuBtn.status = AxButton.HIGHLIGHT;
						restartBtn.status = AxButton.NORMAL;
					}
					else {
						restartBtn.status = AxButton.HIGHLIGHT;
						menuBtn.status = AxButton.NORMAL;
					}
					
					menuBtn.draw();
					restartBtn.draw();					
					
					menuBtn.update();
					restartBtn.update();
				}
				if (Ax.keys.justPressed(Registry.p1Action) ||  Ax.keys.justPressed(Registry.p1Switch) || Ax.keys.justPressed(Registry.p1Jump) || Ax.joystick.j1ButtonAJustPressed ) {
					if (restartBtn.status == AxButton.HIGHLIGHT) {
						Ax.play(Registry.SndPing, Registry.pingVolume);
						this.resetLevel();
						Ax.paused = false;
						
						menuBtn.visible = false;
						restartBtn.visible = false;
						pauseInstructions.visible = false;
						Registry.canJump = false;
						
					}
					else {
						Ax.play(Registry.SndPing, Registry.pingVolume);
						
						this.goToMenu(false);
					}
				}
			}
			
			
			/**
			 * TO BE REMOVED - ABSOLUTELY REMOVED - 
			 */
			var vel:Number = 30;
			
			if (Ax.joystick.j1Stick2LeftPressed) {
				if (player1._currentlyControlled) player1.velocity.x -= vel;
				//if (player2._currentlyControlled) player2.velocity.x -= vel;
			}
			
			if (Ax.joystick.j1Stick2RightPressed)
				if (player1._currentlyControlled) player1.velocity.x += vel;				
				//if (player2._currentlyControlled) player2.velocity.x += vel;				
			
			if (Ax.joystick.j1Stick2UpPressed) {
				if (player1._currentlyControlled) player1.velocity.y -= vel;	
				//if (player2._currentlyControlled) player2.velocity.y -= vel;	
				
			}
			
			if (Ax.joystick.j1Stick2DownPressed)
				player1.velocity.y += vel;	
				
				
				
			
			if (Ax.keys.justPressed(Registry.homeKey) || Ax.joystick.j1ButtonBackJustPressed) {
				if (!Registry.oldSchoolMode)
					onQuit();			
				
			}
			
/*			if (Ax.keys.G) {
				player1.x = player2.x = exit.x;
				player1.y = player2.y = exit.y;
			}*/
			
			if ((Ax.keys.justPressed(Registry.p1Switch) || Ax.joystick.j1ButtonBJustPressed) && Registry.playersNo == 1 && !player1._isPiggyBacking && levelFinished==false ) {
				switchCharacters();
			}
			
			if (player1._isPiggyBacking) {
				player2.x = player1.x;
				player2.y = player1.y-player1.height+1;
			}
			
			for (i = 0; i < exits.length; i++) {
				if (Ax.overlap(players, exits.members[i], openDoor)) {
					
				}
				else {
					(exits.members[i] as Exit).play("closed");
				}
			
			}
			
/*			if (Ax.overlap(player1, exits, openDoor) || Ax.overlap(player2, exits, openDoor) ) {
				//exit.play("open");
			}*/
/*			else {
				for (var i:int = 0; i < exits.length; i++) {
					(exits.members[i] as Exit).play("closed");
					
				
				}
			}*/
			
			if (Ax.overlap(player1, exits, setNextLevel) && Ax.overlap(player2, exits, setNextLevel) && (AxU.getDistance(new AxPoint(player1.x, player1.y), new AxPoint(player2.x, player2.y)  ) )<100 )
			{
				this.levelOver();
			}
				
			
/*			if ( (Ax.keys.justPressed("UP") || Ax.keys.justPressed("I") ) && player1._isPiggyBacking ) {
				//if (player1._isPiggyBacking) {
					player1._isPiggyBacking = false;
					player2._isPiggyBacking = false;
					player2.x = player1.x;
					player2.y = player1.y;
					player2.visible = true;
					
				//}
			}*/
			
		}
		

		
		
		protected function setNextLevel(Sprite1:AxSprite, Sprite2:AxSprite):void {
			Registry.winniNextLevel = (Sprite2 as Exit)._nextLevel;
			
		}
		
		protected function openDoor(Sprite1:AxSprite, Sprite2:AxSprite):void {
			(Sprite2 as Exit).play("open");
			
		}
		
		protected function blowLeaves(Sprite1:AxSprite, Sprite2:AxSprite):void {
			(Sprite2 as Plant).blowLeaves();
			
		}
		
		protected function openCabs(Sprite1:AxSprite, Sprite2:AxSprite):void {
			(Sprite2 as FilingCabinet).closeDoors();
			
		}
		
		protected function showHelp(Sprite1:AxSprite, Sprite2:AxSprite):void
		{
			if(!Registry.oldSchoolMode) {
				if (Registry.playersNo == 1) {
					helpOverlayTextP1.text = (Sprite2 as HelpBox)._helpString;
					helpOverlayP1.visible = true;
					helpOverlayTextP1.visible = true;
					(Sprite2 as HelpBox).play("Idle", true);
				}
				
				else if (Registry.playersNo == 2) {
					if (Sprite1 is PlayerFemale) {
						//Ax.log("fem");
						helpOverlayTextP1.text = (Sprite2 as HelpBox)._helpString;
						helpOverlayP1.visible = true;
						helpOverlayTextP1.visible = true;
						(Sprite2 as HelpBox).play("Idle", true);
						helpCamP1.visible = true;
					}
					else if (Sprite1 is PlayerMale) {
						//Ax.log("mal 2");
						helpOverlayTextP2.text = (Sprite2 as HelpBox)._helpString;
						helpOverlayP2.visible = true;
						helpOverlayTextP2.visible = true;
						(Sprite2 as HelpBox).play("Idle", true);
						helpCamP2.visible = true;
					}
				}
			}
		}
		
		
		
		protected function touchedCheckPoint(Sprite1:AxSprite, Sprite2:AxSprite):void
		{
			var i:int;
			if ((Sprite1 is PlayerMale) && ((Sprite2 as CheckPoint).type)==0 ){
				//(Sprite2 as CheckPoint).play("checked", true);
				
				if ((Sprite2 as CheckPoint).checked==false)
					Ax.play(SndCheckPoint, 0.8, false);
				
				(Sprite1 as PlayerMale).checkPointValue = new AxPoint(((Sprite2 as CheckPoint).x + (Sprite1 as Character).width/2), (Sprite2 as CheckPoint).y);
				
				(Sprite2 as CheckPoint).checked = true;
				
				for (i = 0; i < checkPoints.length; i++) {
					if (checkPoints.members[i].type==0 && (Sprite2!=checkPoints.members[i]) )
						checkPoints.members[i].checked = false;	
				}
			}
			else if ((Sprite1 is PlayerFemale) && ((Sprite2 as CheckPoint).type)==1 ){
				//(Sprite2 as CheckPoint).play("checked", true);
				
				if ((Sprite2 as CheckPoint).checked==false)				
					Ax.play(SndCheckPoint, 0.8, false);
				
				(Sprite1 as PlayerFemale).checkPointValue = new AxPoint( ( (Sprite2 as CheckPoint).x + (Sprite1 as Character).width/2), (Sprite2 as CheckPoint).y);
				
				(Sprite2 as CheckPoint).checked = true;
				
				for (i = 0; i < checkPoints.length; i++) {
					if (checkPoints.members[i].type==1 && (Sprite2!=checkPoints.members[i]) )
						checkPoints.members[i].checked = false;					
				}
				
			}
			
		}
		
		
		protected function checkForLargeCrate(Sprite1:AxSprite, Sprite2:AxSprite):void
		{
			//
							
			if ( (Sprite2 is LargeCrate) && (Sprite1 is PlayerMale) && ((Sprite1 as PlayerMale).airDash < 0.5) && ((Sprite1 as PlayerMale).airDash > 0.05)  ) {
				
				crateShards.at(Sprite2);
				crateShards.start(true, 5, 1, 0);
				
				Sprite2.kill();
				
				Ax.play(SndExp, 0.5);
				
			}
		}
		
		protected function piggyback(Sprite1:AxSprite, Sprite2:AxSprite):void
		{
			if (Registry.playersNo==2) {
				if (Ax.keys.justPressed(Registry.p1Up) || Ax.keys.justPressed(Registry.p2Up)  || Ax.joystick.j1Stick1UpJustPressed  || Ax.joystick.j2Stick1UpJustPressed || Ax.joystick.j1ButtonYJustPressed ) {
					if (!(Sprite1 as PlayerMale)._isPiggyBacking &&  !(Sprite2 as PlayerFemale)._isPiggyBacking )
						Ax.play(SndOnShoulders,0.25);
					(Sprite1 as PlayerMale)._isPiggyBacking = true;
					(Sprite2 as PlayerFemale)._isPiggyBacking = true;
					
				}
				if (Ax.keys.justPressed(Registry.p1Down) || Ax.keys.justPressed(Registry.p2Down) || Ax.joystick.j1Stick1DownJustPressed  || Ax.joystick.j2Stick1DownJustPressed || Ax.joystick.j1ButtonYJustPressed) {
					if ((Sprite1 as PlayerMale)._isPiggyBacking &&  (Sprite2 as PlayerFemale)._isPiggyBacking )
						Ax.play(SndOnShoulders, 0.25);
						
					(Sprite1 as PlayerMale)._isPiggyBacking = false;
					(Sprite2 as PlayerFemale)._isPiggyBacking = false;
					
				}
			}
			else if (Registry.playersNo==1) {
				if (Ax.keys.justPressed(Registry.p1Up) || Ax.joystick.j1Stick1UpJustPressed  ) {
					
					if (!(Sprite1 as PlayerMale)._isPiggyBacking &&  !(Sprite2 as PlayerFemale)._isPiggyBacking )
						Ax.play(SndOnShoulders, 0.45);
						
					cam.follow(player1, AxCamera.STYLE_PLATFORMER);
					
					player1._currentlyControlled = true;
					player2._currentlyControlled = false;
					
					
					(Sprite1 as PlayerMale)._isPiggyBacking = true;
					(Sprite2 as PlayerFemale)._isPiggyBacking = true;
					
					
					
				}
				if (Ax.keys.justPressed(Registry.p1Down) || Ax.joystick.j1Stick1DownJustPressed   ) {
					if ((Sprite1 as PlayerMale)._isPiggyBacking &&  (Sprite2 as PlayerFemale)._isPiggyBacking )
						Ax.play(SndOnShoulders, 0.45);
						
					(Sprite1 as PlayerMale)._isPiggyBacking = false;
					(Sprite2 as PlayerFemale)._isPiggyBacking = false;
					
				}
				
				if (Ax.joystick.j1ButtonYJustPressed) {
					//Ax.log("ok, has pressed Y" + (Sprite1 as PlayerMale)._isPiggyBacking);
				}
/*				if (Ax.joystick.j1ButtonYJustPressed) {
					if (!(Sprite1 as PlayerMale)._isPiggyBacking &&  !(Sprite2 as PlayerFemale)._isPiggyBacking )
						Ax.play(SndOnShoulders, 0.45);
					
					Ax.log("ok, has pressed Y" + (Sprite1 as PlayerMale)._isPiggyBacking);
						
					if ((Sprite1 as PlayerMale)._isPiggyBacking == true)
					{
						Ax.log("\nif part 1");
						
						(Sprite1 as PlayerMale)._isPiggyBacking = false;
						(Sprite2 as PlayerFemale)._isPiggyBacking = false;
					}
					else {
						Ax.log("\nif part 2");
						cam.follow(player1, AxCamera.STYLE_PLATFORMER);
						
						player1._currentlyControlled = true;
						player2._currentlyControlled = false;
						
						(Sprite1 as PlayerMale)._isPiggyBacking = true;
						(Sprite2 as PlayerFemale)._isPiggyBacking = true;
						Ax.log((Sprite1 as PlayerMale)._isPiggyBacking + " " + (Sprite2 as PlayerFemale)._isPiggyBacking);
					}	
				}*/
			}			
		}
		
		
		public function getPickUp(Sprite1:AxSprite, Sprite2:AxSprite):void
		{
			
			Ax.fadeStop();
			Ax.resumeSounds();
			bubbles.at(Sprite2);
			bubbles.start(true, 5, 1, 10);
			
			if (Sprite2 is SoftDrink) {
				hasCollectedCap = true;
				
				try {
					var load_php:URLLoader = new URLLoader(new URLRequest("http://initialscommand.com/php/add.php"));
				}
				catch (error:Error) {
					
				}
				finally {
					
				}
				
			}
			
			if (Sprite2 is SugarBag) {
				_hud.fLives++;
				_hud.mLives++;
				
				Registry.oldSchoolLivesF++;
				Registry.oldSchoolLivesM++;
				
			}
			
			Ax.play(SndPowerUp, 1.0);
			
			(Sprite2 as PickUp).kill();
		}
		
		
		public function killCharacter(Sprite1:AxSprite,Sprite2:AxSprite):void
		{
			//Sprite1.x = (Sprite1 as Character)._startingPosition.x;
			//Sprite1.y = (Sprite1 as Character)._startingPosition.y;
			
			player1._isPiggyBacking = false;
			player2._isPiggyBacking = false;
			
			if ((Sprite1 as Character).dead == false) {
				Ax.play(SndDeath, 1.0, false, true);
				if (Sprite1 is PlayerMale) {
					_hud.mLives--;
					if (_hud.mLives <= -1) {
						this.tryAgain();
					}
				}
				else if (Sprite1 is PlayerFemale) {
					_hud.fLives--;
					if (_hud.fLives <= -1) {
						this.tryAgain();
					}
				}
			
			}
			
			(Sprite1 as Character).dead = true;
			
		}
		
		// function called when the quit button is pressed
		private function onQuit():void
		{
			Ax.paused = false;
			// Go back to the MenuState
			if (Registry.isWinnitron) {
				Ax.switchState(new WinniMenuState);
			}
			else if (Registry.isPCVersion) {
				
				Ax.playMusic(Registry.SndEcho, 1.0);
				
				if (!Registry.oldSchoolMode) {
					if (Registry.isPlayingCustomLevel==true)
						Ax.switchState(new PCCustomLevelState);
					else if (Registry.isPlayingCustomLevel==false)
						Ax.switchState(new PCLevelSelectState);
				}
				else {
					Ax.switchState(new PCMenuState);
				}
				
				
			}
			else {
				Ax.switchState(new MenuState);
			}
		}
		
		public function switchCharacters(withSound:Boolean=true, withFlicker:Number=1.5, withBubbles:Boolean=true):void
		{
			if (withSound)
				Ax.play(SwitchCharacters, 0.35);
				
			if (cam.target==player1) {
				cam.follow(player2, AxCamera.STYLE_PLATFORMER);
				
				if(withBubbles) {
					bubbles.at(player2);
					bubbles.start(true, 5, 1, 10);
				}
				
				player2._currentlyControlled = true;
				player1._currentlyControlled = false;
				
				player2.flicker(withFlicker);
				
				_hud.currentCharacter = "f";
				
				
			}
			else if (cam.target==player2) {
				cam.follow(player1, AxCamera.STYLE_PLATFORMER);
				
				if(withBubbles) {
					bubbles.at(player1);
					bubbles.start(true, 5, 1, 10);
				}
				player1._currentlyControlled = true;
				player2._currentlyControlled = false;
				
				player1.flicker(withFlicker);
				
				// tell the hud what character to display
				_hud.currentCharacter = "m";
				
			}
		}
		
		public function levelOver():void
		{
			//Ax.log("You are a winner");
			
			if (levelFinished == false) {
				Ax.music.stop();
				deathSound = Ax.play(SndTagTone4, 1.0, false, true);
				levelFinished = true;
				player1._currentlyControlled = false;
				player2._currentlyControlled = false;
				Registry.canJump = false;
				
			}
			
			//trace(deathSound.active);
			/*
			for (var i:int = 0; i < Ax.sounds.length; i++) {
				trace(i + " " + (Ax.sounds.members[i] as AxSound).name.toString() );
			}*/
			
			
			if (!deathSound.active ) {
				if (Registry.isPlayingDemo) {
					if (Registry.demoLevel == 1) {
						Registry.demoLevel = 2;
						Registry.levelType = 2;
						Registry.level = XML(new Level2); 
						Ax.switchState(new PlayState);
						return;
					}
					if (Registry.demoLevel == 2) {
						Registry.demoLevel = 3;
						Registry.levelType = 3;
						Registry.level = XML(new Level3);
						Ax.switchState(new PlayState);
						return;					
					}				
					else {
						Ax.switchState(new MenuState);
						
					}
				}
				else if (!Registry.isPlayingDemo) {
					Ax.switchState(new MenuState);
				}
			}
		}
		public function goToMenu(withNextLevel:Boolean=true):void
		{
			if (withNextLevel==true)
				Registry.levelNumber++;
				
				
			if (Registry.oldSchoolMode) {
				Ax.paused = false;
				Ax.switchState(new PCMenuState);
			}
			else
				Ax.switchState(new PCLevelSelectState);
			return;
		}
		
		public function resetLevel():void
		{
			
			
			// reset to start of old school mode.
			if (Registry.oldSchoolMode) {
				Registry.levelType = 1;
				Registry.levelNumber = 1;
				Registry.hardCore = false;
				Registry.level = XML(new Registry.Level1);
				Registry.oldSchoolLivesF = 3;
				Registry.oldSchoolLivesM = 3;
				Ax.switchState(new PCPlayState);
				return;
			}
			
			Ax.music.play(false);
			
			if (followHeight!=0) {
				if (Registry.playersNo == 2) {
					cam2.setBounds(0, 0, followWidth, followHeight, true);
				}
				cam.setBounds(0, 0, followWidth, followHeight, true);
			}
			
			player1.dead = false;
			player2.dead = false;
			
			player1.levelOver = false;
			player2.levelOver = false;
			
			//Ax.log(largeCrates.members.toString() );
			
			_hud.mLives = 1;
			_hud.fLives = 1;
			
			player1.reset(player1._startingPosition.x, player1._startingPosition.y);
			player2.reset(player2._startingPosition.x, player2._startingPosition.y);
			
			player1.checkPointValue = new AxPoint(player1._startingPosition.x, player1._startingPosition.y);
			player2.checkPointValue = new AxPoint(player2._startingPosition.x, player2._startingPosition.y);
			
			levelFinished = false;
			
			playBtn.visible = false;
			menuBtn.visible = false;
			gameOverDarken.visible = false;
			gameOverScreen = false;
						
			if (player1.startsFirst==1) {
				cam.follow(player1, AxCamera.STYLE_PLATFORMER);
				player1._currentlyControlled = true;
				player2._currentlyControlled = false;
				_hud.currentCharacter = "m";
			}
			else {
				cam.follow(player2, AxCamera.STYLE_PLATFORMER);			
				player1._currentlyControlled = false;
				player2._currentlyControlled = true;
				_hud.currentCharacter = "f";
			}
			for (var i:int = 0; i < crates.length; i++) { 
				(crates.members[i] as AxSprite).reset(crates.members[i].originalPosition.x, crates.members[i].originalPosition.y);
				
			}			
			for (i = 0; i < pickUps.length; i++) { 
				(pickUps.members[i] as AxSprite).reset(pickUps.members[i].originalPosition.x, pickUps.members[i].originalPosition.y);
			}			
			
			for (i = 0; i < checkPoints.length; i++) { 
				(checkPoints.members[i] as CheckPoint).checked = false;
			}			
			
			for (i = 0; i < largeCrates.length; i++) { 
				(largeCrates.members[i] as AxSprite).reset(largeCrates.members[i].originalPosition.x, largeCrates.members[i].originalPosition.y);
				(largeCrates.members[i] as AxSprite).alive = true;
				
			}
			for (i = 0; i <levelBlocks.length; i++) { 
				if ((levelBlocks.members[i] as AxSprite).path != null) {
					var p:AxPoint = (levelBlocks.members[i] as AxSprite).path.head();
					(levelBlocks.members[i] as AxSprite).reset(  p.x- (levelBlocks.members[i] as AxSprite).width/2, p.y - (levelBlocks.members[i] as AxSprite).height/2 );
				}
				
			}	
		}		
		
		public function tryAgain():void
		{
			if (levelFinished == false) {
				gameOverScreen = true;
				Ax.music.pause();
				deathSound = Ax.play(SndTagTone1, 1.0, false, true);
				levelFinished = true;
				player1._currentlyControlled = false;
				player2._currentlyControlled = false;
				player1.levelOver = true;
				player2.levelOver = true;				
				
				playBtn.visible = true;
				menuBtn.visible = true;
				gameOverDarken.visible = true;
				Registry.canJump = false;
				
			}
			
			if (!deathSound.active ) {
				//Ax.switchState(new MenuState);
				
			}
		}		
	}
}
