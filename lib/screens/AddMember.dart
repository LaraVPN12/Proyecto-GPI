import 'package:flutter/material.dart';
import 'package:proyecto_visitas/screens/MemberForm.dart';

class AddMember extends StatefulWidget {
  const AddMember({super.key});

  @override
  State<AddMember> createState() => _AddMemberState();
}

class _AddMemberState extends State<AddMember> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const MemberForm())),
        focusElevation: 5,
        backgroundColor: Colors.greenAccent[400],
        child: const Icon(
          Icons.add,
          size: 25,
          color: Colors.white,
        ),
      ),
    );
  }
}
