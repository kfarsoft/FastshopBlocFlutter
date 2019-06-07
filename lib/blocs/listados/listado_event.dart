import 'package:fastshop/bloc_helpers/bloc_event_state.dart';
import 'package:meta/meta.dart';

class ListadoEvent extends BlocEvent {

  final ListadoEventType event;
  final String idList;


  ListadoEvent({
    @required this.event,
    @required this.idList,
  });

}

enum ListadoEventType {
  none,
  working,
}