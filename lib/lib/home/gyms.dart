
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:spotlight_login/gymViews/gymCardView.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:spotlight_login/gymViews/gym1View.dart';
import 'package:spotlight_login/gymViews/gym2View.dart';
import 'package:spotlight_login/gymViews/gym3View.dart';
import 'package:spotlight_login/gymViews/gym4View.dart';

class Gyms extends StatefulWidget {
  @override
  _GymsState createState() => _GymsState();
}
class _GymsState extends State<Gyms> {

  //set of markers to mark the gyms
  Set<Marker> _markers = Set<Marker>();
  BitmapDescriptor _markerIcon;
  GoogleMapController _mapController;

  void initState() {
    //getCurrentUser();
    //_setMarkerIcon();
  }

  //used to set the icon for the map icons - getting from an asset image
  //void _setMarkerIcon() async {
    //_markerIcon = await BitmapDescriptor.fromAssetImage(ImageConfiguration(), "assets/images/.jpg");
  //}

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;

    setState(() {
      _markers.add(Marker(
          markerId: MarkerId("1"),
          position: LatLng(43.847000, -79.551850),
          infoWindow: InfoWindow(title: "Good Life Fitness #1",
              onTap: () {Navigator.pushNamed(context, GymCardOneView.id);},
          snippet: "3420 Major MacKenzie Dr W #201 Vaughan, ON L4H 4J6"),
          )); //icon: _markerIcon-- add this to add an image for marker icons

      _markers.add(Marker(
          markerId: MarkerId("2"),
          position: LatLng(43.790910, -79.544790),
          infoWindow: InfoWindow(title: "Good Life Fitness #2",
              onTap: () {Navigator.pushNamed(context, GymCardTwoView.id);},
              snippet: "57 Northview Blvd Woodbridge, ON L4L 8X9")));

      _markers.add(Marker(
          markerId: MarkerId("3"),
          position: LatLng(43.790050, -79.529910),
          infoWindow: InfoWindow(title: "Good Life Fitness #3",
              onTap: () {Navigator.pushNamed(context, GymCardThreeView.id);},
              snippet: "90 Interchange Way Concord, ON L4K 5Z8")));

      _markers.add(Marker(
          markerId: MarkerId("4"),
          position: LatLng(43.798580, -79.501129),
          infoWindow: InfoWindow(title: "Good Life Fitness #4",
              onTap: () {Navigator.pushNamed(context, GymCardFourView.id);},
              snippet: "7700 Keele St Concord, ON L4K 2A1")));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[ GoogleMap(
          onMapCreated: _onMapCreated,
          markers: _markers,
          //myLocationEnabled: true,
          initialCameraPosition: CameraPosition(
              target: LatLng(43.7983, -79.5079),//this is the lat/lng for concord, CANADA
              zoom: 10
          ),
        ),
          Container(
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.only(bottom: 30),
            child: FloatingActionButton(
              onPressed: () {
                //navigate to the list view of gyms
                Navigator.pushNamed(context, GymCardView.id);
              },
              child: Icon(Icons.format_list_numbered_rounded),
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            )
          )
      ]),
    );
  }
}


/*class _GymsState extends State<Gyms> {
  final _auth = FirebaseAuth.instance;
  var firebaseUser = FirebaseAuth.instance.currentUser;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User loggedInUser;


  void initState() {
    getCurrentUser();
  }

  */
/*void gymStream() async {
    await for(var snapshot in _firestore.collection("Gyms").snapshots()) {
      for(var info in snapshot.docs) {
        print(info.data());
      }
    }
  }*/
/*

  void getCurrentUser() async {
    try {
      final user = _auth.currentUser;

      if (user != null) {
        loggedInUser = user;
        //print(loggedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Text(
        "Spotlight Gyms",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white
        ),
      ),
      Expanded(
        child: Center(
          child: StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection("Gyms").snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                      child: CircularProgressIndicator(
                    backgroundColor: Colors.white,
                  ));
                }
                final gyms = snapshot.data.docs;
                List<GymDisplay> gymWidgets = [];

                for (var gym in gyms) {
                  final gymTitle = gym.data()["Title"];
                  final gymAddress = gym.data()["Address"];
                  final gymCity = gym.data()["City"];
                  final gymUsers = gym.data()["NumUsers"];

                  final gymWidget = GymDisplay(
                      title: gymTitle, address: gymAddress, city: gymCity,
                  numUsers: gymUsers);

                  gymWidgets.add(gymWidget);
                }
                //return the styling that we want here (Cards)
                return Expanded(
                  child: ListView(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    children: gymWidgets,
                  ),
                );
              }),
        ),
      ),
    ]);
  }
}*/

/*class GymDisplay extends StatelessWidget {
  GymDisplay({this.title, this.address, this.city, this.numUsers}); //, this.numUsers

  final String title;
  final String address;
  final String city;
  final int numUsers;

  //final int numUsers;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        elevation: 10,
        color: Colors.red,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "$title",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8.0, left: 8.0),
              child: Row(
                children: [
                  Text(
                    "$address",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 8.0, bottom: 8.0),
              child: Row(
                children: [
                  Text(
                    "$city",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Spacer(),
                  Icon(Icons.how_to_reg),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Text(": $numUsers",
                    style: kLoginTextStyle),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}*/

/*class GymDisplay extends StatelessWidget {

  GymDisplay({this.title, this.address});//, this.numUsers

  final String title;
  final String address;
  //final int numUsers;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Material(
        borderRadius: BorderRadius.circular(30),
        elevation: 10,
        color: Colors.red,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Text(
            "$title \nAddress: $address",// \nSpotlight Users: $numUsers
            style: kLoginTextStyle,
          ),
        ),
      ),
    );
  }
}*/

/*return new ListView(
padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
scrollDirection: Axis.vertical,
shrinkWrap: true,
children: gymWidgets,
);*/

/*Widget build(BuildContext context) {
  return Container(
    child: Card(
      elevation: 10,
      color: Colors.red,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "$title",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: Row(
              children: [
                Text(
                  "$address",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 8.0, bottom: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    "$city",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

    ),
  );

}
}*/


