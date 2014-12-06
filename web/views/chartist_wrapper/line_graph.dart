import 'dart:js';
import 'package:polymer/polymer.dart';

@CustomTag('line-graph')
class LineGraph extends PolymerElement {
	
	@published Iterable<GraphPoint> points;
	
	LineGraph.created() : super.created() {
		onPropertyChange(this, #points, _updatechart);
	}

	@override
	void domReady() {
	}
	
	void _updatechart() {
		JsObject data = new JsObject.jsify({
			"labels": points.map((p) => p.label),
			"series": [points.map((p) => p.value)]
		});
		
		JsObject options = new JsObject.jsify({
			"low": 0,
		});
		
		var test = context["Chartist"];
		var node = this.shadowRoot.querySelector('.ct-chart');
		var line = new JsObject(context["Chartist"]["Line"], [node, data, options]);
	}
}

abstract class GraphPoint {
	Object get label;
	Object get value;
}