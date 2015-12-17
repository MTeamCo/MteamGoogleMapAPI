package
{
          import flash.events.Event;
          import flash.events.MouseEvent;
          import flash.display.MovieClip;
          import flash.media.StageWebView;
          import flash.geom.Rectangle;
          import flash.net.*;
          import flash.net.URLRequest;
          import flash.net.URLVariables;
 
          public class boxMapInteractive extends MovieClip
          {
                    public var webView:StageWebView;
                    public var cityAddress:String;
					
						
						
						
                    public function boxMapInteractive(inpCityAddress:String = null):void
                    {
                              addEventListener(Event.ADDED_TO_STAGE, onAddedToStage, false, 0, true);
                              addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage, false, 0, true);
                              cityAddress = inpCityAddress;
							 
                    }
 
                    private function onAddedToStage(e:Event = null):void{
                              showGoogleMap();
                              removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
						
                    }
 
                    private function onRemovedFromStage(e:Event = null):void{
                              hideGoogleMap();
                              removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
                    }
 
                    public function showGoogleMap() {
                              webView = new StageWebView();
                              webView.stage = this.stage;
                              webView.viewPort = new Rectangle(0,0,500,500); // x, y, width, height
                             // webView.loadURL("http://www.yoursite.com/googlemaps.php?location=Rijksmuseum,Amsterdam");
							  webView.loadURL("H:/kheshti/project/googleMap/test/Markers.html");
							  
							//  webView.loadURL("http://grayart.ir");
							  trace("assssssssssssssssssssssssss")
							  
							  
							  
                    }
 
                    public function hideGoogleMap() {
                           //   stage.removeChild(btnOpenDirections);
                              webView.stage = null;
                              webView.dispose();
                    }
          }
}