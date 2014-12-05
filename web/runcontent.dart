import 'package:polymer/polymer.dart';
import 'models/run.dart';
import 'controllers/runcontroller.dart';
import 'views/chartist_wrapper/line_graph.dart';
import '../packages/intl/intl.dart';

@CustomTag('run-content')
class RunContent extends PolymerElement {
	final RunController controller = new RunController();
	final ObservableList<Run> runs = new ObservableList();
	final ObservableList<RunPoint> runpoints = new ObservableList();
	
  @observable int selectedRace;
    
  RunContent.created() : super.created() {
  	Iterable<Run> dbRuns = controller.getAll();
  	this.runs.addAll(dbRuns);
  	this.runpoints.addAll(dbRuns.map((r) => new RunPoint(r)));
  }
}

class RunPoint implements GraphPoint {
	final DateFormat _format = new DateFormat("dd-MM-yyyy");
	final Run _run;
	
	RunPoint(this._run);
	
  @override
  Object get label => _format.format(_run.date);

  @override
  Object get value => _run.result.minutes;
}