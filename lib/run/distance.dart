part of run;
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