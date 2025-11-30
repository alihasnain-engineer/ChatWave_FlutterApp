import 'package:flutter/material.dart';
import 'home_screen.dart';

class ChatScreen extends StatefulWidget {
  final Chat chat;
  final void Function(ChatMessage) onNewMessage;
  const ChatScreen({super.key, required this.chat, required this.onNewMessage});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  void _send() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    final msg = ChatMessage(text: text, isMe: true);
    setState(() { widget.chat.messages.add(msg); });
    widget.onNewMessage(msg);
    _controller.clear();
    Future.delayed(const Duration(milliseconds: 100), () {
      _scrollController.animateTo(_scrollController.position.maxScrollExtent + 80, duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
    });
  }

  Widget _buildBubble(ChatMessage m) {
    final align = m.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    final bg = m.isMe ? const Color(0xFF6A11CB) : Colors.grey[200];
    final txtColor = m.isMe ? Colors.white : Colors.black87;

    return Column(
      crossAxisAlignment: align,
      children: [
        Container(
          constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
          decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.only(topLeft: const Radius.circular(14), topRight: const Radius.circular(14), bottomLeft: Radius.circular(m.isMe ? 14 : 4), bottomRight: Radius.circular(m.isMe ? 4 : 14))),
          child: Text(m.text, style: TextStyle(color: txtColor, fontSize: 15)),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Text('${m.time.hour.toString().padLeft(2,'0')}:${m.time.minute.toString().padLeft(2,'0')}', style: TextStyle(fontSize: 11, color: Colors.grey[500])),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(backgroundColor: Colors.blueGrey.shade100, child: Text(widget.chat.name[0].toUpperCase())),
            const SizedBox(width: 10),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(widget.chat.name, style: const TextStyle(fontSize: 16)), Text('Online', style: TextStyle(fontSize: 12, color: Colors.white70))]),
          ],
        ),
        backgroundColor: const Color(0xFF2575FC),
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.only(top: 12, bottom: 12),
              itemCount: widget.chat.messages.length,
              itemBuilder: (_, i) {
                final m = widget.chat.messages[i];
                return Align(alignment: m.isMe ? Alignment.centerRight : Alignment.centerLeft, child: _buildBubble(m));
              },
            ),
          ),
          SafeArea(
            child: Container(
              padding: const EdgeInsets.only(left: 12, right: 12, bottom: 8, top: 6),
              color: Colors.white,
              child: Row(
                children: [
                  IconButton(onPressed: () {}, icon: const Icon(Icons.add_circle_outline, color: Colors.grey)),
                  Expanded(child: TextField(controller: _controller, decoration: InputDecoration(hintText: 'Type a message', border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)), contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12)))),
                  const SizedBox(width: 8),
                  CircleAvatar(
                    radius: 22,
                    backgroundColor: const Color(0xFF6A11CB),
                    child: IconButton(icon: const Icon(Icons.send, color: Colors.white), onPressed: _send),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
