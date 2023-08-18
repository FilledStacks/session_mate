import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:session_mate/session_mate.dart';

const String baseUrl = 'www.googleapis.com';
const String booksEndpoint = '/books/v1/volumes';

void main() async {
  await setupSessionMate();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SessionMate(
        child: MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<String> _topics = [
    'http',
    'dart',
    'flutter',
    'development',
    'patterns',
  ];

  final TextEditingController _controller = TextEditingController();

  int _counter = 0;
  String _topic = 'http';
  String _desc = '';

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  Future<void> _requestBooks() async {
    _incrementCounter();

    _topic = _topics[_counter % _topics.length];
    final url = Uri.https(baseUrl, booksEndpoint, {'q': '{$_topic}'});
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      final itemCount = jsonResponse['totalItems'];
      _desc = 'Number of books about $_topic: $itemCount.';
    } else {
      _desc = 'Request failed with status: ${response.statusCode}.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(_desc),
            TextField(controller: _controller),
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            onPressed: () => SessionMateUtils.saveSession(),
            tooltip: 'Save Session',
            backgroundColor: Colors.purple,
            child: const Icon(Icons.check),
          ),
          const SizedBox(width: 20),
          FloatingActionButton(
            onPressed: _requestBooks,
            tooltip: 'Request Books',
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
