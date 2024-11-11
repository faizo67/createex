import 'package:faizahmad_createex/Ui/shared/commonWidget/MyTextField.dart';
import 'package:faizahmad_createex/Ui/shared/commonWidget/customBtn.dart';
import 'package:faizahmad_createex/Ui/shared/constant/size.dart';
import 'package:faizahmad_createex/Ui/view/Home/controller/home_controller.dart';
import 'package:faizahmad_createex/Ui/view/Home/home_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});
  LoginController controller = Get.put(LoginController());
  final _formField = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: Csize.spaceBtwSection * 4),
              // Image Section
              Image.asset("lib/core/images/LoginScreen.png"),
              SizedBox(height: Csize.spaceBtwSection + 25),

              // Form Section
              Form(
                  key: _formField,
                  child: Column(
                    children: [
                      MyTextfield(
                          controller: controller.emailController.value,
                          hintText: '  email',
                          visibleText: false),
                      SizedBox(height: Csize.spaceBtwInputFields),

                      // Password
                      MyTextfield(
                          controller: controller.passwordController.value,
                          hintText: '  password',
                          visibleText: true),
                    ],
                  )),
              // Button Section
              MaterialButton(
                onPressed: () => controller.loginApi(),
                child: CustomBtn(title: 'Update'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
