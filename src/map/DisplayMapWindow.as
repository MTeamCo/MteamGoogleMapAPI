package map
{
	import flash.geom.Rectangle;

	public class DisplayMapWindow
	{
		private static var __mapTypeId:MapTypeId
		public static function get mapTypeId():MapTypeId
		{
			if(__mapTypeId==null)
			{
				__mapTypeId = new MapTypeId()
			}
			return __mapTypeId
		}
			

		public  var mapTypeId:String = DisplayMapWindow.mapTypeId.MAP

		//////////////////////////////////////////////////////////////
		
		
		private static var __fullscreen:FullScreen
		public static function get fullScreen():FullScreen
		{
			if(__fullscreen==null)
			{
				__fullscreen = new FullScreen()
			}
			return __fullscreen
		}
		
		
		
		public var fullscreen:String= DisplayMapWindow.fullScreen.RESTORE
			
		public var fullScreenButtonStyle:ButtonStyle = new ButtonStyle('fullScreen.png', new Rectangle(215,10,34,34))
		public var restoreFullScreenButtonStyle:ButtonStyle = new ButtonStyle('restoreFullScreen.png', new Rectangle(210,10,34,34))	

		///////////////////////
		public var sendButtonLocation:ButtonStyle = new ButtonStyle('send.png',new Rectangle(110,10,103,34))
		public var sendButton:Boolean = true	
		////////////////////////
		
		public  var area:Rectangle,
					fullScreenArea:Rectangle=null,
					viewPort:Rectangle;
		
		
		
		//////////////////////////
		public var  marker:Boolean=false;

		public var outLabel:Boolean=false

		public var zoomOnSelectMarker:int=-1;
		/** value -1 is disable zoom */
	
		public var panTo:Boolean=false;

					
		public var scrollwheel:Boolean=false;

		public var showAllMarker:Boolean = false
		
		public var markerAndPanTo:Boolean = false
		
		public var sendMarkerSelected:Boolean = false	
		
		public var backToMarker:int = -1	
					
		public var defaultZoom:int = 4

					
		
		
		public function DisplayMapWindow()
		{
		}

	}
}
import flash.geom.Rectangle;

internal class MapTypeId
{
	
	public const MAP:String = "MAP",
		SATELLITE:String = "SATELLITE";
}
internal class FullScreen
{
	public const FULLSCREEN:String = "FULLSCREEN",
		RESTORE:String = "RESTORE";			
	
}
