import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_menu_app/presentation/pages/home/home_page.dart';
import 'package:e_menu_app/shared/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserForm extends StatefulWidget {
  @override
  _UserFormState createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  List<String> gender = ["Male", "Female", "Other"];

  Future<void> _selectDateFromPicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(DateTime.now().year - 20),
      firstDate: DateTime(DateTime.now().year - 30),
      lastDate: DateTime(DateTime.now().year),
    );
    if (picked != null) {
      setState(() {
        dobController.text = "${picked.day}/ ${picked.month}/ ${picked.year}";
      });
    }
  }

  sendUserDataToDB() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;

    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection("users-form-data");
    return _collectionRef
        .doc(currentUser!.email)
        .set({
          "id": currentUser.uid,
          "name": nameController.text,
          "phone": phoneController.text,
          "email": currentUser.email,
          "dob": dobController.text,
          "gender": genderController.text,
          "age": ageController.text,
        })
        .then((value) => Navigator.push(
            context, MaterialPageRoute(builder: (_) => const HomePage())))
        .catchError((error) => ("something is wrong. $error"));
  }

  @override
  Widget build(BuildContext context) {
    Widget myTextField(String hintText, keyBoardType, controller) {
      return TextField(
        keyboardType: keyBoardType,
        controller: controller,
        decoration: InputDecoration(hintText: hintText),
      );
    }

    Widget customButton(String buttonText, onPressed) {
      return SizedBox(
        width: 200,
        height: 56,
        child: ElevatedButton(
          onPressed: onPressed,
          child: Text(
            buttonText,
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          style: ElevatedButton.styleFrom(
            primary: priceColor,
            elevation: 3,
          ),
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Submit the form to continue.",
                  style: TextStyle(fontSize: 22, color: priceColor),
                ),
                const Text(
                  "We will not share your information with anyone.",
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFFBBBBBB),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                myTextField(
                    "enter your name", TextInputType.text, nameController),
                myTextField("enter your phone number", TextInputType.number,
                    phoneController),
                TextField(
                  controller: dobController,
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: "date of birth",
                    suffixIcon: IconButton(
                      onPressed: () => _selectDateFromPicker(context),
                      icon: Icon(Icons.calendar_today_outlined),
                    ),
                  ),
                ),
                TextField(
                  controller: genderController,
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: "choose your gender",
                    prefixIcon: DropdownButton<String>(
                      items: gender.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: new Text(value),
                          onTap: () {
                            setState(() {
                              genderController.text = value;
                            });
                          },
                        );
                      }).toList(),
                      onChanged: (_) {},
                    ),
                  ),
                ),
                myTextField(
                    "enter your age", TextInputType.number, ageController),

                SizedBox(
                  height: 50,
                ),

                // elevated button
                customButton("Continue", () => sendUserDataToDB()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
