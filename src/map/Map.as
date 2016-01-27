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
		
		
		

		
		private var _displayMapWindow:DisplayMapWindow = new DisplayMapWindow()
		public function set displayMapWindow(DisplayMapWindow_p:DisplayMapWindow):void
		{
			_displayMapWindow = DisplayMapWindow_p
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
					
		protected var htmlUrl:String,	
					_fullScreen:Boolean=false;
		public function Map()
		{

		}
		public function setup(Target_p:MovieClip,DisplayMapWindow_p:DisplayMapWindow=null):void
		{
			_target = Target_p

			_displayMapWindow = DisplayMapWindow_p	

			if(_displayMapWindow.fullscreen == DisplayMapWindow.fullScreen.FULLSCREEN)
			{
				_fullScreen = true
			}
			setFullScreen()
			_movieMap = new MovieClip()
			_movieMap.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage, false, 0, true);
			_movieMap.addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage, false, 0, true);
			_target.addChild(_movieMap)			
		}
		private function setFullScreen():void
		{
			if(_fullScreen && _displayMapWindow.fullScreenArea!=null)
			{
				_displayMapWindow.viewPort = _displayMapWindow.fullScreenArea	
			}
			else
			{
				_displayMapWindow.viewPort = _displayMapWindow.area	
			}

		}
		protected function onRemovedFromStage(event:Event):void
		{
			// TODO Auto-generated method stub
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
				
			_mapStage.viewPort = _displayMapWindow.viewPort
				
			_mapStage.stage = _stage;
			
			//_mapStage.addEventListener(LocationChangeEvent.LOCATION_CHANGING,canging_fun)
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
		/*protected function canging_fun(event:LocationChangeEvent):void
		{
			// TODO Auto-generated method stub
			trace('location changing :',event.location)
		
		}*/
		
		protected function onHTMLLoadComplete(event:Event):void
		{
			// TODO Auto-generated method stub
			
		}
		protected function setLoaction(Location_p:Array,FullScreen_p:Boolean=false):void 
		{
		
			if(FullScreen_p!=_fullScreen)
			{
				_fullScreen = FullScreen_p
				setFullScreen()
				_mapStage.viewPort = _displayMapWindow.viewPort		
				_mapStage.stage = _stage;
				_mapStage.reload()
			}
			counter++
			var _params:Object = new Object()
				_params.location = Location_p	
				_params.scrollwheel = _displayMapWindow.scrollwheel
				_params.zoom = _displayMapWindow.defaultZoom	
				_params.marker = _displayMapWindow.marker
				_params.showAllMarker = _displayMapWindow.showAllMarker
				_params.panTo = _displayMapWindow.panTo
				_params.markerAndPanTo = _displayMapWindow.markerAndPanTo
				_params.backToMarker = _displayMapWindow.backToMarker	
				_params.zoomOnSelectMarker = _displayMapWindow.zoomOnSelectMarker
				_params.sendMarkerSelected = _displayMapWindow.sendMarkerSelected	
				_params.outLabel = _displayMapWindow.outLabel	
				_params.mapTypeId = _displayMapWindow.mapTypeId
					
					
				_params.sendBtnTitle = _displayMapWindow.sendButtonLocation.title
				_params.sendBtnWidth = _displayMapWindow.sendButtonLocation.position.width
				_params.sendBtnHeight = _displayMapWindow.sendButtonLocation.position.height
				_params.sendBtnX = _displayMapWindow.sendButtonLocation.position.x
				_params.sendBtnY = _displayMapWindow.sendButtonLocation.position.y
				_params.sendButton = _displayMapWindow.sendButton
				_params.fullScreen = _fullScreen
				if(_displayMapWindow.fullScreenArea!=null)
				{
					_params.fullScreenStatus=true
					if(!_fullScreen)
					{
						_params.fullScreenBtnStyleWidth = _displayMapWindow.fullScreenButtonStyle.position.width
						_params.fullScreenBtnStyleHeight= _displayMapWindow.fullScreenButtonStyle.position.height
						_params.fullScreenBtnStyleX= _displayMapWindow.fullScreenButtonStyle.position.x
						_params.fullScreenBtnStyleY= _displayMapWindow.fullScreenButtonStyle.position.y
						_params.fullScreenTitle= _displayMapWindow.fullScreenButtonStyle.title
					}
					else
					{
						_params.fullScreenBtnStyleWidth = _displayMapWindow.restoreFullScreenButtonStyle.position.width
						_params.fullScreenBtnStyleHeight= _displayMapWindow.restoreFullScreenButtonStyle.position.height
						_params.fullScreenBtnStyleX= _displayMapWindow.restoreFullScreenButtonStyle.position.x
						_params.fullScreenBtnStyleY= _displayMapWindow.restoreFullScreenButtonStyle.position.y
						_params.fullScreenTitle= _displayMapWindow.restoreFullScreenButtonStyle.title
					}
				}
				
				
				_params.conter = counter
			var _paramsJson:String= JSON.stringify(_params)			

			_mapStage.loadURL("javascript:setMap("+_paramsJson+")");
			
		}
	}
}

