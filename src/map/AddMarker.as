package map
{
	import com.mteamapp.JSONParser;
	
	import flash.display.MovieClip;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.LocationChangeEvent;
	import flash.geom.Rectangle;
	import flash.text.ReturnKeyLabel;


	public class AddMarker extends Map 
	{
		private var _urlObject:Object=new Object();
		

		public function AddMarker()
		{						
			super();			
		}
		override protected function addMarker():void
		{
			_urlObject.loaction = new Array()
			for each (var index:Marker in displayMapOption.location)
			{
				_urlObject.loaction.push({lat:index.lat,
					lng:index.lng,
					label:index.label,
					title:index.title,
					id:index.id,
					icon:index.icon,
					useSetIconPath:index.useSetIconPath,
					infowindow:index.infowindow})
			}
		}		
		override protected function changing_fun(event:LocationChangeEvent):void
		{
			getLocation(event.location);
		}
		
		override protected function error(event:ErrorEvent):void
		{
			getLocation(event.text);
		}
		
		private function getLocation(location_p:String):void
		{
			if(location_p.indexOf("unknown:/")==-1)
			{
				return 
			}
			var _url:String = location_p.split("unknown:/")[1]
			if(_url!=null)
			{	
				_urlObject = JSON.parse(decodeURIComponent(_url));	
				var _selectedMarkder:Marker=null
				if(_urlObject.seledted!=null)
				{
					_selectedMarkder = new Marker(_urlObject.seledted.lat,
						_urlObject.seledted.lng,
						_urlObject.seledted.id,
						_urlObject.seledted.label,
						_urlObject.seledted.title,
						_urlObject.seledted.icon)
				}
				if(_fullScreen ==_urlObject.fullScreen)
				{
					this.dispatchEvent(new MapEvent(MapEvent.GET_MARKER_LIST,true,listMarker(_urlObject.loaction),_selectedMarkder));
				}
				else
				{
					_fullScreen = _urlObject.fullScreen;
					setFullScreen();
					changeFulScreen();
				}
				reloadMap(_urlObject.loaction);
			}	
		}

		private function listMarker(List_p:Array):Vector.<Marker>
		{
			var _list:Vector.<Marker> = new Vector.<Marker>()
			for each(var index:Object in List_p)
			{
				_list.push(new Marker(index.lat,
					index.lng,
					index.id,
					index.label,
					index.title,
					index.icon,
					index.useSetIconPath,
					index.infowindow))
			}
			return _list
		}
	}
}