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
		onPropertyChange(this, #runs, _listenchanges);
		//onPropertyChange(this, #runs, _updateRunPoints);
	}
	
	void _listenchanges() {
		//runs.listChanges.listen((_) => _updateRunPoints);
	}
	
	//todo listen doesn't seem to work, so call update from parent
  void updateOverview() {
  	//runs.where((r) => r.distance == runlist.selectedDistance)
  	this.runpoints = runs.map((r) => new RunPoint(r));
  	runlist.update();
  }

	@override
	void domReady() {
		runlist = this.shadowRoot.querySelector("#runlist");	
		this.runpoints = runs.map((r) => new RunPoint(r));
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
