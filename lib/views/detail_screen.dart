import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:trackcam/services/device_controller.dart';

class HistoryScreen extends StatelessWidget {
  HistoryScreen({Key? key}) : super(key: key);

  final DeviceController deviceController  = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(deviceController.name.value),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 25.0, horizontal: 15.0),
            child: Obx(() =>Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${deviceController.name.value} Details', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                const SizedBox(height: 40.0),
                Text('Longitude', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                Text('${deviceController.lon.value}', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Colors.grey)),

                const SizedBox(height: 20.0),
                Text('Latitude', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                Text('${deviceController.lat.value}', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Colors.grey)),

                const SizedBox(height: 20.0),
                Text('Altitude', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                Text('${deviceController.alt.value}', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Colors.grey)),

                const SizedBox(height: 20.0),
                Text('Speed', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                Text('${deviceController.vel.value}', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Colors.grey)),

                const SizedBox(height: 20.0),
                Text('Heading', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                Text('${deviceController.hea.value}', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Colors.grey)),

                const SizedBox(height: 20.0),
                Text('Accuracy', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                Text('${deviceController.acc.value}', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Colors.grey)),


                const SizedBox(height: 40.0),
                Text('Real Address', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                Text('${deviceController.address.value}', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Colors.grey)),

              ],
            )),
          ),
        ),
      ),
    );
  }
}
