package map
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.text.ReturnKeyLabel;


	public class MarkerAndPanTo extends Map
	{
		private var _location:Array,
					_showAllMarker:Boolean;
		public function set showAllMarker(ShowAllMarker_p:Boolean):void
		{
			_showAllMarker = ShowAllMarker_p
		}
		public function get showAllMarker():Boolean
		{
			return _showAllMarker
		}
		
		private var _sendBtnLocatoin:Rectangle;
		public function set sendBtnLocatoin(SendBtnLocatoin_p:Rectangle):void
		{
			_sendBtnLocatoin = SendBtnLocatoin_p
		}
		public function get sendBtnLocatoin():Rectangle
		{
			return _sendBtnLocatoin
		}
		private var _sendBtnUrlImage:String;
		public function set sendBtnUrlImage(SendBtnUrlImage_p:String):void
		{
			_sendBtnUrlImage = SendBtnUrlImage_p
		}
		public function get sendBtnUrlImage():String
		{
			return _sendBtnUrlImage
		}
		public function MarkerAndPanTo(Location_p:Vector.<Marker>,ShowAllMarker_p:Boolean=true,SendBtnUrlImage_p:String='send.png',SendBtnLocatoin_p:Rectangle=null)
		{
			
			
			super();	
				
			if(SendBtnLocatoin_p!=null)
			{
				_sendBtnLocatoin = SendBtnLocatoin_p
			}
			else
			{
				_sendBtnLocatoin = new Rectangle(110,10,103,34)
			}
			_sendBtnUrlImage = SendBtnUrlImage_p
			_location = new Array()
			for each (var index:Marker in Location_p)
			{
				_location.push({lat:index.lat,lng:index.lng,label:index.label,title:index.title})
			}	
			_showAllMarker = ShowAllMarker_p	
				
			htmlUrl = 'Data/markerAndPanTo.html'		
		}
		override protected function onHTMLLoadComplete(event:Event):void
		{
			trace('change*********************')
			this.dispatchEvent(new MapEvent(MapEvent.LOAD_COMPELET,true))
			reSetLocatoin(mapStage.location)
			
			setLoaction(_location,_showAllMarker,true,-1,_sendBtnUrlImage,_sendBtnLocatoin)
		}
		private function reSetLocatoin(Url_p:String)
		{
			var _url:String = Url_p.split("?~")[1]
			if(_url!=null)
			{	
				var urlObject:Object = converUrlStrToObj(_url)
				_location = urlObject.loaction
					
				var _selectedMarkder:Marker=null
				if(urlObject.seledted!=null)
				{
					_selectedMarkder = new Marker(urlObject.seledted.lat,urlObject.seledted.lng,urlObject.seledted.label,urlObject.seledted.title)
				}
									
				this.dispatchEvent(new MapEvent(MapEvent.GET_MARKER_LIST,true,listMarker(_location),_selectedMarkder))	
			}	
		}
		private function converUrlStrToObj(Str_p:String):Object
		{
			var _str:String = Str_p
			_str = _str.split("%22").join("\"")
			_str = _str.split("%7B").join("{")
			_str = _str.split("%3A").join(":")
			_str = _str.split("%5B").join("[")
			_str = _str.split("%2C").join(",")
			_str = _str.split("%7D").join("}")
			_str = _str.split("%5D").join("]")	
			_str = _str.split("%20").join(" ")
			trace('_Str :',_str)	
			return JSON.parse(_str)	
		}
		private function listMarker(List_p:Array):Vector.<Marker>
		{
			var _list:Vector.<Marker> = new Vector.<Marker>()
			for each(var index:Object in List_p)
			{
				_list.push(new Marker(index.lat,index.lng,index.label,index.title))
			}
			return _list
		}
	}
}