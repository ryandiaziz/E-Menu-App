import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_menu_app/presentation/pages/home/home_page.dart';
import 'package:e_menu_app/shared/theme.dart';
import 'package:e_menu_app/widgets/custom_textfield.dart';
import 'package:e_menu_app/widgets/mytextformfield.dart';
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
    Widget buildCategory() {
      return Container(
        color: const Color(0xffEFF0F6),
        margin: const EdgeInsets.only(top: 20),
        padding: const EdgeInsets.symmetric(horizontal: 15),
        width: double.infinity,
        height: 50,
        child: DropdownButton(
          // Initial Value
          value: gender,
          hint: const Text('Kategori'),

          // Down Arrow Icon
          icon: const Icon(Icons.keyboard_arrow_down),
          isExpanded: true,
          itemHeight: 50,

          // Array list of items
          items: items.map((String items) {
            return DropdownMenuItem(
              value: items,
              child: Text(items),
            );
          }).toList(),
          // After selecting the desired option,it will
          // change button value to selected value
          onChanged: (String? newValue) {
            setState(() {
              gender = newValue!;
            });
          },
        ),
      );
    }

    Widget customButton(String buttonText, onPressed) {
      return Container(
        margin: const EdgeInsets.only(top: 20),
        height: 50,
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onPressed,
          child: Text(
            buttonText,
            style: const TextStyle(color: Colors.white, fontSize: 18),
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
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 50,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: const Color(0xffEFF0F6),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Center(
                          child: Row(
                            children: [
                              Image.asset(
                                'assets/icon/calendar.png',
                                width: 17,
                                color: secondsubtitleColor,
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              Expanded(
                                child: TextFormField(
                                  readOnly: true,
                                  controller: dobController,
                                  style: primaryTextStyle,
                                  decoration: InputDecoration(
                                    hintText: "date of birth",
                                    hintStyle: subtitleTextStyle,
                                    suffixIcon: IconButton(
                                      onPressed: () =>
                                          _selectDateFromPicker(context),
                                      icon: Icon(Icons.arrow_drop_down),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                buildCategory(),

                // TextField(
                //   controller: dobController,
                //   readOnly: true,
                //   decoration: InputDecoration(
                //     hintText: "date of birth",
                //     suffixIcon: IconButton(
                //       onPressed: () => _selectDateFromPicker(context),
                //       icon: Icon(Icons.calendar_today_outlined),
                //     ),
                //   ),
                // ),
                // TextField(
                //   controller: genderController,
                //   readOnly: true,
                //   decoration: InputDecoration(
                //     hintText: "choose your gender",
                //     prefixIcon: DropdownButton<String>(
                //       items: gender.map((String value) {
                //         return DropdownMenuItem<String>(
                //           value: value,
                //           child: new Text(value),
                //           onTap: () {
                //             setState(() {
                //               genderController.text = value;
                //             });
                //           },
                //         );
                //       }).toList(),
                //       onChanged: (_) {},
                //     ),
                //   ),
                // ),
                // myTextField(
                //     "enter your age", TextInputType.number, ageController),

                // SizedBox(
                //   height: 50,
                // ),

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
