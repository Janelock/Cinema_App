import 'package:cinema_application/Screens/transition_screen.dart';
import 'package:cinema_application/data/profileData.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cinema_application/components/default_textformfield.dart';
import 'Login_screen.dart';
import 'package:email_validator/email_validator.dart';


class RegisterScreen extends StatefulWidget {

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  final formKey =GlobalKey<FormState>();

  final passwordStrengthKey=GlobalKey<FormState>();

  final TextEditingController email = TextEditingController() ;

  final TextEditingController password= TextEditingController();

  final TextEditingController userName= TextEditingController();

  final  auth = FirebaseAuth.instance;

  RegExp passwordValid= RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)");
  double password_strength =0;
  bool ValidatePassword (String pass){
    String _password =pass.trim();
    Future.delayed(Duration.zero,(){
      if (_password.isEmpty) {
        setState(() {
          password_strength = 0;
        });
      }
      else if (_password.length<6){
        setState(() {
          password_strength=1/4;
        });
      }
      else if (_password.length<8){
        setState(() {
          password_strength=2/4;
        });
      }
      else {
        if (passwordValid.hasMatch(_password)){
          setState(() {
            password_strength=4/4;
          });
          return true;
        } else{
          setState(() {
            password_strength=3/4;
          });
          return false;
        }
      }
    });
    if (password_strength==1){
      return true ;
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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

                            defaultTextFormField(hintText: 'User Name ',
                                icon: Icons.person,
                                color: Colors.orangeAccent,
                                Type: TextInputType.emailAddress,
                                controller: userName,
                                fieldonChange: (value){

                                },
                                fieldValidator:(username){
                                  if (username.isEmpty){
                                    return 'Enter a username';
                                  }
                                  else if (  username.length!=null&&username.length<8){
                                    return 'User name is too short';
                                  }
                                }
                            ),
                            const SizedBox(height: 35,),

                            defaultTextFormField(hintText: 'Email',
                                icon: Icons.email_outlined,
                                color: Colors.orangeAccent,
                                Type: TextInputType.emailAddress,
                                controller: email,
                                fieldonChange: (value){

                                },
                                fieldValidator: (Email){
                                  if(Email.isEmpty){
                                    return 'Enter a Email';
                                  }
                                  else if (Email!=null&& !EmailValidator.validate(Email)) {
                                    return  'Enter a Valid Email';
                                  }
                                  else {
                                    return null ;
                                  }
                                }
                            ),

                            const SizedBox(height: 35,),
                          ])),
                            Form(
                              key: passwordStrengthKey,
                              autovalidateMode:  AutovalidateMode.onUserInteraction,
                              child: defaultTextFormField(hintText: 'Password',
                                  icon: Icons.lock,
                                  color: Colors.orangeAccent,
                                  obscureText: true,
                                  controller: password,
                                  fieldonChange: (value){},
                                  fieldValidator: (value){
                                    if (value!.isEmpty){
                                      return ' please enter a password ';
                                    }
                                    else {

                                      //call function to check password
                                      bool result = ValidatePassword(value);
                                      if (result==true){
                                        return null ;

                                      }
                                      else{
                                        return 'password should contain capital , small letter & number and special character ';
                                      }
                                    }
                                  }
                              ),
                            ),

                            const SizedBox(height: 30,),

                            password.text.length==0? SizedBox():Align(
                                alignment: Alignment.centerLeft,
                                child: Text('Password Strength',style: TextStyle(color: Colors.white , fontSize: 15),)),
                            const SizedBox(height: 15,),
                            password.text.length==0? SizedBox():LinearProgressIndicator(
                              value: password_strength,
                              minHeight: 5,
                              backgroundColor: Colors.white,
                              color:password_strength<=1/4?Colors.red:password_strength==2/4?Colors.yellow:password_strength==3/4?Colors.orange : Colors.green ,
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
                                  passwordStrengthKey.currentState!.validate();
                                  formKey.currentState!.validate();
                                  final validForm = formKey.currentState!.validate();
                                    if (validForm) {
                                      await auth.createUserWithEmailAndPassword(email: email.text, password: password.text);

                                      emailAddress = email.text;
                                      username = userName.text;

                                      FirebaseFirestore.instance.collection("Points").doc(email.text).set({"points":0});
                                      points=0;

                                      FirebaseFirestore.instance.collection("Usernames").doc(email.text).set({"Username":userName.text});
                                      username=userName.text;

                                      Navigator.push(context, MaterialPageRoute(
                                          builder: (context) =>
                                              TransitionScreen()));

                                    }
                                }
                                catch(e) {
                                  if(e.toString()=="[firebase_auth/unknown] Given String is empty or null"){
                                    print ("*"+e.toString());
                                  }
                                  // print(e);
                                }
                              },
                                child:Text('Register',style: TextStyle(color: Colors.white,fontSize: 16),) ,),
                            ),
                            const SizedBox(height: 50,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text('Already have an Account ? ',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),),
                                TextButton(onPressed: () {
                                  Navigator.pop(context);
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (context) => LoginScreen()));
                                },
                                    child: const Text('Sign In', style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.orangeAccent,),)),
                              ],
                            ),
                          ],
                        ),
                      ),
                  ),
                ),
              ]),
            ),
        );
  }
}
