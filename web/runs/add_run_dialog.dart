library rundialog;

import 'package:polymer/polymer.dart';
import '../controllers/runcontroller.dart';
import '../models/run.dart';
import 'dart:html';


@CustomTag('add-run-dialog')
class AddRunDialog extends PolymerElement {
	@published bool open = false;
	@published String defaultdistance = "";

	@observable bool test = true;

	@observable String hours = "";
	@observable String minutes = "";
	@observable String seconds = "";

	@observable String distance = "";

	AddRunDialog.created() : super.created() {
		onPropertyChange(this, #open, setDefaultDistance);
	}

	void setDefaultDistance() {
		if (open) {
			//kinda ugly but does the job for now
			RegExp exp = new RegExp("[-+]?[0-9]*\\.?[0-9]+([eE][-+]?[0-9]+)?");
      Match match = exp.firstMatch(defaultdistance);
      this.distance = match.group(0);
		}
	}

	void flipTest() {
		test = !test;
	}

	void createRun() {
		var controller = new RunController();
		Run added = controller.create(_getTimeSpan(), _getDistance());

		dispatchEvent(new CustomEvent("runadded", detail: added));
	}

	@ComputedProperty('minutes.isNotEmpty && seconds.isNotEmpty')
	bool get validInput => readValue(#validInput);

	Timespan _getTimeSpan() {
		return new Timespan(
				hours: toInteger(hours),
				minutes: toInteger(minutes),
				seconds: toInteger(seconds));
	}

	Distance _getDistance() {
		return new Distance(toDouble(distance));
	}

	int toInteger(String value) {
		if (value == null || value.isEmpty) {
			return 0;
		} else {
			return int.parse(value);
		}
	}

	double toDouble(String value) {
		return double.parse(value);
	}
}
