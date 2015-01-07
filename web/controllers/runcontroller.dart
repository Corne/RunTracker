library controllers.runcontroller;

import 'dart:async';
import 'dart:convert' show JSON;
import 'dart:html';
import '../models/run.dart';

class RunController {
	final List<Run> _tempruns = new List<Run>();
	
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
		//todo use config value
			String url = "http://localhost:8080/runs/";
			String result = await HttpRequest.getString(url);
			return decodeRuns(result);
		}catch(ex){
			print("error on loading runs" + ex.toString());
			return _tempruns;
		}
	}
	
  Iterable<Run> decodeRuns(String value) {
  	print("runs loaded: " + value);
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
	
	Run create(Timespan timespan, Distance distance, {DateTime date}){
		int id = _tempruns.last.id + 1;
		Run run = new Run(id, timespan, distance, date: date);
		_tempruns.add(run);
		
		return run;
	}
  

}