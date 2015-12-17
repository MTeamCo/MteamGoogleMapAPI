package map
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.LocationChangeEvent;
	import flash.filesystem.File;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.media.StageWebView;

	public class Map extends MovieClip
	{
		[Event(name="LOAD_COMPELET",type="map.MapEvent")]
		/**use scroll midel for zoom*/
		
		
		
	
		private static var _mapType:MapTypeId
		public static function get mapType():MapTypeId
		{
			if(_mapType==null)
			{
				_mapType = new MapTypeId()
			}
			return _mapType
		}
		
		private  var _mapTypeId:String = mapType.MAP
		public function set mapTypeId(MapTypeId_p:String):void
		{
			_mapTypeId = MapTypeId_p 
		}
		public function get():String
		{
			return _mapTypeId
		}
		
		private var  _marker:Boolean=false;
		public function set marker(Marker_p:Boolean):void
		{
			_marker = Marker_p
		}
		public function get marker():Boolean
		{
			return _marker
		}
		private var _outLabel:Boolean=false
		public function set outLabel(OutLabel_p:Boolean):void
		{
			_outLabel = OutLabel_p
		}
		public function get outLabel():Boolean
		{
			return _outLabel
		}
		private var _zoomOnSelectMarker:int=-1;
		/** value -1 is disable zoom */
		public function set  zoomOnSelectMarker(ZoomOnSelectMarker_p:int):void
		{
			_zoomOnSelectMarker = ZoomOnSelectMarker_p
		}
		public function get zoomOnSelectMarker():int
		{
			return _zoomOnSelectMarker
		}
		private var _panTo:Boolean=false;
		public function set panTo(PanTo_p:Boolean):void
		{
			_panTo = PanTo_p
		}
		public function get panTo():Boolean
		{
			return _panTo
		}
		
		private var _scrollwheel:Boolean=false;
		public function set scrollwheel(Scrollwheel_p:Boolean):void
		{
			_scrollwheel = Scrollwheel_p 
		}
		public function get scrollwheel():Boolean
		{
			return _scrollwheel
		}
		
		
		private var _defaultZoom:int = 4
		public function set defaultZoom(DefaultZoom_p:int):void
		{
			_defaultZoom = DefaultZoom_p
		}
		public function get defaultZoom():int
		{
			return _defaultZoom
		}
		
		private var _mapStage:StageWebView;
		public function get mapStage():StageWebView
		{
			return _mapStage
		}
				
		private var _target:MovieClip,
					_stage:Stage,
					_path:File,
					counter:int,
					_movieMap:MovieClip;
					
		protected var htmlUrl:String;	
		
		protected var _area:Rectangle;
		public function Map()
		{

		}
		public function setup(Target_p:MovieClip,Area_p:Rectangle):void
		{
			_target = Target_p
			_area = Area_p
				
			_movieMap = new MovieClip()
			_movieMap.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage, false, 0, true);
			_movieMap.addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage, false, 0, true);
			_target.addChild(_movieMap)			
		}
		
		protected function onRemovedFromStage(event:Event):void
		{
			// TODO Auto-generated method stub
			hideMap()
			_movieMap.removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
		}
		
		protected function onAddedToStage(event:Event):void
		{
			// TODO Auto-generated method stub
			_stage = _movieMap.stage
			showMap()
			_movieMap.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		public function hideMap():void
		{
			// TODO Auto Generated method stub
			if(_mapStage!=null)
			{
				_mapStage.stage = null;
				_mapStage.dispose();	
			}
		}
				
		protected function showMap():void
		{
			// TODO Auto Generated method stub	
			_mapStage = new StageWebView();
				
			_mapStage.viewPort = _area
				
			_mapStage.stage = _stage;
				
			_mapStage.addEventListener(LocationChangeEvent.LOCATION_CHANGING,canging_fun)
			_mapStage.addEventListener(Event.COMPLETE, onHTMLLoadComplete, false, 0, true);
		
				
			_path = File.applicationDirectory.resolvePath(htmlUrl); 
			if(DevicePrefrence.isAndroid())
			{				
				var _pathCopy : File = File.createTempFile();
				_path.copyTo(_pathCopy, true);  
				_mapStage.loadURL(_pathCopy.url);			
			}
			else				
			{		
				_mapStage.loadURL(_path.nativePath);
			}

		}
		
		protected function canging_fun(event:LocationChangeEvent):void
		{
			// TODO Auto-generated method stub
			trace('location changing :',event.location)
		}
		
		protected function onHTMLLoadComplete(event:Event):void
		{
			// TODO Auto-generated method stub
			
		}
		protected function setLoaction(Location_p:Array,ShowAllMarker_p:Boolean=false,MarkerAndPanTo_p:Boolean=false,BackToMarker_p:int=-1,SendBtnUrlImage_p:String='',SendBtnLocatoin_p:Rectangle=null):void 
		{
			counter++
			var _params:Object = new Object()
				_params.location = Location_p	
				_params.scrollwheel = _scrollwheel
				_params.zoom = _defaultZoom	
				_params.marker = _marker
				_params.showAllMarker = ShowAllMarker_p
				_params.panTo = _panTo
				_params.markerAndPanTo = MarkerAndPanTo_p
				_params.backToMarker = BackToMarker_p	
				_params.zoomOnSelectMarker = _zoomOnSelectMarker
				_params.outLabel = _outLabel	
				_params.mapTypeId = _mapTypeId
				_params.sendBtnUrlImage = SendBtnUrlImage_p
				if(SendBtnLocatoin_p!=null)
				{
					_params.sendBtnWidth = SendBtnLocatoin_p.width
					_params.sendBtnHeight = SendBtnLocatoin_p.height
					_params.sendBtnX = SendBtnLocatoin_p.x
					_params.sendBtnY = SendBtnLocatoin_p.y
				}
				_params.conter = counter
			var _paramsJson:String= JSON.stringify(_params)			

			_mapStage.loadURL("javascript:setMap("+_paramsJson+")");
			
		}
	}
}


///////////////////////////////
internal class MapTypeId
{
	
	public const MAP:String = "MAP",
		SATELLITE:String = "SATELLITE";
}
