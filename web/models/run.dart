library models.run;

import 'package:intl/intl.dart' show DateFormat;
import 'dart:convert' show JSON;

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
		//we have nano's since epoch, so divide by 1000000, todo change on server?
		this._date = new DateTime.fromMillisecondsSinceEpoch((json["date"] / 1000000).round()); 
	}
	
	//todo look at http://stackoverflow.com/questions/20024298/add-json-serializer-to-every-model-class for easier encoding
	String toJSON() {
		Map map = new Map();
		
		map["id"] = id;
		map["result"] = result.totalSeconds();
		map["distance"] = distance.kilometers;
		map["date"] = date.millisecondsSinceEpoch * 1000000;
		
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


//todo refactor to meters as base?
class Distance {
	double _kilometers;
	
	double get kilometers => this._kilometers;

	Distance(double kilometers){
		this._kilometers = kilometers;
	}
		
	@override toString() {
		return "$_kilometers km";
	}
}

class Timespan {

	int hours;
	int minutes;
	int seconds;

	Timespan({int hours: 0, int minutes: 0, int seconds: 0}) {
		if(minutes > 60 || seconds > 60){
			throw new ArgumentError("Minutes and seconds should have value under 60");
		}
		this.hours = hours;
		this.minutes = minutes;
		this.seconds = seconds;
	}
	
	Timespan.fromTotalSeconds(final int seconds){
		int rest = seconds;
		this.hours = (rest / 3600).floor();
		rest = rest - (hours * 3600);
		this.minutes = (rest / 60).floor();
		rest = rest - (minutes * 60);
		this.seconds = rest;
	}
	
	double totalHours() {
		return this.totalMinutes() /  60.0;
	}
	
	double totalMinutes() {
		return this.totalSeconds() / 60.0;
	}
	
	int totalSeconds() {
		return (hours * 60 * 60) + (minutes * 60) + seconds;
	}

	DateTime toDateTime() {
		return new DateTime(0, 0, 0, this.hours, this.minutes, this.seconds);
	}

	@override toString() {
		var time = this.toDateTime();
		return new DateFormat.Hms().format(time);
	}
}