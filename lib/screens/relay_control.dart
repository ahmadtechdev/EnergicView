import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../colors.dart';
import 'graphs/doughnut_graph.dart';
import 'home_screen.dart';
import 'navbar.dart';
import 'store_screen.dart';
import 'educational_content.dart'; // Import for Realtime Database

class RelayControl extends StatefulWidget {
  const RelayControl({super.key});

  @override
  State<RelayControl> createState() => _RelayControlState();
}

class _RelayControlState extends State<RelayControl> {

  String _selectedRelay="relay";

  final _database = FirebaseDatabase.instance.ref(); // Firebase reference
  bool _isRelayOn = false; // State variable for relay
  bool _isRelay1On = false; // State variable for relay 2
  void initState() {
    super.initState();
    _fetchRelayState(); // Fetch initial relay state from database
  }

  void _fetchRelayState() async {
    DataSnapshot snapshot =  (await _database.child('relay/state').once()).snapshot;
    if (snapshot.exists) {
      setState(() {
        if(snapshot.value==0){
          _isRelayOn = false;
        }else{
          _isRelayOn = true;
        }
       // Update state with database value
      });
    } else {
      // Handle potential database errors or missing data
      print('Error fetching relay state or data not found');
    }
    DataSnapshot snapshot1 =  (await _database.child('relay/state1').once()).snapshot;
    if (snapshot1.exists) {
      setState(() {
        if(snapshot1.value==0){
          _isRelay1On = false;
        }else{
          _isRelay1On = true;
        }
       // Update state with database value
      });
    } else {
      // Handle potential database errors or missing data
      print('Error fetching relay state or data not found');
    }
  }
  void toggleRelay(bool value) {
    setState(() {
      _isRelayOn = value;
      _isRelay1On = value;
    });
    if(_selectedRelay=="relay"){
      _database.child('relay/state').set(_isRelayOn ? 1 : 0); // Update database
    }else{
      _database.child('relay/state1').set(_isRelayOn ? 1 : 0); // Update database
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavBar(),
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: pColor,
        title: const Text(
          "Remote Control", style: TextStyle(color: yColor, fontWeight: FontWeight.bold, fontSize: 22),
        ),
        foregroundColor: wColor,
        toolbarHeight: MediaQuery.of(context).size.height / 15, // Set your desired height here
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          color: pColor,
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // Center content
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: DropdownButtonFormField(
                    style: const TextStyle(
                        color: yColor, fontSize: 17.0),
                    decoration: InputDecoration(
                        prefixIcon: Icon(MdiIcons.electricSwitch,
                            color: yColor.withOpacity(0.6)),
                        // suffixIcon: Icon(Icons.email),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: const BorderSide(
                            color: yColor,
                            width: 2.0,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(
                            color: yColor.withOpacity(0.6),
                            width: 2.0,
                          ),
                        ),
                        labelText: 'Relay to Control',
                        labelStyle: TextStyle(
                            color: yColor.withOpacity(0.8))),
                    items: const [
                      DropdownMenuItem(
                        value: "relay",
                        child: Text("Relay 1"),
                      ),
                      DropdownMenuItem(
                        value: "relay1",
                        child: Text("Relay 2"),
                      ),
                    ],
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedRelay =
                        newValue!; // Update the selected value
                      });
                      _fetchRelayState();
                    },
                  ),
                ),
                // Image with conditional rendering for bulb state
                Image(
                  image: AssetImage(_selectedRelay == "relay" ? (_isRelayOn ? 'assets/images/bulb_on.png' : 'assets/images/bulb_off.png') : (_isRelay1On ? 'assets/images/bulb_on.png' : 'assets/images/bulb_off.png')),
                  width: 300, // Adjust image size as needed
                  height: 500,
                ),
                // Add spacing between image and toggle
                // Toggle switch
                Switch(
                  value: _selectedRelay == "relay" ? _isRelayOn : _isRelay1On,
                  onChanged: (value) => toggleRelay(value),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(top: BorderSide(color: yColor, width: 2.0))),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: pColor,
          items: <BottomNavigationBarItem>[
            const BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                MdiIcons.lightbulbMultiple,
              ),
              label: 'Relay',
            ),
            BottomNavigationBarItem(
              icon: Icon(MdiIcons.chartPie),
              label: 'Usage ',
            ),

          ],
          currentIndex: 1,
          selectedItemColor: yColor,
          unselectedItemColor: y1Color,
          onTap: onTabTapped,
        ),
      ),
    );
  }
  void onTabTapped(int index) {
    if (index == 0) {
      Get.to(() => const HomeScreen());
    } else if (index == 1) {
      Get.to(() => const RelayControl());
    } else if (index == 2) {
      Get.to(() => const YesterdayHoursData());
    }
  }
}
