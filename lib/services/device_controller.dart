import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:supabase/supabase.dart';

import '../misc/constants.dart';

class DeviceController extends GetxController{
  final client = SupabaseClient(supabaseUrl, supabaseKey);

  var name = 'Name'.obs;
  var isTracking = false.obs;
  var lon = 0.0.obs;
  var lat = 0.0.obs;
  var alt = 0.0.obs;
  var vel = 0.0.obs;
  var hea = 0.0.obs;
  var acc = 0.0.obs;
  var address = 'Unknown Location'.obs;

  void fetchDeviceInfo() async{

    final res = await client.from('gps')
        .select()
        .order('id', ascending: true)
        .execute();
    if(res.error != null){
      print(res.error!.message.toString());
    }
    else{
      name.value = res.data[0]['name'];
      lon.value = res.data[0]['longitude'];
      lat.value = res.data[0]['latitude'];
      print(res.data.toString());
    }


  }

  getDeviceAddress(double long, double lat) async{
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, long);
    address.value = '${placemarks[0].name}';
  }
}