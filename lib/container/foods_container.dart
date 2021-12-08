import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import '../models/app_state.dart';
import '../models/food.dart';

class FoodsContainer extends StatelessWidget {
  const FoodsContainer({Key? key, required this.builder}) : super(key: key);

  final ViewModelBuilder<List<Food>> builder;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, List<Food>>(
      builder: builder,
      converter: (Store<AppState> store) {
        return store.state.foods;
      },
    );
  }
}
