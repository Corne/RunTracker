library runlist;

import 'package:polymer/polymer.dart';
import 'package:intl/intl.dart' show DateFormat;
import '../models/run.dart';

@CustomTag('run-list')
class RunList extends PolymerElement {

	final ObservableMap<String, List<Run>> groupedRuns = new ObservableMap();
	final ObservableList<RunViewModel> activeResults = new ObservableList();

	@published Iterable<Run> runs;

	@observable int selectedResult;
	//selected property of core-selector will always be a string
	@observable String selectedDistance = "";
	//todo use enum (still experimental)
	@observable int selectedOrder = 0;

	RunList.created()
			: super.created() {
		onPropertyChange(this, #runs, _bindruns);

		onPropertyChange(this, #selectedDistance, () => selectedResult = null);
		onPropertyChange(this, #selectedDistance, _bindActiveResults);

		onPropertyChange(this, #selectedOrder, () => selectedDistance = null);
		onPropertyChange(this, #selectedOrder, _bindruns);
	}

	void update() {
		_bindruns();
		_bindActiveResults();
	}

	void _bindruns() {
		groupedRuns.clear();
		//todo pass property as param
		if (selectedOrder == 0) {
			groupViewModels(runs, (e) => e.distance.kilometers.toString());
		} else if (selectedOrder == 1) {
			groupViewModels(runs, (e) => e.date.month.toString());
		}
	}

	void _bindActiveResults() {
		activeResults.clear();

		if (selectedDistance.isEmpty) {
			return;
		}
		activeResults.addAll(groupedRuns[selectedDistance].map((r) => new RunViewModel(r)));

		Iterable<Timespan> results = activeResults.map((vm) => vm.run.result);
		activeResults.insert(0, getAverageResult(results));
	}

	//temp solution returning a runvm, so we can use it for details
	RunViewModel getAverageResult(Iterable<Timespan> results) {
		int totalSeconds = sum(results, (timespan) => timespan.totalSeconds());
		double averageTotal = totalSeconds / results.length;

		Timespan timespan = new Timespan.fromTotalSeconds(averageTotal.round());

		Run run = new Run(-1, timespan, groupedRuns[selectedDistance].first.distance);
		return new RunViewModel.customdescription(run, "average");
	}

	int sum(Iterable<Timespan> data, int property(Timespan el)) {
		return data.map((e) => property(e)).reduce((value, element) => value + element);
	}

	void groupViewModels(Iterable<Run> data, String property(Run el)) {
		var keys = data.map((e) => property(e)).toSet();
		for (String key in keys) {
			groupedRuns[key] = toObservable(data.where((e) => property(e) == key));
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
		if (groupedRuns.keys.contains(run.distance.toString()) == false) {
			groupedRuns[run.distance.toString()] = toObservable([]);
		}
		groupedRuns[run.distance.toString()].add(run);

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
