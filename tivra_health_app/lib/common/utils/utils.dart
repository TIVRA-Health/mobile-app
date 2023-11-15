import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';

String emailRegex =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
String passwordRegex =
    r'^(?=.*?[A-Za-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';

bool isValidEmail(String email) {
  return email.isNotEmpty && RegExp(emailRegex).hasMatch(email);
}

bool isValidPassword(String password) {
  return password.isNotEmpty && RegExp(passwordRegex).hasMatch(password);
}

bool isValidConfirmPassword(String pwd, String confirmPwd) {
  return confirmPwd.isNotEmpty && confirmPwd == pwd;
}

bool isValidName(String name) {
  return name.isNotEmpty;
}

bool isPasswordEmpty(String password) {
  return password.isNotEmpty;
}

bool isValidOTP(String otp) {
  return otp.isNotEmpty && otp.length == 6;
}

Future<String> getFilePath(String fileName, String extension) async {
  Directory appDocumentsDirectory = await getApplicationDocumentsDirectory();
  String appDocumentsPath = appDocumentsDirectory.path;
  String filePath = '$appDocumentsPath/$fileName.$extension';
  print('File path: $filePath');
  return filePath;
}

void saveFile(List<int> data, String fileName, String extension) async {
  File file = File(await getFilePath(fileName, extension));
  file.writeAsBytes(data);
}

Future<Uint8List> readFile(String fileName, String extension) async {
  File file = File(await getFilePath(fileName,extension));
  Uint8List fileContent = await file.readAsBytes();
  return fileContent;
}

