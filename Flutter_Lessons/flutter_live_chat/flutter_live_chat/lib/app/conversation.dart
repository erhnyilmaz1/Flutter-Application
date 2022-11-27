// ignore_for_file: import_of_legacy_library_into_null_safe, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_live_chat/model/message.dart';
import 'package:flutter_live_chat/viewModel/chat_view_model.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Conversation extends StatefulWidget {
  const Conversation({super.key});

  @override
  State<Conversation> createState() => _ConversationState();
}

class _ConversationState extends State<Conversation> {
  // KULLANICIYA BİLGİ GETİRİLİP GETİRİLMEDİĞİNİ BELİRTEN DEĞİŞKEN
  bool _isLoading = false;
  final TextEditingController _messageContentController =
      TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_listScrollListener);
  }

  @override
  Widget build(BuildContext context) {
    final _chatViewModel = Provider.of<ChatViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Conversation'),
      ),
      body: _chatViewModel.state == ChatViewState.BUSY
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Center(
              child: Column(
                children: <Widget>[
                  _showMessageList(),
                  _enterNewMessage(),
                ],
              ),
            ),
    );
  }

  Widget _showMessageList() {
    final _chatViewModel = Provider.of<ChatViewModel>(context);
    return Consumer<ChatViewModel>(builder: (context, ref, child) {
      return Expanded(
        child: ListView.builder(
          controller: _scrollController,
          reverse: true,
          itemBuilder: (context, index) {
            if (_chatViewModel.continueFlagLoading &&
                _chatViewModel.allMessageList.length == index) {
              return progressIndicatorNewElement();
            } else {
              Message? _message = ref.allMessageList[index];
              return _createConversationBaloon(_message);
            }
          },
          itemCount: _chatViewModel.continueFlagLoading
              ? _chatViewModel.allMessageList.length + 1
              : _chatViewModel.allMessageList.length,
        ),
      );
    });
  }

  Widget _enterNewMessage() {
    final _chatViewModel = Provider.of<ChatViewModel>(context);
    return Container(
      padding: const EdgeInsets.only(bottom: 8, left: 8),
      child: Row(
        children: <Widget>[
          Expanded(
              child: TextField(
            controller: _messageContentController,
            cursorColor: Colors.blueGrey,
            style: const TextStyle(fontSize: 16, color: Colors.black),
            decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              hintText: 'Write Your Message',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: BorderSide.none,
              ),
            ),
          )),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 4.0),
            child: FloatingActionButton(
              elevation: 0,
              backgroundColor: Colors.blue,
              child: const Icon(
                Icons.navigation,
                size: 35,
                color: Colors.white,
              ),
              onPressed: () async {
                if (_messageContentController.text.trim().isNotEmpty) {
                  Message _saveMessage = Message(
                      fromUser: _chatViewModel.currentUser!.userId,
                      toUser: _chatViewModel.chatUser!.userId,
                      conversationOwner: _chatViewModel.currentUser!.userId,
                      isFromMe: true,
                      messageContent: _messageContentController.text);
                  var _result = await _chatViewModel.saveMessage(
                      _saveMessage, _chatViewModel.currentUser!);

                  if (_result) {
                    _messageContentController.clear();
                    _scrollController.animateTo(
                        //_scrollController.position.maxScrollExtent, /* Maksimum Pozisyon */
                        0.0,
                        duration: const Duration(milliseconds: 100),
                        curve: Curves.easeOut);
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _createConversationBaloon(Message? _currentChatUserMessage) {
    final _chatViewModel = Provider.of<ChatViewModel>(context);
    Color _currentUserColor = Theme.of(context).primaryColor;
    Color _chatUserColor = Colors.blue;

    var _hourMinuteValue = "";

    try {
      _hourMinuteValue = showHourMinute(
          _currentChatUserMessage!.messageDate ?? Timestamp(1, 1));
    } catch (e) {
      debugPrint("Timestamp Error: ${e.toString()}");
    }

    var _isFromMe = _currentChatUserMessage!.isFromMe;

    if (_isFromMe!) {
      return Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Flexible(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.0),
                      color: _currentUserColor,
                    ),
                    padding: const EdgeInsets.all(10.0),
                    margin: const EdgeInsets.all(4.0),
                    child: Text(
                      _currentChatUserMessage.messageContent!,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Text(_hourMinuteValue),
              ],
            ),
          ],
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.grey.withAlpha(40),
                  backgroundImage:
                      NetworkImage(_chatViewModel.chatUser!.profilURL!),
                ),
                Flexible(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.0),
                      color: _chatUserColor,
                    ),
                    padding: const EdgeInsets.all(10.0),
                    margin: const EdgeInsets.all(4.0),
                    child: Text(_currentChatUserMessage.messageContent!),
                  ),
                ),
                Text(_hourMinuteValue),
              ],
            ),
          ],
        ),
      );
    }
  }

  String showHourMinute(Timestamp? messageDate) {
    var _formatter = DateFormat.Hm();
    var _formattedDate = _formatter.format(messageDate!.toDate());

    return _formattedDate;
  }

  progressIndicatorNewElement() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(child: CircularProgressIndicator()),
    );
  }

  void fetchOldMessage() async {
    final _chatViewModel = Provider.of<ChatViewModel>(context);
    if (!_isLoading) {
      _isLoading = true;
      await _chatViewModel.fetchMoreMessage();
      _isLoading = false;
    }
  }

  void _listScrollListener() {
    // maxScrollExtent = LİSTENİN EN AŞAĞI KISMINA GELDİĞİMİZDE OLUŞUR.
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      print("We Are In The Bottom");
      fetchOldMessage();
    }

    // minScrollExtent = LİSTENİN EN YUKARI KISMINA GELDİĞİMİZDE OLUŞUR.
    if (_scrollController.offset >=
            _scrollController.position.minScrollExtent &&
        !_scrollController.position.outOfRange) {
      print("We Are In The Top");
    }
  }
}
