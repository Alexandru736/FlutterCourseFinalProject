import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import '../actions/put_food.dart';
import '../models/app_state.dart';
import '../models/food.dart';

class AddFood extends StatefulWidget {
  const AddFood({Key? key}) : super(key: key);

  @override
  _AddFoodState createState() => _AddFoodState();
}

class _AddFoodState extends State<AddFood> {
  void onPressedBackButton() {
    Navigator.pop(context);
  }

  final TextEditingController _foodNameController = TextEditingController();
  final TextEditingController _foodFamilyController = TextEditingController();
  final TextEditingController _foodGenusController = TextEditingController();
  final TextEditingController _foodOrderController = TextEditingController();
  final TextEditingController _foodCarbsController = TextEditingController();
  final TextEditingController _foodProteinsController = TextEditingController();
  final TextEditingController _foodFatController = TextEditingController();
  final TextEditingController _foodSugarController = TextEditingController();
  final TextEditingController _foodCaloriesController = TextEditingController();

  List<Pair> originsPairs = <Pair>[];
  List<Pair> nutritionPair = <Pair>[];

  @override
  void initState() {
    super.initState();
    originsPairs = <Pair>[
      Pair(_foodNameController, 'Enter name of food'),
      Pair(_foodFamilyController, 'Enter food family'),
      Pair(_foodOrderController, 'Enter food order'),
      Pair(_foodGenusController, 'Enter food genus'),
    ];
    nutritionPair = <Pair>[
      Pair(_foodCarbsController, 'Enter amount of carbs'),
      Pair(_foodCaloriesController, 'Enter amount of calories'),
      Pair(_foodFatController, 'Enter amount of fat'),
      Pair(_foodProteinsController, 'Enter amount of proteins'),
      Pair(_foodSugarController, 'Enter amount of sugar'),
    ];
  }

  void _onTap(Food food) {
    final Store<AppState> store = StoreProvider.of<AppState>(context);

    store.dispatch(
      PutFood(
        food: food,
        result: (dynamic action) {
          if (action is PutFoodError) {
            showDialog<void>(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Error putting food'),
                  content: Text('${action.error}'),
                );
              },
            );
          } else if(action is PutFoodSuccessful) {
            showDialog<void>(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Gotta wait for server response'),
                  content: Text(action.successfulMessage),
                );
                //Navigator.of(context).pop();
              },
            );
          }
        },
      ),
    );
  }

  bool isValidForm() {
    final List<TextEditingController> controllers = <TextEditingController>[
      _foodNameController,
      _foodFamilyController,
      _foodGenusController,
      _foodOrderController,
      _foodCarbsController,
      _foodProteinsController,
      _foodFatController,
      _foodSugarController,
      _foodCaloriesController,
    ];
    for (final TextEditingController controller in controllers) {
      if (controller.value.text.isEmpty)
        return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new Food'),
        leading: IconButton(
          onPressed: onPressedBackButton,
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: ListView(
        children: <Widget>[
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: originsPairs.length,
            itemBuilder: (BuildContext context, int index) {
              final Pair pair = originsPairs[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: pair.controller,
                  decoration: InputDecoration(
                    hintText: pair.hintText,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    errorText: pair.controller.value.text.isEmpty ? 'Please enter a value' : null,
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                  ),
                ),
              );
            },
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: nutritionPair.length,
            itemBuilder: (BuildContext context, int index) {
              final Pair pair = nutritionPair[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: pair.controller,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    hintText: pair.hintText,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    errorText: pair.controller.value.text.isEmpty ? 'Please enter a value' : null,
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                  ),
                ),
              );
            },
          ),
          TextButton(
            onPressed: () {
              if (!isValidForm()) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const AlertDialog(
                      title: Text('Values not set'),
                      content: Text('Please complete all fields'),
                    );
                  },
                );
                return;
              }

              final Food food = Food(
                genus: _foodGenusController.value.text,
                nutrition: Nutrition(
                  carbs: NutritionalValue(
                    name: 'carbs',
                    value: double.parse(_foodCarbsController.value.text),
                  ),
                  protein: NutritionalValue(
                    name: 'protein',
                    value: double.parse(_foodProteinsController.value.text),
                  ),
                  fat: NutritionalValue(
                    name: 'fat',
                    value: double.parse(_foodFatController.value.text),
                  ),
                  calories: NutritionalValue(
                    name: 'calories',
                    value: double.parse(_foodCaloriesController.value.text),
                  ),
                  sugar: NutritionalValue(
                    name: 'sugar',
                    value: double.parse(_foodSugarController.value.text),
                  ),
                ),
                name: _foodNameController.value.text,
                order: _foodOrderController.value.text,
                family: _foodFamilyController.value.text,
              );
              _onTap(food);
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.6,
              height: MediaQuery.of(context).size.height * 0.1,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: const Align(
                child: Text(
                  'Add new food',
                  style: TextStyle(color: Colors.white54, fontSize: 20),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class Pair {
  Pair(this.controller, this.hintText);

  final TextEditingController controller;
  final String hintText;
}
