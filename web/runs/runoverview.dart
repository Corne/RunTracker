library runoverview;

import 'package:polymer/polymer.dart';
import '../models/run.dart';
import 'runlist.dart';

@CustomTag('run-overview')
class RunOverview extends PolymerElement {
	@published String modelId;

	//@observable Run run;
	//@observable ObservableList<RunViewModel> items;

	@observable String name = 'hello';

	//temp properties till better solution
	@observable String tempHours;
	@observable String tempMinutes;
	@observable String tempSeconds;

	@observable RunList runlist;

	RunOverview.created() : super.created() {
		//items = new ObservableList();
	}
	
	@override
	void domReady() {
		var temp = this.shadowRoot.querySelector("#runlist");
		runlist = temp;
		
		
		
		//test data
		Distance distance = new Distance(5.0);
		Run run1 = new Run(new Timespan(minutes: 30, seconds: 5), distance);
		Run run2 =
				new Run(
						new Timespan(minutes: 25, seconds: 31),
						distance,
						date: new DateTime(2014, 5, 16));
		Run run3 =
				new Run(
						new Timespan(minutes: 21, seconds: 2),
						distance,
						date: new DateTime(2014, 8, 12));

		runlist.data.addAll(
				[new RunViewModel(run1), new RunViewModel(run2), new RunViewModel(run3)]);
	}

	bool get itemSelected => run != null;

	@ComputedProperty("runlist.selectedIndex")
	Run get run {
		if (runlist != null) {
			return runlist.selectedItem;
		}
		return null;
	}

	void testClick() {
		Timespan time =
				new Timespan(
						hours: 0,
						minutes: 29,
						seconds: 6);

		Distance distance = new Distance(6.5);

		runlist.data.add(new RunViewModel(new Run(time, distance)));
	}

	
	int toInteger(String value) {
		if (value == null || value.isEmpty) {
			return 0;
		} else {
			return int.parse(value);
		}
	}

}
