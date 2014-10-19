library runoverview;

import 'package:polymer/polymer.dart';
import '../models/run.dart';
import 'runlist.dart';

@CustomTag('run-overview')
class RunOverview extends PolymerElement {
	@published String modelId;

	@observable String name = 'hello';
	//temp properties till better solution
	@observable String tempHours;
	@observable String tempMinutes;
	@observable String tempSeconds;

	@observable RunList runlist;

	RunOverview.created() : super.created() {
	}

	@override
	void domReady() {
		//todo switch to polymer published propeties
		runlist = this.shadowRoot.querySelector("#runlist");
	}

	bool get itemSelected => run != null;

	@ComputedProperty("runlist.selectedResult")
	Run get run {
		if (runlist != null) {
			return runlist.selectedItem;
		}
		return null;
	}

	void testClick() {
		Timespan time = new Timespan(hours: 0, minutes: 29, seconds: 6);
		Distance distance = new Distance(6.5);
		//TODO fix id
		//TODO fix selection bug
		runlist.add(new Run(999, time, distance));
	}


	int toInteger(String value) {
		if (value == null || value.isEmpty) {
			return 0;
		} else {
			return int.parse(value);
		}
	}

}
