library controllers.runcontroller;

import 'dart:async';
import 'dart:convert' show JSON;
import 'dart:html';
import '../models/run.dart';

class RunController {
	final List<Run> _tempruns = new List<Run>();
	//todo use config value (for localhost and port)
	static const String URL = "http://localhost:8090/runs/";
	
	RunController() {
		//test data
		Distance distance = new Distance(5.0);
		Run run1 = new Run(1, new Timespan(minutes: 30, seconds: 5), distance);
		Run run2 =
				new Run(2,
						new Timespan(minutes: 25, seconds: 31),
						distance,
						date: new DateTime(2014, 5, 16));
		Run run3 =
				new Run(3,
						new Timespan(minutes: 21, seconds: 2),
						distance,
						date: new DateTime(2014, 8, 12));

		_tempruns.addAll([run1, run2, run3]);
	}
	
	Future<Iterable<Run>> getAll() async {
		try {
			String result = await HttpRequest.getString(URL);
			return decodeRuns(result);
		} catch(ex) {
			print("error on loading runs" + ex.toString());
			return _tempruns;
		}
	}
	
  Iterable<Run> decodeRuns(String value) {
  	Iterable decoded = JSON.decode(value);
  	
  	List<Run> runs = new List();
  	for(Map obj in decoded){
  		Run run = new Run.fromJSONMap(obj);
  		runs.add(run);
  	}
  	
  	return runs;
  }
  
  	
	Run getById(int id){
		return _tempruns.firstWhere((r) => r.id == id);
	}
	
	Future<Run> create(Timespan result, Distance distance, {DateTime date}) async {	
		Run run = new Run(0, result, distance, date: date);
		String json = run.toJSON();
		
		try {
			HttpRequest request = await HttpRequest.request(URL, method: "POST", sendData: json);
			Map data = JSON.decode(request.response);
			return new Run.fromJSONMap(data);
		} catch(ex) {
			_tempruns.add(run);
			return run;
		}
	}
}