import 'package:flutter/material.dart';

import 'digi_rating.dart';

class RewardTable extends StatefulWidget {
  const RewardTable({Key key}) : super(key: key);

  @override
  _RewardTableState createState() => _RewardTableState();
}

class _RewardTableState extends State<RewardTable> {
  List<FocusNode> focusNodeList = List();
  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: ListView(
        children: <Widget>[
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Card(color: Colors.deepOrange[200],
            shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                              child: DataTable(
                  columnSpacing: 40,
                  dataRowHeight: 100,
                  columns: [
                    DataColumn(
                        label: Text(
                      'Roll No',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.black),
                    )),
                    DataColumn(
                        label: Text(
                      'Name',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.black),
                    )),
                    DataColumn(
                        label: Text(
                      'Rewards',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.black),
                    )),
                    DataColumn(
                        label: Text(
                      'Comments',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.black),
                    ))
                  ],
                  rows: List<DataRow>.generate(6, (index) {
                    FocusNode focusNode = FocusNode();
                    focusNodeList.add(focusNode);
                    return DataRow(cells: [
                      DataCell(Text(
                        (index + 1).toString(),
                        style: TextStyle(
                          color: Colors.black,
                        fontWeight: FontWeight.w600),
                      )),
                      DataCell(Text(
                        'Jijo',
                        style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600),
                      )),
                      DataCell(Container(
                        child: DigiRating(
                          valueChanged: (value) {
                            print(value);
                            print(index + 1);
                            focusNodeList.elementAt(index).requestFocus();
                          },
                          rating: 0,
                        ),
                      )),
                      DataCell(
                        Column(
                          children: <Widget>[
                            SizedBox(height: 20),
                            Container(
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
                              width: 200,
                              child: TextFormField(
                                focusNode: focusNodeList.elementAt(index),
                                decoration: InputDecoration(
                                  hintText: 'comments',
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(12.0),
                                      borderSide: const BorderSide(
                                          color: Colors.black)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ]);
                  })),
            ),
          ),
        ],
      ),
    );
  }
}
