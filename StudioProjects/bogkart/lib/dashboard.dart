import 'package:bogkart/sign_in_api.dart';
import 'package:flutter/material.dart';

import 'allcateforyresp.dart';
import 'myinherited.dart';

class Dashboard extends StatefulWidget {
@override
State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  TextEditingController searchField = TextEditingController();
  bool isLoading = false;
  bool addToCart = false;
  bool updateLike = false;
  int counter = 1;
  // UserData? userData;
  SignUpUserData? signUpUserData;
  String? error;
  List<AllCategoryData>? categories;
  // List<AllProductData>? cartProductsList = [];
  List<bool> cartOrNot = [true,true,true,true,true,true];
  List<bool> likeOrNot = [false,false,false,false,false,false];
  List<int> productCounts = [1,1,1,1,1,1];
  List<double>? subTotalPrice;
  // List<AllProductData>? itemsOnSearch;
  // List<AllProductData>? products;
  bool searching = false;

  final sliderImages = [
    "images/slider_1.png",
    "images/slider_2.jpg",
    "images/slider_3.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    double heightVariable = MediaQuery.of(context).size.height;
    double widthVariable = MediaQuery.of(context).size.width;
    var myAppState = MyInheritedWidget.of(context);
    return Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.white,Colors.white, Color(0xFFFAF6F6FF)])),
        child: Scaffold(
        drawer: Drawer(
        child: Text("S"),
    ),
    backgroundColor: Colors.transparent,
    floatingActionButton: FloatingActionButton(
    onPressed: (){
    // updatingCartOrNotToState(context);
    // updatingLikeOrNotToState(context);
    // updatingProductCount(context);
    // final sumPrice = subTotalPrice!.sum;
    // myAppState?.updateSubTotal(sumPrice);
    // Navigator.of(context).push(MaterialPageRoute(builder: (_)=> CartScreen()));
    },
    backgroundColor: const Color(0xFF6CC51D),
    child: const Image(image: AssetImage("images/floating_cart.png"),),

    ),
    body: Column(
    //mainAxisSize: MainAxisSize.min,
    children: [
    Padding(
    // SearchField(controller: search, title: "Search Keywords.."),
    padding: const EdgeInsets.only(top: 41, left: 17, right: 17),
    child: TextFormField(

    controller: searchField,
    decoration: InputDecoration(
    fillColor: Color(0xFFF4F5F9),
    filled: true,
    hintText: "Search Keywords...",
    prefixIcon: const Icon(Icons.search),
    suffixIcon: Icon(Icons.sort),
    hintStyle: const TextStyle(
    fontFamily: "Poppins"
    ),
    border: OutlineInputBorder(
    borderSide: BorderSide.none,
    borderRadius: BorderRadius.circular(10)))
    )
    ),
    Expanded(
    child: Padding(
    padding: const EdgeInsets.only(bottom: 13),
    child: ListView(
    children: [
    //if(search.text.isEmpty)
    if (!searching)
    Stack(
    children: const [
    Padding(
    padding: EdgeInsets.only(left: 25),
    child: Image(image: AssetImage("images/slider_1.png",),),
    ),
    Positioned(
    top: 190,
    left: 40,
    child: Text("20% off on your\nfirst purchase", style: TextStyle(
    color: Colors.white,
    fontFamily: "Poppins",
    fontSize: 20,
    fontWeight: FontWeight.w600
    ),)
    )
    ],
    ),
    !searching?Padding(
    padding: const EdgeInsets.only(left: 16, top: 17, right: 16),
    child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: const [
    Text("Categories", style: TextStyle(
    fontSize: 20,
    fontFamily: "Poppins",
    fontWeight: FontWeight.w600
    ),),
    Icon(Icons.arrow_forward_ios, color: Color(0xFF868889),)
    ],
    ),
    ):Container(),
    Padding(
    padding: const EdgeInsets.only(top: 17),
    child: SizedBox(
    height: 100,
    width: double.infinity,
    child: Padding(
    padding: const EdgeInsets.only(left: 5, right: 10),
    child: Row(
    children: [
    Expanded(
    child: ListView.builder(
    scrollDirection: Axis.horizontal,
    shrinkWrap: true,
    itemCount: myAppState?.categories?.length, itemBuilder:   categoryItem,
    // itemBuilder: categoryItem
    )
    ),
    ],
    ),
    ),
    ),
    )])))])));}


  Widget categoryItem(BuildContext context, int index){
    var myAppState = MyInheritedWidget.of(context);
    String baseUrl = "http://ishaqhassan.com:2000/";
    String startColor = "0xFF";
    //int avatarColor = int.parse(myAppState.categories)
    return GestureDetector(
      onTap: ()async{
        // await getProductByCategory(context, index+1);
        // updatingCartOrNotToState(context);
        // updatingLikeOrNotToState(context);
        // updatingProductCount(context);
        // Navigator.of(context).push(MaterialPageRoute(builder: (_)=> ProductDisplay()));
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 5),
        child: Column(
          children: [
            CircleAvatar(
                maxRadius: 32,
                backgroundColor: Color(int.parse("$startColor${myAppState?.categories![index].color?.substring(1)}")).withOpacity(0.2),
                child: CircleAvatar(
                  maxRadius: 18,
                  backgroundColor: Colors.transparent,
                  child: Image.network("$baseUrl${myAppState?.categories![index].icon?.substring(28)}"),

                )
            ),
            const SizedBox(height: 11,),
            Text(myAppState?.categories![index].title ?? "", style: const TextStyle(
                fontFamily: "Poppins",
                fontSize: 12,
                color: Color(0xFF868889)
            ),)
          ],
        ),
      ),
    );
  }
}