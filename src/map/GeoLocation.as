﻿package map {
    import com.mteamapp.gps.MyLocation;



    import flash.display.MovieClip;
    import flash.events.Event;
    import flash.events.EventDispatcher;
    import flash.events.GeolocationEvent;
    import flash.sensors.Geolocation;
    import flash.utils.setTimeout;


    [Event(name = "MARKER_ISREADY", type = "map.MapEvent")]
    [Event(name = "NOSUPPORTED", type = "map.MapEvent")]
    [Event(name = "GEOLOCATION_UPDATE", type = "map.MapEvent")]
    [Event(name = "GPS_NO_ACTIVE", type = "map.MapEvent")]
    public class GeoLocation extends MovieClip {

        private var _marker:Marker = null;
        private var _geo:Geolocation = null;
        private var _debugGPS:Boolean;
        private var _pause:Boolean;
        private var _accracy:String;
		private var _onGranted:Function;
		private var _onDenied:Function;

        public function get marker():Marker {

            if (!Geolocation.isSupported && !_debugGPS) {
                this.dispatchEvent(new MapEvent(MapEvent.NOSUPPORTED));
            }

            if (Geolocation.isSupported && _marker == null) {
                this.dispatchEvent(new MapEvent(MapEvent.GPS_NO_ACTIVE));
            }
            return _marker;
        }

        /**
         * @param	pause	for ios This would allow application developers to choose if they want to keep the geolocation services active when the application is in the background*/
        public function pausesLocationUpdatesAutomatically(pause:Boolean):void {
            if (_geo != null) {

                (_geo as Object).pausesLocationUpdatesAutomatically = pause;
            }
        }

        public function setAccuracy(Accracy:String):void {
            if (_geo != null) {
                (_geo as Object).desiredAccuracy = Accracy;

            }
        }

        /**
         * @param	pauseAutomatically	for ios This would allow application developers to choose if they want to keep the geolocation services active when the application is in the background*/
        public function setup(DebugGPS_p:Boolean = true, pauseAutomatically:Boolean = true, accuracy:String = "",onGranted:Function=null,onDenied:Function=null):void {

            if (onGranted == null)
				onGranted = new Function();
			if (onDenied == null)
				onDenied = new Function();
                
			if(accuracy=="")
            {
                accuracy = AccuracyMode.LOCATION_ACCURACY_NEAREST_TEN_METERS
            }
			_onGranted = onGranted;
			_onDenied = onDenied;
            getLocation(DebugGPS_p);
            _pause = pauseAutomatically;
            _accracy = accuracy;
        }

        private function getLocation(DebugGPS_p:Boolean):void {
            _debugGPS = DebugGPS_p;
            if (DebugGPS_p) {
                _marker = new Marker(35.700726037213926, 51.39178147280688);
                this.dispatchEvent(new MapEvent(MapEvent.GEOLOCATION_UPDATE));
                this.dispatchEvent(new MapEvent(MapEvent.MARKER_ISREADY));
				this.dispatchEvent(new MapEvent(MapEvent.GPS_ACTIVE));
				_onGranted();
                return;
            }

            if (!Geolocation.isSupported && !DebugGPS_p) {
                this.dispatchEvent(new MapEvent(MapEvent.NOSUPPORTED));
                return;
            }
            this.addEventListener(Event.ENTER_FRAME, chekMarkerReady);
            if (_geo == null) {
                _geo = new Geolocation();
            }
            MyLocation.getGPSPermission(permissionGranted, permissionDenid);

        }

        private function permissionGranted():void {
			if (!_geo.hasEventListener(GeolocationEvent.UPDATE))
                    _geo.addEventListener(GeolocationEvent.UPDATE, update_fun);

                if ((_geo as Object).hasOwnProperty("pausesLocationUpdatesAutomatically") && (_geo as Object).hasOwnProperty("desiredAccuracy")) {

                    (_geo as Object).pausesLocationUpdatesAutomatically = _pause;
                    (_geo as Object).desiredAccuracy = _accracy;
                }

			 this.dispatchEvent(new MapEvent(MapEvent.GPS_ACTIVE));
			 _onGranted();

		}

        private function permissionDenid():void {
            this.dispatchEvent(new MapEvent(MapEvent.GPS_NO_ACTIVE));
			_onDenied();
        }

        protected function chekMarkerReady(event:Event):void {
            //	trace('try to find Geo Location...');
            if (_marker != null) {
                this.removeEventListener(Event.ENTER_FRAME, chekMarkerReady);
                this.dispatchEvent(new MapEvent(MapEvent.MARKER_ISREADY));
                trace('Location is finded')

            }
        }

        private function update_fun(event:GeolocationEvent):void {

            trace('1***********************loca******************')
            _marker = new Marker(event.latitude, event.longitude);
            this.dispatchEvent(new MapEvent(MapEvent.GEOLOCATION_UPDATE));
        }
    }
}
