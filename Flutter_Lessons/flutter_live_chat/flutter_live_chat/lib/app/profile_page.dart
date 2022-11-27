// ignore_for_file: prefer_const_declarations, unrelated_type_equality_checks, await_only_futures, sized_box_for_whitespace, unused_field, unnecessary_null_comparison
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_live_chat/common_widget/platform_sensitive_alert_dialog.dart';
import 'package:flutter_live_chat/common_widget/social_login_button.dart';
import 'package:flutter_live_chat/viewModel/user_view_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late TextEditingController _controllerUserName;
  final ImagePicker _picker = ImagePicker();
  late File _profilePhoto;

  @override
  void initState() {
    super.initState();
    _controllerUserName = TextEditingController();
  }

  @override
  void dispose() {
    _controllerUserName.dispose();
    super.dispose();
  }

  void _takePhotoCamera() async {
    var _newPhoto = await _picker.pickImage(source: ImageSource.camera);
    setState(() {
      _profilePhoto = File(_newPhoto!.path);
      Navigator.of(context).pop();
    });
  }

  void _choosePhotoGallery() async {
    var _newPhoto = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _profilePhoto = File(_newPhoto!.path);
      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    UserViewModel _userViewModel =
        Provider.of<UserViewModel>(context, listen: false);
    _controllerUserName.text = _userViewModel.user!.userName!;
    debugPrint(
        'UserViewModel Value In Profil Page: ${_userViewModel.user.toString()}');

    return Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
          actions: <Widget>[
            ElevatedButton(
                onPressed: () => _signOutWithDialog(context),
                child: const Text(
                  'Logout',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ))
          ],
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Container(
                          height: 160,
                          child: Column(
                            children: [
                              ListTile(
                                leading: const Icon(Icons.camera),
                                title: const Text('Take A Photo From Camera'),
                                onTap: () {
                                  _takePhotoCamera();
                                },
                              ),
                              ListTile(
                                leading: const Icon(Icons.image),
                                title: const Text('Choose A Photo From Camera'),
                                onTap: () {
                                  _choosePhotoGallery();
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: CircleAvatar(
                    radius: 75,
                    backgroundColor: Colors.white,
                    // backgroundImage: _profilePhoto == null
                    //     ? NetworkImage(_userViewModel.user!.profilURL!)
                    //     : FileImage(_profilePhoto),                    
                    backgroundImage:
                        NetworkImage(_userViewModel.user!.profilURL!),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  initialValue: _userViewModel.user!.email,
                  readOnly: true,
                  decoration: const InputDecoration(
                    labelText: 'Your Email',
                    hintText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _controllerUserName,
                  //initialValue: _userViewModel.user!.userName,
                  decoration: const InputDecoration(
                    labelText: 'Your Username',
                    hintText: 'Username',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SocialLoginButton(
                  buttonText: 'SAVE',
                  onPressed: () {
                    _updateUserName(context);
                    _updateFile(context);
                  },
                ),
              )
            ]),
          ),
        ));
  }

  Future<bool?> _signOut(BuildContext context) async {
    final _userViewModel = Provider.of<UserViewModel>(context, listen: false);
    bool? result = await _userViewModel.signOut();
    return result;
  }

  Future _signOutWithDialog(BuildContext context) async {
    final _result = await const PlatformSensitiveAlertDialog(
      title: 'Are You Sure?',
      content: 'Are You Sure You Want To Exit?',
      mainButtonText: 'YES',
      cancelButtonText: 'GIVE UP',
    );

    if (_result == true) {
      _signOut(context);
    }
  }

  void _updateUserName(BuildContext context) async {
    final _userViewModel = Provider.of<UserViewModel>(context);

    if (_userViewModel.user!.userName! != _controllerUserName.text) {
      var _updateResult = await _userViewModel.updateUserName(
          _userViewModel.user!.userId, _controllerUserName.text);

      if (_updateResult) {
        const PlatformSensitiveAlertDialog(
                title: 'Success',
                content: 'Changed Username',
                mainButtonText: 'OK')
            .show(context);
      } else {
        _controllerUserName.text = _userViewModel.user!.userName!;
        const PlatformSensitiveAlertDialog(
                title: 'Success',
                content:
                    'Username Is Already In Use. Please You Try A Different User',
                mainButtonText: 'OK')
            .show(context);
      }
    }
  }

  void _updateFile(BuildContext context) async {
    final _userViewModel = Provider.of<UserViewModel>(context);

    if (_profilePhoto != null) {
      var _url = await _userViewModel.updateFile(
          _userViewModel.user!.userId, "profile_photo", _profilePhoto);

      debugPrint('URL Value : $_url');

      if (_url != null) {
        const PlatformSensitiveAlertDialog(
                title: 'Success',
                content: 'Update Your Profile Picture',
                mainButtonText: 'OK')
            .show(context);
      }
    }
  }
}
