import 'package:flutter/material.dart';
import 'package:myshop/widgets/base_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      child: Column(
        children: [
          Text('profile'),
        ],
      ),
    );
  }
}
