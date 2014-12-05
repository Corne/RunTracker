import 'package:polymer/polymer.dart';
import 'models/run.dart';
import 'controllers/runcontroller.dart';

@CustomTag('run-content')
class RunContent extends PolymerElement {
	final RunController controller = new RunController();
	final ObservableList<Run> runs = new ObservableList();
	
  @observable int selectedRace;
    
  RunContent.created() : super.created() {
  	Iterable<Run> dbRuns = controller.getAll();
  	this.runs.addAll(dbRuns);
  }
}