import 'package:flutter/material.dart';
import 'chat_screen.dart';
import 'add_chat_screen.dart';
import 'login_screen.dart';

class Chat {
  final String id;
  final String name;
  final List<ChatMessage> messages;
  Chat({required this.id, required this.name, List<ChatMessage>? messages}) : messages = messages ?? [];
}

class ChatMessage {
  final String text;
  final bool isMe;
  final DateTime time;
  ChatMessage({required this.text, required this.isMe, DateTime? time}) : time = time ?? DateTime.now();
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Chat> _chats = [
    Chat(id: '1', name: 'Ali', messages: [ChatMessage(text: 'Hey! How are you?', isMe: false), ChatMessage(text: 'I am good — working on a project.', isMe: true)]),

    Chat(id: '2', name: 'Ayesha', messages: [ChatMessage(text: 'Did you submit the lab?', isMe: false)]),
  ];

  void _addChat(String chatName) {
    setState(() {
      final newChat = Chat(id: DateTime.now().millisecondsSinceEpoch.toString(), name: chatName);
      _chats.insert(0, newChat);
    });
  }

  void _openChat(Chat chat) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ChatScreen(
          chat: chat,
          onNewMessage: (m) {
            setState(() {
              chat.messages.add(m);
            });
          },
        ),
      ),
    );
    setState(() {});
  }

  void _logout() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginScreen()));
  }

  PreferredSizeWidget _buildGradientAppBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(60),
      child: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [Color(0xFF6A11CB), Color(0xFF2575FC)], begin: Alignment.topLeft, end: Alignment.bottomRight),
          ),
        ),
        title: Row(children: const [Icon(Icons.waves, size: 22 ,color: Colors.white,), SizedBox(width: 8), Text('ChatWave',style: TextStyle(color: Colors.white),)]),
        actions: [IconButton(onPressed: _logout, icon: const Icon(Icons.logout,color: Colors.white,))],
      ),
    );
  }

  Widget _buildChatTile(Chat chat) {
    final last = chat.messages.isNotEmpty ? chat.messages.last : null;
    final subtitle = last?.text ?? 'No messages yet';
    final timeString = last != null ? '${last.time.hour.toString().padLeft(2,'0')}:${last.time.minute.toString().padLeft(2,'0')}' : '';
    return ListTile(
      leading: CircleAvatar(backgroundColor: Colors.blueGrey.shade200, child: Text(chat.name[0].toUpperCase())),
      title: Text(chat.name, style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text(subtitle, maxLines: 1, overflow: TextOverflow.ellipsis),
      trailing: Text(timeString, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
      onTap: () => _openChat(chat),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildGradientAppBar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
            child: TextField(decoration: InputDecoration(hintText: 'Search chats', prefixIcon: const Icon(Icons.search), filled: true, fillColor: Colors.white, contentPadding: const EdgeInsets.symmetric(vertical: 12), border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none))),
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(18))),
              child: _chats.isEmpty ? const Center(child: Text('No chats yet. Tap + to create one.')) : ListView.separated(
                itemCount: _chats.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (_, index) => _buildChatTile(_chats[index]),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final name = await Navigator.push<String>(context, MaterialPageRoute(builder: (_) => const AddChatScreen()));
          if (name != null && name.trim().isNotEmpty) _addChat(name.trim());
        },
        backgroundColor: const Color(0xFF6A11CB),
        child: const Icon(Icons.add,color: Colors.white,),
      ),
    );
  }
}
