import 'package:biongoweb/bingo.dart';
import 'package:biongoweb/screen/widget.dart';
import 'package:flutter/material.dart';

class BingoGameScreen extends StatefulWidget {
  const BingoGameScreen({super.key});

  @override
  State<BingoGameScreen> createState() => _BingoGameScreenState();
}

class _BingoGameScreenState extends State<BingoGameScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            spacing: 15,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: TopRow(),
              ),
              BingoBoard(),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  spacing: 10,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 80,
                      backgroundColor: Colors.yellow,
                      child: CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.deepOrange,
                        child: Text("data"),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text('check'),
                    ),
                    Column(
                      spacing: 10,
                      children: [
                        Container(
                          width: 150,
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.blue),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Center(
                            child: Row(
                              spacing: 3,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                    onTap: () => {},
                                    child: Text('Start New Game')),
                                Icon(Icons.gamepad),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: 150,
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.lime,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Center(
                            child: Row(
                              spacing: 3,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () => {},
                                  child: Text('Start'),
                                ),
                                Icon(Icons.play_arrow),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: 150,
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.blue),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Center(
                            child: Row(
                              spacing: 3,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Reset Board'),
                                Icon(Icons.refresh_rounded),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: 150,
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.blue),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Center(
                            child: Row(
                              spacing: 3,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Shuffle Board'),
                                Icon(Icons.shuffle_sharp),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      spacing: 10,
                      children: [
                        Row(
                          children: [
                            Text('speed:',
                                style: TextStyle(color: Colors.blue)),
                            const SizedBox(
                              width: 5,
                            ),
                            Icon(
                              Icons.speed,
                              color: Colors.blue,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text('slow'),
                            Slider(
                              value: 0.7,
                              onChanged: (double value) {},
                              activeColor: Colors.blue,
                            ),
                            Text('fast')
                          ],
                        ),
                        Row(
                          spacing: 10,
                          children: [
                            Text('Color:',
                                style: TextStyle(color: Colors.blue)),
                            Icon(Icons.color_lens, color: Colors.blue),
                            Container(
                              width: 150,
                              height: 35,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 4),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: DropdownButton<String>(
                                value:
                                    'defalut Color', // Default selected language
                                icon: Icon(Icons.arrow_drop_down,
                                    color: Colors.black),
                                underline:
                                    SizedBox(), // Remove the default underline
                                isExpanded: true,
                                style: TextStyle(color: Colors.black),
                                items: [
                                  'defalut Color',
                                  'orange',
                                  'red',
                                  'yellow'
                                ].map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value,
                                        style: TextStyle(color: Colors.black)),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {},
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      spacing: 10,
                      children: [
                        Row(
                          spacing: 10,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text("Second Pattern: ",
                                style: TextStyle(color: Colors.blue)),
                            Icon(
                              Icons.pattern,
                              color: Colors.blue,
                            ),
                            Row(
                              children: [
                                Checkbox(
                                    value: false, onChanged: (bool? value) {}),
                                Text("add"),
                              ],
                            ),
                            Row(
                              children: [
                                Text("bell:",
                                    style: TextStyle(color: Colors.blue)),
                                const SizedBox(width: 5),
                                Icon(Icons.ring_volume, color: Colors.blue)
                              ],
                            ),
                            Row(
                              children: [
                                Checkbox(
                                    value: false, onChanged: (bool? value) {}),
                                Text("enable"),
                              ],
                            )
                          ],
                        ),
                        Row(
                          spacing: 10,
                          children: [
                            Row(
                              spacing: 5,
                              children: [
                                Text('Speaker:',
                                    style: TextStyle(color: Colors.blue)),
                                Icon(Icons.speaker, color: Colors.blue),
                                Container(
                                  width: 150,
                                  height: 35,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 4),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: DropdownButton<String>(
                                    value:
                                        'English-Male', // Default selected language
                                    icon: Icon(Icons.arrow_drop_down,
                                        color: Colors.black),
                                    underline:
                                        SizedBox(), // Remove the default underline
                                    isExpanded: true,
                                    style: TextStyle(color: Colors.black),
                                    items: [
                                      'English-Male',
                                      'Englsih-Female',
                                      'Amhric-Male',
                                      'Amhric-Female'
                                    ].map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value,
                                            style:
                                                TextStyle(color: Colors.black)),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {},
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              spacing: 5,
                              children: [
                                Text('Pattern:',
                                    style: TextStyle(color: Colors.blue)),
                                Icon(Icons.pattern, color: Colors.blue),
                                Container(
                                  width: 150,
                                  height: 35,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 4),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: DropdownButton<String>(
                                    value:
                                        'default pattern', // Default selected language
                                    icon: Icon(Icons.arrow_drop_down,
                                        color: Colors.black),
                                    underline:
                                        SizedBox(), // Remove the default underline
                                    isExpanded: true,
                                    style: TextStyle(color: Colors.black),
                                    items: [
                                      'default pattern',
                                      'diagonal',
                                      'vertical',
                                      'horizontal'
                                    ].map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value,
                                            style:
                                                TextStyle(color: Colors.black)),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {},
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
