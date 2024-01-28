import 'package:flutter/material.dart';
import 'package:maverics/loation.dart';
import 'package:maverics/login.dart';


void main() {
  runApp(
    MaterialApp(
      home: home(),
    ),
  );
}

class home extends StatelessWidget {
  const home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: const Text('ABOUT MAVERICS',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w900,
            letterSpacing: 2.0,
            color: Colors.black,
        ),),
        actions: [
          IconButton(
            icon: Icon(Icons.login),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => login()),
              );
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                  horizontal: 30.0,
                  vertical: 25.0),
              onPrimary: Colors.black87, // Text color
              minimumSize: Size(20, 50),),
          ),
        ],
        // centerTitle: true,
        backgroundColor: Colors.cyanAccent,
        toolbarHeight: 75.0,// Change the background color
        elevation: 5.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Welcome to our about page! We take pride in introducing our groundbreaking ',
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                 ),
              ),
            ),
            Image.asset(
              'assets/image/mav_fro.png',
              height: 200.0, // Adjust the height as needed
              width: double.infinity,
              fit: BoxFit.cover,
            ),

            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'innovation – a one-seater electric vehicle equipped with four tires. Our creation boasts an '
                    'impressive speed of up to 18 km per second, setting a new standard in the realm of electric '
                    'transportation. What sets us apart is the ability to control this sleek and efficient vehicle '
                    'remotely, offering a unique and futuristic driving experience. Join us on this journey as we '
                    'redefine the landscape of sustainable and cutting-edge transportation.',
                style: TextStyle(fontSize: 18.0),
              ),
            ),
            Image.asset(
              'assets/image/mav_sid.png',
              height: 200.0, // Adjust the height as needed
              width: double.infinity,
              fit: BoxFit.cover,
            ),

            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'At the heart of our endeavor is a commitment to revolutionize personal mobility with an unwavering '
                    'focus on sustainability and technological advancement. By crafting a one-seater electric vehicle '
                    'with four tires, we have reimagined urban commuting, blending efficiency with style. The remarkable '
                    'speed of up to 18 km per second is not just a testament to our engineering prowess but also a '
                    'testament to our dedication to providing a swift and exhilarating driving experience. With the '
                    'added feature of remote control, we empower users to navigate their surroundings effortlessly. '
                    'Our journey is not just about creating a mode of transportation; it iss a stride towards a greener, '
                    'smarter, and more connected future.',
                style: TextStyle(fontSize: 18.0),
              ),
            ),
            Image.asset(
              'assets/image/mav_bac.png',
              height: 200.0, // Adjust the height as needed
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            // Add more text and images as needed
          ],
        ),
      ),
    );
  }
}

