// ignore_for_file: prefer_const_constructors, unrelated_type_equality_checks

import 'package:flutter/material.dart';

Widget listMusicTile(
    {required String title,
    required String artist,
    required String cover,
    required Icon iconPlay,
    required Icon iconResume,
    bool isActive = false,
    onTap}) {
  return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(8),
        child: Row(children: [
          Container(
            height: 80.0,
            width: 80.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                image: DecorationImage(image: NetworkImage(cover))),
          ),
          SizedBox(width: 10.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style:
                      TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600)),
              SizedBox(
                height: 5.0,
              ),
              Text(
                artist,
                style: TextStyle(color: Colors.black54, fontSize: 16.0),
              )
            ],
          ),
          Spacer(),
          isActive ? iconPlay : iconResume
        ]),
      ));
}
