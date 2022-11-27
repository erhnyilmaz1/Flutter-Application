// ignore_for_file: file_names

import 'package:flutter/material.dart';

class DrawerUsage extends StatelessWidget {
  const DrawerUsage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: const Text('Erhan Yılmaz'),
            accountEmail: const Text('erhnyilmaz1@gmail.com'),
            currentAccountPicture: Image.network(
                'https://emrealtunbilek.com/wp-content/uploads/2016/10/apple-icon-72*72.png'),
            otherAccountsPictures: const [
              CircleAvatar(
                child: Text('SY'),
                backgroundColor: Colors.purple,
              ),
              CircleAvatar(
                child: Text('AY'),
                backgroundColor: Colors.grey,
              ),
            ],
          ),
          Expanded(
              child: ListView(
            children: [
              const ListTile(
                title: Text('Ana Sayfa'),
                leading: Icon(Icons.home),
                trailing: Icon(Icons.chevron_right),
              ),
              const ListTile(
                title: Text('Ara'),
                leading: Icon(Icons.call),
                trailing: Icon(Icons.chevron_right),
              ),
              const ListTile(
                title: Text('Hesap'),
                leading: Icon(Icons.account_box),
                trailing: Icon(Icons.chevron_right),
              ),
              const Divider(),
              InkWell(
                onTap: () {},
                splashColor: Colors.cyan,
                child: const ListTile(
                  title: Text('İletişim'),
                  leading: Icon(Icons.contact_page),
                  trailing: Icon(Icons.chevron_right),
                ),
              ),
              const AboutListTile(
                applicationName: 'Flutter Lessons',
                applicationIcon: Icon(Icons.save),
                applicationVersion: '2.0',
                child: Text('ABOUT US'),
                applicationLegalese: 'Flutter Lesssons Entry Page',
                icon: Icon(Icons.keyboard),
                aboutBoxChildren: [
                  Text('Child 1'),
                  Text('Child 2'),
                  Text('Child 3'),
                ],
              ),
            ],
          ))
        ],
      ),
    );
  }
}
