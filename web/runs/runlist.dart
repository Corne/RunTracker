library runlist;

import 'package:polymer/polymer.dart';
import 'package:intl/intl.dart' show DateFormat;
import '../models/run.dart';

@CustomTag('run-list')
class RunList extends PolymerElement {

	final ObservableMap<String, List<RunViewModel>> viewmodels = new ObservableMap();
	final ObservableList<RunViewModel> activeResults = new ObservableList();

	@published Iterable<Run> runs;

	@observable int selectedResult;
	@observable String selectedDistance = "";
	//todo use enum (still experimental)
	@observable int selectedOrder = 0;

	RunList.created()
			: super.created() {
		onPropertyChange(this, #runs, _bindruns);

		onPropertyChange(this, #selectedDistance, () => selectedResult = null);
		onPropertyChange(this, #selectedDistance, _bindActiveResults);

		onPropertyChange(this, #selectedOrder, () => selectedDistance = "");
		onPropertyChange(this, #selectedOrder, _bindruns);
	}

	void update() {
		_bindruns();
		_bindActiveResults();
	}

	void _bindruns() {
		viewmodels.clear();
		//todo pass property as param
		if (selectedOrder == 0) {
			groupViewModels(runs.map((r) => new RunViewModel(r)), (e) => e.distance);
		} else if (selectedOrder == 1) {
			groupViewModels(runs.map((r) => new RunViewModel(r)), (e) => e.run.date.month.toString());
		}
	}

	void _bindActiveResults() {
		activeResults.clear();

		if (selectedDistance.isEmpty) {
			return;
		}

		activeResults.addAll(viewmodels[selectedDistance]);

		Iterable<Timespan> results = activeResults.map((vm) => vm.run.result);
		activeResults.insert(0, getAverageResult(results));
	}

	//temp solution returning a runvm, so we can use it for details
	RunViewModel getAverageResult(Iterable<Timespan> results) {
		int totalSeconds = sum(results, (timespan) => timespan.totalSeconds());
		double averageTotal = totalSeconds / results.length;

		Timespan timespan = new Timespan.fromTotalSeconds(averageTotal.round());

		Run run = new Run(-1, timespan, viewmodels[selectedDistance].first.run.distance);
		return new RunViewModel.customdescription(run, "average");
	}

	int sum(Iterable<Timespan> data, int property(Timespan el)) {
		return data.map((e) => property(e)).reduce((value, element) => value + element);
	}

	void groupViewModels(Iterable<RunViewModel> data, String property(RunViewModel el)) {
		var keys = data.map((e) => property(e)).toSet();
		for (String key in keys) {
			viewmodels[key] = toObservable(data.where((e) => property(e) == key));
		}
	}

	Run get selectedItem {
		if (selectedDistance == null || selectedResult == null) {
			return null;
		} else {
			return activeResults.elementAt(selectedResult).run;
		}
	}

	void add(Run run) {
		if (viewmodels.keys.contains(run.distance.toString()) == false) {
			viewmodels[run.distance.toString()] = toObservable([]);
		}
		viewmodels[run.distance.toString()].add(new RunViewModel(run));

		_bindActiveResults();
	}

	Iterable<String> sort(Iterable<String> values) {
		return values.toList()..sort();
	}

	@observable bool showDialog = false;
	void addNewRun() {
		showDialog = true;
	}
}

class RunViewModel {
	static final DateFormat _format = new DateFormat("dd-MM-yyyy");

	final String _description;

	Run run;

	String get result => this.run.result.toString();
	String get distance => this.run.distance.toString();
	String get description => _description;

	RunViewModel(Run run) : _description = _format.format(run.date) {
		this.run = run;
	}

	RunViewModel.customdescription(Run run, String description) : _description = description {
		this.run = run;
	}
}
