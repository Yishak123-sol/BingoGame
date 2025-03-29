import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BingoPage extends StatefulWidget {
  const BingoPage({super.key});

  @override
  State<BingoPage> createState() => _BingoPageState();
}

class _BingoPageState extends State<BingoPage> {
  List<int> calls = [];
  List<int> board = List.generate(75, (index) => index + 1);
  bool isPaused = false;
  bool isGameRunning = false;
  final AudioPlayer _player = AudioPlayer();

  bool isWinner(List<List<int>> card, List<int> calledNumbers) {
    int size = 5;

    for (int i = 0; i < size; i++) {
      // ignore: avoid_types_as_parameter_names
      if (card[i].every((num) => calledNumbers.contains(num))) {
        return true;
      }
    }

    // Check columns
    for (int col = 0; col < size; col++) {
      bool columnWin = true;
      for (int row = 0; row < size; row++) {
        if (!calledNumbers.contains(card[row][col])) {
          columnWin = false;
          break;
        }
      }
      if (columnWin) return true;
    }

    // Check main diagonal
    bool mainDiagonalWin = true;
    for (int i = 0; i < size; i++) {
      if (!calledNumbers.contains(card[i][i])) {
        mainDiagonalWin = false;
        break;
      }
    }
    if (mainDiagonalWin) return true;

    // Check secondary diagonal
    bool secondaryDiagonalWin = true;
    for (int i = 0; i < size; i++) {
      if (!calledNumbers.contains(card[i][size - 1 - i])) {
        secondaryDiagonalWin = false;
        break;
      }
    }
    if (secondaryDiagonalWin) return true;

    return false;
  }

  Future<void> callNumber(int number) async {
    String filePath = 'assets/audio/english/$number.mp3';
    await _player.play(UrlSource(filePath));
  }

  Future<void> callFunc() async {
    Random random = Random();

    while (board.isNotEmpty && !isPaused) {
      int randomIndex = random.nextInt(board.length);
      int randomNumber = board[randomIndex];
      board.removeAt(randomIndex);
      await callNumber(randomNumber);
      setState(() {
        calls.add(randomNumber);
      });
      await Future.delayed(Duration(seconds: 2));

      if (isPaused) {
        break;
      }
    }
  }

  void togglePauseResume() {
    setState(() {
      if (isPaused) {
        isPaused = false;
        callFunc();
      } else {
        isPaused = true;
      }
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            children: [
              // CircleAvatar(
              //   radius: 30,
              // ),
              // TextField(
              //   decoration: InputDecoration(
              //     hintText: 'Win Amount',
              //     border: OutlineInputBorder(),
              //     labelText: 'Enter card number',
              //   ),
              // ),
            ],
          ),
          const SizedBox(
            height: 50,
          ),
          BingoBoard(),

          Row(
            children: [
              CircleAvatar(
                radius: 60,
                // backgroundImage: AssetImage("assets/images/bingo.png"),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("check", style: textStyle),
                ),
              )
            ],
          ),
          ElevatedButton(
            onPressed: () {
              if (!isGameRunning) {
                setState(() {
                  isGameRunning = true;
                });

                callFunc();
              }
              if (board.isEmpty) {
                setState(() {
                  board = List.generate(15, (index) => index + 1);
                });
                callFunc();
              }
            },
            child: Text("Start New Game"),
          ),
          ElevatedButton(
            onPressed: togglePauseResume,
            child: Text(isPaused ? "Start" : "Pause"),
          ),

          // ElevatedButton(
          //         onPressed: () {
          //           if (_controller.text.isEmpty ||
          //               int.tryParse(_controller.text) == null) {
          //             print("Please enter a valid card number");
          //             return;
          //           }
          //           int cardIndex = int.parse(_controller.text) - 1;
          //           if (cardIndex < 0 || cardIndex >= bingoCards.length) {
          //             print("Invalid card number");
          //             return;
          //           }

          //           bool iWinner = isWinner(bingoCards[cardIndex], calls);
          //           print("Winner: $iWinner");
          //         },
          //         child: Text("Check Bingo"),
          //       ),
        ],
      ),
    );
  }
}

