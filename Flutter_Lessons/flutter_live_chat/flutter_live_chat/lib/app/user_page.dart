// ignore_for_file: non_constant_identifier_names, prefer_void_to_null, sized_box_for_whitespace, avoid_print, unrelated_type_equality_checks, unnecessary_null_comparison
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_live_chat/app/conversation.dart';
import 'package:flutter_live_chat/viewModel/all_users_view_model.dart';
import 'package:flutter_live_chat/viewModel/chat_view_model.dart';
import 'package:flutter_live_chat/viewModel/user_view_model.dart';
import 'package:provider/provider.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  // KULLANICIYA BİLGİ GETİRİLİP GETİRİLMEDİĞİNİ BELİRTEN DEĞİŞKEN
  bool _isLoading = false;
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();

    // _scrollController.addListener(() {
    //   if (_scrollController.position.atEdge) {
    //     print("atEdge İLE EN KÖŞEDEYİZ!");
    //     if (_scrollController.position == 0) {
    //       print("SAYFADA EN TEPEDEYİZ!");
    //     } else {
    //       print("SAYFADA EN AŞAĞIDAYIZ!");
    //       getUser();
    //     }
    //   }
    // });

    _scrollController.addListener(_listScrollListener);
  }

  @override
  Widget build(BuildContext context) {
    final _allUsersViewModel = Provider.of<AllUsersViewModel>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text('User'),
        ),
        body: Consumer<AllUsersViewModel>(
          builder: (context, ref, child) {
            if (ref.state == AllUsersViewState.BUSY) {
              return const Center(child: CircularProgressIndicator());
            } else if (ref.state == AllUsersViewState.LOADED) {
              return RefreshIndicator(
                onRefresh: ref.refreshUserList,
                child: ListView.builder(
                  controller: _scrollController,
                  itemBuilder: (context, index) {
                    if (ref.allUserList.length == 1) {
                      return _thereIsNotOtherUser();
                    } else if (ref.continueFlagLoading &&
                        index == ref.allUserList.length) {
                      return progressIndicatorNewElement();
                    } else {
                      return createListTile(index);
                    }
                  },
                  itemCount: _allUsersViewModel.continueFlagLoading
                      ? _allUsersViewModel.allUserList.length + 1
                      : _allUsersViewModel.allUserList.length,
                ),
              );
            } else {
              return Container();
            }
          },
        ));
  }

  Widget createListTile(int index) {
    UserViewModel _userViewModel = Provider.of<UserViewModel>(context);
    AllUsersViewModel _allUsersViewModel =
        Provider.of<AllUsersViewModel>(context);
    var _currentUser = _allUsersViewModel.allUserList[index];

    if (_currentUser!.userId == _userViewModel.user!.userId) {
      return Container();
    }
    return GestureDetector(
      onTap: () {
        Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
            create: (context) => ChatViewModel(
              currentUser: _userViewModel.user!,
              chatUser: _currentUser,
            ),
            child: const Conversation(),
          ),
        ));
      },
      child: Card(
        child: ListTile(
          title: Text(_currentUser.userName!),
          subtitle: Text(_currentUser.email!),
          leading: CircleAvatar(
            backgroundColor: Colors.grey.withAlpha(40),
            backgroundImage: NetworkImage(_currentUser.profilURL!),
          ),
        ),
      ),
    );
  }

  progressIndicatorNewElement() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(child: CircularProgressIndicator()),
    );
  }

  Widget _thereIsNotOtherUser() {
    final _allUsersViewModel = Provider.of<AllUsersViewModel>(context);
    return RefreshIndicator(
      onRefresh: _allUsersViewModel.refreshUserList,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Container(
          child: Center(
            //child: Text('There Is Not Registered Other User'),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.supervised_user_circle,
                  color: Theme.of(context).primaryColor,
                  size: 120,
                ),
                const Text(
                  'There Is Not Registered Other User Yet',
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

  void fetchMoreUser() async {
    if (!_isLoading) {
      _isLoading = true;
      final _allUsersViewModel = Provider.of<AllUsersViewModel>(context);
      await _allUsersViewModel.fetchMoreUser();
      _isLoading = false;
    }
  }

  void _listScrollListener() {
    // maxScrollExtent = LİSTENİN EN AŞAĞI KISMINA GELDİĞİMİZDE OLUŞUR.
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      print("We Are In The Bottom");
      fetchMoreUser();
    }

    // minScrollExtent = LİSTENİN EN YUKARI KISMINA GELDİĞİMİZDE OLUŞUR.
    if (_scrollController.offset >=
            _scrollController.position.minScrollExtent &&
        !_scrollController.position.outOfRange) {
      print("We Are In The Top");
    }
  }
}
