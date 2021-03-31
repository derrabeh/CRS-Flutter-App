import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Document extends ChangeNotifier{

  final String documentID;
  final String documentType;
  final String expireDate;
  final String image;
  final String volunteerID;

  Document({
    this.documentID,
    @required this.documentType,
    @required this.expireDate,
    @required this.image,
    this.volunteerID
  });
}