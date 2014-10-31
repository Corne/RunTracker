library rundialog;

import 'package:polymer/polymer.dart';
import '../controllers/runcontroller.dart';


@CustomTag('add-run-dialog')
class AddRunDialog extends PolymerElement {
	@published bool open = false;
	
	@observable String hours;
	@observable String minutes;
	@observable String seconds;
	
  AddRunDialog.created() : super.created();
	
  void createRun() {
  	var controller  = new RunController();
  	
  	//controller.create(timespan, distance)
  	
  }
}