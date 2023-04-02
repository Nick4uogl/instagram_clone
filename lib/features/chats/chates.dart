import 'package:flutter/material.dart';

class Chates extends StatelessWidget {
  const Chates({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 15, left: 15),
            child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('back')),
          ),
          const Expanded(
              child: Center(
            child: Text('chates'),
          ))
        ],
      ),
    );
  }
}
