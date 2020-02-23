import 'package:flutter/material.dart';

class AppBarContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(

      children:<Widget> [
        IconButton(
          icon: Icon(Icons.account_circle),
          onPressed: () {

          },
        ),
        Flexible(
            child: TextField(
              decoration:InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueAccent),
                      borderRadius: BorderRadius.circular(0.0)
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 32.0),
                    borderRadius: BorderRadius.circular(0.0)
                  ),
                  hintText: 'Search'
              ),
            )
        ),
        IconButton(
          icon: Icon(Icons.filter_list),
          onPressed: () {

          },
        ),
      ],
    );



  }
}