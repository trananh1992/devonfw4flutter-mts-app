import 'dart:async';
import 'dart:collection';
import 'package:bloc/bloc.dart';
import 'package:my_thai_star_flutter/blocs/current_order_state.dart';
import 'package:my_thai_star_flutter/models/dish.dart';

import 'package:my_thai_star_flutter/blocs/current_order_event.dart';

class CurrentOrderBloc extends Bloc<CurrentOrderEvent, CurrentOrderState> {
  @override
  CurrentOrderState get initialState => InitialCurrentOrderState();

  @override
  Stream<CurrentOrderState> mapEventToState(CurrentOrderEvent event) async* {
    LinkedHashMap<Dish, int> newDishMap = LinkedHashMap()
      ..addAll(currentState.dishMap);

    if (event is AddDishToOrderEvent) {
      if (newDishMap.containsKey(event.order)) {
        newDishMap[event.order]++;
      } else {
        newDishMap[event.order] = 1;
      }
    }

    if (event is RemoveDishFromOrderEvent) {
      if (newDishMap.containsKey(event.order)) {
        if (newDishMap[event.order] > 1) {
          newDishMap[event.order]--;
        } else {
          newDishMap.remove(event.order);
        }
      }
    }

    if (event is DeleteOrderPositionEvent) {
      if (newDishMap.containsKey(event.order)) {
        newDishMap.remove(event.order);
      }
    }

    if (event is ClearOrderEvent) {
      newDishMap = LinkedHashMap();
    }

    yield IdleCurrentOrderState(newDishMap);
  }
}
