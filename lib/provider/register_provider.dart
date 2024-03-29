import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../toast/show_toast.dart';

class RegisterProvider extends ChangeNotifier {
  final ImagePicker picker = ImagePicker();
  int _pageIndex = 0;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwdController = TextEditingController();
  final TextEditingController _pwdCheckController = TextEditingController();
  final TextEditingController _nickController = TextEditingController();
  final List<XFile> _imageList = [];
  final FocusNode _emailNode = FocusNode();
  final FocusNode _pwdNode = FocusNode();
  final FocusNode _pwdCheckNode = FocusNode();
  final FocusNode _nickNode = FocusNode();
  final GlobalKey<FormState> _emailFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _pwdFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _pwdCheckFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _nickFormKey = GlobalKey<FormState>();
  bool _isEmailExists = false;
  final bool _isKeyboard = false;

  int get pageIndex => _pageIndex;

  TextEditingController get emailController => _emailController;

  TextEditingController get pwdController => _pwdController;

  TextEditingController get pwdCheckController => _pwdCheckController;

  TextEditingController get nickController => _nickController;

  FocusNode get emailNode => _emailNode;

  FocusNode get pwdNode => _pwdNode;

  List<XFile> get imageList => _imageList;

  FocusNode get pwdCheckNode => _pwdCheckNode;

  FocusNode get nickNode => _nickNode;

  GlobalKey<FormState> get emailFormKey => _emailFormKey;

  GlobalKey<FormState> get pwdFormKey => _pwdFormKey;

  GlobalKey<FormState> get pwdCheckFormKey => _pwdCheckFormKey;

  GlobalKey<FormState> get nickFormKey => _nickFormKey;

  bool get isEmailExists => _isEmailExists;

  bool get isKeyboard => _isKeyboard;

  void addNodeListener() {
    emailNode.addListener(() async {
      if (!emailNode.hasFocus) {
        emailFormKey.currentState!.validate();
      }
    });
    pwdNode.addListener(() {
      if (!pwdNode.hasFocus) {
        pwdFormKey.currentState!.validate();
      }
    });
    pwdCheckNode.addListener(() {
      if (!pwdCheckNode.hasFocus) {
        pwdCheckFormKey.currentState!.validate();
      }
    });
    nickNode.addListener(() async {
      if (!nickNode.hasFocus) {
        nickFormKey.currentState!.validate();
      }
    });
  }

  Future<void> registerEmail(BuildContext context) async {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: emailController.text.trim(),
            password: pwdController.text.trim())
        .then((value) {
          //uid 값을 키값으로 쓰기! value.user!.uid
      FirebaseStorage.instance
          .ref('user_profile_image/${emailController.text.trim()}')
          .putFile(File(_imageList.first.path))
          .then((val) async {
        FirebaseFirestore.instance
            .collection('user')
            .doc(value.user!.uid)
            .set({
          'email': emailController.text.trim(),
          'nickname': nickController.text.trim(),
          'image': await val.ref.getDownloadURL(),
          'uid':value.user!.uid,
        });
      });
      context.pop();
      showToast('회원가입에 성공했습니다');
    }).catchError((e) {
      if (e.code == 'email-already-in-use') {
        _isEmailExists = true;
        emailFormKey.currentState!.validate();
        showToast('이미 등록된 이메일 입니다');
      } else {
        showToast('회원가입에 실패했습니다');
      }
    });
    notifyListeners();
  }

  Future<void> selectProfileImage() async {
    await picker
        .pickImage(source: ImageSource.gallery, maxHeight: 1024, maxWidth: 1024)
        .then((value) {
      _imageList.clear();
      _imageList.add(value!);
    });
    notifyListeners();
  }

  void stepPrevious() async {
    _pageIndex = 0;
    notifyListeners();
  }

  void stepNext(context) async {
    if (pageIndex == 0) {
      if (nickFormKey.currentState!.validate() == false || imageList.isEmpty) {
        showToast('닉네임,프로필 사진을 작성해주세요');
      } else {
        _pageIndex = 1;
      }
    } else {
      registerEmail(context);
    }
    notifyListeners();
  }

  void resetProvider() {
    _pageIndex = 0;
    _emailController.clear();
    _pwdController.clear();
    _pwdCheckController.clear();
    _nickController.clear();
    _imageList.clear();
    notifyListeners();
  }
}
