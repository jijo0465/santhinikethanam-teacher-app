import 'package:flutter/material.dart';

class DigiTeach extends StatefulWidget {
  const DigiTeach({
    Key key,
  }) : super(key: key);

  @override
  _DigiTeachState createState() => _DigiTeachState();
}

class _DigiTeachState extends State<DigiTeach> {
  int grade = 0;
  int subject = 0;
  int topic = 0;
  List<bool> subjectCheck = [false, false, false];
  List<bool> classCheck = [false, false, false, false, false];
  List<bool> videoCheck = [false, false, false];

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).primaryColor;
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              color.withOpacity(0.7),
              color.withOpacity(0.6),
              color.withOpacity(0.7)
            ],
          ),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12), topRight: Radius.circular(12)),
          boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 4)]),
      width: MediaQuery.of(context).size.width,
      // height: 160,
      padding: EdgeInsets.only(top: 8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
                child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SizedBox(width: 8),
                Icon(
                  Icons.filter_list,
                  color: Colors.white,
                ),
                SizedBox(width: 4),
                Text(
                  'Filter',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 16),
                )
              ],
            )),
            SizedBox(height: 8),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 40,
              padding: EdgeInsets.only(right: 8.0),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Colors.white.withOpacity(0.9),
                      Colors.white.withOpacity(0.7),
                      Colors.white.withOpacity(0.9)
                    ],
                  ),
                  borderRadius: BorderRadius.circular(12)),
              child: IntrinsicHeight(
                child: Row(
                  children: <Widget>[
                    Container(
                      // height: double.infinity,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(color: Colors.grey, blurRadius: 4)
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12),
                              bottomLeft: Radius.circular(12))),
                      child: Text('Subjects',
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold)),
                      alignment: Alignment.center,
                      // padding: EdgeInsets.only(left: 8),
                      width: 100,
                    ),
                    VerticalDivider(
                      width: 10,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceAround,
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text('Maths'),
                            Checkbox(
                                activeColor: Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.8),
                                value: subjectCheck[0],
                                onChanged: (value) {
                                  setState(() {
                                    subjectCheck[0] = value;
                                  });
                                }),
                            SizedBox(width: 12),
                            // Text('English'),
                            // Checkbox(value: false, onChanged: (value) {}),
                            // SizedBox(width: 12),
                            Text('Science'),
                            Checkbox(
                                activeColor: Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.8),
                                value: subjectCheck[1],
                                onChanged: (value) {
                                  setState(() {
                                    subjectCheck[1] = value;
                                  });
                                }),
                            SizedBox(width: 12),
                            Text('Social'),
                            Checkbox(
                                activeColor: Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.8),
                                value: subjectCheck[2],
                                onChanged: (value) {
                                  setState(() {
                                    subjectCheck[2] = value;
                                  });
                                }),
                            SizedBox(width: 12),
                            // Text('Malayalam'),
                            // Checkbox(value: false, onChanged: (value) {})
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 12),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 40,
              padding: EdgeInsets.only(right: 8.0),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Colors.white.withOpacity(0.9),
                      Colors.white.withOpacity(0.7),
                      Colors.white.withOpacity(0.9)
                    ],
                  ),
                  borderRadius: BorderRadius.circular(12)),
              child: IntrinsicHeight(
                child: Row(
                  children: <Widget>[
                    Container(
                      // height: double.infinity,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(color: Colors.grey, blurRadius: 4)
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12),
                              bottomLeft: Radius.circular(12))),
                      child: Text('Class',
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold)),
                      alignment: Alignment.center,
                      // padding: EdgeInsets.only(left: 8),
                      width: 100,
                    ),
                    VerticalDivider(
                      width: 10,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceAround,
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text('I'),
                            Checkbox(
                                activeColor: Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.8),
                                value: classCheck[0],
                                onChanged: (value) {
                                  setState(() {
                                    classCheck[0] = value;
                                  });
                                }),
                            SizedBox(width: 12),
                            Text('II'),
                            Checkbox(
                                activeColor: Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.8),
                                value: classCheck[1],
                                onChanged: (value) {
                                  setState(() {
                                    classCheck[1] = value;
                                  });
                                }),
                            SizedBox(width: 12),
                            Text('III'),
                            Checkbox(
                                activeColor: Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.8),
                                value: classCheck[2],
                                onChanged: (value) {
                                  setState(() {
                                    classCheck[2] = value;
                                  });
                                }),
                            SizedBox(width: 12),
                            Text('IV'),
                            Checkbox(
                                activeColor: Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.8),
                                value: classCheck[3],
                                onChanged: (value) {
                                  setState(() {
                                    classCheck[3] = value;
                                  });
                                }),
                            SizedBox(width: 12),
                            Text('V'),
                            Checkbox(
                                // checkColor: Theme.of(context).primaryColor,
                                activeColor: Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.8),
                                value: classCheck[4],
                                onChanged: (value) {
                                  setState(() {
                                    classCheck[4] = value;
                                  });
                                }),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Padding(
            //     padding: const EdgeInsets.only(top: 10),
            //     child: Container(
            //       width: double.infinity,
            //       height: 25,
            //       decoration: BoxDecoration(
            //           gradient: LinearGradient(
            //             begin: Alignment.topRight,
            //             end: Alignment.bottomLeft,
            //             colors: [
            //               color.withOpacity(0.7),
            //               color.withOpacity(0.6),
            //               color.withOpacity(0.7)
            //             ],
            //           ),
            //           borderRadius: BorderRadius.circular(12)),
            // child: Padding(
            //   child: DropdownButtonHideUnderline(
            //     child: DropdownButton(
            //         value: grade,
            //         items: [
            //           DropdownMenuItem(child: Text('Class'), value: 0),
            //           DropdownMenuItem(child: Text('Class I'), value: 1),
            //           DropdownMenuItem(child: Text('Class II'), value: 2),
            //           DropdownMenuItem(child: Text('Class III'), value: 3),
            //           DropdownMenuItem(child: Text('Class IV'), value: 4),
            //           DropdownMenuItem(child: Text('Class V'), value: 5),
            //         ],
            //         onChanged: (value) {
            //           setState(() {
            //             grade = value;
            //           });
            //           print(value);
            //         }),
            //   ),
            //   padding: EdgeInsets.only(left: 4),
            // ),
            // )),
            // Container(
            //   width: MediaQuery.of(context).size.width,
            //   height: 40,
            //   decoration: BoxDecoration(
            //       gradient: LinearGradient(
            //         begin: Alignment.topRight,
            //         end: Alignment.bottomLeft,
            //         colors: [
            //           Colors.white.withOpacity(0.9),
            //           Colors.white.withOpacity(0.7),
            //           Colors.white.withOpacity(0.9)
            //         ],
            //       ),
            //       borderRadius: BorderRadius.circular(12)),
            //   child: Row(
            //     children: <Widget>[
            //       Container(
            //         child: Text('Class : '),
            //         alignment: Alignment.centerLeft,
            //         padding: EdgeInsets.only(left: 8),
            //         width: 100,
            //       ),
            //       Expanded(
            //         child: SingleChildScrollView(
            //           scrollDirection: Axis.horizontal,
            //           child: Row(
            //             children: <Widget>[
            //               Text('I'),
            //               Checkbox(
            //                   value: false,
            //                   onChanged: (value) {
            //                     print(1);
            //                   }),
            //               SizedBox(width: 12),
            //               Text('II'),
            //               Checkbox(value: false, onChanged: (value) {}),
            //               SizedBox(width: 12),
            //               Text('III'),
            //               Checkbox(value: false, onChanged: (value) {}),
            //               SizedBox(width: 12),
            //               Text('IV'),
            //               Checkbox(value: false, onChanged: (value) {}),
            //               SizedBox(width: 12),
            //               Text('V'),
            //               Checkbox(value: false, onChanged: (value) {})
            //             ],
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            SizedBox(height: 12),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 40,
              // padding: EdgeInsets.only(right: 8.0),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Colors.white.withOpacity(0.9),
                      Colors.white.withOpacity(0.7),
                      Colors.white.withOpacity(0.9)
                    ],
                  ),
                  borderRadius: BorderRadius.circular(12)),
              child: IntrinsicHeight(
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(child: Container()),
                    Text('All'),
                    Checkbox(
                        activeColor:
                            Theme.of(context).primaryColor.withOpacity(0.8),
                        value: videoCheck[0],
                        onChanged: (value) {
                          setState(() {
                            videoCheck[0] = value;
                          });
                        }),
                    SizedBox(width: 12),
                    // Text('English'),
                    // Checkbox(value: false, onChanged: (value) {}),
                    // SizedBox(width: 12),
                    Text('New'),
                    Checkbox(
                        activeColor:
                            Theme.of(context).primaryColor.withOpacity(0.8),
                        value: videoCheck[1],
                        onChanged: (value) {
                          setState(() {
                            videoCheck[1] = value;
                          });
                        }),
                    SizedBox(width: 12),
                    Text('Shared'),
                    Checkbox(
                        activeColor:
                            Theme.of(context).primaryColor.withOpacity(0.8),
                        value: videoCheck[2],
                        onChanged: (value) {
                          setState(() {
                            videoCheck[2] = value;
                          });
                        }),
                    // Text('Malayalam'),
                    // Checkbox(value: false, onChanged: (value) {})
                    Expanded(child: Container()),
                  ],
                ),
              ),
            ),
            // GestureDetector(
            //   child: Container(
            //       width: 150,
            //       height: 40,
            //       decoration: BoxDecoration(
            //           gradient: LinearGradient(
            //             begin: Alignment.topRight,
            //             end: Alignment.bottomLeft,
            //             colors: [
            //               Colors.white.withOpacity(0.9),
            //               Colors.white.withOpacity(0.7),
            //               Colors.white.withOpacity(0.9)
            //             ],
            //           ),
            //           borderRadius: BorderRadius.circular(12)),
            //       child: Center(child: Text('shared videos'))),
            // )
          ],
        ),
      ),
    );
  }
}