class BingoBoard extends StatelessWidget {
  const BingoBoard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.teal.shade900,
        border: Border.all(color: Colors.green, width: 3),
      ),
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        child: Column(
          children: [
            Row(
              spacing: 10,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  spacing: 15,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      spacing: 20,
                      children: [],
                    ),
                    Container(
                      width: 150,
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Image(
                        fit: BoxFit.contain,
                        image: AssetImage("assets/gif/bingo1.gif"),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child:
                                  Text("B", style: textStyleForContainerText),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("1", style: textStyle),
                                Text("2", style: textStyle),
                                Text("3", style: textStyle),
                                Text("4", style: textStyle),
                                Text("5", style: textStyle),
                                Text("6", style: textStyle),
                                Text("7", style: textStyle),
                                Text("8", style: textStyle),
                                Text("9", style: textStyle),
                                Text("10", style: textStyle),
                                Text("11", style: textStyle),
                                Text("12", style: textStyle),
                                Text("13", style: textStyle),
                                Text("14", style: textStyle),
                                Text("15", style: textStyle),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child:
                                  Text("B", style: textStyleForContainerText),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("1", style: textStyle),
                                Text("2", style: textStyle),
                                Text("3", style: textStyle),
                                Text("4", style: textStyle),
                                Text("5", style: textStyle),
                                Text("6", style: textStyle),
                                Text("7", style: textStyle),
                                Text("8", style: textStyle),
                                Text("9", style: textStyle),
                                Text("10", style: textStyle),
                                Text("11", style: textStyle),
                                Text("12", style: textStyle),
                                Text("13", style: textStyle),
                                Text("14", style: textStyle),
                                Text("15", style: textStyle),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child:
                                  Text("B", style: textStyleForContainerText),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("1", style: textStyle),
                                Text("2", style: textStyle),
                                Text("3", style: textStyle),
                                Text("4", style: textStyle),
                                Text("5", style: textStyle),
                                Text("6", style: textStyle),
                                Text("7", style: textStyle),
                                Text("8", style: textStyle),
                                Text("9", style: textStyle),
                                Text("10", style: textStyle),
                                Text("11", style: textStyle),
                                Text("12", style: textStyle),
                                Text("13", style: textStyle),
                                Text("14", style: textStyle),
                                Text("15", style: textStyle),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child:
                                  Text("B", style: textStyleForContainerText),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("1", style: textStyle),
                                Text("2", style: textStyle),
                                Text("3", style: textStyle),
                                Text("4", style: textStyle),
                                Text("5", style: textStyle),
                                Text("6", style: textStyle),
                                Text("7", style: textStyle),
                                Text("8", style: textStyle),
                                Text("9", style: textStyle),
                                Text("10", style: textStyle),
                                Text("11", style: textStyle),
                                Text("12", style: textStyle),
                                Text("13", style: textStyle),
                                Text("14", style: textStyle),
                                Text("15", style: textStyle),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child:
                                  Text("B", style: textStyleForContainerText),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("1", style: textStyle),
                                Text("2", style: textStyle),
                                Text("3", style: textStyle),
                                Text("4", style: textStyle),
                                Text("5", style: textStyle),
                                Text("6", style: textStyle),
                                Text("7", style: textStyle),
                                Text("8", style: textStyle),
                                Text("9", style: textStyle),
                                Text("10", style: textStyle),
                                Text("11", style: textStyle),
                                Text("12", style: textStyle),
                                Text("13", style: textStyle),
                                Text("14", style: textStyle),
                                Text("15", style: textStyle),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

TextStyle? textStyle = GoogleFonts.monoton(
  fontSize: 26,
  decoration: TextDecoration.none,
  color: Colors.white,
  fontStyle: FontStyle.italic,
);

TextStyle? textStyleForContainerText = GoogleFonts.lato(
  fontSize: 35,
  decoration: TextDecoration.none,
  color: Colors.red,
  fontStyle: FontStyle.normal,
);
