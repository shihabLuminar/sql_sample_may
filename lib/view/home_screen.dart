import 'package:flutter/material.dart';
import 'package:sql_sample_may/controller/home_screen_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController nameContorller = TextEditingController();
  TextEditingController designationContrller = TextEditingController();
  final _fromKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: _fromKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Add an employees",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 30),

              // email input fied
              TextFormField(
                controller: nameContorller,
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  hintText: "Name",
                  hintStyle: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 16,
                      fontWeight: FontWeight.normal),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.grey.shade400,
                      )),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Color(0xff1a75d2),
                      )),
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.red.shade400,
                      )),
                ),
                validator: (value) {
                  if (value != null && value.isNotEmpty) {
                    return null;
                  } else {
                    return "Enter a Name";
                  }
                },
              ),
              SizedBox(height: 20),
              // password input field
              TextFormField(
                  controller: designationContrller,
                  obscureText: true,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    hintText: "Designation",
                    hintStyle: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 16,
                        fontWeight: FontWeight.normal),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.grey.shade400,
                        )),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Color(0xff1a75d2),
                        )),
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.red.shade400,
                        )),
                  ),
                  validator: (value) {
                    if (value != null && value.length >= 6) {
                      return null;
                    } else {
                      return "Enter a data";
                    }
                  }),
              SizedBox(height: 20),

              InkWell(
                onTap: () async {
                  await HomeScreenController.addEmployee(
                      name: nameContorller.text,
                      designation: designationContrller.text);
                  await HomeScreenController.getEmployees();
                  setState(() {});
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Color(0xff1a75d2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    "Save",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              Expanded(
                  child: ListView.builder(
                itemCount: HomeScreenController.myDataList.length,
                itemBuilder: (context, index) => ListTile(
                  title: Text(HomeScreenController.myDataList[index]["name"]),
                  subtitle: Text(
                      HomeScreenController.myDataList[index]["designation"]),
                  trailing: IconButton(
                      onPressed: () async {
                        await HomeScreenController.deleteEmployee(
                            HomeScreenController.myDataList[index]["id"]);
                        setState(() {});
                      },
                      icon: Icon(Icons.delete)),
                ),
              ))
            ],
          ),
        ),
      )),
    );
  }
}
