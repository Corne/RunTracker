library controllers.runcontroller;

import '../models/run.dart';

class RunController {
	
	final List<Run> _tempruns = new List<Run>();
	
	RunController() {
		//test data
		Distance distance = new Distance(5.0);
		Run run1 = new Run(1, new Timespan(minutes: 30, seconds: 5), distance);
		Run run2 =
				new Run(2,
						new Timespan(minutes: 25, seconds: 31),
						distance,
						date: new DateTime(2014, 5, 16));
		Run run3 =
				new Run(3,
						new Timespan(minutes: 21, seconds: 2),
						distance,
						date: new DateTime(2014, 8, 12));
		
		this._tempruns.addAll([run1, run2, run3]);
	}
	
	Iterable<Run> getAll() {
		return this._tempruns;
	}
	
	Run getById(int id){
		return _tempruns.firstWhere((r) => r.id == id);
	}
}