library rundialog;

import 'package:polymer/polymer.dart';
import '../controllers/runcontroller.dart';
import 'package:runtracker/run/run.dart';
import 'dart:html';


@CustomTag('add-run-dialog')
class AddRunDialog extends PolymerElement {
	@published bool open = false;
	@published String defaultdistance = "";

	@observable String hours = "";
	@observable String minutes = "";
	@observable String seconds = "";

	@observable String distance = "";
	@observable String date = "";
	

	AddRunDialog.created() : super.created() {
		onPropertyChange(this, #open, setDefaultValues);
	}

	void setDefaultValues() {
		if (open) { 
			//kinda ugly but does the job for now
			RegExp exp = new RegExp("[-+]?[0-9]*\\.?[0-9]+([eE][-+]?[0-9]+)?");
      Match match = exp.firstMatch(defaultdistance);
      if(match != null){
      	this.distance = match.group(0);
      }
      //todo use transformer: https://gist.github.com/Vloz/10553552
      String now = new DateTime.now().toString();
      this.date = now.substring(0, now.lastIndexOf(' '));
		}
	}

	void createRun() {
		var controller = new RunController();
		controller.create(_getTimeSpan(), _getDistance(), date: _getDateTime()).then(_onRunResult);
	}
	
	void _onRunResult(Run run) {
		dispatchEvent(new CustomEvent("runadded", detail: run));
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
	
	DateTime _getDateTime() {
		return DateTime.parse(date);
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
