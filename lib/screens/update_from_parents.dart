import 'package:flutter/material.dart';
import 'package:teacher_app/components/digicampus_appbar.dart';

class UpdateFromParents extends StatelessWidget {
  const UpdateFromParents({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              SizedBox(height: 120),
              Container(
                child: Container(
                  child: Text(
                    'Remarks from Parents',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).primaryColor),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 14, right: 14),
                child: Container(
                  height: 130,
                  width: MediaQuery.of(context).size.width,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    elevation: 2,
                    color: Colors.white,
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: Text('Remarks:'),
                        ),
                        SizedBox(height: 60),
                        Padding(
                          padding: const EdgeInsets.only(left: 14, right: 14),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              children: <Widget>[
                                Divider(
                                  color: Colors.grey[500],
                                  thickness: 1.5,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                        child: Text(
                                      '10/06/2020',
                                      style: TextStyle(
                                          fontSize: 12, color: Theme.of(context).primaryColor),
                                    )),
                                    Container(
                                        child: Text(
                                      'V A',
                                      style: TextStyle(
                                          fontSize: 12, color: Theme.of(context).primaryColor),
                                    )),
                                    Container(
                                        child: Text(
                                      'Parent of Sansa',
                                      style: TextStyle(
                                          fontSize: 12, color: Theme.of(context).primaryColor),
                                    )),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.only(left: 14, right: 14),
                child: Container(
                  height: 130,
                  width: MediaQuery.of(context).size.width,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    elevation: 2,
                    color: Colors.white,
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: Text('Remarks:'),
                        ),
                        SizedBox(height: 60),
                        Padding(
                          padding: const EdgeInsets.only(left: 14, right: 14),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              children: <Widget>[
                                Divider(
                                  color: Colors.grey[500],
                                  thickness: 1.5,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                        child: Text(
                                      '11/06/2020',
                                      style: TextStyle(
                                          fontSize: 12, color: Theme.of(context).primaryColor),
                                    )),
                                    Container(
                                        child: Text(
                                      'IX C',
                                      style: TextStyle(
                                          fontSize: 12, color: Theme.of(context).primaryColor),
                                    )),
                                    Container(
                                        child: Text(
                                      'Parent of Ramsey',
                                      style: TextStyle(
                                          fontSize: 12, color: Theme.of(context).primaryColor),
                                    )),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 14, right: 14),
                child: Container(
                  height: 130,
                  width: MediaQuery.of(context).size.width,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    elevation: 2,
                    color: Colors.white,
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: Text('Remarks:'),
                        ),
                        SizedBox(height: 60),
                        Padding(
                          padding: const EdgeInsets.only(left: 14, right: 14),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              children: <Widget>[
                                Divider(
                                  color: Colors.grey[500],
                                  thickness: 1.5,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                        child: Text(
                                      '11/06/2020',
                                      style: TextStyle(
                                          fontSize: 12, color: Theme.of(context).primaryColor),
                                    )),
                                    Container(
                                        child: Text(
                                      'VII A',
                                      style: TextStyle(
                                          fontSize: 12, color: Theme.of(context).primaryColor),
                                    )),
                                    Container(
                                        child: Text(
                                      'Parent of Theon',
                                      style: TextStyle(
                                          fontSize: 12, color: Theme.of(context).primaryColor),
                                    )),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          DigiCampusAppbar(
            icon: Icons.close,
            onDrawerTapped: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
