part of run;

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
		if(this.hours > 0) {
			return new DateFormat.Hms().format(time);
		} else {
			return new DateFormat.ms().format(time);
		}
	}
}