library controllers.racecontroller;

import '../models/race.dart';
import '../models/run.dart' show Distance;


class RaceController {

	final List<Race> _tempdata;

	RaceController()
			: _tempdata = new List<Race>() {
		RaceCourse course =
				new RaceCourse(
						new Distance(15.0),
						"http://www.montferlandrun.nl/images/made/uploads/Plattegrond_MR2_500_405_80.JPG");
		RaceCourse course2 =
				new RaceCourse(
						new Distance(17.3),
						"http://www.clipartbest.com/cliparts/dT8/5pj/dT85pj5qc.jpeg");

		_tempdata.add(new Race(1, "Montferland run", course));
		_tempdata.add(new Race(2, "Montferland run", course));
		_tempdata.add(new Race(3, "Goofy run", course2));
	}

	Iterable<Race> getAll() {
		return _tempdata;
	}


	Race getById(int id) {
		return _tempdata.firstWhere((race) => race.id == id);
	}
}
