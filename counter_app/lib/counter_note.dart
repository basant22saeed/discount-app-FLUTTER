import 'package:flutter/material.dart';

class CounterTextField extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final textController;
  const CounterTextField({super.key, required this.textController});

  @override
  Widget build(BuildContext context) {
    return Form(
      
      child: TextFormField(
        validator: (value) {
          if (value!.isEmpty) {
            return "This field can't be empty!";
          }
          return null;
        },
        controller: textController,
        maxLines: 10,
        maxLength: 200,
        decoration: InputDecoration(
          suffix: IconButton(
              onPressed: () {
                textController.clear();
              },
              icon: const Icon(Icons.clear)),
          hintText: "Add your notes here",
          filled: true,
          fillColor: Colors.grey[200],
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.transparent)),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
