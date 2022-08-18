import 'package:cs_helper/cs/common/pair.dart';
import 'package:cs_helper/cs/common/triple.dart';

class Node<E,Q>{
  Q? stateLabel;


        // read value -> where to go, value to write, direction
  Map<E,Triple<Q,E,HeadDirection>> transitions = {};

  Triple<Q,E,HeadDirection>? transit(E? symbol){
    return (symbol == null) ? null : transitions[symbol];
  }

  Node({this.stateLabel});
}

class MachineStep<E,Q>{
  MachineStep<E,Q>? previousStep;
  Node<E,Q>? state;
  int head = 0;
  E? headValue;
}


enum HeadDirection {
  none,
  left,
  right
}

extension HeadDirectionExtension on HeadDirection {
  String get data {
    switch (this) {
      case HeadDirection.left:
        return 'L';
      case HeadDirection.right:
        return 'R';
      default:
        return '';
    }
  }
}

class TransitionData<E,Q>{
  final Q from;
  final E symbolFromTape;
  final Q to;
  final E symbolToWriteOnTape;
  final HeadDirection headDirection;
  TransitionData({
    required this.from,
    required this.symbolFromTape,
    required this.to,
    required this.symbolToWriteOnTape,
    required this.headDirection,
  }); 

  @override
  String toString() {
    return '$from, $symbolFromTape --> $to, $symbolToWriteOnTape, $headDirection';
  }
}

class CurrentStateData<E,Q>{
    Q? whereItWas;
    E? symbolRead;
    Q? whereItsNow;
    E? symbolWrote;
    HeadDirection? headDirection;
    int headPosition;

  CurrentStateData({
    required this.whereItWas,
    required this.symbolRead,
    required this.whereItsNow,
    required this.symbolWrote,
    required this.headDirection,
    required this.headPosition
  });

    @override
  String toString() {
    return '$whereItWas, $symbolRead --> $whereItsNow, $symbolWrote, $headDirection';
  }
}

class PreviousData<E,Q>{
  Q was;
  Q now;
  E previousHeadValue;
  HeadDirection previousHeadDirection;
  int headPosition;
  PreviousData({
    required this.was,
    required this.now,
    required this.previousHeadValue,
    required this.previousHeadDirection,
    required this.headPosition
  });
}

extension ListExtension on List{
  toStringNewLine(){
    String str = String.fromCharCodes([]);
    forEach((element) {
      str += '${element.toString()}\n';
    });
    return str;
  }
}

extension SetExtension on Set{
  toStringWithComma(){
    String str = String.fromCharCodes([]);
    forEach((element) {
      str += '${element.toString()},';
    });
    return str;
  }
}

extension MapExtension on Map{
  toStringWithComma(){
    String str = String.fromCharCodes([]);
    forEach((key, value) {
      str += '${key.toString()},';
    });
    return str;
  }
} 

class TuringMachine<E,Q>{
  int setupFlag = 0;
  int head = 0;
  List<E?> tape = [];
  Map<Q, Node<E,Q>> states = {};
  Set<E> inputAlphabet = {};
  Set<E> tapeAlphabet = {};
  Q? startState;
  Q? acceptState;
  Q? rejectState;
  E? emptySymbol;
  Node<E,Q>? currentState;
  MachineStep<E,Q>? machineStep;

  setStartState(Q? state){
    currentState = states[state];
    startState = currentState?.stateLabel;
    setupFlag = setupFlag | 8;
  }
  setAcceptState(Q? state){
    acceptState = state;
    setupFlag = setupFlag | 16;
  }
  setRejectState(Q? state){
    rejectState = state;
    setupFlag = setupFlag | 32;
  }

