library models.race;

import 'run.dart' show Distance;

class Race {
	int id;
	String name;
	RaceCourse course;
	
	Race(this.id, this.name, this.course);
}


class RaceCourse {
	
	Distance distance;
	String map;
	
	RaceCourse(this.distance, this.map);
}