import 'package:flutter/material.dart';

class AddChatScreen extends StatefulWidget {
  const AddChatScreen({super.key});

  @override
  State<AddChatScreen> createState() => _AddChatScreenState();
}

class _AddChatScreenState extends State<AddChatScreen> {
  final TextEditingController _controller = TextEditingController();

  void _save() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    Navigator.pop(context, text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('New Chat',  style: TextStyle(color: Colors.white),) , backgroundColor: Colors.indigo),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                  labelText: 'Chat Name',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10)),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _save,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                minimumSize: const Size.fromHeight(46),
              ),
              child: const Text('Create Chat',style: TextStyle(color: Colors.white),),
            )
          ],
        ),
      ),
    );
  }
}
