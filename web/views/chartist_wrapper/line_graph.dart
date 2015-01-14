import 'dart:js';
import 'package:polymer/polymer.dart';

@CustomTag('line-graph')
class LineGraph extends PolymerElement {
	
	@published GraphData graphdata;
	
	LineGraph.created() : super.created() {
		onPropertyChange(this, #graphdata, _updatechart);
	}

	@override
	void domReady() {
	}
	
	String getValue([value, index]) {
		return value.toString();
	}
	
	void _updatechart() {
		Iterable<GraphPoint> points = graphdata.points;
		if(points.length == 0) return;
		
		JsObject data = new JsObject.jsify({
			"labels": points.map((p) => p.label),
			"series": [points.map((p) => p.value)]
		});
		
		JsObject options = new JsObject.jsify({

			"axisY": {
				"labelInterpolationFnc": graphdata.displayValue,
			},
		});
		
		var test = context["Chartist"];
		var node = this.shadowRoot.querySelector('.ct-chart');
		var line = new JsObject(context["Chartist"]["Line"], [node, data, options]);
	}
}

abstract class GraphData {
	Iterable<GraphPoint> get points;
	
	String displayValue([value, index]) {
		return value.toString();
	}
	
	String displayLabel([value, index]) {
		return value.toString();
	}
}

abstract class GraphPoint {
	Object get label;
	Object get value;
}