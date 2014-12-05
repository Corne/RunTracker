import '../views/chartist_wrapper/line_graph.dart';
import '../models/run.dart';
import 'package:intl/intl.dart' show DateFormat;

class RunPoint implements GraphPoint {
	final DateFormat _format = new DateFormat("dd-MM-yyyy");
	final Run _run;
	
	RunPoint(this._run);
	
  @override
  Object get label => _format.format(_run.date);

  @override
  Object get value => _run.result.minutes;
}