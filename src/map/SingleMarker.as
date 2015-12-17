package map
{
	import flash.events.Event;

	public class SingleMarker extends Map
	{
		private var _location:Array;
		
		
		private var	_backToMarker:int=-1
			
		/** this value is time after the center of the map has changed, pan back to the
		 marker and -1 value is disable it*/
		public function set backToMarker(BackToMarker_p:int):void
		{
			_backToMarker = BackToMarker_p
		}
		public function get backToMarker():int
		{
			return _backToMarker
		}
		public function SingleMarker(Lat_p:Number,Lng_p:Number,BackToMarker_p:int=-1,Label_p:String='',Title_p:String='')
		{
			super();
			_location = new Array()
			_location.push({lat:Lat_p,lng:Lng_p,label:Label_p,title:Title_p})
			_backToMarker = BackToMarker_p	
	
			htmlUrl = 'Data/markerAndPanTo.html'
		}
		override protected function onHTMLLoadComplete(event:Event):void
		{
			this.dispatchEvent(new MapEvent(MapEvent.LOAD_COMPELET,true))
			setLoaction(_location,false,false,_backToMarker)
		}
	}
}