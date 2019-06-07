import 'package:fastshop/bloc_helpers/bloc_event_state.dart';

class ListadoState extends BlocState {
  ListadoState({
    this.isRunning: false,
    this.isSuccess: false,
    this.isFailure: false,
  });

  final bool isRunning;
  final bool isSuccess;
  final bool isFailure;

  factory ListadoState.noAction() {
    return ListadoState();
  }

  factory ListadoState.running(){
    return ListadoState(isRunning: true,);
  }

  factory ListadoState.success(){
    return ListadoState(isSuccess: true,);
  }

  factory ListadoState.failure(){
    return ListadoState(isFailure: true,);
  }

}