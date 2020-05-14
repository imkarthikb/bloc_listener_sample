import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toast/toast.dart';

import '../blocs/bloc.dart';

class FirstScreen extends StatefulWidget {
  FirstScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: BlocListener<ValueUpdaterBloc, ValueUpdaterState>(
        bloc: BlocProvider.of<ValueUpdaterBloc>(context),
        listener: (ctx, state) {
          if (state.substate is ValueUpdationFailedState) {
            Toast.show(
                (state.substate as ValueUpdationFailedState).errorMessage,
                context);
          }

          if (state.substate is ValueUpdatingState) {
            if ((state.substate as ValueUpdatingState).type ==
                ValueUpdationType.increment) {
              Toast.show('Incrementing the value', context);
            } else if ((state.substate as ValueUpdatingState).type ==
                ValueUpdationType.decrement) {
              Toast.show('Decrementing the value', context);
            }
          }

          if (state.substate is ValueUpdatedState) {
            if (state.currentValue == 6) {
              // May navigate to another screen.
            }
          }
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Current Value :',
              ),
              _valueWidget(),
            ],
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            onPressed: _decrementCounter,
            tooltip: 'Decrement',
            child: Icon(Icons.remove),
          ),
          SizedBox(
            width: 16,
          ),
          FloatingActionButton(
            onPressed: _incrementValue,
            tooltip: 'Increment',
            child: Icon(Icons.add),
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  _valueWidget() {
    return BlocBuilder<ValueUpdaterBloc, ValueUpdaterState>(
      bloc: BlocProvider.of<ValueUpdaterBloc>(context),
      builder: (ctx, state) {
        return Text(
          '${state.currentValue.toString()}',
          style: Theme.of(context).textTheme.headline4,
        );
      },
    );
  }

  _incrementValue() {
    BlocProvider.of<ValueUpdaterBloc>(context).add(IncrementEvent());
  }

  _decrementCounter() {
    BlocProvider.of<ValueUpdaterBloc>(context).add(DecrementEvent());
  }
}
