import 'package:flutter/material.dart';
import 'chat_screen.dart';
import 'add_chat_screen.dart';

void main() => runApp(const ChatWaveApp());

class ChatWaveApp extends StatelessWidget {
  const ChatWaveApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ChatWave 🌊 ',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: Colors.grey[50],
      ),
      home: const HomeScreen(),
    );
  }
}

// Chat model
class Chat {
  final String name;
  final List<String> messages;
  Chat({required this.name, List<String>? messages}) : messages = messages ?? [];
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Dummy chat data
  final List<Chat> _chats = [
    Chat(name: 'Ali Hasnain', messages: ['Hey! How are you?', 'I am good, working on Flutter.']),
    Chat(name: 'Dawood Tahir', messages: ['Did you submit the lab?', 'Yes, just now.']),
    Chat(name: 'Ahmad Yasin', messages: ['Hello!', 'Are you free today?']),
    Chat(name: 'Mam Mina Iqbal', messages: ['Meet at 5 PM?', 'Sure!']),
  ];

  void _addChat(String name) {
    setState(() => _chats.add(Chat(name: name)));
  }

  void _openChat(Chat chat) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => ChatScreen(chat: chat)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ChatWave 🌊',style: TextStyle(color: Colors.white),),
        leading: const Icon(Icons.chat_bubble ,color: Colors.white,),
        backgroundColor: Colors.indigo,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: _chats.length,
        itemBuilder: (_, i) {
          final chat = _chats[i];
          final lastMsg = chat.messages.isNotEmpty ? chat.messages.last : 'No messages yet';
          return Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            margin: const EdgeInsets.symmetric(vertical: 6),
            child: ListTile(
              leading: CircleAvatar(child: Text(chat.name[0].toUpperCase())),
              title: Text(chat.name, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(lastMsg, maxLines: 1, overflow: TextOverflow.ellipsis),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () => _openChat(chat),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final name = await Navigator.push<String>(
              context, MaterialPageRoute(builder: (_) => const AddChatScreen()));
          if (name != null && name.isNotEmpty) _addChat(name);
        },
        backgroundColor: Colors.indigo,
        child: const Icon(Icons.add,color: Colors.white,),
      ),
    );
  }
}
