// ignore_for_file: avoid_print, avoid_function_literals_in_foreach_calls, prefer_void_to_null

import 'package:flutter/material.dart';
import 'package:flutter_live_chat/locator.dart';
import 'package:flutter_live_chat/model/user_model.dart';
import 'package:flutter_live_chat/repository/user_repository.dart';

// ignore: constant_identifier_names
enum AllUsersViewState { IDLE, ERROR, LOADED, BUSY }

class AllUsersViewModel with ChangeNotifier {
  AllUsersViewState _state = AllUsersViewState.IDLE;
  final UserRepository _userRepository = locator<UserRepository>();
  late List<FirebaseProcessUser?> _allUsers;
  FirebaseProcessUser? _lastUser;

  // SAYFALAMA YAPILACAK ELEMAN SAYFASI
  final int _fetchData = 10;

  // SAYFALAMA İŞLEMİNİN DEVAM EDİP ETMEYECEĞİNİ BELİRTEN DEĞİŞKEN
  bool _continueFlag = true;

  List<FirebaseProcessUser?> get allUserList => _allUsers;
  bool get continueFlagLoading => _continueFlag;

  AllUsersViewState get state => _state;

  set state(AllUsersViewState value) {
    _state = value;
    notifyListeners(); // HER SET İŞLEMİNDE YAPILMALIDIR. YOKSA HATA ALIR. (SETSTATE GİBİ İŞLEV GÖRÜR.)
  }

  AllUsersViewModel() {
    _allUsers = [];
    _lastUser = null;
    getAllUsersFetch(_lastUser, false);
  }

// boolfetchNewElement ==> true : Refresh And Paging Process  ; false : Open Page Process
  getAllUsersFetch(FirebaseProcessUser? lastUser, bool fetchNewElement) async {
    if (_allUsers.isNotEmpty) {
      _lastUser = _allUsers.last;
      print('Fetch Last User:  ${_lastUser!.userName!}');
    }

    if (!fetchNewElement) {
      _state = AllUsersViewState.BUSY;
    }

    var _repoAllUser =
        await _userRepository.getAllUsersFetch(_lastUser, _fetchData);

    if (_repoAllUser.length < _fetchData) {
      _continueFlag = false;
    }

    _repoAllUser.forEach((element) {
      print('Fetch User: ${element!.userName!}');
    });

    _allUsers.addAll(_repoAllUser);
    _state = AllUsersViewState.LOADED;
  }

  Future<void> fetchMoreUser() async {
    print('Trigged Fetch More User Method In AllUsersViewModel');
    if (_continueFlag) {
      getAllUsersFetch(_lastUser, true);
    } else {
      print('Won' 't Be Called Because Has Not More Element!');
    }
    await Future.delayed(const Duration(seconds: 2));
  }

  Future<Null> refreshUserList() async {
    _continueFlag = true;
    _lastUser = null;
    _allUsers = [];
    getAllUsersFetch(_lastUser, true);
  }
}
