import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../components/default_textformfield.dart';

class ChangePasswordScreen extends StatefulWidget {
  ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {

  final  auth = FirebaseAuth.instance;
  final formKey =GlobalKey<FormState>();
  final TextEditingController email_controller = TextEditingController();

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
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Form(
                  key:formKey,
                  child: defaultTextFormField(
                      hintText: 'Email',
                      icon: Icons.email_outlined,
                      color: Colors.orangeAccent,
                      Type: TextInputType.emailAddress,
                      controller: email_controller,
                      fieldonChange: (value){
                      },
                      fieldValidator: (Email){
                        if(Email.isEmpty){
                          return 'Enter an Email';
                        }
                        else if (Email!=null&& !EmailValidator.validate(Email)) {
                          return  'Enter a Valid Email';
                        }
                        else {
                          return null ;
                        }
                      }
                  ),
                ),
                const SizedBox(height: 20,),
                InkWell(
                  onTap: () {
                    formKey.currentState!.validate();
                    if (formKey.currentState!.validate() == true) {
                      resetPassword();
                      Navigator.pop(context);
                      final snackBar = SnackBar(

                        backgroundColor: Colors.green,
                        content: SizedBox(
                          height: 30,
                          child: Center(child: Text("Password Reset Email Sent",
                            style: TextStyle(fontWeight: FontWeight.bold,
                                color: Colors.white),)),
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  },
                  child: Container(
                    height: 50,
                    width: 350,
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.email),
                        Text(" Reset Password",style: TextStyle(fontSize: 20),),

                      ],
                    ),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [ const Color(0xffff5983),Colors.orangeAccent],),
                      borderRadius: BorderRadius.circular(30),
                    ),),
                ),
                const SizedBox(height: 20,),
                Text("You'll receive an email that will guide you through resetting your password.",),

              ],
            ),
          )
        ],),);
  }

  Future resetPassword() async{
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email_controller.text.trim());
  }
}

