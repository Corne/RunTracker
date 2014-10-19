library runlist;

import 'package:polymer/polymer.dart';
import 'package:intl/intl.dart' show DateFormat;
import '../models/run.dart';
import '../controllers/runcontroller.dart';

@CustomTag('run-list')
class RunList extends PolymerElement {

	final RunController _controller = new RunController();

	@observable ObservableList<RunViewModel> data;
	@observable int selectedResult;
	@observable int selectedDistance;

	RunList.created()
			: super.created() {
		viewmodels = new ObservableMap();

		var runs = _controller.getAll().map((r) => new RunViewModel(r));
		data = new ObservableList.from(runs);
		
		onPropertyChange(this, #selectedDistance, () => selectedResult = null);
	}
	
	Run get selectedItem {
		if (selectedResult == null) {
			return null;
		} else {
			return results.elementAt(selectedResult).run;
		}
	}

	ObservableMap<String, Iterable<RunViewModel>> viewmodels;

	void add(Run run){
		this.data.add(new RunViewModel(run));
	}
	
	void orderByDistance() {
		this.orderBy((vm) => vm.distance);
	}

	void orderBy(String property(RunViewModel el)) {
		var keys = data.map((e) => property(e)).toSet();
		for (String key in keys) {
			viewmodels[key] = data.where((e) => property(e) == key);
		}
	}

	@ComputedProperty("data.length")
	Set<String> get distances {
		return data.map((vm) => vm.distance).toSet();
	}

	@ComputedProperty("selectedDistance")
	Iterable<RunViewModel> get results {
		if (data != null && selectedDistance != null) {
			return data.where(
					(e) => e.distance == distances.elementAt(selectedDistance));
		}
		return [];
	}
}

class RunViewModel {
	final DateFormat _format = new DateFormat("dd-MM-yyyy");
	
	Run run;

	String get result => this.run.result.toString();
	String get distance => this.run.distance.toString();
	String get date => _format.format(this.run.date);

	RunViewModel(Run run) {
		this.run = run;
	}
}
