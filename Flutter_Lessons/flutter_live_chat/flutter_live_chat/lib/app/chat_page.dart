// ignore_for_file: prefer_void_to_null, sized_box_for_whitespace
import 'package:flutter/material.dart';
import 'package:flutter_live_chat/app/conversation.dart';
import 'package:flutter_live_chat/model/chat.dart';
import 'package:flutter_live_chat/model/user_model.dart';
import 'package:flutter_live_chat/viewModel/chat_view_model.dart';
import 'package:flutter_live_chat/viewModel/user_view_model.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    UserViewModel _userViewModel = Provider.of<UserViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat Page'),
      ),
      body: FutureBuilder<List<Chat?>>(
        future: _userViewModel.getAllConversations(_userViewModel.user!.userId),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            var _allConversations = snapshot.data;

            if (_allConversations!.isNotEmpty) {
              return RefreshIndicator(
                onRefresh: _refreshConversationList,
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    Chat? item = _allConversations[index];

                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context, rootNavigator: true)
                            .push(MaterialPageRoute(
                          builder: (context) => ChangeNotifierProvider(
                            create: (context) => ChatViewModel(
                              currentUser: _userViewModel.user!,
                              chatUser: FirebaseProcessUser.userIdAndProfilUrl(
                                  userId: item!.chatUserId!,
                                  profilURL: item.chatUserProfilUrl),
                            ),
                            child: const Conversation(),
                          ),
                        ));
                      },
                      child: ListTile(
                        title: Text(item!.lastMessage!),
                        subtitle: Text(
                            item.chatUserName! + "  " + item.timeDifference!),
                        leading: CircleAvatar(
                            backgroundColor: Colors.grey.withAlpha(40),
                            backgroundImage:
                                NetworkImage(item.chatUserProfilUrl!)),
                      ),
                    );
                  },
                  itemCount: _allConversations.length,
                ),
              );
            } else {
              return RefreshIndicator(
                onRefresh: _refreshConversationList,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Container(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.chat,
                            color: Theme.of(context).primaryColor,
                            size: 120,
                          ),
                          const Text(
                            'There Is Not Conversation Yet',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 36),
                          ),
                        ],
                      ),
                    ),
                    height: MediaQuery.of(context).size.height - 150,
                  ),
                ),
              );
            }
          }
        },
      ),
    );
  }

  Future<Null> _refreshConversationList() async {
    setState(() {});
    await Future.delayed(const Duration(seconds: 1));
    return null;
  }
}
