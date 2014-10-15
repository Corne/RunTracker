library runlist;

import 'package:polymer/polymer.dart';
import '../models/run.dart';

@CustomTag('run-list')
class RunList extends PolymerElement {

	@published ObservableList<RunViewModel> data;
	@observable int selectedIndex;

	RunList.created() : super.created() {
		data = new ObservableList();
		viewmodels = new ObservableMap();
	}

	Run get selectedItem {
		if (selectedIndex == null) {
			return null; 
		} else {
			return results.elementAt(selectedIndex).run;
		}
	}

	ObservableMap<String, Iterable<RunViewModel>> viewmodels;

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
		if (data != null) {
			return data.map((vm) => vm.distance).toSet();
		}
		return new Set();
	}

	@observable int selectedDistance;

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
	Run run;

	String get result => this.run.result.toString();
	String get distance => this.run.distance.toString();

	RunViewModel(Run run) {
		this.run = run;
	}
}
