//@dart=2.9
import 'dart:convert';
import 'package:grouped_list/grouped_list.dart';
import 'package:flutter/material.dart';

class JsonData extends StatefulWidget {
  // const JsonData({ Key? key }) : super(key: key);

  @override
  _JsonDataState createState() => _JsonDataState();
}

class _JsonDataState extends State<JsonData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Json Data"),
      ),
      body: Center(
        child: FutureBuilder(
            future:
                DefaultAssetBundle.of(context).loadString('assets/sample.json'),
            builder: (context, snapshot) {
              var new_data = json.decode(snapshot.data.toString());
              return GroupedListView<dynamic , String>(
                elements: new_data,
                groupBy: (element) => element['category'],
                groupComparator: (value1, value2) => value2.compareTo(value1),
                itemComparator: (item1, item2) =>
                    item1['productName'].compareTo(item2['productName']),
                order: GroupedListOrder.DESC,
                useStickyGroupSeparators: true,
                groupSeparatorBuilder: (var value) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    value,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                itemBuilder: (c, element) {
                  return Card(
                    elevation: 8.0,
                    margin:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                    child: Container(
                      child: ListTile(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10.0),
                        leading: Icon(Icons.food_bank),
                        title: Text(element['productName']),
                      ),
                    ),
                  );
                },
              );
            }),
      ),
    );
  }
}
