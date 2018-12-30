package map
{
	import flash.events.Event;

	
	public class MapEvent extends Event
	{
		public static const LOAD_COMPELET:String = "LOAD_COMPELET",
							GET_MARKER_LIST:String = "GET_MARKER_LIST",
							GEOLOCATION_UPDATE:String = "GEOLOCATION_UPDATE",
							NOSUPPORTED:String = "NOSUPPORTED",
							MARKER_ISREADY:String="MARKER_ISREADY",
							GPS_NO_ACTIVE:String = "GPS_NO_ACTIVE";
		

		
		private var _loadCompelet:Boolean;
		public function get loadCompelet():Boolean
		{
			return _loadCompelet
		}
		private var _makerList:Vector.<Marker>;
		public function get makerList():Vector.<Marker>
		{
			return _makerList
		}
		
		private var _marker:Marker;
		public function get marker():Marker
		{
			return _marker
		}
		
		public function MapEvent(type:String,loadCompelet:Boolean=false,makerList:Vector.<Marker>=null,marker:Marker=null,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_loadCompelet = loadCompelet
			_makerList = makerList	
			_marker = marker	
		}
		
	}
}