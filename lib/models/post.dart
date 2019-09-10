import 'package:flutter/material.dart';
import 'user.dart';

class Post {
  AssetImage image;
  User user;
  List<User> likes;
  DateTime date;

  Post(this.image, this.user, this.date, this.likes);
}
