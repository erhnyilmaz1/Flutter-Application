import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_json_app/model/user_model.dart';

class RemoteApi extends StatefulWidget {
  const RemoteApi({Key? key}) : super(key: key);

  @override
  _RemoteApiState createState() => _RemoteApiState();
}

class _RemoteApiState extends State<RemoteApi> {
  late final Future<List<User>> _futureUserListFill;

  @override
  void initState() {
    super.initState();
    _futureUserListFill = readUserJson();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Remote Api With Duo'),
      ),
      body: FutureBuilder<List<User>>(
        future: _futureUserListFill,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<User> userList = snapshot.data!;

            return ListView.builder(
              itemBuilder: (context, index) {
                User item = userList[index];
                return ListTile(
                  title: Text(item.email),
                  subtitle: Text(item.address.toString()),
                  leading: CircleAvatar(
                    child: Text(item.id.toString()),
                  ),
                );
              },
              itemCount: userList.length,
            );
          } else if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Future<List<User>> readUserJson() async {
    try {
      var response =
          await Dio().get('https://jsonplaceholder.typicode.com/users');

      List<User> allUsers = [];
      if (response.statusCode == 200) {
        allUsers = (response.data as List)
            .map((userMap) => User.fromMap(userMap))
            .toList();
      }
      return allUsers;
    } on DioError catch (e) {
      return Future.error(e.toString());
    }
  }
}
