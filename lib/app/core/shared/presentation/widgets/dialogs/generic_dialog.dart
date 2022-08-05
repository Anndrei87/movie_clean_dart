import 'package:dart_clean_movies/app/core/shared/presentation/widgets/buttons/button_custom.dart';
import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';

class GenericDialog extends StatelessWidget {
  final String? message;
  final GestureTapCallback onPressed;
  final String? title;
  final bool isError;
  const GenericDialog(
      {Key? key,
      required this.onPressed,
      this.message,
      this.title,
      this.isError = false})
      : super(key: key);

  static void showGenericDialog(
      {String? message,
      required GestureTapCallback onPressed,
      String? title,
      bool isError = false,
      required BuildContext context}) {
    showDialog(
        context: context,
        builder: (context) {
          return GenericDialog(
            onPressed: onPressed,
            title: title,
            isError: isError,
            message: message,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                width: 300,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            isError
                                ? Icon(
                                    UniconsLine.exclamation_circle,
                                    color: Theme.of(context).errorColor,
                                    size: 50,
                                  )
                                : Icon(
                                    UniconsLine.check_circle,
                                    color: Colors.green[600],
                                    size: 50,
                                  ),
                            Padding(
                              padding: const EdgeInsets.only(top: 12.0),
                              child: Text(title ?? '',
                                  style: TextStyle(
                                      color: Colors.grey[700], fontSize: 32)),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 12.0),
                              child: Text(message ?? '',
                                  style: TextStyle(
                                      color: Colors.grey[500], fontSize: 18)),
                            ),
                            const SizedBox(height: 16),
                          ],
                        ),
                        MediumButton(
                          onPressed: onPressed,
                          borderRadius: 4,
                          text: 'Ok',
                          buttonColor: Theme.of(context).primaryColor,
                        ),
                      ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
