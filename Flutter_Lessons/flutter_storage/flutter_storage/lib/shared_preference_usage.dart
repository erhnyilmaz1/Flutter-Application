import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_storage/main.dart';
import 'package:flutter_storage/services/local_storage_service.dart';
//import 'package:flutter_storage/services/shared_pref_service.dart';
//import 'package:flutter_storage/services/path_provider_service.dart';
//import 'package:flutter_storage/services/secure_storage_service.dart';

import 'model/my_models.dart';

/*
  1.) describeEnum(EnumParameter) : EnumParameter Değerini String'e Çevirir.
 */

class SharedPreferenceUsage extends StatefulWidget {
  const SharedPreferenceUsage({Key? key}) : super(key: key);

  @override
  State<SharedPreferenceUsage> createState() => _SharedPreferenceUsageState();
}

class _SharedPreferenceUsageState extends State<SharedPreferenceUsage> {
  var _selectedGender = Gender.FEMALE;
  var _selectedColor = <String>[];
  var _selectedStudent = false;
  final TextEditingController _nameController = TextEditingController();
  final LocalStorageService _service = locator<LocalStorageService>();
  //final LocalStorageService _service = SharedPreferencesService();
  // final LocalStorageService _service2 = SecureStorageService();
  // final LocalStorageService _service3 = PathProviderService();

  @override
  void initState() {
    super.initState();
    _readData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shared Preference Kullanımı'),
      ),
      body: ListView(
        children: [
          ListTile(
              title: TextField(
            controller: _nameController,
            decoration: const InputDecoration(labelText: 'Adınızı Giriniz'),
          )),
          for (var itemGender in Gender.values)
            _buildRadioListTiles(itemGender),
          for (var itemColor in Color.values)
            _buildCheckboxListTiles(itemColor),
          SwitchListTile(
            title: const Text('Öğrenci Misin ? '),
            value: _selectedStudent,
            onChanged: (bool? value) {
              setState(() {
                _selectedStudent = value!;
              });
            },
          ),
          TextButton(
            onPressed: () {
              var _userInformation = UserInformation(_nameController.text,
                  _selectedGender, _selectedColor, _selectedStudent);
              _service.saveData(_userInformation);
            },
            child: const Text('Kaydet'),
          ),
        ],
      ),
    );
  }

  Widget _buildRadioListTiles(Gender gender) {
    return RadioListTile(
      title: Text(describeEnum(gender)),
      value: gender,
      groupValue: _selectedGender,
      onChanged: (Gender? value) {
        setState(() {
          _selectedGender = value!;
        });
      },
    );
  }

  Widget _buildCheckboxListTiles(Color color) {
    return CheckboxListTile(
      title: Text(describeEnum(color)),
      value: _selectedColor.contains(describeEnum(color)),
      onChanged: (bool? value) {
        if (value == true) {
          _selectedColor.add(describeEnum(color));
        } else {
          _selectedColor.remove(describeEnum(color));
        }
        setState(() {});
      },
    );
  }

  void _readData() async {
    var data = await _service.readData();
    _nameController.text = data.name;
    _selectedGender = data.gender;
    _selectedColor = data.color;
    _selectedStudent = data.isStudent;

    setState(() {});
  }
}
