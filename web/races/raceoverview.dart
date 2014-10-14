library raceoverview;

import 'package:polymer/polymer.dart';
import '../models/race.dart';
import '../controllers/racecontroller.dart';

@CustomTag('race-overview')
class RaceOverview extends PolymerElement {
	
	final RaceController controller = new RaceController();
	
	@published int selected;
  @observable ObservableList<Race> data; 
	
  RaceOverview.created() : super.created() {
		var races = controller.getAll();
		data = new ObservableList.from(races);
  }
  
  
}
