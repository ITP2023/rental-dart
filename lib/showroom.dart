import "package:flutter/material.dart";
import "package:rentallapp/car_widget.dart";
import "./available_cars.dart";
import "./dealer_widget.dart";
import "./book_car.dart";
import './data.dart';
import './constants.dart';


class Showroom extends StatefulWidget {

  const Showroom({ super.key });
  @override
  State<Showroom> createState() => _ShowroomState();
}

class _ShowroomState extends State<Showroom> {
  late int selectedItem;

  late Future<List<Car>> cars;
  late Future<List<Dealer>> dealers;

  @override
  void initState() {
    super.initState();
    cars = fetchCars();
    dealers = fetchDealers();
    setState(() {
      selectedItem = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Car Rental App",
        ),
        centerTitle: false,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(
              Icons.menu,
              color: Colors.black,
              size: 28,
            ),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [

          Container(
            padding: EdgeInsets.only(bottom: 10),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: TextStyle(fontSize: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      width: 0, 
                      style: BorderStyle.none,
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.grey[100],
                  contentPadding: EdgeInsets.only(left: 30,),
                  suffixIcon: Padding(
                    padding: EdgeInsets.only(right: 24.0, left: 16.0),
                    child: Icon(
                      Icons.search,
                      color: Colors.black,
                      size: 24,
                    ),
                  ),
                ),
              ),
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  children: [

                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          Text(
                            "TOP DEALS",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[400],
                            ),
                          ),

                          Row(
                            children: [

                              Text(
                                "view all",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: kPrimaryColor,
                                ),
                              ),

                              SizedBox(
                                width: 8,
                              ),

                              Icon(
                                Icons.arrow_forward_ios,
                                size: 12,
                                color: kPrimaryColor,
                              ),

                            ],
                          ),

                        ],
                      ),
                    ),

                    Container(
                      height: 280,
                      child: FutureBuilder<List<Car>>(
                        future: cars,
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Text("Something went wrong: ${snapshot.error}");
                          }

                          if (snapshot.hasData) {
                            return ListView(
                              scrollDirection: Axis.horizontal,
                              padding: EdgeInsets.all(16),
                              physics: BouncingScrollPhysics(),
                              children: snapshot.data!.map((e) =>
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(context,  MaterialPageRoute(builder: (context) => BookCar(car: snapshot.data!.first)));
                                },
                                child: Container(
                                  margin: EdgeInsets.only(left: 5),
                                  width: 200,
                                  // alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.00),
                                    color: Colors.white,
                                  ),
                                  padding: const EdgeInsets.all(16),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Image.network(e.imageURL),
                                      Text(
                                        e.model,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20
                                        ),
                                      ),
                                      Text(e.brand),
                                      Text(e.color)
                                    ],
                                  ),
                                ),
                              )
                              ).toList(),
                            );
                          }
                          return Container(
                            child: CircularProgressIndicator(),
                            width: 100,
                            height: 100,
                          );
                        },
                      ),
                    ),

                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AvailableCars()),
                        );
                      },
                      child: Padding(
                        padding: EdgeInsets.only(top: 16, right: 16, left: 16),
                        child: Container(
                          decoration: BoxDecoration(
                            color: kPrimaryColor,
                            borderRadius: BorderRadius.all(
                              Radius.circular(15),
                            ),
                          ),
                          padding: EdgeInsets.all(24),
                          height: 100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [

                                  Text(
                                    "Available Cars",
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),

                                  Text(
                                    "Long term and short term",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),

                                ],
                              ),

                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(15),
                                  ),
                                ),
                                height: 50,
                                width: 50,
                                child: Center(
                                  child: Icon(
                                    Icons.arrow_forward_ios,
                                    color: kPrimaryColor,
                                  ),
                                ),
                              ),

                            ],
                          ),
                        ),
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          Text(
                            "TOP DEALERS",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[400],
                            ),
                          ),

                          Row(
                            children: [

                              Text(
                                "view all",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: kPrimaryColor,
                                ),
                              ),

                              SizedBox(
                                width: 8,
                              ),

                              Icon(
                                Icons.arrow_forward_ios,
                                size: 12,
                                color: kPrimaryColor,
                              ),

                            ],
                          ),

                        ],
                      ),
                    ),

                    Container(
                      height: 150,
                      margin: EdgeInsets.only(bottom: 16),
                      child: FutureBuilder<List<Dealer>>(
                        future: dealers,
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Text("Something went wrong: ${snapshot.error}");
                          }
                          
                          if (snapshot.hasData) {
                            return ListView(
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              children: snapshot.data!.map((e) => buildDealer(e, snapshot.data!.indexOf(e))).toList(growable: false),
                            );
                          }
                          return const CircularProgressIndicator();
                        },
                      ),
                      
                    ),

                  ],
                ),
              ),
            ),
          ),

        ],
      ),
      bottomNavigationBar: StatefulBuilder(
        builder:(context, setState) => BottomNavigationBar(
          unselectedItemColor: Colors.white,
          selectedItemColor: Colors.white,
          showSelectedLabels: true,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.purple,
          currentIndex: selectedItem,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_filled, color: Colors.white),
              label: "Home",    
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today, color: Colors.white),
              label: "Reservations",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications, color: Colors.white),
              label: "Notifications",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person, color: Colors.white),
              label: "Customers",
            )
          ],
          onTap: (value) => setState(() {selectedItem = value;}),
        ),
      ),
    );
  }



}
