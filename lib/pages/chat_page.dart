import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:projecknew/chat/chat_bubble.dart';
import 'package:projecknew/chat/chat_service.dart';
import 'package:projecknew/components/my_text_field.dart';
import 'package:projecknew/extra/filespage.dart';

class ChatPage extends StatefulWidget {
  final String receiverUserEmail;
  final String receverUserId;

  const ChatPage(
      {super.key,
      required this.receiverUserEmail,
      required this.receverUserId});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(
          widget.receverUserId, _messageController.text);
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.receiverUserEmail),
      ),
      body: Column(
        children: [
          Expanded(
            child: _buildMessageList(),
          ),
          _buildMessageInput(),

          SizedBox(height: 25,)
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    return StreamBuilder(
        stream: _chatService.getMessage(
            widget.receverUserId, _firebaseAuth.currentUser!.uid),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error${snapshot.error}');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('Loading....');
          }
          return ListView(
            children: snapshot.data!.docs
                .map((document) => _buildMessageItem(document))
                .toList(),
          );
        });
  }

  Widget _buildMessageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    var alignment = (data['senderId'] == _firebaseAuth.currentUser!.uid)
        ? Alignment.centerRight
        : Alignment.centerLeft;

    return Container(
      alignment: alignment,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment:
              (data['senderId'] == _firebaseAuth.currentUser!.uid)
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
          mainAxisAlignment:
              (data['senderId'] == _firebaseAuth.currentUser!.uid)
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.start,
          children: [
            Text(data['senderEmail']),
            SizedBox(height: 5,),
            ChatBubble(message: data['message']),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        children: [
          Expanded(
            child: MyTextField(
              controller: _messageController,
              hintText: "Enter message",
              obscureText: false,
            ),
          ),
          IconButton(
            onPressed: sendMessage,
            icon: Icon(
              Icons.arrow_upward,
              size: 40,
            ),
          ),
          IconButton(onPressed: () async{
            final result = await FilePicker.platform.pickFiles(allowMultiple: true,
            type: FileType.custom,
              allowedExtensions: ['pdf','mp4'],
            );
            if (result == null) return;

            openFile(result.files.first);

            final file = result.files.first;

            print('Name: ${file.name}');
            print('Bytes: ${file.bytes}');
            print('Size: ${file.size}');
            print('Extension: ${file.extension}');
            print('Path: ${file.path}');

            final newFile =  await SaveFilePermanently(file);

            print('From Path: ${file.path!}');
            print('To Path: ${newFile.path!}');

            openFile(file);

          }, icon: Icon(Icons.add_box_outlined))
        ],
      ),
    );
  }

  Future<File>SaveFilePermanently(PlatformFile file) async{
    final appStroge = await getApplicationDocumentsDirectory();
    final newFile = File('${appStroge.path}/${file.name}');


    return File(file.path!).copy(newFile.path);
  }

  void openFiles(List<PlatformFile> files) =>
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => Filespage(
        files: files,
        onOpenedFile: openFile,
      )));


  void openFile(PlatformFile file){
    OpenFile.open(file.path!);
  }
}
