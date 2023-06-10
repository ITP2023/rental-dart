import 'package:flutter/material.dart';

import 'components/buttons.dart';
import 'validator.dart';


class CustomerEntryScreen extends StatefulWidget {

  const CustomerEntryScreen({ super.key });

  @override
  State<StatefulWidget> createState() => _CustomerEntryScreenState();
}

class _CustomerEntryScreenState extends State<CustomerEntryScreen> {
  int _currPage = 0;

  @override
  void initState() {
    super.initState();
    _currPage = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currPage == 0 ?
      CustomerLogin(gotoSignUp: gotoSignUpScreen)
      : CustomerSignUp(gotoLogin: gotoLoginScreen)
      ,
    );
  }

  void gotoSignUpScreen() {
    setState(() {
      _currPage = 1;
    });
  }

  void gotoLoginScreen() {
    setState(() {
      _currPage = 0;
    });
  }
}
class CustomerLogin extends StatefulWidget {
  final void Function() gotoSignUp;
  CustomerLogin({ super.key, required this.gotoSignUp });

  @override
  State<StatefulWidget> createState() => _CustomerLoginState(gotoSignUp: gotoSignUp);

}

class _CustomerLoginState extends State<CustomerLogin> {
  
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _signInGlobalKey = GlobalKey<FormState>();
  bool passwordHidden = true;

  final void Function() gotoSignUp;
  _CustomerLoginState({ required this.gotoSignUp });
  
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
                      if (text != null && text.contains("@") && text.contains(".")) {
                        return null;
                      } else {
                        return "Email in not valid";
                      }
                    },
                    decoration:
                        InputDecoration(
                          hintText: "Email",
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
                    validator: (text) {
                      if (text != null && text.contains(RegExp(r"[a-z]{3}[0-9]{3}"))) {
                        return null;
                      } else {
                        return "Password in not valid";
                      }
                    },
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
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
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
                  showDialog(context: context, builder: (ctx) => AlertDialog(title: Text("Pressed"), content: Text("Please wait"),));
                }),
                TextButton(
                  onPressed: () {
                    gotoSignUp();
                  },
                  child: const Text("Create an account here"),
                ),
                const SizedBox(height: 30),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  }, 
                  child: const Text("Go back")
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


class CustomerSignUp extends StatefulWidget {

  final void Function() gotoLogin;
  CustomerSignUp({ super.key, required this.gotoLogin });

  @override
  State<StatefulWidget> createState() => _CustomerSignUpState(gotoLogin: gotoLogin);
}

class _CustomerSignUpState extends State<CustomerSignUp> {

  final GlobalKey<FormState> _signUpGlobalKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordRetryController = TextEditingController();
  bool passwordHidden = true;

  final void Function() gotoLogin;
  _CustomerSignUpState({ required this.gotoLogin });

  @override
  void initState() {
    super.initState();
    passwordHidden = true;
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: _signUpGlobalKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 50),

                // Back Icon Button
                GestureDetector(
                  onTap: () {
                    gotoLogin();
                  },
                  child: const Icon(
                    Icons.chevron_left,
                    size: 40,
                  ),
                ),
                const SizedBox(height: 30),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(width: 10),
                    Text(
                      "Enter your details",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Column(
                  children: [
                    // Email Input -------------------------------------
                    const SizedBox(height: 40),
                    TextFormField(
                      controller: emailController,
                      validator: AuthValidator.isEmailValid,
                      decoration: const InputDecoration(
                        hintText: "Email",
                        border: OutlineInputBorder()
                      ),
                    ),

                    // Password Input -------------------------------------
                    const SizedBox(height: 40),
                    TextFormField(
                      controller: passwordController,
                      obscureText: passwordHidden,
                      validator: AuthValidator.isPasswordValid,
                      decoration: InputDecoration(
                        hintText: "Password",
                        border: OutlineInputBorder(),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              passwordHidden = !passwordHidden;
                            });
                          },
                          child: Icon(
                            passwordHidden
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                          ),
                        ),
                      ),
                    ),

                    // Retry Password Input -------------------------------------
                    const SizedBox(height: 40),
                    TextFormField(
                      controller: passwordRetryController,
                      obscureText: passwordHidden,
                      validator: AuthValidator.isPasswordValid,
                      decoration: const InputDecoration(
                        hintText: "Enter password again",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 50),
                    // Sign Up for Button ----------------------------------
                    MyButtonTwo(
                      text: "Continue",
                      onPressed: signUpButton,
                    ),

                    TextButton(
                      child: const Text("Already a user? Login"),
                      onPressed: () {
                        gotoLogin();
                      },
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      );
  }

    void signUpButton() {
    if (_signUpGlobalKey.currentState!.validate()) {
      final message = 
        nameController.text.trim()+
        emailController.text.trim()+
        passwordController.text.trim();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          margin:
              EdgeInsets.only(bottom: MediaQuery.of(context).size.height * .9),
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 5),
          shape: const StadiumBorder(),
          dismissDirection: DismissDirection.horizontal,
          showCloseIcon: true,
        ),
      );
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    passwordRetryController.dispose();
    super.dispose();
  }
}