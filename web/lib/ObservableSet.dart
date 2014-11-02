library collections;

import 'package:polymer/polymer.dart' show ObservableList;

/*
 * Temp solution for observableset till sdk gets one
 */
class ObservableSet<E> extends ObservableList<E> {
	@override
	void add(E item){
		if(!this.contains(item)){
			super.add(item);
		}
	}
	
	@override
	void addAll(Iterable<E> iterable) {
		Iterable<E> unadded = iterable.where((e) => !this.contains(e));
		super.addAll(unadded);
	}
}