library runoverview;

import 'package:polymer/polymer.dart';
import '../models/run.dart';
import 'runlist.dart';
import 'dart:html';

@CustomTag('run-overview')
class RunOverview extends PolymerElement {
	@published String modelId;

	@observable String name = 'hello';

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
		runlist.add(new Run(999, time, distance));
	}
	
	@observable bool showDialog = false;
	void buttonClick() {
		//var container = this.shadowRoot.querySelector("#container");
		//var dialog = new Element.tag("add-run-dialog");
		//container.children.add(dialog);
		showDialog = true;
	}

	void addRun(Event e, Object detail, Node sender) {
		if(detail is Run){
			runlist.add(detail);
		}
	}

}
