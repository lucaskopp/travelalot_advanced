import 'package:flutter/material.dart';

import 'spaces.dart';

class FlightWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 24,
        right: 24,
        top: 8,
        bottom: 16,
      ),
      child: InkWell(
        splashColor: Colors.transparent,
        onTap: () {},
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(16.0),
            ),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.grey.withOpacity(0.6),
                offset: const Offset(4, 4),
                blurRadius: 16,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(
              Radius.circular(16.0),
            ),
            child: Column(
              children: <Widget>[
                buildImage(),
                buildDescription(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildDescription(BuildContext context) {
    return Container(
      color: Theme.of(context).backgroundColor,
      child: Expanded(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 16,
            top: 8,
            bottom: 8,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              buildTitle(),
              SpaceH12(),
              buildFlightDetails(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildFlightDetails(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'United Airlines',
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.withOpacity(0.8),
          ),
        ),
        SpaceW12(),
        Icon(
          Icons.airplanemode_active,
          color: Theme.of(context).primaryColor,
          size: 20,
        ),
        SpaceW12(),
        Text(
          'Flight 276',
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.withOpacity(0.8),
          ),
        ),
      ],
    );
  }

  Widget buildTitle() {
    return Text(
      'Florida to Virginia',
      textAlign: TextAlign.left,
      style: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 18,
      ),
    );
  }

  Widget buildImage() {
    return AspectRatio(
      aspectRatio: 2,
      child: Image.network(
        "https://i1.wp.com/movingtips.wpengine.com/wp-content/uploads/2020/02/virginia-sign.jpg?fit=1024%2C684&ssl=1",
        fit: BoxFit.cover,
      ),
    );
  }
}
