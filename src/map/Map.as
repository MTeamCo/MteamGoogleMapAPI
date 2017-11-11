package map
{
	import contents.TextFile;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.LocationChangeEvent;
	import flash.filesystem.File;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.media.StageWebView;
	import flash.utils.ByteArray;

	[Event(name="LOAD_COMPELET",type="map.MapEvent")]
	public class Map extends MovieClip
	{
		/**use scroll midel for zoom*/
		
		
		
	//	protected var myObject:Object = null
		
		protected var displayMapOption:DisplayMapOption = new DisplayMapOption()
		public function set displayMapWindow(DisplayMapOption_p:DisplayMapOption):void
		{
			displayMapOption = DisplayMapOption_p
		}

		
		private var _mapStage:StageWebView;
		public function get mapStage():StageWebView
		{
			return _mapStage
		}
		
		private var _isHide:Boolean= true;
		public function get isHide():Boolean
		{
			return _isHide
		}

		private var _target:MovieClip,
					_stage:Stage,
					_path:File,
					counter:int,
					_movieMap:MovieClip;
					
		protected var _fullScreen:Boolean=false;
					
		public static var dataAddress:String,
							htmlName:String;
							
							
		private var _htmlString:String;					
							
		public static var GPS:GeoLocation = new GeoLocation();					
							
					
		public function Map()
		{
		}
		
		public static function setup(dataAddress_p:String=null,htmlName_p:String=null,OnGPS_p:Boolean= false):void
		{
			if(dataAddress_p!=null)
			{
				dataAddress = dataAddress_p;
			}
			if(htmlName_p!=null)
			{
				htmlName = htmlName_p;
			}
			
			if(OnGPS_p)
			{
				if(DevicePrefrence.isItPC)
				{
					GPS.setup();
				}
				else
				{
					GPS.setup(false);
				}
				
			}
			
		}
		public function setup(Target_p:MovieClip,DisplayMapWindow_p:DisplayMapOption=null):void
		{
			_target = Target_p;
			displayMapOption = DisplayMapWindow_p;	
			if(displayMapOption.fullscreen == DisplayMapOption.fullScreen.FULLSCREEN)
			{
				_fullScreen = true;
			}
			setFullScreen();;
			_movieMap = new MovieClip();
			_movieMap.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage, false, 0, true);
			_movieMap.addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage, false, 0, true);
			_target.addChild(_movieMap);
			addMarker();
		}
		protected function addMarker():void
		{
			
		}
		public function update(DisplayMapWindow_p:DisplayMapOption=null):void
		{
			if(_mapStage!=null)
			{
				displayMapOption = DisplayMapWindow_p;	
				displayMapOption.viewPort = displayMapOption.area;
				_mapStage.viewPort = displayMapOption.viewPort;				
				_mapStage.stage = _stage;
			}
		}
		protected function changeFulScreen():void
		{
			_mapStage.viewPort = displayMapOption.viewPort;	
		}
		protected function setFullScreen():void
		{
			if(_fullScreen && displayMapOption.fullScreenArea!=null)
			{
				displayMapOption.viewPort = displayMapOption.fullScreenArea;	
			}
			else
			{
				displayMapOption.viewPort = displayMapOption.area;	
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
			_stage = _movieMap.stage;
			showMap();
			_movieMap.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		public function hideMap():void
		{
			// TODO Auto Generated method stub
			trace('__mapStage :',_mapStage)
			if(_mapStage!=null)
			{
				_mapStage.stage = null;
				_mapStage.dispose();
				_mapStage = null
				_isHide = true	
			}
		}
		
		public function visibleMap(Status_p:Boolean):void
		{
			if(Status_p)
			{
				_mapStage.stage = _stage;
			}
			else
			{
				_mapStage.stage = null
			}
		}
				
		protected function showMap():void
		{
			_isHide = false;
			// TODO Auto Generated method stub	
			_mapStage = new StageWebView(false);
				
			_mapStage.viewPort = displayMapOption.viewPort;
				
			_mapStage.stage = _stage;
			
			
			_mapStage.addEventListener(LocationChangeEvent.LOCATION_CHANGING,changing_fun);
			_mapStage.addEventListener(LocationChangeEvent.LOCATION_CHANGE,change_fun);		
			_mapStage.addEventListener(Event.COMPLETE, onHTMLLoadComplete, false, 0, true);
			
			_mapStage.addEventListener(ErrorEvent.ERROR,error);
			
			
			_path = File.applicationDirectory.resolvePath(dataAddress+htmlName); 
			
			var loadHtmlByte:ByteArray = FileManager.loadFile(_path);
			loadHtmlByte.position = 0 ;
			trace("loadHtmlByte size : "+loadHtmlByte.length);
			_htmlString = loadHtmlByte.readUTFBytes(loadHtmlByte.length);

			var loc:Array = new Array();
			for(var i:int=0;i<displayMapOption.location.length;i++)
			{
				loc.push(displayMapOption.location[i]);
			}
			
			var _html = _htmlString.split('"MY_PARAM_TO_SPLIT_AND_REPLACE"').join(setLoaction(loc));
			_mapStage.loadString(_html);
				
		}

		protected function reloadMap(Location_p:Array):void
		{
			var _html = _htmlString.split('"MY_PARAM_TO_SPLIT_AND_REPLACE"').join(setLoaction(Location_p));
			if(_mapStage!=null)
			{
				//trace('_html :',_html)
				_mapStage.loadString(_html);
			}
		}
		protected function error(event:ErrorEvent):void
		{
			// TODO Auto-generated method stub
			//trace('erorrorrrrrrrrrrr :',event.text)
		}
		
		protected function change_fun(event:LocationChangeEvent):void
		{
			trace('change')
			// TODO Auto-generated method stub
			//trace('location change true:',event.location)
		}
		protected function changing_fun(event:LocationChangeEvent):void
		{
			// TODO Auto-generated method stub
			//trace('location changing2222 :',event.location)
			
			
		}
		
		protected function onHTMLLoadComplete(event:Event):void
		{
			// TODO Auto-generated method stub
			
		}
		protected function setLoaction(Location_p:Array):String 
		{
			counter++;		
			var _params:Object = new Object();
				
				
				_params.location = Location_p;	

				_params.scrollwheel = displayMapOption.scrollwheel;
				_params.zoom = displayMapOption.defaultZoom	;
				_params.marker = displayMapOption.marker;
				_params.showAllMarker = displayMapOption.showAllMarker;
				_params.panTo = displayMapOption.panTo;
				_params.markerAndPanTo = displayMapOption.markerAndPanTo;
				_params.backToMarker = displayMapOption.backToMarker;	
				_params.zoomOnSelectMarker = displayMapOption.zoomOnSelectMarker;
				_params.sendMarkerSelected = displayMapOption.sendMarkerSelected;	
				_params.outLabel = displayMapOption.outLabel;	
				_params.mapTypeId = displayMapOption.mapTypeId;
					
				_params.simpleButtonUrl	= editSimpleButtonUrl(displayMapOption.simpleButtonUrl);
				_params.polyline = displayMapOption.polyline;
				_params.disableDefaultUI = displayMapOption.disableDefaultUI;	
					
				_params.sendBtnTitle = displayMapOption.sendButtonLocation.title;
				_params.sendBtnWidth = displayMapOption.sendButtonLocation.position.width;
				_params.sendBtnHeight = displayMapOption.sendButtonLocation.position.height;
				_params.sendBtnX = displayMapOption.sendButtonLocation.position.x;
				_params.sendBtnY = displayMapOption.sendButtonLocation.position.y;
				_params.sendButton = displayMapOption.sendButton;
				_params.fullScreen = _fullScreen;
				_params.searchBox = displayMapOption.searchBox;	
					
				if(displayMapOption.fullScreenArea!=null)
				{
					_params.fullScreenStatus=true;
					if(!_fullScreen)
					{
						_params.fullScreenBtnStyleWidth = displayMapOption.fullScreenButtonStyle.position.width;
						_params.fullScreenBtnStyleHeight= displayMapOption.fullScreenButtonStyle.position.height;
						_params.fullScreenBtnStyleX= displayMapOption.fullScreenButtonStyle.position.x;
						_params.fullScreenBtnStyleY= displayMapOption.fullScreenButtonStyle.position.y;
						_params.fullScreenTitle= displayMapOption.fullScreenButtonStyle.title;
					}
					else
					{
						_params.fullScreenBtnStyleWidth = displayMapOption.restoreFullScreenButtonStyle.position.width;
						_params.fullScreenBtnStyleHeight= displayMapOption.restoreFullScreenButtonStyle.position.height;
						_params.fullScreenBtnStyleX= displayMapOption.restoreFullScreenButtonStyle.position.x;
						_params.fullScreenBtnStyleY= displayMapOption.restoreFullScreenButtonStyle.position.y;
						_params.fullScreenTitle= displayMapOption.restoreFullScreenButtonStyle.title;
					}
				}
								
				_params.conter = counter;
			var _paramsJson:String= JSON.stringify(_params);	
										
			return _paramsJson;
			

		}
		private function editSimpleButtonUrl(Url_p:String):String
		{
			if(Url_p!='' && Url_p!=null)
			{	
				var _path:File = File.applicationDirectory.resolvePath(Url_p);
				var _pathCopy : File = File.createTempFile();
				if(_path.exists)
				{			
					_path.copyTo(_pathCopy, true);
					return  _pathCopy.url;
				}
			}
			
			return null;
		}
	}
}

