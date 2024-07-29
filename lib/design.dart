import 'package:flutter/material.dart';
import 'main.dart';

class Paddings {
  //Paddings
  static const elevatedButton = EdgeInsets.all(10);
  static const defaultPadding = EdgeInsets.all(20);
}

class ButtonStyles {
  ///The box decoration for a button of primary status, for example the OK button in a dialog box
  static ButtonStyle primaryElevatedButton(BuildContext context) {
    return ElevatedButton.styleFrom(
      padding: const EdgeInsets.all(20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      backgroundColor: const Color.fromRGBO(255, 69, 0, 100),
    );
  }

  ///The box decoration for a button of non-primary status, for example the Cancel button in a dialog box
  static ButtonStyle secondaryElevatedButton(BuildContext context) {
    return ElevatedButton.styleFrom(
      padding: const EdgeInsets.all(20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      backgroundColor: const Color.fromARGB(156, 255, 255, 255),
    );
  }
}

class Buttons {
  static ElevatedButton primary(
          BuildContext context, String text, Function() onPressed) =>
      ElevatedButton(
          onPressed: onPressed,
          style: ButtonStyles.primaryElevatedButton(context),
          child: Text(text,
              style: tt(context)
                  .labelLarge!
                  .copyWith(color: cs(context).onPrimary)));

  static ElevatedButton secondary(
          BuildContext context, String text, Function() onPressed) =>
      ElevatedButton(
          onPressed: onPressed,
          style: ButtonStyles.secondaryElevatedButton(context),
          child: Text(text,
              style: tt(context)
                  .labelLarge!
                  .copyWith(color: cs(context).onBackground)));
}
