package map 
{
	/**
	 * ...
	 * @author Younes Mashayekhi
	 */
	public class AccuracyMode 
	{
		/**
		 *choose this case for Air31 and lower */
		public static const LOCATION_NOT_DEFINE:String = "notDefine";
		/**
		 *The best level of accuracy available */
		public static const LOCATION_ACCURACY_BEST:String = "locationAccuracyBest";
		/**
		 *The highest possible accuracy that uses additional sensor data to facilitate navigation apps */
		public static const LOCATION_ACCURACY_BEST_FOR_NAVIGATION:String = "locationAccuracyBestForNavigation";
		/**
		 *Accurate to within one hundred meters */
		public static const LOCATION_ACCURACY_HUNDRED_METERS:String = "locationAccuracyHundredMeters";
		/**
		 *Accurate to the nearest kilometer */
		public static const LOCATION_ACCURACY_KILOMETER:String = "locationAccuracyKilometer";
		/**
		 *Accurate to within ten meters of the desired target */
		public static const LOCATION_ACCURACY_NEAREST_TEN_METERS:String = "locationAccuracyNearestTenMeters";
		/**
		 *Accurate to the nearest three kilometers */
		public static const LOCATION_ACCURACY_THREE_KILOMETERS:String = "locationAccuracyThreeKilometers";
		public function AccuracyMode() 
		{
			
		}
		
	}

}