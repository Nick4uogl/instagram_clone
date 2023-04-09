import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
      height: 51,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1, color: Theme.of(context).dividerColor),
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
              icon: Icon(
                Icons.arrow_back,
                color: Theme.of(context).iconTheme.color,
              ),
            ),
          if (title != null)
            Text(
              title!,
              style: GoogleFonts.roboto(
                textStyle: TextStyle(
                  color: Theme.of(context).iconTheme.color,
                ),
              ),
            ),
          if (nextButton != null)
            TextButton(
              onPressed: () {
                nextPopUp!();
              },
              child: Text(
                nextButton!,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
        ],
      ),
    );
  }
}
