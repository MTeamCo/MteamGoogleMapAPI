package
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	import map.Map;
	import map.MapEvent;
	import map.Marker;
	import map.MarkerAndPanTo;
	import map.MultiMarker;
	import map.SingleMarker;
	
	public class googleMap extends MovieClip
	{
		private var mc:MovieClip
		public function googleMap()
		{
			super()
			mc = this
			trace('----------------- Sampel Google Map width javascript && AS3 -----------')
			//show class is addin google map location to stage 
			var show:SingleMarker = new SingleMarker(35,50)
				show.addEventListener(MapEvent.LOAD_COMPELET,show_compelet_fun)
				show.scrollwheel = true
				show.defaultZoom = 10	
				show.setup(this,new Rectangle(0,0,384,300))
			// show and mark location		
			var marker:SingleMarker = new SingleMarker(35,50,3000)
				marker.marker = true
				marker.addEventListener(MapEvent.LOAD_COMPELET,marker_compelet_fun)
				marker.setup(this,new Rectangle(384,0,384,300))
					
			// mark and pant to
				var markerList:Vector.<Marker>= new Vector.<Marker>()
					markerList.push(new Marker(40,45,'','new marker'))
			var markerPanTo:MarkerAndPanTo = new MarkerAndPanTo(markerList,true)
				markerPanTo.addEventListener(MapEvent.GET_MARKER_LIST,panto_fun)
				markerPanTo.scrollwheel = true
				markerPanTo.marker = true
				markerPanTo.panTo = true	
				markerPanTo.outLabel = true	
				markerPanTo.zoomOnSelectMarker = 12	
				markerPanTo.setup(this,new Rectangle(0,300,384,300))
					
			// sho multi marker and crate new marker bye user		
				var markerPanTo2:MarkerAndPanTo = new MarkerAndPanTo(markerList,false)
				markerPanTo2.addEventListener(MapEvent.GET_MARKER_LIST,panto_fun)
				markerPanTo2.scrollwheel = true
				markerPanTo2.marker = true
				markerPanTo2.mapTypeId = Map.mapType.SATELLITE
				//markerPanTo.panTo = true		
				markerPanTo2.setup(this,new Rectangle(384,300,384,300))	
		
			// multi marker
			var list:Vector.<Marker> = new Vector.<Marker>()
				list.push(new Marker(35,50,'a','marker 1'))
				list.push(new Marker(30,53,'b','marker 2'))
				list.push(new Marker(37,45,'c','marker 3'))	
			var multiMarker:MultiMarker = new MultiMarker(list)
				multiMarker.marker = true
				multiMarker.setup(this,new Rectangle(0,600,384,300))
				

			//////////////////////////Sepehr debug
			
			
					
		}
		

		
		protected function panto_fun(event:MapEvent):void
		{
			// TODO Auto-generated method stub

			trace('lat :',event.makerList[0].lat,'lng :',event.makerList[0].lng)
			trace('title :',event.makerList)
			if(event.marker!=null)
			{
				trace('marker :',event.marker.label)
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
