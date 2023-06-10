import 'package:flutter/material.dart';

import 'components/buttons.dart';
import 'validator.dart';


class StaffEntryScreen extends StatelessWidget {

  const StaffEntryScreen({ super.key });
  @override
  Widget build(BuildContext context) {
    return const StaffLogin();
  }
}




class StaffLogin extends StatefulWidget {
  const StaffLogin({ super.key });

  @override
  State<StatefulWidget> createState() => _StaffLoginState();
}


class _StaffLoginState extends State<StaffLogin> {
  
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _signInGlobalKey = GlobalKey<FormState>();
  bool passwordHidden = true;

  @override
  void initState() {
    super.initState();
    passwordHidden = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(
              width: 100,
              height: 100,
            ),
            const Center(
              child: Text(
                "Sign In to continue",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
            ),
            const SizedBox(
              width: 100,
              height: 100,
            ),
            
            Form(
              key: _signInGlobalKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: emailController,
                    validator: (text) {
                      if (text == null || text.isEmpty || !text.contains("[A-z]")) {
                        return "Bad format";
                      }
                      return "Goodge";
                    },
                    decoration: InputDecoration(
                          hintText: "Staff ID",
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.black38,
                            ),
                            borderRadius: BorderRadius.circular(10.0)
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.black38
                            ),
                            borderRadius: BorderRadius.circular(10.0)
                          )
                        ),
                  ),
                  const SizedBox(height: 30),
                  TextFormField(
                    controller: passwordController,
                    obscureText: passwordHidden,
                    validator: AuthValidator.isPasswordValid,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.black38,
                        ),
                        borderRadius: BorderRadius.circular(10.0)
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.black38
                        ),
                        borderRadius: BorderRadius.circular(10.0)
                      ),
                      hintText: "Password",
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            passwordHidden = !passwordHidden;
                          });
                        },
                        child: Icon(
                          passwordHidden
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 50),
            Column(
              children: [
                MyButtonTwo(text: "Log in", onPressed: () {
                  showDialog(context: context, builder: (ctx) => const AlertDialog(title: Text("Pressed"), content: Text("Please wait"),));
                }),
                const SizedBox(height: 30),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  }, 
                  child: const Text("Go back")
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}


