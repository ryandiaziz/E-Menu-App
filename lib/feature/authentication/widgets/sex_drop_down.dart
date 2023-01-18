import 'package:flutter/material.dart';

class SexDropDown extends StatefulWidget {
  const SexDropDown({
    Key? key,
    required this.gender,
    required this.items,
  }) : super(key: key);

  final String gender;
  final List<String> items;

  @override
  State<SexDropDown> createState() => _SexDropDownState();
}

class _SexDropDownState extends State<SexDropDown> {
  String? gender;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xffEFF0F6),
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      width: double.infinity,
      height: 50,
      child: DropdownButton(
        // Initial Value
        value: widget.gender,
        hint: const Text('Kategori'),

        // Down Arrow Icon
        icon: const Icon(Icons.keyboard_arrow_down),
        isExpanded: true,
        itemHeight: 50,

        // Array list of items
        items: widget.items.map((String items) {
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
}
