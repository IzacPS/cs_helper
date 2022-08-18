import 'package:cs_helper/bloc/bloc/load_visualization_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SimulationScreen extends StatelessWidget {
  const SimulationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoadVisualizationBloc, LoadVisualizationState>(
      builder: (context, state) {
        
        return Container();
      },
    );
  }
}