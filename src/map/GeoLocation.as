package map
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.GeolocationEvent;
	import flash.sensors.Geolocation;
	import flash.utils.setTimeout;

	[Event(name="MARKER_ISREADY",type="map.MapEvent")]
	[Event(name="NOSUPPORTED",type="map.MapEvent")]
	[Event(name="GEOLOCATION_UPDATE",type="map.MapEvent")]
	[Event(name="GPS_NO_ACTIVE",type="map.MapEvent")]
	public class GeoLocation extends EventDispatcher
	{

		private var _marker:Marker=null
		private var _geo:Geolocation=null
		public function GeoLocation()
		{
		}
		
		public function get marker():Marker
		{
			
			if(!Geolocation.isSupported)
			{
				this.dispatchEvent(new MapEvent(MapEvent.NOSUPPORTED))
			}
			
			if(Geolocation.isSupported && _marker==null)
			{
				this.dispatchEvent(new MapEvent(MapEvent.GPS_NO_ACTIVE))	
			}
			return _marker
		}
		public function setup(DebugGPS_p:Boolean=true):void
		{		
			getLocation(DebugGPS_p)		
		}
		private function getLocation(DebugGPS_p:Boolean):void
		{	

			if(DebugGPS_p)
			{
				_marker = new Marker(35.7137559,51.4149215)
				this.dispatchEvent(new MapEvent(MapEvent.GEOLOCATION_UPDATE))
				return 	
			}
			
			if(!Geolocation.isSupported)
			{
				this.dispatchEvent(new MapEvent(MapEvent.NOSUPPORTED))
				return	
			}
			else
			{
				this.addEventListener(Event.ENTER_FRAME,chekMarkerReady)
			}
			
			if(_geo==null)
			{
				_geo = new Geolocation()
				_geo.addEventListener(GeolocationEvent.UPDATE,update_fun)
			}
			
		}
		
		protected function chekMarkerReady(event:Event):void
		{
			// TODO Auto-generated method stub
			if(marker!=null)
			{
				this.removeEventListener(Event.ENTER_FRAME,chekMarkerReady)
				this.dispatchEvent(new MapEvent(MapEvent.MARKER_ISREADY))	
			}
		}
		private function update_fun(event:GeolocationEvent):void
		{
			_marker = new Marker(event.latitude,event.longitude)
			this.dispatchEvent(new MapEvent(MapEvent.GEOLOCATION_UPDATE))	
		}
	}
}