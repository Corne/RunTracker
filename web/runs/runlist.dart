library runlist;

import 'package:polymer/polymer.dart';
import 'package:intl/intl.dart' show DateFormat;
import '../models/run.dart';
import '../controllers/runcontroller.dart';
import '../lib/ObservableSet.dart';

@CustomTag('run-list')
class RunList extends PolymerElement {

	final RunController _controller = new RunController();

	//@observable ObservableList<RunViewModel> data;
	@observable int selectedResult;
	@observable int selectedDistanceIndex;
	
	@ComputedProperty("selectedDistanceIndex")
	String get selectedDistance { 
		if(selectedDistanceIndex != null) {
			return viewmodels.keys.elementAt(selectedDistanceIndex);
		}
		return "";
	}
	
	final ObservableMap<String, List<RunViewModel>> viewmodels = new ObservableMap();
	RunList.created()
			: super.created() {
		
		var runs = _controller.getAll().map((r) => new RunViewModel(r));
		this.orderBy(runs, (e) => e.distance);
				
		onPropertyChange(this, #selectedDistanceIndex, () => selectedResult = null);
	}
	
	void orderBy(Iterable<RunViewModel> data, String property(RunViewModel el)) {
		var keys = data.map((e) => property(e)).toSet();
		for (String key in keys) {
			viewmodels[key] = toObservable(data.where((e) => property(e) == key));
		}
	}
	
//	void dataChanged() {
//		distances.addAll(data.map((e) => e.distance));
//	}
	
	Run get selectedItem {
		if (selectedDistance == null || selectedResult == null) {
			return null;
		} else {
			return viewmodels[selectedDistance].elementAt(selectedResult).run;
		}
	}

	void add(Run run){
		if(viewmodels.keys.contains(run.distance) == false){
			viewmodels[run.distance] = toObservable([]);
		}
		viewmodels[run.distance].add(new RunViewModel(run));
	}
	
	Iterable<String> sort(Iterable<String> values) {
		return values.toList()..sort();
	}

//	@ComputedProperty("selectedDistance")
//	Iterable<RunViewModel> get results {
//		if (data != null && selectedDistance != null) {
//			return data.where(
//					(e) => e.distance == distances.elementAt(selectedDistance));
//		}
//		return [];
//	}
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
