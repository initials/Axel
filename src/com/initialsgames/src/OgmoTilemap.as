package
{
	import org.axgl.*;
	import org.flixel.system.AxTile;
	import org.flixel.system.AxTilemapBuffer;
	import flash.display.*;
	import flash.geom.Rectangle;

	public class OgmoTilemap extends AxTilemap
	{		
		public function OgmoTilemap(Width:int, Height:int):void
		{
			super();
			width = Width;
			height = Height;			
		}
		
		/*
		   Load a Tilemap type of layer
		*/ 
		public function loadTilemap(Layer:XML, TileGraphic:Class, DrawIndex:uint = 0, CollideIndex:uint = 1):OgmoTilemap
		{
			//refresh = true;

			var file:XML = Layer;
			
			//figure out the map dimmesions based on the xml and set variables			
			_tileWidth = file.@tileWidth;
			_tileHeight = file.@tileHeight;
			
			widthInTiles = width / _tileWidth;
			heightInTiles = height / _tileHeight;
			
			totalTiles = widthInTiles * heightInTiles;

			//load graphics
			_tiles = Ax.addBitmap(TileGraphic);
			
			
			//create tile objects for overlap
			var i:uint = 0;
			var l:uint = (_tiles.width/_tileWidth) * (_tiles.height/_tileHeight);
			l++;
			_tileObjects = new Array(l);
			var ac:uint;
			while(i < l)
			{
				_tileObjects[i] = new AxTile(this,i,_tileWidth,_tileHeight,(i >= DrawIndex),(i >= CollideIndex)?allowCollisions:NONE);
				i++;
			}

			
			//Initialize the data
			_data = new Array();
			for(var di:int; di < totalTiles; di++)
			{
				_data.push(0);
			}
			
			// Not sure yet
			_rects = new Array(totalTiles);
			

			//create debug tiles:
			_debugTileNotSolid = makeDebugTile(Ax.BLUE);
			_debugTilePartial = makeDebugTile(Ax.PINK);
			_debugTileSolid = makeDebugTile(Ax.GREEN);
			_debugRect = new Rectangle(0,0, _tileWidth, _tileHeight);

			// Set rectTiles
			var t:XML
			for each (t in file.rect)
			{
				var startX:uint = t.@x;
				var startY:uint = t.@y;
				var tw:uint = t.@w / _tileWidth;
				var th:uint = t.@h / _tileHeight;

				for (var w:uint = 0; w < tw; ++w)
				{
					for (var h:uint = 0; h < th; ++h)
					{
						this.setTile((startX + (w*_tileWidth))/_tileWidth, (startY + (h*_tileHeight))/_tileHeight, t.@id, true);
					}
				}

			}

			// Set tiles
			for each (t in file.tile)
			{
				this.setTile((t.@x / _tileWidth), (t.@y / _tileHeight), t.@id, true);
			}

						
			// Alocate the buffer to hold the rendered tiles
			/*var bw:uint = (AxU.ceil(Ax.width/ _tileWidth) + 1)*_tileWidth;
			var bh:uint = (AxU.ceil(Ax.height / _tileHeight) + 1)*_tileHeight;*/
			//_buffer = new BitmapData(bw,bh,true,0);
			
			
			//Update screen vars
			/*_screenRows = Math.ceil(Ax.height/_tileHeight)+1;
			if(_screenRows > heightInTiles)
				_screenRows = heightInTiles;
			_screenCols = Math.ceil(Ax.width/_tileWidth)+1;
			if(_screenCols > widthInTiles)
				_screenCols = widthInTiles;*/
			
			//_bbKey = String(TileGraphic);
			//generateBoundingTiles();
			//refreshHulls();

			//_flashRect.x = 0;
			//_flashRect.y = 0;
			//_flashRect.width = _buffer.width;
			//_flashRect.height = _buffer.height;

			
			return this;
		}
		
		/*
		   Load a grid type of layer.
		   
		   If you want to use the grid as an invisible tilemap to use it for
		   collision, provide a transparent png as TileGraphic.
		*/
		public function loadGrid(Layer:XML, TileGraphic:Class):AxTilemap
		{
			var data:String = Layer.toString();
			var array:Array = new Array();
			
			var l:Array = data.split("\n");
			
			widthInTiles = l[0].length;

			
			var tmpString:String = ""
			for each(var i:String in l)
			{
				tmpString += i;
			}

			
			array = tmpString.split("");
			data = arrayToCSV(array, widthInTiles);
			var tmpMap:AxTilemap = new AxTilemap().loadMap(data, TileGraphic);
			return tmpMap;
			//return new AxTilemap().loadMap(data, TileGraphic);
		}		
	}
}
