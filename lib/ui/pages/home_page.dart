import 'package:flutter/material.dart';

import '../../app_theme.dart';
import '../../models/flight_model.dart';
import '../widgets/spaces.dart';

const List<FlightModel> flights = [
  FlightModel(
    arrivalLocaiton: 'Virgina',
    carrier: 'United Airlines',
    name: 'Flight 2346',
    roundTrip: false,
    startLocation: 'Florida',
    timeOfArrival: '2:48pm',
    timeOfFlight: '4:50pm',
  ),
];

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemBuilder: (context, index) {
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
                    borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.6),
                        offset: const Offset(4, 4),
                        blurRadius: 16,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                    child: Column(
                      children: <Widget>[
                        AspectRatio(
                          aspectRatio: 2,
                          child: Image.network(
                            "https://i1.wp.com/movingtips.wpengine.com/wp-content/uploads/2020/02/virginia-sign.jpg?fit=1024%2C684&ssl=1",
                            fit: BoxFit.cover,
                          ),
                        ),
                        Container(
                          color: AppTheme.buildLightTheme().backgroundColor,
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
                                  Text(
                                    'Florida to Virginia',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                    ),
                                  ),
                                  SpaceH12(),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );

            // TODO make seperate widget
            // return Container(
            //   width: double.infinity,
            //   height: MediaQuery.of(context).size.height * .16,
            //   child: Card(
            //     shadowColor: Colors.grey,
            //     elevation: 6,
            //     child: Padding(
            //       padding: const EdgeInsets.all(10.0),
            //       child: Row(
            //         children: <Widget>[
            //           FlutterLogo(),
            //           Spacer(flex: 1,),
            //           Text(flights.elementAt(index).arrivalLocaiton),
            //         ],
            //       ),
            //     ),
            //   ),
            // );
          },
          itemCount: flights.length,
        ),
      ),
    );
  }
}
