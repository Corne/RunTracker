library runmodels;

import 'package:intl/intl.dart' show DateFormat;

class Run {
	int _id;
	Timespan _result;
	Distance _distance;
	DateTime _date;

	int get id => _id;
	String get result => _result.toString();
	String get distance => _distance.toString();

	Run(this._id, Timespan result, Distance distance, {DateTime date}) {
		this._result = result;
		this._distance = distance;

		if (date == null) {
			this._date = new DateTime.now();
		} else {
			this._date = date;
		}
	}
	
	double getAverageSpeed() {
		return _distance.kilometers / _result.totalHours();
	}
	
	double getAverageKilometerTime() {
		return _result.totalMinutes() / _distance.kilometers;
	}
}


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
		this.hours = hours;
		this.minutes = minutes;
		this.seconds = seconds;
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