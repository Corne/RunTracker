import '../views/chartist_wrapper/line_graph.dart';
import '../models/run.dart';
import 'package:intl/intl.dart' show DateFormat;

class RunGraphData extends GraphData {
	
	final Iterable<GraphPoint> _points;
	
  @override
  Iterable<GraphPoint> get points => _points;
  
  RunGraphData(Iterable<GraphPoint> this._points); 
  
  
  @override
  String displayValue([value, index]) {
  	if(value is int) {
  		return new Timespan.fromTotalSeconds(value).toString();
  	}
  	return value.toString();
  }
}

class RunPoint implements GraphPoint {
	final DateFormat _format = new DateFormat("dd-MM-yyyy");
	final Run _run;
	
	RunPoint(this._run);
	
  @override
  Object get label => _format.format(_run.date);

  @override
  Object get value => _run.result.totalSeconds();
}