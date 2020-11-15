import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:random_meal_generator/api.dart';
import 'package:random_meal_generator/constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Map mapResponse;
  List meals;

  Future getMeal() async {
    http.Response response;
    response =
        await http.get(url);

    if (response.statusCode == 200) {
      setState(() {
        mapResponse = json.decode(response.body);
        meals = mapResponse['meals'];
      });
    }
  }

  @override
  void initState() {
    getMeal();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Todays Recipe",style: TextStyle(color: Colors.white,fontSize: 20),textAlign: TextAlign.center,
      ),
      backgroundColor: Colors.black,),
        body: meals == null
            ? Text("wait")
            : ListView.builder(
                itemCount: meals == null ? 0 : meals.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 20,),
                        Text(meals[index]['strCategory'],style: Constants.regularHeading,),
                        Text(meals[index]['strMeal'],style: TextStyle(color: Colors.black,fontSize: 40,fontWeight: FontWeight.w700),),
                        Image.network(meals[index]['strMealThumb']),
                        SizedBox(height: 20,),
                        Text("Recipe",style: Constants.regularHeading,),
                        SizedBox(height: 10,),
                        Text(meals[index]['strInstructions'],style: TextStyle(fontSize: 20),),
                      
                      
                      ],
                    ),
                  );
                },
              ));
  }
}
