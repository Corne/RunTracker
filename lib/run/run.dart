library run;

import 'package:intl/intl.dart' show DateFormat;
import 'dart:convert' show JSON;

part 'distance.dart';
part 'timespan.dart';

class Run {
	int _id;
	Timespan _result;
	Distance _distance;
	DateTime _date;

	int get id => _id;
	Timespan get result => _result;
	Distance get distance => _distance;
	DateTime get date => _date;

	Run(this._id, Timespan result, Distance distance, {DateTime date}) {
		this._result = result;
		this._distance = distance;

		if (date == null) {
			this._date = new DateTime.now();
		} else {
			this._date = date;
		}
	}
	
	Run.fromJSONMap(Map json) {
		this._id = json["id"];
		//todo validation
		this._result = new Timespan.fromTotalSeconds(json["result"]);
		this._distance = new Distance(double.parse(json["distance"].toString()));
		//server has seconds since epoch so multiply by 1000
		this._date = new DateTime.fromMillisecondsSinceEpoch((json["date"] * 1000).round()); 
	}
	
	//todo look at http://stackoverflow.com/questions/20024298/add-json-serializer-to-every-model-class for easier encoding
	String toJSON() {
		Map map = new Map();
		
		map["id"] = id;
		map["result"] = result.totalSeconds();
		map["distance"] = distance.kilometers;
		map["date"] = (date.millisecondsSinceEpoch / 1000).round();
		
		return JSON.encode(map);
	}
	
	double getAverageSpeed() {
		return _distance.kilometers / _result.totalHours();
	}
	
	double getAverageKilometerTime() {
		return _result.totalMinutes() / _distance.kilometers;
	}
	
	@override toString() {
		return "Run instance -> Id: $id, result: $result, distance: $distance, date: $date";
	}
}