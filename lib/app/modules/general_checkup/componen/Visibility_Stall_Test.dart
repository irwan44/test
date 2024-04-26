import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextFieldVisibilitystell extends StatefulWidget {
  final ValueNotifier<String> valueNotifier;

  const TextFieldVisibilitystell({super.key,
    required this.valueNotifier,
  });

  @override
  _TextFieldVisibilitystellState createState() => _TextFieldVisibilitystellState();
}

class _TextFieldVisibilitystellState extends State<TextFieldVisibilitystell> {
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: widget.valueNotifier.value == 'Not Oke',
      child: const Column(
        children: [
          SizedBox(height: 10),
          TextField(
            decoration: InputDecoration(
              labelText: 'Keterangan',
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    widget.valueNotifier.addListener(_updateState);
  }

  @override
  void dispose() {
    widget.valueNotifier.removeListener(_updateState);
    super.dispose();
  }

  void _updateState() {
    setState(() {});
  }
}