  addStates(List<Q> s){
    for (var element in s) { 
      states[element] = Node(stateLabel: element);
    }
    if(s.isNotEmpty) setupFlag = setupFlag | 1;
  }
  addInputAlphabet(List<E> a){
    for (var element in a){
      inputAlphabet.add(element);
    }
    if(a.isNotEmpty) setupFlag = setupFlag | 2;
  }
  addTapeAlphabet(List<E> t){
    for(var element in t){
      tapeAlphabet.add(element);
    }
    if(t.isNotEmpty) setupFlag = setupFlag | 4;
  }
  isMachineready() => (setupFlag == 255);
  setIsReady(bool i){
    setupFlag = (i) ? 255 : setupFlag;
  }
  setupTransition(List<TransitionData<E,Q>> t){
    for(var element in t){
      states[element.from]?.transitions[element.symbolFromTape] = Triple(t0: element.to, t1: element.symbolToWriteOnTape, t2: element.headDirection);
    }
    if(t.isNotEmpty) setupFlag = setupFlag | 128;
  }
  resetMachine(){
    tape.clear();
    currentState = states[startState];
    head = 0;
    machineStep = null;
  }
  addInput(List<E> i){
    resetMachine();
    tape = i;
    tape.add(emptySymbol);
  }
  String getVizFormat(){
    String vizStr = "digraph finite_state_machine { fontname=\"Helvetica,Arial,sans-serif\" node [fontname=\"Helvetica,Arial,sans-serif\"] edge [fontname=\"Helvetica,Arial,sans-serif\"] rankdir=LR; node [shape = point ]; start; ";

    vizStr += "node [shape = doublecircle]; ${acceptState.toString()}; ";

    vizStr += "node [shape = circle]; ";

    Map<Pair<Q,Q>, List<String>>  transStr = {};

    states.forEach((key, value) {
      value.transitions.forEach((key1, value1) {
        var pair = Pair(p0: key, p1: value1.t0);
        if(transStr[pair] == null) transStr[pair] = [];
        transStr[pair]?.add('$key1 -> ${value1.t1},${value1.t2.data}');
       });      
     });

    transStr.forEach((key, value) { 
      vizStr += "${key.p0.toString()} -> ${key.p1.toString()} [label = \"${value.toStringNewLine()}\"]; ";
    });

    vizStr += "start -> ${startState?.toString()}; ";

    vizStr +="}";

    return vizStr;
  }

  CurrentStateData<E,Q>? nextStep(){// : {
    if(currentState?.stateLabel == acceptState ||
        currentState?.stateLabel == rejectState ||
        head < 0 ||
            tape.isEmpty){
        return null;
    }

    var cur = currentState?.stateLabel;
    var curHead = tape[head];
    var data = currentState?.transit(tape[head]);

    var step = MachineStep<E,Q>();

    step.state = currentState;
    step.head = head;
    step.headValue = curHead;

    if(machineStep == null) {
      machineStep = step;
    } else{
      step.previousStep = machineStep;
      machineStep = step;
    }
    var wroteHeadPosition = head;
    if(data == null){
      currentState = states[rejectState];
      return CurrentStateData(
        whereItWas: cur, 
        symbolRead: curHead, 
        whereItsNow: currentState?.stateLabel, 
        symbolWrote: null, 
        headDirection: null, 
        headPosition: wroteHeadPosition);
    }
    tape[head] = data.t1;// second

    currentState = states[data.t0];

    switch(data.t2){
      case HeadDirection.left:{
        head--;
        break;
      }
      case HeadDirection.right:{
        head++;
        break;
      } 
      case HeadDirection.none:
        break;
    }

    return CurrentStateData(
      whereItWas: cur, 
      symbolRead: curHead, 
      whereItsNow: data.t0, 
      symbolWrote: data.t1, 
      headDirection: data.t2, 
      headPosition: wroteHeadPosition);
    }

    PreviousData<E,Q>? previousStep(){
      if(machineStep != null){
        var currentHead = head;
        var previousHead = machineStep?.head;
        var prev = currentState?.stateLabel;
        var now = machineStep?.state?.stateLabel;
        var previousHeadValue = machineStep?.headValue;
        currentState = machineStep?.state;
        head = machineStep!.head;
        tape[head] = machineStep?.headValue;
        machineStep = machineStep?.previousStep;
        var headPreviousDirection = (currentHead > previousHead!) ? HeadDirection.left : HeadDirection.right;
      }
      return null;
    }

    hasMachineHalted(){
      return currentState?.stateLabel == acceptState || currentState?.stateLabel == rejectState;
    }
}