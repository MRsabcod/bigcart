import 'dart:convert';

import 'package:bogkart/sign_in_api.dart';
import 'package:bogkart/widgets.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'allcateforyresp.dart';
import 'dashboard.dart';
import 'myinherited.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return AppStateWidget(
counter: 7,
      child: MaterialApp(

        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SignUpScreen(),
      ),
    );
  }
}


class SignUpScreen extends StatefulWidget {

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  //-- user data --
  SignUpUserData? userData;
  // -------------
  bool isLoading = false;
  String? error;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  List<AllCategoryData>? categories;
  // List<AllProductData>? products;
  @override
  Widget build(BuildContext context) {
    double heightVariable = MediaQuery.of(context).size.height;
    double widthVariable = MediaQuery.of(context).size.width;
    var myappstate=MyInheritedWidget.of(context);
    return Scaffold(
      appBar: AppBar(title:Text(myappstate!.counter.toString()),),
      body: Form(
        child: Builder(
            builder: (childContext) {
              return Stack(
                children: [
                  Container(
                    height: heightVariable * 0.6,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage("images/signup_pic.png")
                        )
                    ),
                  ),
                  Positioned(
                      top: 40,
                      child: IconButton(
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back, color: Colors.white, size: 30,),
                      )
                  ),
                  Positioned(
                      top: 45,
                      left: widthVariable*0.4,
                      child: const Text("Welcome",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Poppins",
                            fontSize: 18
                        ),)
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(topRight: Radius.circular(15), topLeft: Radius.circular(15)),
                      child: Container(
                        width: widthVariable,
                        height: heightVariable*0.52,
                        decoration: const BoxDecoration(
                            color: Color(0xFFF4F5F9)
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(top: 20,left: 16),
                                child: Text("Create account", style: TextStyle(
                                    fontSize: 25,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.bold
                                ),),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 16),
                                child: Text("Quickly create account", style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: "Poppins",
                                    color: Color(0xFF868889)
                                ),),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 26, left: 17, right: 17),
                                child: EmailField(controller: email, title: "Email Address"),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5, left: 17, right: 17),
                                child: PhoneField(controller: phoneNumber, title: "Contact Number"),
                              ),
                              Padding(
                                  padding: const EdgeInsets.only(top: 5, left: 17, right: 17),
                                  child: PasswordField(controller: password, title: "Password")
                              ),
                              Padding(
                                padding: const EdgeInsets.all(17),
                                child: Container(
                                    height: 50,
                                    width: widthVariable,
                                    child: !isLoading? ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF6CC51D)),
                                        shadowColor: MaterialStateProperty.all<Color>(Colors.white),
                                      ),
                                      onPressed: (){
                                        if(Form.of(childContext)?.validate() ?? false){
                                          signup();
                                        }
                                      },
                                      child: const Text(
                                        "Signup",style: TextStyle(
                                          fontSize: 22,
                                          fontFamily: "Poppins",
                                          color: Colors.white
                                      ),
                                      ),
                                    ): const Center(
                                      child: CircularProgressIndicator(),
                                    )
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text("Already have an account?", style: TextStyle(
                                        fontSize: 15,
                                        color: Color(0xFF868889),
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.w300
                                    ),),
                                    GestureDetector(
                                      onTap: (){
                                        Navigator.pop(context);
                                      },
                                      child: const Text(" Login", style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black,
                                          fontFamily: "Poppins",
                                          fontWeight: FontWeight.bold
                                      ),),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              );
            }
        ),
      ),
    );
  }
  void signup()async{
    var url = Uri.parse('http://ishaqhassan.com:2000/user');
    setState(() {
      isLoading = true;
    });
    try{
      var response = await http.post(url, body: {
        'email': email.text,
        'phone': phoneNumber.text,
        'password': password.text});
      var responseJSON = SignUpResponse.fromJson(jsonDecode(response.body));
      setState(() {
        userData = responseJSON.data;
      });
      updatingUserSignUpDataToState(context);
      if(userData != null) {
        await getAllCategory(context);
        // await getAllProducts(context);
      }
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=> Dashboard()));

    }catch(e){
      setState(() {
        error = e.toString();
      });
    }
    setState(() {
      isLoading = false;
    });
  }
  Future<void> getAllCategory(BuildContext context)async{
    var url = Uri.parse('http://ishaqhassan.com:2000/category');
    var myAppState = MyInheritedWidget.of(context);
    setState(() {
      isLoading = true;
    });
    try{
      var response = await http.get(url, headers: {"Authorization": "Bearer ${myAppState?.userSignUpData?.accessToken}"});
      var responseJSON = AllCategoryResponse.fromJson(jsonDecode(response.body));

      setState(() {
        categories = responseJSON.data;
      });
      updatingCategoriesToState(context);

    }catch(e){
      setState(() {
        error = e.toString();
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  // Future<void> getAllProducts(BuildContext context)async{
  //   var url = Uri.parse('http://ishaqhassan.com:2000/product');
  //   var myAppState = MyInheritedWidget.of(context);
  //   setState(() {
  //     isLoading = true;
  //   });
  //   try{
  //     var response = await http.get(url, headers: {"Authorization": "Bearer ${myAppState?.userSignUpData?.accessToken}"});
  //     var responseJSON = AllProductResponse.fromJson(jsonDecode(response.body));
  //
  //     setState(() {
  //       products = responseJSON.data;
  //     });
  //     // updatingProductsToState(context);
  //
  //   }catch(e){
  //     setState(() {
  //       error = e.toString();
  //     });
  //   }
  //   setState(() {
  //     isLoading = false;
  //   });
  // }
  //

  // updatingUserDataToState(BuildContext context){
  //   var myAppState = MyInheritedWidget.of(context);
  //   myAppState?.updateUserData(userData!);
  // }
  updatingUserSignUpDataToState(BuildContext context){
    var myAppState = MyInheritedWidget.of(context);
    myAppState?.updateUserSignUpData(userData!);
  }
  updatingCategoriesToState(BuildContext context){
    var myAppState = MyInheritedWidget.of(context);
    myAppState?.updateCategory(categories!);
  }
  // updatingProductsToState(BuildContext context){
  //   var myAppState = MyInheritedWidget.of(context);
  //   myAppState?.updateProducts(products!);
  // }
}