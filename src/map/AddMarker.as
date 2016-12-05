package map
{
	import com.mteamapp.JSONParser;
	
	import flash.display.MovieClip;
	import flash.events.Event;
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
		override protected function onHTMLLoadComplete(event:Event):void
		{
			
			trace('change*********************')
			if(_urlObject.fullScreen==undefined)
			{
				_urlObject.fullScreen = _fullScreen
			}
			this.dispatchEvent(new MapEvent(MapEvent.LOAD_COMPELET,true))
			reSetLocatoin(mapStage.location)
			
			setLoaction(_urlObject.loaction,_urlObject.fullScreen)
		}
		private function reSetLocatoin(Url_p:String)
		{
			var _url:String = Url_p.split("?~")[1]
			if(_url!=null)
			{	
				_urlObject = JSON.parse(decodeURIComponent(_url))		
				var _selectedMarkder:Marker=null
				if(_urlObject.seledted!=null)
				{
					_selectedMarkder = new Marker(_urlObject.seledted.lat,
						_urlObject.seledted.lng,
						_urlObject.seledted.id,
						_urlObject.seledted.label,
						_urlObject.seledted.title,
						_urlObject.seledted.icon,
						_urlObject.seledted.useSetIconPath,
						_urlObject.seledted.infowindow)
				}					
				this.dispatchEvent(new MapEvent(MapEvent.GET_MARKER_LIST,true,listMarker(_urlObject.loaction),_selectedMarkder))	
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