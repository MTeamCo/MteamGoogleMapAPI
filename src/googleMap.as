package
{
	import file.SwitchUrl;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	import map.AddMarker;
	import map.DisplayMapWindow;
	import map.Map;
	import map.MapEvent;
	import map.Marker;

	public class googleMap extends MovieClip
	{
		private var mc:MovieClip
		public function googleMap()
		{
			super()
			mc = this
						
			trace('----------------- Sampel Google Map width javascript && AS3 -----------')

			
			var markerList:Vector.<Marker>= new Vector.<Marker>()
				
			SwitchUrl	
			markerList.push(new Marker(40,45,'0','M','new marker','icon.png'))
			markerList.push(new Marker(35,50,'1','K',''))	
				var markerPanTo2:AddMarker = new AddMarker(markerList)
				markerPanTo2.addEventListener(MapEvent.GET_MARKER_LIST,panto_fun)
					
					
	
					
				var displayMap:DisplayMapWindow = new DisplayMapWindow()
					displayMap.mapTypeId = DisplayMapWindow.mapTypeId.SATELLITE
					displayMap.fullscreen = DisplayMapWindow.fullScreen.FULLSCREEN	
					displayMap.area = new Rectangle(0,0,384,300)
					displayMap.fullScreenArea = new Rectangle(0,0,768,1024)		
					displayMap.sendButton = true	
					displayMap.marker = true
					displayMap.markerAndPanTo = true
					displayMap.panTo = true
					displayMap.showAllMarker = true
					displayMap.scrollwheel = true
					//displayMap.backToMarker = 2000	
					displayMap.outLabel = true
				//	displayMap.zoomOnSelectMarker = 8
					displayMap.sendMarkerSelected = true	
					
				markerPanTo2.setup(this,displayMap)	
			//////////////////////////Sepehr debug
			
			
					
		}
		

		
		protected function panto_fun(event:MapEvent):void
		{
			// TODO Auto-generated method stub

			trace('lat :',event.makerList[0].lat,'lng :',event.makerList[0].lng)
			trace('title :',event.makerList)
			if(event.marker!=null)
			{
				trace('marker label :',event.marker.label)
				trace('marker id :',event.marker.id)
			}
			
		}
		
		protected function marker_compelet_fun(event:MapEvent):void
		{
			// TODO Auto-generated method stub
			trace('marker :',event.loadCompelet)
		}
		
		protected function show_compelet_fun(event:MapEvent):void
		{
			// TODO Auto-generated method stub
			trace('showMap :',event.loadCompelet)
		}
	}
}
