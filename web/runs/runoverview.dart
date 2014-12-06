library runoverview;

import 'package:polymer/polymer.dart';
import '../models/run.dart';
import 'runlist.dart';
import 'runpoint.dart';

@CustomTag('run-overview')
class RunOverview extends PolymerElement {
	@published ObservableList<Run> runs;

	@observable Iterable<RunPoint> runpoints;
	@observable RunList runlist;

	RunOverview.created() : super.created() {
	}


	//todo listen doesn't seem to work, so call update from parent
	void updateOverview() {
		_updateRunPoints();
		runlist.update();
	}

	void _updateRunPoints() {
		if (runlist == null || runlist.selectedDistance == null) {
			this.runpoints = [];
		} else {
			this.runpoints = runs
					.where((r) => r.distance.toString() == runlist.selectedDistance)
					.map((r) => new RunPoint(r));
		}
	}

	@override
	void domReady() {
		runlist = this.shadowRoot.querySelector("#runlist");

		onPropertyChange(runlist, #selectedDistance, _updateRunPoints);
	}

	bool get itemSelected => run != null;

	@ComputedProperty("runlist.selectedResult")
	Run get run {
		if (runlist != null) {
			return runlist.selectedItem;
		}
		return null;
	}

}
