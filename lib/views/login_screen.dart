import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:supabase/supabase.dart';
import 'package:trackcam/services/auth_controller.dart';
import 'package:trackcam/views/home_screen.dart';

import '../misc/constants.dart';
import '../services/theme_service.dart';
import '../widgets/normal_text.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final box = GetStorage('data');

  @override
  Widget build(BuildContext context) {

    TextEditingController emailController = TextEditingController();
    TextEditingController passController = TextEditingController();
    var _formKey = GlobalKey<FormState>();
    AuthController authController = Get.put(AuthController());

    var size = Get.size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(onPressed: (){
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (ctx) => AlertDialog(
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    NormalText(text: 'help'.tr, size: 22),
                    const SizedBox(height: 20),
                    NormalText(text: 'help-text'.tr),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: mainColor,
                        borderRadius: BorderRadius.circular(15.0)
                    ),
                    padding: const EdgeInsets.all(14),
                    child: NormalText(text: 'ok'.tr, color: Colors.white, size: 15),
                  ),
                ),
              ],
            ),
          );
        }, icon: Icon(Icons.help)),
        title:Text('auth'.tr),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
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
          const SizedBox(width: 10),
        ],
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
            child: Center(
              child: Column(
                children: [
                  NormalText(text: 'welcome'.tr, size: 15),

                  Container(
                    height: size.height / 4,
                    width: size.width / 3,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/app-logo.png'),
                        )
                    ),
                  ),

                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Container(
                          height: 60,
                          width: double.infinity,
                          margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: TextFormField(
                              maxLength: 25,
                              keyboardType: TextInputType.emailAddress,
                              controller: emailController,
                              validator: (val){
                                if(val!.isEmpty){
                                  return 'enter-email'.tr;
                                }
                                else if(!val.isEmail){
                                  return 'valid-email'.tr;
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                labelText: 'email'.tr,
                                labelStyle: TextStyle(
                                  color: Colors.black54,
                                    fontFamily: 'LatoLight'
                                ),
                                prefixIcon: Icon(Icons.email),
                                contentPadding: EdgeInsets.zero,
                                fillColor: Colors.grey.shade200,
                                counterText: '',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide: BorderSide(
                                    color: mainColor,
                                  ),
                                ),
                              )
                          ),
                        ),

                        Container(
                          height: 60,
                          width: double.infinity,
                          margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Obx(() => TextFormField(
                              maxLength: 25,
                              controller: passController,
                              obscureText: authController.isObscured.value,
                              validator: (val){
                                if(val!.isEmpty){
                                  return 'enter-pass'.tr;
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                labelText: 'password'.tr,
                                labelStyle: TextStyle(
                                    color: Colors.black54,
                                    fontFamily: 'LatoLight'
                                ),
                                prefixIcon: Icon(Icons.lock),
                                suffixIcon: GestureDetector(
                                  onTap: (){
                                    authController.isObscured.value = !authController.isObscured.value;
                                  },
                                  child: authController.isObscured.value ? Icon(Icons.remove_red_eye) : Icon(Icons.remove_red_eye_outlined),
                                ),
                                contentPadding: EdgeInsets.zero,
                                fillColor: Colors.grey.shade200,
                                counterText: '',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide: BorderSide(
                                    color: mainColor,
                                  ),
                                ),
                              )
                          )),
                        ),

                        GestureDetector(
                          onTap: (){
                            if(_formKey.currentState!.validate()){
                              authController.isLoading.value = true;
                              loginMethod(emailController.text.trim(), passController.text.trim(), context);
                            }
                            else{
                              return;
                            }

                          },
                          child: Container(
                            height: 60,
                            width: size.width,
                            margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                color: mainColor
                            ),
                            child: Center(
                              child: NormalText(
                                  text: 'login'.tr, size: 22, color: Colors.white),
                            )
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),

      bottomSheet: Container(
        height: 30,
        width: double.infinity,
        child: Column(
          children: [
            NormalText(text: 'slogan'.tr, size: 10),
            NormalText(text: 'power'.tr, size: 7),
          ],
        )
      )
    );
  }

  Future showSimpleDialog({required BuildContext context, required String title, required String content}){
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: [
              TextButton(onPressed: (){
                Get.back;
              }, child: Text('Got it!'))
            ],
          );
        }
    );
  }

  loginMethod(String email, String pass, BuildContext context) async{
    final client = SupabaseClient(supabaseUrl, supabaseKey);
    final res = await client.auth.signIn(email: email, password: pass);
    if(res.error != null){
      if(res.error!.message.contains('SocketException:')){
        Get.snackbar('Error!', 'Could not connect to the internet!',
            backgroundColor: Colors.red,
            colorText: Colors.white);
      }
      if(res.error!.message.contains('Invalid login credentials')){
        Get.snackbar('Error!', 'Email or password is incorrect!',
            backgroundColor: Colors.red,
            colorText: Colors.white);
      }
      else{
        Get.snackbar('Error!', '${res.error!.message.toString()}',
            backgroundColor: Colors.red,
            colorText: Colors.white);
      }

    }
    else if(res.data != null){
      box.write('first', 'no');
      Get.off(() => HomeScreen());
    }
  }
}
