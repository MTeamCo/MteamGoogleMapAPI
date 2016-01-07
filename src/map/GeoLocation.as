package map
{
	import flash.display.MovieClip;
	import flash.events.GeolocationEvent;
	import flash.sensors.Geolocation;
	import flash.utils.setTimeout;

	public class GeoLocation extends MovieClip
	{
		public static var update:GeoLocation;
		public static var marker:Marker=null
		private var _geo:Geolocation=null
		public function GeoLocation()
		{
			update = this
		}
		public function setup():void
		{		
			getLocation()		
		}
		private function getLocation():void
		{			
			if(_geo==null)
			{
				_geo = new Geolocation()
				_geo.addEventListener(GeolocationEvent.UPDATE,update_fun)
			}
		}
		private function update_fun(event:GeolocationEvent):void
		{
			marker = new Marker(event.latitude,event.longitude)
			this.dispatchEvent(new MapEvent(MapEvent.GEOLOCATION_UPDATE))	
		}
	}
}