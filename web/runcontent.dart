import 'package:polymer/polymer.dart';

@CustomTag('run-content')
class RunContent extends PolymerElement {
  RunContent.created() : super.created();
	
  @observable int selectedRace;
}