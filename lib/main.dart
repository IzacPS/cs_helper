import 'package:cs_helper/cs/tm/turing_machine.dart';
import 'package:flutter/material.dart';

void main() {
  var t = TuringMachine<String, String>();
  t.emptySymbol = "␣";
  t.addStates("q1,q2,q3,q4,q5,q6,q7,q8,qaccept,qreject".split(","));
  t.addInputAlphabet("0,1,#".split(","));
  t.addTapeAlphabet("0,1,#,X".split(","));
  t.setAcceptState("qaccept");    
  t.setRejectState("qreject");
  t.setStartState("q1");

  var list = [
      TransitionData(from: "q1", symbolFromTape: "0", to: "q2", symbolToWriteOnTape: "X", headDirection: HeadDirection.right),
      TransitionData(from: "q1", symbolFromTape: "#", to: "q8", symbolToWriteOnTape: "#", headDirection: HeadDirection.right),
      TransitionData(from: "q1", symbolFromTape: "1", to: "q3", symbolToWriteOnTape: "X", headDirection: HeadDirection.right),

      TransitionData(from: "q2", symbolFromTape: "0", to: "q2", symbolToWriteOnTape: "0", headDirection: HeadDirection.right),
      TransitionData(from: "q2", symbolFromTape: "1", to: "q2", symbolToWriteOnTape: "1", headDirection: HeadDirection.right),
      TransitionData(from: "q2", symbolFromTape: "#", to: "q4", symbolToWriteOnTape: "#", headDirection: HeadDirection.right),

      TransitionData(from: "q3", symbolFromTape: "0", to: "q3", symbolToWriteOnTape: "0", headDirection: HeadDirection.right),
      TransitionData(from: "q3", symbolFromTape: "1", to: "q3", symbolToWriteOnTape: "1", headDirection: HeadDirection.right),
      TransitionData(from: "q3", symbolFromTape: "#", to: "q5", symbolToWriteOnTape: "#", headDirection: HeadDirection.right),

      TransitionData(from: "q4", symbolFromTape: "X", to: "q4", symbolToWriteOnTape: "X", headDirection: HeadDirection.right),
      TransitionData(from: "q4", symbolFromTape: "0", to: "q6", symbolToWriteOnTape: "X", headDirection: HeadDirection.left),

      TransitionData(from: "q5", symbolFromTape: "X", to: "q5", symbolToWriteOnTape: "X", headDirection: HeadDirection.right),
      TransitionData(from: "q5", symbolFromTape: "1", to: "q6", symbolToWriteOnTape: "X", headDirection: HeadDirection.left),

      TransitionData(from: "q6", symbolFromTape: "0", to: "q6", symbolToWriteOnTape: "0", headDirection: HeadDirection.left),
      TransitionData(from: "q6", symbolFromTape: "1", to: "q6", symbolToWriteOnTape: "1", headDirection: HeadDirection.left),
      TransitionData(from: "q6", symbolFromTape: "X", to: "q6", symbolToWriteOnTape: "X", headDirection: HeadDirection.left),
      TransitionData(from: "q6", symbolFromTape: "#", to: "q7", symbolToWriteOnTape: "#", headDirection: HeadDirection.left),

      TransitionData(from: "q7", symbolFromTape: "0", to: "q7", symbolToWriteOnTape: "0", headDirection: HeadDirection.left),
      TransitionData(from: "q7", symbolFromTape: "1", to: "q7", symbolToWriteOnTape: "1", headDirection: HeadDirection.left),
      TransitionData(from: "q7", symbolFromTape: "X", to: "q1", symbolToWriteOnTape: "X", headDirection: HeadDirection.right),

      TransitionData(from: "q8", symbolFromTape: "X", to: "q8", symbolToWriteOnTape: "X", headDirection: HeadDirection.right),
      TransitionData(from: "q8", symbolFromTape: "␣", to: "qaccept", symbolToWriteOnTape: "␣", headDirection: HeadDirection.right)    
  ];
  t.setupTransition(list);
  var input = ["0","1","#","0","1"];
  t.addInput(input);

  while(true){
      var currentState = t.nextStep();
      debugPrint(currentState.toString());
      if(currentState?.whereItsNow == "qaccept" || currentState?.whereItsNow == "qreject") break;
  }

  while(true){
      var data = t.previousStep();
    if(data == null){
      break;
    }
      debugPrint(data.toString());
  }

  while(true){
      var currentState = t.nextStep();
      debugPrint(currentState.toString());
      if(currentState?.whereItsNow == "qaccept" || currentState?.whereItsNow == "qreject") break;
  }
  //runApp(const MyApp());
}

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         // This is the theme of your application.
//         //
//         // Try running your application with "flutter run". You'll see the
//         // application has a blue toolbar. Then, without quitting the app, try
//         // changing the primarySwatch below to Colors.green and then invoke
//         // "hot reload" (press "r" in the console where you ran "flutter run",
//         // or simply save your changes to "hot reload" in a Flutter IDE).
//         // Notice that the counter didn't reset back to zero; the application
//         // is not restarted.
//         primarySwatch: Colors.blue,
//       ),
//       home: const MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key, required this.title}) : super(key: key);

//   // This widget is the home page of your application. It is stateful, meaning
//   // that it has a State object (defined below) that contains fields that affect
//   // how it looks.

//   // This class is the configuration for the state. It holds the values (in this
//   // case the title) provided by the parent (in this case the App widget) and
//   // used by the build method of the State. Fields in a Widget subclass are
//   // always marked "final".

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;

//   void _incrementCounter() {
//     setState(() {
//       // This call to setState tells the Flutter framework that something has
//       // changed in this State, which causes it to rerun the build method below
//       // so that the display can reflect the updated values. If we changed
//       // _counter without calling setState(), then the build method would not be
//       // called again, and so nothing would appear to happen.
//       _counter++;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     // This method is rerun every time setState is called, for instance as done
//     // by the _incrementCounter method above.
//     //
//     // The Flutter framework has been optimized to make rerunning build methods
//     // fast, so that you can just rebuild anything that needs updating rather
//     // than having to individually change instances of widgets.
//     return Scaffold(
//       appBar: AppBar(
//         // Here we take the value from the MyHomePage object that was created by
//         // the App.build method, and use it to set our appbar title.
//         title: Text(widget.title),
//       ),
//       body: Center(
//         // Center is a layout widget. It takes a single child and positions it
//         // in the middle of the parent.
//         child: Column(
//           // Column is also a layout widget. It takes a list of children and
//           // arranges them vertically. By default, it sizes itself to fit its
//           // children horizontally, and tries to be as tall as its parent.
//           //
//           // Invoke "debug painting" (press "p" in the console, choose the
//           // "Toggle Debug Paint" action from the Flutter Inspector in Android
//           // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
//           // to see the wireframe for each widget.
//           //
//           // Column has various properties to control how it sizes itself and
//           // how it positions its children. Here we use mainAxisAlignment to
//           // center the children vertically; the main axis here is the vertical
//           // axis because Columns are vertical (the cross axis would be
//           // horizontal).
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headline4,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }
