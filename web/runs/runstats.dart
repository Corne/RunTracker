library runstats;

import 'package:polymer/polymer.dart';
import 'package:runtracker/run/run.dart';

@CustomTag('run-stats')
class RunStats extends PolymerElement {
	RunStats.created() : super.created() {

	}

	@published Run run;

	@ComputedProperty("run")
	String get averageSpeed {
		if (run == null) {
			return "";
		} else {
			return run.getAverageSpeed().toStringAsFixed(2) + " km/h";
		}
	}

	@ComputedProperty("run")
	String get averageKilometerTime {
		if (run == null) {
			return "";
		} else {
			return run.getAverageKilometerTime().toStringAsFixed(2) + " min/km";
		}
	}

}
