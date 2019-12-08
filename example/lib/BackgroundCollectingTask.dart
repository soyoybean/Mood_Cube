import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:scoped_model/scoped_model.dart';
import 'home_page.dart';

class BackgroundCollectingTask extends Model {
  static BackgroundCollectingTask of(BuildContext context,
          {bool rebuildOnChange = false}) =>
      ScopedModel.of<BackgroundCollectingTask>(context,
          rebuildOnChange: rebuildOnChange);

  final BluetoothConnection _connection;
  List<int> _buffer = List<int>();

  bool inProgress;

  BackgroundCollectingTask._fromConnection(this._connection) {
    _connection.input.listen((data) {
      if (data.contains(82)) {
        HomePageState.setRed();
        HomePageState.result[0]++;
        print('green:');
        print(HomePageState.greenCount);
        print('blue:');
        print(HomePageState.blueCount);
        HomePageState.update();
        HomePageState.setColor();
      }

      if (data.contains(71)) {
        HomePageState.setGreen();
        HomePageState.result[1]++;
        print('red:');
        print(HomePageState.redCount);
        print('blue:');
        print(HomePageState.blueCount);
        HomePageState.update();
        HomePageState.setColor();
      }

      if (data.contains(66)) {
        HomePageState.setBlue();
        HomePageState.result[2]++;
        print('red:');
        print(HomePageState.redCount);
        print('green:');
        print(HomePageState.greenCount);
        HomePageState.update();
        HomePageState.setColor();
      }
    });
  }

  static Future<BackgroundCollectingTask> connect(
      BluetoothDevice server) async {
    final BluetoothConnection connection =
        await BluetoothConnection.toAddress(server.address);
    return BackgroundCollectingTask._fromConnection(connection);
  }

  void dispose() {
    _connection.dispose();
  }

  Future<void> start() async {
    inProgress = true;
    _buffer.clear();
    notifyListeners();
    _connection.output.add(ascii.encode('start'));
    await _connection.output.allSent;
  }

  Future<void> cancel() async {
    inProgress = false;
    notifyListeners();
    _connection.output.add(ascii.encode('stop'));
    await _connection.finish();
  }

  Future<void> pause() async {
    inProgress = false;
    notifyListeners();
    _connection.output.add(ascii.encode('stop'));
    await _connection.output.allSent;
  }

  Future<void> reasume() async {
    inProgress = true;
    notifyListeners();
    _connection.output.add(ascii.encode('start'));
    await _connection.output.allSent;
  }
}
