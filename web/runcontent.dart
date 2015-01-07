import 'package:polymer/polymer.dart';

import 'dart:html';
import 'models/run.dart';
import 'controllers/runcontroller.dart';
import 'runs/runoverview.dart';

@CustomTag('run-content')
class RunContent extends PolymerElement {
	final RunController controller = new RunController();
	final ObservableList<Run> runs = new ObservableList();

	@observable int selectedRace;

	RunOverview overview;

	RunContent.created() : super.created() {
		controller.getAll()
				.then(onRunsLoaded);		
	}
	
	void onRunsLoaded(Iterable<Run> data) {
		this.runs.addAll(data);
		overview.updateOverview();
	}

	@override
	void domReady() {
		overview = shadowRoot.querySelector("#overview");
	}

	void addRun(Event e, Object detail, Node sender) {
		if (detail is Run) {
			runs.add(detail);
			overview.updateOverview();
		}
	}
}
