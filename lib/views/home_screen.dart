
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:latlong2/latlong.dart';
import 'package:supabase/supabase.dart';
import 'package:trackcam/misc/constants.dart';
import 'package:trackcam/services/auth_controller.dart';
import 'package:trackcam/views/command_screen.dart';
import 'package:trackcam/views/detail_screen.dart';
import 'package:trackcam/views/login_screen.dart';
import 'package:trackcam/widgets/normal_text.dart';

import 'package:geocoding/geocoding.dart';
import '../services/device_controller.dart';
import '../services/theme_service.dart';

class HomeScreen extends StatelessWidget {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  AuthController authController = Get.put(AuthController());
  DeviceController deviceController = Get.put(DeviceController());
  final box = GetStorage('data');
  static final client = SupabaseClient(supabaseUrl, supabaseKey);

  @override
  Widget build(BuildContext context) {
    var size = Get.size;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: (){
            _scaffoldKey.currentState!.openDrawer();
          },
          icon: Icon(Icons.menu, size: 30),
        ),

        title: Text(appName),
        centerTitle: true,

        actions: [
          IconButton(
            onPressed: (){

            },
            icon: Icon(Icons.notifications, size: 30),
          ),
          PopupMenuButton(
              elevation: 5,
              icon: Icon(Icons.language),
              itemBuilder:(context) => [
                PopupMenuItem(
                  child: Text('English'),
                  value: 1,
                  onTap: (){
                    var locale = Locale('en', 'US');
                    Get.updateLocale(locale);
                    ThemeServices().saveLocale(locale);
                  },
                ),
                PopupMenuItem(
                  child: Text('Français'),
                  value: 2,
                  onTap: (){
                    var locale = Locale('fr', 'Fr');
                    Get.updateLocale(locale);
                    ThemeServices().saveLocale(locale);
                  },
                ),
              ]
          ),
          SizedBox(width: 5),
        ],
      ),

      drawer: Drawer(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: mainColor,
                //borderRadius: BorderRadius.circular(10.0)
                //borderRadius: BorderRadius.circular(10.0)
              ),
              child: UserAccountsDrawerHeader(
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.grey,
                  backgroundImage: AssetImage('assets/images/tembeck.jpg'),
                ),
                accountName: NormalText(text: 'Tembuck Franco', size: 15),
                accountEmail: NormalText(text: 'francotembuck@gmail.com', size: 10),
                arrowColor: Colors.white,
                // onDetailsPressed: (){
                //   Get.to(() => UpdateScreen());
                // },
              )
            ),

            Obx(() => SwitchListTile(
                value: authController.isOn.value,
                title: Text('dark'.tr),
                dense: true,
                visualDensity: VisualDensity(vertical: -3),
                secondary: Icon(Icons.dark_mode),
                contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                onChanged: (val){
                  authController.isOn.value = val;
                  ThemeServices().switchTheme();
                }
            )),

            Divider(thickness: 1),

            ListTile(
              leading: Icon(Icons.location_on),
              title: Text('Live Tracking'),
              dense: true,
              visualDensity: VisualDensity(vertical: -3),
              trailing: Icon(Icons.arrow_forward_ios, size: 20),
              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 8),
              onTap: (){
                Get.back();
              },
            ),

            Divider(thickness: 1),

            ListTile(
              leading: Icon(Icons.gps_fixed),
              title: Text('GPS Details'),
              dense: true,
              visualDensity: VisualDensity(vertical: -3),
              trailing: Icon(Icons.arrow_forward_ios, size: 20),
              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 8),
              onTap: (){
                deviceController.fetchDeviceInfo();
                deviceController.getDeviceAddress(deviceController.lat.value, deviceController.lon.value);
                Get.to(() => HistoryScreen());
              },
            ),

            Divider(thickness: 1),

            ListTile(
              leading: Icon(Icons.settings_remote),
              title: Text('Remote Commands'),
              dense: true,
              visualDensity: VisualDensity(vertical: -3),
              trailing: Icon(Icons.arrow_forward_ios, size: 20),
              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 8),
              onTap: (){
                Get.to(() => CommandScreen());
              },
            ),

            Divider(thickness: 1),

            ListTile(
              leading: Icon(Icons.person_pin),
              title: Text('About'),
              dense: true,
              visualDensity: VisualDensity(vertical: -3),
              trailing: Icon(Icons.arrow_forward_ios, size: 20),
              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 8),
              onTap: (){

              },
            ),

            Divider(thickness: 1),

            ListTile(
              leading: Icon(Icons.bug_report),
              title: Text('Report Bug'),
              dense: true,
              visualDensity: VisualDensity(vertical: -3),
              trailing: Icon(Icons.arrow_forward_ios, size: 20),
              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 8),
              onTap: (){

              },
            ),

            Divider(thickness: 1),

            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              dense: true,
              visualDensity: VisualDensity(vertical: -3),
              trailing: Icon(Icons.arrow_forward_ios, size: 20),
              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 8),
              onTap: (){
                GetStorage().erase();
                Get.off(LoginScreen());
              },
            ),

            SizedBox(height: 30.0),

            NormalText(text: 'power'.tr, size: 8),

            SizedBox(height: 15.0),
          ],
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
          child: Stack(
            children: [

              SizedBox(
                height: size.height / 1.2,
                width: double.infinity,
                child: FlutterMap(
                  options: MapOptions(
                    center: LatLng(deviceController.lat.value, deviceController.lon.value),
                    zoom: 15.54,
                  ),
                  layers: [
                    TileLayerOptions(
                      urlTemplate: "https://api.mapbox.com/styles/v1/asaserge/cl452c3zp001h15oc83vn08fl/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiYXNhc2VyZ2UiLCJhIjoiY2w0MWFxN2s2MGVvajNsbnZ0ZDZzd2ZsciJ9.uhgsqewaW_Urwvi9Axm-UQ",
                      additionalOptions: {
                        'accessToken': 'pk.eyJ1IjoiYXNhc2VyZ2UiLCJhIjoiY2w0MWFxN2s2MGVvajNsbnZ0ZDZzd2ZsciJ9.uhgsqewaW_Urwvi9Axm-UQ',
                        'id': 'mapbox.mapbox-street-v8'
                      }
                    ),

                    MarkerLayerOptions(
                        markers: [
                          Marker(
                            width: 30.0,
                            height: 70.0,
                            point: LatLng(deviceController.lat.value, deviceController.lon.value),
                            builder: (ctx) => Container(
                              child: Image.asset('assets/images/car-icon.png'),
                            )
                          )
                        ]
                    ),
                  ],

                  nonRotatedChildren: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('OpenStreetMaps by Tembuck', style: TextStyle(fontSize: 12)),
                        Obx(() =>Text('${deviceController.name.value}', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)))

                      ],
                    )
                  ],
                ),
              ),

              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 80,
                  width: double.infinity,
                  child: Column(
                    children: [
                      Obx(() => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Latitude', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                              Text('${deviceController.lat.value}', style: const TextStyle(fontSize: 12)),
                            ],
                          ),
                          ElevatedButton(
                            onPressed: (){
                              if(deviceController.isTracking != true){
                                deviceController.fetchDeviceInfo();
                                deviceController.isTracking.value = true;
                              }
                              else{
                                deviceController.isTracking.value = false;
                              }
                            },
                            child: deviceController.isTracking.value != true ?
                              Text('Track Vehicle') :
                              deviceController.name.value.length == 4 ?
                              Padding(padding: EdgeInsets.all(5.0), child: CircularProgressIndicator(color: Colors.white)) :
                              Text('Stop Tracking')
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Longitude', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                              Text('${deviceController.lon.value}', style: const TextStyle(fontSize: 12)),
                            ],
                          ),
                        ],
                      )),
                    ],
                  )
                ),
              ),
          ],
        ),
      ),
      )
    );
  }

}
