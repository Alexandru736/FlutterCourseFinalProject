import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import '../actions/get_food.dart';
import '../container/foods_container.dart';
import '../models/app_state.dart';
import '../models/food.dart';
import 'add_new_food_page.dart';
import 'food_page.dart';
import 'menu_generator_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    final Store<AppState> store = StoreProvider.of<AppState>(context, listen: false);
    store.dispatch(GetFoods());
  }

  void _onTap(Food food) {
    Navigator.push(
      context,
      MaterialPageRoute<FoodPage>(
        builder: (BuildContext context) {
          return FoodPage(food: food);
        },
      ),
    );
  }

  void onPressedAddFood() {
    Navigator.push(
      context,
      MaterialPageRoute<AddFood>(
        builder: (BuildContext context) {
          return const AddFood();
        },
      ),
    );
  }

  void onPressedMenuGenerator() {
    Navigator.push(
      context,
      MaterialPageRoute<AddFood>(
        builder: (BuildContext context) {
          return const MenuGenerator();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Foods'),
        actions: <Widget>[
          IconButton(
            onPressed: onPressedMenuGenerator,
            icon: const Icon(Icons.menu_book_outlined),
          ),
          IconButton(
            onPressed: onPressedAddFood,
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: FoodsContainer(builder: (BuildContext context, List<Food> foods) {
        return ListView.builder(
          itemCount: foods.length,
          itemBuilder: (BuildContext context, int index) {
            final Food food = foods[index];
            final String foodName = foods[index].name;
            return InkWell(
              onTap: () {
                _onTap(food);
              },
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.1,
                child: Card(
                  child: ListTile(
                    title: Text(
                      foodName,
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
