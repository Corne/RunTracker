library runoverview;

import 'package:polymer/polymer.dart';
import 'package:runtracker/run.dart';
import 'runlist.dart';
import 'runpoint.dart';

@CustomTag('run-overview')
class RunOverview extends PolymerElement {
	@published ObservableList<Run> runs;

	//@observable Iterable<RunPoint> runpoints;
	@observable RunGraphData graphdata;
	@observable RunList runlist;

	RunOverview.created() : super.created() {
	}

	//todo listen doesn't seem to work, so call update from parent
	void updateOverview() {
		_updateRunPoints();
		runlist.update();
	}

	void _updateRunPoints() {
		if (runlist == null || runlist.selectedDistance == null || runlist.selectedOrder == 1) {
			//this.runpoints = [];
			this.graphdata = null;
		} else {
			Iterable<RunPoint> runpoints = runs
					.where((r) => r.distance.kilometers.toString() == runlist.selectedDistance)
					.map((r) => new RunPoint(r));
			graphdata = new RunGraphData(runpoints);
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
