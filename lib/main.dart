// import 'package:cs_helper/cs/tm/turing_machine.dart';
import 'package:cs_helper/widgets/turing_machine/turing_machine_screen.dart';
import 'package:flutter/material.dart';

void main() {
  // var t = TuringMachine<String, String>();
  // t.emptySymbol = "␣";
  // t.addStates("q1,q2,q3,q4,q5,q6,q7,q8,qaccept,qreject".split(","));
  // t.addInputAlphabet("0,1,#".split(","));
  // t.addTapeAlphabet("0,1,#,X".split(","));
  // t.setAcceptState("qaccept");
  // t.setRejectState("qreject");
  // t.setStartState("q1");

  // var list = [
  //     TransitionData(from: "q1", symbolFromTape: "0", to: "q2", symbolToWriteOnTape: "X", headDirection: HeadDirection.right),
  //     TransitionData(from: "q1", symbolFromTape: "#", to: "q8", symbolToWriteOnTape: "#", headDirection: HeadDirection.right),
  //     TransitionData(from: "q1", symbolFromTape: "1", to: "q3", symbolToWriteOnTape: "X", headDirection: HeadDirection.right),

  //     TransitionData(from: "q2", symbolFromTape: "0", to: "q2", symbolToWriteOnTape: "0", headDirection: HeadDirection.right),
  //     TransitionData(from: "q2", symbolFromTape: "1", to: "q2", symbolToWriteOnTape: "1", headDirection: HeadDirection.right),
  //     TransitionData(from: "q2", symbolFromTape: "#", to: "q4", symbolToWriteOnTape: "#", headDirection: HeadDirection.right),

  //     TransitionData(from: "q3", symbolFromTape: "0", to: "q3", symbolToWriteOnTape: "0", headDirection: HeadDirection.right),
  //     TransitionData(from: "q3", symbolFromTape: "1", to: "q3", symbolToWriteOnTape: "1", headDirection: HeadDirection.right),
  //     TransitionData(from: "q3", symbolFromTape: "#", to: "q5", symbolToWriteOnTape: "#", headDirection: HeadDirection.right),

  //     TransitionData(from: "q4", symbolFromTape: "X", to: "q4", symbolToWriteOnTape: "X", headDirection: HeadDirection.right),
  //     TransitionData(from: "q4", symbolFromTape: "0", to: "q6", symbolToWriteOnTape: "X", headDirection: HeadDirection.left),

  //     TransitionData(from: "q5", symbolFromTape: "X", to: "q5", symbolToWriteOnTape: "X", headDirection: HeadDirection.right),
  //     TransitionData(from: "q5", symbolFromTape: "1", to: "q6", symbolToWriteOnTape: "X", headDirection: HeadDirection.left),

  //     TransitionData(from: "q6", symbolFromTape: "0", to: "q6", symbolToWriteOnTape: "0", headDirection: HeadDirection.left),
  //     TransitionData(from: "q6", symbolFromTape: "1", to: "q6", symbolToWriteOnTape: "1", headDirection: HeadDirection.left),
  //     TransitionData(from: "q6", symbolFromTape: "X", to: "q6", symbolToWriteOnTape: "X", headDirection: HeadDirection.left),
  //     TransitionData(from: "q6", symbolFromTape: "#", to: "q7", symbolToWriteOnTape: "#", headDirection: HeadDirection.left),

  //     TransitionData(from: "q7", symbolFromTape: "0", to: "q7", symbolToWriteOnTape: "0", headDirection: HeadDirection.left),
  //     TransitionData(from: "q7", symbolFromTape: "1", to: "q7", symbolToWriteOnTape: "1", headDirection: HeadDirection.left),
  //     TransitionData(from: "q7", symbolFromTape: "X", to: "q1", symbolToWriteOnTape: "X", headDirection: HeadDirection.right),

  //     TransitionData(from: "q8", symbolFromTape: "X", to: "q8", symbolToWriteOnTape: "X", headDirection: HeadDirection.right),
  //     TransitionData(from: "q8", symbolFromTape: "␣", to: "qaccept", symbolToWriteOnTape: "␣", headDirection: HeadDirection.right)
  // ];
  // t.setupTransition(list);
  // var input = ["0","1","#","0","1"];
  // t.addInput(input);

  // while(true){
  //     var currentState = t.nextStep();
  //     debugPrint(currentState.toString());
  //     if(currentState?.whereItsNow == "qaccept" || currentState?.whereItsNow == "qreject") break;
  // }
  // debugPrint('\n');
  // while(true){
  //     var data = t.previousStep();
  //   if(data == null){
  //     break;
  //   }
  //     debugPrint(data.toString());
  // }

  // debugPrint('\n');
  // while(true){
  //     var currentState = t.nextStep();
  //     debugPrint(currentState.toString());
  //     if(currentState?.whereItsNow == "qaccept" || currentState?.whereItsNow == "qreject") break;
  // }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(),
        drawer: Drawer(
          child: SingleChildScrollView(
            child: Column(
              children: [
                //menu here
                ListTile(
                  title: Text('Automatos Finitos'),
                ),
                ListTile(
                  title: Text('Gramáticas e Linguagens'),
                ),
                ListTile(
                  title: Text('Máquinas de Turing'),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => TuringMachineScreen()));
                  },
                ),
                ListTile(
                  title: Text('Compiladores'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
