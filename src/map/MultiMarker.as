package map
{
	import flash.events.Event;


	public class MultiMarker extends Map
	{
		private var _location:Array;
		public function MultiMarker(Location_p:Vector.<Marker>)
		{
			super();
			_location = new Array()
			for each (var index:Marker in Location_p)
			{
				_location.push({lat:index.lat,lng:index.lng,label:index.label,title:index.title})
			}
			htmlUrl = 'Data/markerAndPanTo.html'
		}
		override protected function onHTMLLoadComplete(event:Event):void
		{
			this.dispatchEvent(new MapEvent(MapEvent.LOAD_COMPELET,true))
			setLoaction(_location,true)
		}
	}
}