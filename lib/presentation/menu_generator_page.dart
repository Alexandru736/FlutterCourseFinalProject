import 'dart:math';

import 'package:flutter/material.dart';
import '../container/foods_container.dart';
import '../models/food.dart';

import 'add_new_food_page.dart';

class MenuGenerator extends StatefulWidget {
  const MenuGenerator({Key? key}) : super(key: key);

  @override
  _MenuGeneratorState createState() => _MenuGeneratorState();
}

class _MenuGeneratorState extends State<MenuGenerator> {
  final TextEditingController _foodCarbsController = TextEditingController();
  final TextEditingController _foodCaloriesController = TextEditingController();
  final TextEditingController _foodProteinController = TextEditingController();
  final TextEditingController _foodFatController = TextEditingController();
  final TextEditingController _foodSugarController = TextEditingController();

  List<Pair> controllers = <Pair>[];
  List<Food> menu = <Food>[];

  @override
  void initState() {
    super.initState();
    controllers = <Pair>[
      Pair(_foodCarbsController, 'Carbs Amount'),
      Pair(_foodCaloriesController, 'Calories Amount'),
      Pair(_foodProteinController, 'Protein Amount'),
      Pair(_foodFatController, 'Fat Amount'),
      Pair(_foodSugarController, 'Sugar Amount')
    ];
  }

  @override
  void dispose() {
    _foodCarbsController.dispose();
    _foodCaloriesController.dispose();
    _foodProteinController.dispose();
    _foodFatController.dispose();
    _foodSugarController.dispose();
    super.dispose();
  }

  void calculateMenu(List<Food> food) {
    menu = <Food>[];

    final double neededAmountOfCalories = double.parse(_foodCaloriesController.value.text);
    final double neededAmountOfCarbs = double.parse(_foodCarbsController.value.text);
    final double neededAmountOfProtein = double.parse(_foodProteinController.value.text);
    final double neededAmountOfSugar = double.parse(_foodSugarController.value.text);
    final double neededAmountOfFat = double.parse(_foodFatController.value.text);

    bool menuIsReady = false;
    double currentAmountOfCarbs = 0;
    double currentAmountOfCalories = 0;
    double currentAmountOfProtein = 0;
    double currentAmountOfFat = 0;
    double currentAmountOfSugar = 0;

    int randomIndex;

    while (!menuIsReady) {
      if (currentAmountOfCarbs > neededAmountOfCarbs &&
          currentAmountOfCalories > neededAmountOfCalories &&
          currentAmountOfProtein > neededAmountOfProtein &&
          currentAmountOfSugar > neededAmountOfSugar &&
          currentAmountOfFat > neededAmountOfFat) {
        menuIsReady = true;
        break;
      }
      randomIndex = Random().nextInt(food.length);
      final Food selectedFood = food[randomIndex];
      setState(() {
        menu.add(selectedFood);
        currentAmountOfCarbs += double.parse(selectedFood.nutrition.carbs.value.toString());
        currentAmountOfCalories += double.parse(selectedFood.nutrition.calories.value.toString());
        currentAmountOfProtein += double.parse(selectedFood.nutrition.protein.value.toString());
        currentAmountOfFat += double.parse(selectedFood.nutrition.fat.value.toString());
        currentAmountOfSugar += double.parse(selectedFood.nutrition.sugar.value.toString());
      });
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Here is you menu'),
          children: menu.map((Food food) => SimpleDialogOption(child: Text(food.name))).toList(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu Generator'),
      ),
      body: FoodsContainer(
        builder: (BuildContext context, List<Food> food) {
          return SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Image.network(
                    'https://www.lalpathlabs.com/blog/wp-content/uploads/2019/01/Fruits-and-Vegetables-1024x683.jpg'),
                GridView.builder(
                  shrinkWrap: true,
                  itemCount: controllers.length,
                  padding: const EdgeInsetsDirectional.only(start: 10, end: 10, bottom: 10),
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.0,
                    childAspectRatio: 2.5,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    final Pair pair = controllers[index];

                    return Align(
                      child: TextField(
                        controller: pair.controller,
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        decoration: InputDecoration(
                          hintText: pair.hintText,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Container(
                    decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(5.0)),
                    child: TextButton(
                      onPressed: () {
                        calculateMenu(food);
                      },
                      child: const Text(
                        'Calculate Menu',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
