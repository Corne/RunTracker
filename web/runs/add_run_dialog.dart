library rundialog;

import 'package:polymer/polymer.dart';
import '../controllers/runcontroller.dart';
import '../models/run.dart';
import 'dart:html';


@CustomTag('add-run-dialog')
class AddRunDialog extends PolymerElement {
	@published bool open = false;

	@observable bool test = true;
	
	@observable String hours = "";
	@observable String minutes = "";
	@observable String seconds = "";

	AddRunDialog.created() : super.created();

	void flipTest() {
		test = !test;
	}
	
	void createRun() {
		var controller = new RunController();
		Run added = controller.create(_getTimeSpan(), new Distance(6.0));
		
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

	int toInteger(String value) {
		if (value == null || value.isEmpty) {
			return 0;
		} else {
			return int.parse(value);
		}
	}
}
