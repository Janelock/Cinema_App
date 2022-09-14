import 'package:cinema_application/Screens/Register_screen.dart';
import 'package:cinema_application/Screens/change_password.dart';
import 'package:cinema_application/Screens/transition_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cinema_application/components/default_textformfield.dart';
import 'package:cinema_application/data/profileData.dart';


class LoginScreen extends StatefulWidget {

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isEmailorPasswordWrong=false ;

  final TextEditingController email = TextEditingController();

  final TextEditingController password = TextEditingController();

  final TextEditingController userName = TextEditingController();


  final auth = FirebaseAuth.instance;
  final formKey =GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(

            width: double.infinity,
            height: double.infinity,
            color: Colors.black,
            child: Opacity(
              opacity: 0.3,
              child: Image.network(
                'https://images.squarespace-cdn.com/content/v1/618f1949e28d5e64417a9ba1/1637461630196-CPUM9INIO8C2OE57HKWY/tyson-moultrie-BQTHOGNHo08-unsplash.jpg',
                fit: BoxFit.cover,),

            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Form(
                      key: formKey,
                      child: Column(


                        children: [

                          const SizedBox(height: 35,),

                          defaultTextFormField(hintText: 'Email',
                            fieldonChange: (value){
                            },
                            icon: Icons.email_outlined,
                            color: Colors.orangeAccent,
                            Type: TextInputType.emailAddress,
                            controller: email,
                            fieldValidator: (Email){
                              if(Email.isEmpty){
                                return 'Enter an Email';
                              }
                              else if (Email!=null&& !EmailValidator.validate(Email) ) {
                                return  'Enter a Valid Email';
                              }
                              else {

                                isEmailorPasswordWrong =false;
                                setState(() {

                                });
                                return null ;
                              }
                            }
                            ,

                          ),
                          const SizedBox(height: 35,),

                          defaultTextFormField(hintText: 'Password',
                            fieldonChange: (value){
                            },
                            icon: Icons.lock,
                            color: Colors.orangeAccent,
                            obscureText: true,
                            Type: TextInputType.visiblePassword,
                            controller: password,
                            fieldValidator:  (Password){
                              if(Password.isEmpty){
                                return 'Enter a Password';
                              }
                              else if (Password!=null && Password.length<6 ) {
                                return  'Enter a Valid Password';
                              }
                              else {
                                isEmailorPasswordWrong =false;
                                setState(() {

                                });
                                return null ;
                              }
                            },),


                          const SizedBox(height: 40,),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Visibility(
                              visible: isEmailorPasswordWrong,
                              child: Text('Either Email or Password are wrong' ,style: TextStyle(color: Colors.red),),

                            ),
                          ),
                          const SizedBox(height: 30,),
                          Container(
                            width: 200,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),

                                gradient: const LinearGradient(
                                  begin: Alignment.centerLeft,
                                  colors: <Color>[
                                    Color(0xffff5983),
                                    Colors.orangeAccent,

                                  ],

                                )

                            ),
                            child: MaterialButton(onPressed: () async {
                              try {
                                formKey.currentState!.validate();
                                final validForm = formKey.currentState!
                                    .validate();
                                if (validForm) {
                                  await auth.signInWithEmailAndPassword(email: email.text, password: password.text);

                                  print("logged successfully");

                                  username=userName.text;
                                  emailAddress = email.text;
                                  isEmailorPasswordWrong =false;


                                  var Points = await FirebaseFirestore.instance.collection("Points").doc(email.text).get();



                                  points = Points["points"];



                                  var Username = await FirebaseFirestore.instance.collection("Usernames").doc(email.text).get();

                                  username=Username["Username"];

                                  print("hna");
                                  setState(() {

                                  });
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => TransitionScreen()));
                                }
                              }
                              catch (e) {
                                print("error in login");
                                isEmailorPasswordWrong=true;
                                setState(() {

                                });
                              }
                            },
                              child: const Text('Login', style: TextStyle(
                                  color: Colors.white, fontSize: 20),),),
                          ),
                          const SizedBox(height: 30,),
                          Column(
                            children: [
                              GestureDetector(
                                child: Text("Forgot Password?",
                                  style: TextStyle(color: Colors.orangeAccent,fontSize: 20,),
                                ),
                                onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=>ChangePasswordScreen())),
                              ),
                              const SizedBox(height: 20,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text('Don\'t have an Account ? ',
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white),),
                                  TextButton(onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(
                                        builder: (context) => RegisterScreen()));
                                  },
                                      child: const Text('Sign Up', style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.orangeAccent,),)),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
