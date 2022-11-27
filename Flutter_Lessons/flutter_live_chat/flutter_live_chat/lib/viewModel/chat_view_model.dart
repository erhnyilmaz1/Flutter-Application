// ignore_for_file: avoid_print, avoid_function_literals_in_foreach_calls

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_live_chat/locator.dart';
import 'package:flutter_live_chat/model/message.dart';
import 'package:flutter_live_chat/model/user_model.dart';
import 'package:flutter_live_chat/repository/user_repository.dart';

// ignore: constant_identifier_names
enum ChatViewState { IDLE, ERROR, LOADED, BUSY }

class ChatViewModel with ChangeNotifier {
  ChatViewState _state = ChatViewState.IDLE;
  final UserRepository _userRepository = locator<UserRepository>();
  late List<Message?> _allMessages;
  Message? _firstMessage;
  Message? _lastMessage;

  // SAYFALAMA YAPILACAK ELEMAN SAYFASI
  final int _fetchData = 10;
  // SAYFALAMA İŞLEMİNİN DEVAM EDİP ETMEYECEĞİNİ BELİRTEN DEĞİŞKEN
  bool _continueFlag = true;
  // MESAJLARI ANLIK DİNLEYİP DEĞİŞİKLİKLERİ ÖN YÜZE İLETMEYİ SAĞLAYAN DEĞİŞKEN
  bool _reelTimeMessageListenerFlag = false;

  late StreamSubscription _streamSubscription;

  final FirebaseProcessUser? currentUser;
  final FirebaseProcessUser? chatUser;

  List<Message?> get allMessageList => _allMessages;
  bool get continueFlagLoading => _continueFlag;

  ChatViewState get state => _state;

  set state(ChatViewState value) {
    _state = value;
    notifyListeners(); // HER SET İŞLEMİNDE YAPILMALIDIR. YOKSA HATA ALIR. (SETSTATE GİBİ İŞLEV GÖRÜR.)
  }

  @override
  void dispose() {
    // dispose METODU İÇERİSİNDE YAPILAN İŞLEMLER super METODUNUN ÜSTÜNDE OLUR. initState'de İSE ALTINDA OLUR.
    print('ChatViewModel Dispose Trigged');
    _streamSubscription.cancel();
    super.dispose();
  }

  ChatViewModel({this.currentUser, this.chatUser}) {
    _allMessages = [];
    getAllMessagesFetch(false);
  }

// boolfetchNewElement ==> true : Refresh And Paging Process  ; false : Open Page Process
  void getAllMessagesFetch(bool fetchNewElement) async {
    if (_allMessages.isNotEmpty) {
      _lastMessage = _allMessages.last;
      print('Fetch Last Message:  ${_lastMessage!.messageContent!}');
    }

    if (!fetchNewElement) {
      _state = ChatViewState.BUSY;
    }

    var _repoAllMessage = await _userRepository.getAllMessagesFetch(
        currentUser!.userId, chatUser!.userId, _lastMessage, _fetchData);

    if (_repoAllMessage.length < _fetchData) {
      _continueFlag = false;
    }

    _repoAllMessage.forEach((element) {
      print('Fetch Message: ${element!.messageContent!}');
    });

    _allMessages.addAll(_repoAllMessage);
    if (_allMessages.isNotEmpty) {
      _firstMessage = _allMessages.first;
      print('First Message In List: $_firstMessage ');
    }
    _state = ChatViewState.LOADED;

    if (!_reelTimeMessageListenerFlag) {
      _reelTimeMessageListenerFlag = true;
      print('Listener Has Not Yet. Will Move Listener');
      _moveReelTimeNewMessage();
    }
  }

  Future<bool> saveMessage(
      Message saveMessage, FirebaseProcessUser? currentUser) async {
    return await _userRepository.saveMessage(saveMessage,currentUser);
  }

  Future<void> fetchMoreMessage() async {
    print('Trigged Fetch More User Method In AllUsersViewModel');
    if (_continueFlag) {
      getAllMessagesFetch(true);
    } else {
      print('Won' 't Be Called Because Has Not More Element!');
    }
    await Future.delayed(const Duration(seconds: 2));
  }

  void _moveReelTimeNewMessage() {
    print('Move Listener For New Messages');
    _streamSubscription = _userRepository
        .getOppositeMessage(currentUser!.userId, chatUser!.userId)
        .listen((constantData) {
      if (constantData.isNotEmpty) {
        print(
            'Trigged Listener, Last Fetch Data : ${constantData[0].toString()}');

        // BU KONTROLÜ EKLEMEZSEM SON EKLENEN MESAJI 2 KERE INSERT EDİYOR.
        // (saveMessage() METODUNDA "createdDate": FieldValue.serverTimestamp() ATAMASI YAPILDIĞI İÇİN METOT TETİKLENDİĞİNDE LISTENER 1 KERE DAHA ÇALIŞIYOR VE 2.KERE VERIYI INSERT EDİYOR )
        if (constantData[0]!.messageDate != null) {
          if ((_firstMessage == null) ||
              (constantData[0]!.messageDate!.millisecondsSinceEpoch !=
                  _firstMessage!.messageDate!.millisecondsSinceEpoch)) {
            // ELEMANLAR TERSTEN GÖSTERİLDEİĞİNDEN (reverse:true), SON GELEN MESAJIN EN ALTTA GÖSTERİLMESİ İÇİN add METODU YERİNE insert METODU KULLANILDI ve Index'i 0 VERİLDİ.
            _allMessages.insert(0, constantData[0]);
          }
        }
        _state = ChatViewState.LOADED;
      }
    });
  }
}
