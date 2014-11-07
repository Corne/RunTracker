library runlist;

import 'package:polymer/polymer.dart';
import 'package:intl/intl.dart' show DateFormat;
import '../models/run.dart';
import '../controllers/runcontroller.dart';

@CustomTag('run-list')
class RunList extends PolymerElement {

	final RunController _controller = new RunController();

	@observable int selectedResult;
	@observable String selectedDistance = "";
	
	final ObservableMap<String, List<RunViewModel>> viewmodels = new ObservableMap();
	RunList.created()
			: super.created() {
		
		var runs = _controller.getAll().map((r) => new RunViewModel(r));
		this.orderBy(runs, (e) => e.distance);
				
		onPropertyChange(this, #selectedDistance, () => selectedResult = null);
	}
	
	void orderBy(Iterable<RunViewModel> data, String property(RunViewModel el)) {
		var keys = data.map((e) => property(e)).toSet();
		for (String key in keys) {
			viewmodels[key] = toObservable(data.where((e) => property(e) == key));
		}
	}
		
	Run get selectedItem {
		if (selectedDistance == null || selectedResult == null) {
			return null;
		} else {
			return viewmodels[selectedDistance].elementAt(selectedResult).run;
		}
	}

	void add(Run run){
		if(viewmodels.keys.contains(run.distance.toString()) == false){
			viewmodels[run.distance.toString()] = toObservable([]);
		}
		viewmodels[run.distance.toString()].add(new RunViewModel(run));
	}
	
	Iterable<String> sort(Iterable<String> values) {
		return values.toList()..sort();
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
