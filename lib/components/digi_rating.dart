import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class DigiRating extends StatelessWidget {
  final ValueChanged<double> valueChanged;
  final int rating;
  const DigiRating({Key key, this.valueChanged, @required this.rating}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child:RatingBar(
                    minRating: 0.0,
                    // tapOnlyMode: true,
                    initialRating: 0,
                    itemCount: 3,
                    itemSize: 28,
                    allowHalfRating: false,
                    itemPadding: EdgeInsets.all(4),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber[700],
                    ),
                    onRatingUpdate: valueChanged,
                  ),
    );
  }
}
