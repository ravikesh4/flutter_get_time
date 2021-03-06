import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:untitled/timezone_modal.dart';
import 'package:http/http.dart' as http;


class TimeZone extends StatefulWidget {
  final String url;
  final Color color;
  final String listUrl;
  const TimeZone({Key key,this.listUrl, this.url, this.color}) : super(key: key);

  @override
  _TimeZoneState createState() => _TimeZoneState();
}

class _TimeZoneState extends State<TimeZone> {

  Future<TimezoneModal> _data;
  var _data2;

  @override
  void initState() {
    _data = _getTime();
    _data2 = _getData();
    print(widget.url);
    super.initState();
  }


  Future<TimezoneModal> _getTime() async {
    try {
      final response = await http.get(Uri.parse(widget.url));
      if (response.statusCode == 200) {
        return TimezoneModal.fromJson(jsonDecode(response.body));
      }
      throw "${response.body}";
    }  catch (e) {
      print(e);
      return e;
    }
  }

  _getData() async {
    try {
      final response = await http.get(Uri.parse(widget.listUrl));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
      throw "${response.body}";
    }  catch (e) {
      print(e);
      return e;
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.color,
      body: SafeArea(
        child: widget.listUrl == null ?
        FutureBuilder(
          future: _data,
          builder: (BuildContext context, AsyncSnapshot<TimezoneModal> snapshot) {
            var dateUtc = snapshot?.data?.utcDatetime;
            String updatedDt;
            if(dateUtc == null) {
              return Center(child: CircularProgressIndicator());
            } else {
              var strToDateTime = DateTime.parse(dateUtc.toString());
              final convertLocal = strToDateTime.toLocal();
              var newFormat = DateFormat("yy-MM-dd hh:mm:ss aaa");
              updatedDt = newFormat.format(convertLocal);
            }
            if (snapshot.hasData) {
              if(_data == null) {
                return Text('No data');
              } else {
                return Center(
                  child: Column(
                    children: [
                      Text(snapshot.data.timezone.toString()),
                      Text(snapshot.data.dstFrom.toString()),
                      Text(snapshot.data.datetime.toString()),
                      Text(snapshot.data.dayOfWeek.toString()),
                      Text(snapshot.data.unixtime.toString()),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('In local Format  ${updatedDt.toString()}'),
                      ),
                    ],
                  ),
                );
              }
            } else {
              return Center(
                child: RefreshProgressIndicator(),
              );
            }
          },

        ) :
        FutureBuilder(
          future: _data2,
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if(snapshot.hasData) {
              List<JsonPlaceholderData> items = snapshot.data
                  ?.map<JsonPlaceholderData>((item) => JsonPlaceholderData.fromJson(item))
                  ?.toList();

              return Column(
                children: items?.map((e) =>
                Text(e.body),
                ).toList(),
              );
            } else {
              return Center(
                child: RefreshProgressIndicator(),
              );
            }
          },

        ),
      ),
    );
  }
}
