import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:projecknew/extra%20features/photoclicker.dart';
class Information extends StatelessWidget {
    Information({super.key});
  final TextEditingController name=TextEditingController();
  final TextEditingController number=TextEditingController();
  final TextEditingController password=TextEditingController();
    final SignUpState _controller=Get.put(SignUpState());
  final _key=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Form(
              key: _key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Profile",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 25),),
                      const Spacer(),
                      const Spacer(),
                      const Spacer(),
                      const Spacer(),
                      const Spacer(),
                      Obx(
                            () => GestureDetector(
                          onTap: () => _controller.picImage(),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Container(
                              height: 100,
                              width: 100,
                              color: Colors.white,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  _controller.path.isEmpty
                                      ? const Padding(
                                    padding: EdgeInsets.all(20.0),
                                    child: FlutterLogo(
                                      size: 50,
                                    ),
                                  )
                                      : Image.file(
                                    File(_controller.path.value),
                                    height: 100,
                                    width: 100,
                                    fit: BoxFit.cover,
                                  ),
                                  Positioned(
                                      bottom: 1,
                                      child: Container(
                                        height: 30,
                                        width: 100,
                                        color: Colors.black12,
                                        child: const Center(
                                          child: Icon(
                                            Icons.camera_alt,
                                            color: Colors.black38,
                                          ),
                                        ),
                                      )),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
