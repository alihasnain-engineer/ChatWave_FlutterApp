import 'package:flutter/material.dart';

class AddChatScreen extends StatefulWidget {
  const AddChatScreen({super.key});

  @override
  State<AddChatScreen> createState() => _AddChatScreenState();
}

class _AddChatScreenState extends State<AddChatScreen> {
  final TextEditingController _name = TextEditingController();

  void _save() {
    final n = _name.text.trim();
    if (n.isEmpty) return;
    Navigator.of(context).pop(n);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('New Chat'), backgroundColor: const Color(0xFF6A11CB)),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            TextField(controller: _name, decoration: InputDecoration(labelText: 'Contact or group name', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)))),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _save,
              icon: const Icon(Icons.check),
              label: const Text('Create Chat'),
              style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(46), backgroundColor: const Color(0xFF6A11CB)),
            )
          ],
        ),
      ),
    );
  }
}
