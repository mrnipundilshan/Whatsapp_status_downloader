import 'package:flutter/material.dart';

TabBar textbar() {
  return const TabBar(
    indicatorColor: Colors.green,
    indicatorSize: TabBarIndicatorSize.label,
    tabs: <Widget>[
      Tab(
        //icon: Icon(Icons.cloud_outlined),
        child: Text(
          'Videos',
          style: TextStyle(
            fontSize: 20.0,
          ),
        ),
      ),
      Tab(
        //icon: Icon(Icons.beach_access_sharp),
        child: Text(
          'Photos',
          style: TextStyle(
            fontSize: 20.0,
          ),
        ),
      ),
      Tab(
        //icon: Icon(Icons.brightness_5_sharp),
        child: Text(
          'Saved',
          style: TextStyle(
            fontSize: 20.0,
          ),
        ),
      ),
    ],
  );
}
