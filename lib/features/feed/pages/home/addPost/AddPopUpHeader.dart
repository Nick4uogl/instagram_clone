import 'package:flutter/material.dart';

class AddPopUpHeader extends StatelessWidget {
  const AddPopUpHeader(
      {super.key,
      this.title,
      this.nextButton,
      this.nextPopUp,
      this.previousPopUp});
  final Function? nextPopUp;
  final Function? previousPopUp;
  final String? title;
  final String? nextButton;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1, color: Colors.grey),
        ),
      ),
      child: Row(
        mainAxisAlignment: (nextButton != null)
            ? MainAxisAlignment.spaceBetween
            : MainAxisAlignment.center,
        children: [
          if (nextButton != null)
            IconButton(
              onPressed: () {
                previousPopUp!();
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
            ),
          if (title != null)
            Text(
              title!,
              style: const TextStyle(color: Colors.black),
            ),
          if (nextButton != null)
            TextButton(
              onPressed: () {
                nextPopUp!();
              },
              child: Text(
                nextButton!,
                style: const TextStyle(
                    color: Colors.blue, fontWeight: FontWeight.w600),
              ),
            ),
        ],
      ),
    );
  }
}
