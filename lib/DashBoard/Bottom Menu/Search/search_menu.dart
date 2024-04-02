import 'package:flutter/material.dart';

class SearchMenu extends StatefulWidget {
  const SearchMenu({Key? key}) : super(key: key);

  @override
  State<SearchMenu> createState() => _SearchState();
}

class _SearchState extends State<SearchMenu> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.white,
      child: const Center(
        child: Text("Search"),
      ),
    );
  }
}
