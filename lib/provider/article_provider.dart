import 'package:calendar_every/model/comment_model.dart';
import 'package:calendar_every/user_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class ArticleProvider extends ChangeNotifier {
  final PageController _pageController = PageController();
  final bool _isLiked = false;
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();


  PageController get pageController => _pageController;
  bool get isLiked => _isLiked;
  TextEditingController get controller => _controller;
  ScrollController get scrollController => _scrollController;


  Future<void> tabLikeBtn(bool onTap, String articleId,int likeCount) async {
    if (onTap == false) {
      FirebaseFirestore.instance.collection('article').doc(articleId).update({
        'like':{
          'count': likeCount+1,
          'people': FieldValue.arrayUnion([UserService.instance.userModel.uid]),
        }

      });
    }else{
      FirebaseFirestore.instance.collection('article').doc(articleId).update({
        'like':{
          'count': likeCount-1,
          'people': FieldValue.arrayRemove([UserService.instance.userModel.uid]),
        }
      });
    }
  }

}
