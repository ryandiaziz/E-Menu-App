import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_menu_app/common/widgets/custom_elevated_button.dart';
import 'package:e_menu_app/common/widgets/custom_textfield.dart';
import 'package:e_menu_app/feature/authentication/widgets/date_picker.dart';
import 'package:e_menu_app/feature/authentication/widgets/sex_drop_down.dart';
import 'package:e_menu_app/shared/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserForm extends StatefulWidget {
  const UserForm({Key? key}) : super(key: key);

  @override
  _UserFormState createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  // Initial Selected Value
  String gender = 'Male';

  // List of items in our dropdown menu
  var items = ['Male', 'Female'];

  sendUserDataToDB() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;

    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection("users");
    return _collectionRef
        .doc(currentUser!.email)
        .set({
          "id": currentUser.uid,
          "name": nameController.text,
          "phone": int.parse(phoneController.text),
          "email": (currentUser.email),
          "dob": dobController.text,
          "gender": gendervalue,
          "isOwner": false,
          "isAdmin": false,
          "imageUrl": null,
        })
        .then((value) => Navigator.pushReplacementNamed(context, '/home-page'))
        .catchError((error) => ("something is wrong. $error"));
  }

  String gendervalue = 'male';

  // List of items in our dropdown menu
  var genders = ["Male", "Female"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
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
                const SizedBox(
                  height: 15,
                ),
                CustomTextField(
                  image: 'assets/icon/icon_profile_select.png',
                  controller: nameController,
                  hintText: "Full Name",
                  keyBoardType: TextInputType.text,
                  read: false,
                ),
                CustomTextField(
                  image: 'assets/icon/phone.png',
                  controller: phoneController,
                  hintText: "Phone Number",
                  keyBoardType: TextInputType.number,
                  read: false,
                ),
                DatePicker(dobController: dobController),
                SexDropDown(gender: gender, items: items),
                const SizedBox(height: 20),
                CustomElevatedButton(
                    onPressed: () => sendUserDataToDB(), text: "Continue"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
