import 'package:flutter/material.dart';
import 'package:maverics/bt_service/connect.dart';

class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<login> with SingleTickerProviderStateMixin {
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
    TextEditingController _userNameController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'LOGIN',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
        backgroundColor: Colors.cyanAccent,
        toolbarHeight: 75.0,// Change the background color
        elevation: 5.0, // Add elevation
      ),
      body: Center(
        child: FadeTransition(
          opacity: _fadeInAnimation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'MAVERICS LOGIN',
                style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 2.0,
                  color: Colors.black,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 25.0,
                  vertical: 25.0,
                ),
                child: Form(
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        controller: _userNameController,
                        decoration: InputDecoration(
                          labelText: 'User Name',
                        ),
                      ),
                      TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          labelText: 'Password',
                        ),
                        obscureText: true,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      String username = _userNameController.text;
                      String password = _passwordController.text;

                      if (username == "user" && password == "password") {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => Connect()),
                        );
                      } else {
                        print('error');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.cyanAccent,
                      onPrimary: Colors.black,
                      minimumSize: Size(120, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      elevation: 3.0,
                    ),
                    child: Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 2.0,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ],
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
