import 'package:flutter/material.dart';

class Pressure extends StatefulWidget {
  const Pressure({Key? key}) : super(key: key);

  @override
  _PressureState createState() => _PressureState();
}

class _PressureState extends State<Pressure>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeInAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    _fadeInAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    int p1 = 32;
    int p2 = 32;
    int p3 = 32;
    int p4 = 32;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'TIRE PRESSURE',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
        backgroundColor: Colors.cyanAccent,
        toolbarHeight: 75.0,
        elevation: 5.0,
      ),
      body: Center(
        child: FadeTransition(
          opacity: _fadeInAnimation,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'assets/image/tier_number.png', // Replace with your car image asset path
                  width: 200.0, // Adjust the width as needed
                  height: 150.0, // Adjust the height as needed
                ),
                SizedBox(height: 30.0),
                _buildInfoTextField("TIRE 1 PRESSURE", p1),
                SizedBox(height: 10),
                _buildInfoTextField("TIRE 2 PRESSURE", p2),
                SizedBox(height: 10),
                _buildInfoTextField("TIRE 3 PRESSURE", p3),
                SizedBox(height: 10),
                _buildInfoTextField("TIRE 4 PRESSURE", p4),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

Widget _buildInfoTextField(String label, int value) {
  return Container(
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10.0),
      color: Colors.grey[200],
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        Text(
          value.toString(),
          style: TextStyle(fontSize: 18.0),
        ),
      ],
    ),
  );
}
