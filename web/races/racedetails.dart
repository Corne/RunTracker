library racedetails;

import 'package:polymer/polymer.dart';
import '../controllers/racecontroller.dart' show RaceController;
import '../models/race.dart';

@CustomTag('race-details')
class RaceDetails extends PolymerElement {
	final RaceController controller = new RaceController();
	
	@observable Race race;
	
	//http://japhr.blogspot.nl/2014/03/different-ways-to-listen-to-polymer.html
	int _raceid;
	@published int get raceid => _raceid;
	void set raceid(int value){
		_raceid = value;
		
		if(value != null){
			race = controller.getById(value);
		}
	}

	RaceDetails.created()
			: super.created();


	String get image =>
			"http://www.montferlandrun.nl/images/made/uploads/Plattegrond_MR2_500_405_80.JPG";
}
