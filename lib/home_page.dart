import 'package:flutter/material.dart';
import 'package:untitled/timezone.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => TimeZone(
                    url: 'http://worldtimeapi.org/api/timezone/Asia/Kolkata',
                    color: Colors.blue,
                  ),));
                },
                child: Text('Kolkata'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => TimeZone(
                    url: 'http://worldtimeapi.org/api/timezone/America/New_York',
                    color: Colors.pink,
                  ),));
                },
                child: Text('New York'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => TimeZone(
                    url: 'http://worldtimeapi.org/api/timezone/Europe/Paris',
                    color: Colors.green,
                  ),));
                },
                child: Text('Paris'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => TimeZone(
                    url: 'http://worldtimeapi.org/api/timezone/Pacific/Auckland',
                    color: Colors.cyan,
                  ),));
                },
                child: Text('Auckland'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
