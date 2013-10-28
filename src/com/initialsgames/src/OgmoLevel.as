package
{
	import org.axgl.*;

	public class OgmoLevel
	{

		public var xml:XML;
		public var width:uint;
		public var height:uint;
		
		public function OgmoLevel(File:String):void
		{
			super();
			xml = new XML(File);
			width = xml.width;
			height = xml.height;			
			//AxU.setWorldBounds(0,0,width,height);
			//AxU.worldBounds.x = AxU.worldBounds.y = 0
			//AxU.worldBounds.width = width;
			//AxU.worldBounds.height = height;
			Ax.camera.setBounds(0,0,width,height, true);
		}
		
		/*
		   Load a Tilemap type of layer
		*/ 
		public function loadTilemap(Layer:String, TileGraphic:Class):AxTilemap
		{
			var l:XML = getElementByName(xml, Layer);
			return new OgmoTilemap(width, height).loadTilemap(l, TileGraphic);
		}

		/*
		   Load a grid type of layer.
		   
		   If you want to use the grid as an invisible tilemap to use it for
		   collision, provide a transparent png as TileGraphic.
		*/		
		public function loadGrid(Layer:String, TileGraphic:Class):AxTilemap
		{
			var l:XML = getElementByName(xml, Layer);
			return new OgmoTilemap(width, height).loadGrid(l, TileGraphic);			
		}

		public function getElementByName(data:XML, name:String):XML
		{
			return new XML(data.descendants(name).toXMLString());
		}
	}
}
