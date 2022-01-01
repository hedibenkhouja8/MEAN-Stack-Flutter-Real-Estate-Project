import 'package:flutter/material.dart';
import 'package:mobile/model/agent.dart';

//import 'package:mobile/utils/rent_list.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:mobile/page/rent_detail.dart';

class AgentPage extends StatefulWidget {
  const AgentPage({Key? key}) : super(key: key);

  @override
  _AgentPageState createState() => _AgentPageState();
}

class _AgentPageState extends State<AgentPage> {
  final String url ='http://localhost:3000/agents';
  List<dynamic> _agents = [];
  bool loading = true;

  @override
  void initState() {
    getAgents();
    super.initState();
  }

  Future<void> getAgents() async {
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final parsedData = jsonDecode(response.body).cast<Map<String, dynamic>>();
      _agents = parsedData.map<Agent>((json) => Agent.fromJson(json)).toList();
      setState(() {
        loading = !loading;
      });
    } else {
      throw Exception('Failed to load rents');
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    //drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFF545D68)),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text('Agents',
            style: TextStyle(
                fontFamily: 'Varela',
                fontSize: 20.0,
                color: Color(0xFF545D68))),
      ),
      body: loading ? waitingScreen() : agentsList());

  Widget waitingScreen() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[
          Text("Loading data ..."),
          Padding(padding: EdgeInsets.only(bottom: 25)),
          CircularProgressIndicator()
        ],
      ),
    );
  }

  Widget agentsList() {
    return ListView.builder(
        itemCount: _agents.length,
        itemBuilder: (context, index) {
          Agent agent = _agents[index];
          return Container(
            margin: const EdgeInsets.all(2.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[cardBuild(agent)],
            ),
          );
        });
  }

  Widget cardBuild(Agent agent) {
    return Card(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0))),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          ListTile(
            leading: Container(
        height: 100,
        width: 100,
        child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(8.0)),
              child: Image.asset(agent.image,
                 fit: BoxFit.fill),
            )),
            title: Text(
              agent.name,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            subtitle: Text("${agent.phone}"),


          ),
          ButtonTheme(
            // make buttons use the appropriate styles for cards
              child: ButtonBar(children: <Widget>[
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => RentDetail(
                          rent: agent,
                        )));
                  },
                  child: const Text(
                    "more Details",
                    style: TextStyle(color: Color.fromRGBO(212, 202, 104, 1)),
                  ),
                )
              ]))
        ],
      ),
    );
  }
}