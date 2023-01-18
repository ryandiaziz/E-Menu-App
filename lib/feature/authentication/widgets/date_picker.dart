import 'package:e_menu_app/shared/theme.dart';
import 'package:flutter/material.dart';

class DatePicker extends StatefulWidget {
  const DatePicker({
    Key? key,
    required this.dobController,
  }) : super(key: key);

  final TextEditingController dobController;

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  Future<void> _selectDateFromPicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(DateTime.now().year - 20),
      firstDate: DateTime(DateTime.now().year - 30),
      lastDate: DateTime(DateTime.now().year),
    );
    if (picked != null) {
      setState(() {
        widget.dobController.text =
            "${picked.day}/ ${picked.month}/ ${picked.year}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                      controller: widget.dobController,
                      style: primaryTextStyle,
                      decoration: InputDecoration(
                        hintText: "date of birth",
                        hintStyle: subtitleTextStyle,
                        suffixIcon: IconButton(
                          onPressed: () => _selectDateFromPicker(context),
                          icon: const Icon(Icons.arrow_drop_down),
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
    );
  }
}
