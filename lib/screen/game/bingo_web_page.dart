import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:biongoweb/bingo_game_logic.dart';
import 'package:biongoweb/data.dart';
import 'package:biongoweb/screen/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class BingoWebPage extends StatefulWidget {
  const BingoWebPage({super.key});
  @override
  State<BingoWebPage> createState() => _BingoWebPageState();
}

class _BingoWebPageState extends State<BingoWebPage> {
  bool _startGame = false;
  List<String> isAnimated = [];
  TextEditingController betAmountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    final double _screenWidth = MediaQuery.of(context).size.width;
    // ignore: no_leading_underscores_for_local_identifiers
    final BingoGameLogicProvider _bingoGameProvider =
        Provider.of<BingoGameLogicProvider>(context);

    void _showBottomSheetForStartingGame() {
      showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white60,
              ),
              width: MediaQuery.of(context).size.width / 1.5,
              height: MediaQuery.of(context).size.height / 1.2,
              child: Padding(
                padding: const EdgeInsets.only(left: 30, right: 30, top: 30),
                child: Column(
                  mainAxisSize:
                      MainAxisSize.min, // Prevents unnecessary stretching
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Win Amount:",
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          _bingoGameProvider.winAmount.toString(),
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        reusableTextfield(
                          hintText: 'Bet Amount',
                          mainText: 'Bet Amount',
                          controller: betAmountController,
                        ),
                        SizedBox(width: 20), // Fix missing spacing attribute
                        gameType(context),
                      ],
                    ),
                    SizedBox(height: 20), // Adds spacing before grid
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Cancel'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (!_startGame &&
                                _bingoGameProvider.selectedCartela.isNotEmpty) {
                              _bingoGameProvider.startGame();
                              _bingoGameProvider.clear();
                              _startGame = true;
                              _bingoGameProvider.winAmountFunc(
                                betAmountController.text,
                              );
                              Navigator.pop(context);
                            }
                          },
                          child: Text('Done'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            _bingoGameProvider.clear();
                          },
                          child: Text('Clear'),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: Consumer<BingoGameLogicProvider>(
                        builder: (context, bingoGameLogicProvider, child) {
                          return GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 10,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                            ),
                            itemCount: 120,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  bingoGameLogicProvider.addCartela(index);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color:
                                        bingoGameLogicProvider.falseList[index]
                                            ? Colors.blueAccent
                                            : Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Center(
                                    child: Text(
                                      '${index + 1}',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          );
        },
      );
    }

    return Scaffold(
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
              child: TopRow(),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.teal.shade900,
                border: Border.all(
                  color: Colors.green,
                  width: 3,
                ),
              ),
              padding: const EdgeInsets.all(20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InfoCard(
                            textCall: "Calls",
                            color: Colors.white,
                            title: "Total",
                            value: '',
                          ),
                          SizedBox(width: 20),
                          InfoCard(
                            textCall: "Call",
                            color: Colors.white,
                            title: "Previous",
                            value: '',
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
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
                  SizedBox(width: 20),
                  Expanded(
                    child: GridView.count(
                      shrinkWrap: true,
                      crossAxisCount: 16,
                      children: List.generate(
                        numbers.length,
                        (index) {
                          // ignore: collection_methods_unrelated_type
                          final called = _bingoGameProvider
                              .isInCalled(numbers[index].toString());

                          if (called && isAnimated.contains(numbers[index])) {
                            return Container(
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: Colors.grey),
                              ),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text(
                                    int.parse(numbers[index]) >= 10
                                        ? numbers[index]
                                        : " ${numbers[index]}",
                                    style: TextStyle(
                                      fontSize: _screenWidth > 1320 ? 50 : 30,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          } else if (called) {
                            return DefaultTextStyle(
                              style: TextStyle(
                                fontSize: _screenWidth > 1320 ? 50 : 30,
                                color: Colors.grey,
                              ),
                              child: AnimatedTextKit(
                                totalRepeatCount: 3,
                                animatedTexts: [
                                  RotateAnimatedText(
                                    int.parse(numbers[index]) > 10
                                        ? numbers[index]
                                        : " ${numbers[index]} ",
                                    duration: Duration(milliseconds: 350),
                                  ),
                                ],
                                onFinished: () {
                                  setState(() {
                                    isAnimated.add(numbers[index]);
                                  });
                                },
                              ),
                            );
                          } else if (["B", "I", "N", "G", "O"]
                              .contains(numbers[index])) {
                            return Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: Colors.grey),
                              ),
                              child: Center(
                                child: Text(
                                  numbers[index],
                                  style: GoogleFonts.lato(
                                    fontSize: 26,
                                    decoration: TextDecoration.none,
                                    color: Colors.red,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ),
                            );
                          } else {
                            return Center(
                              child: Text(
                                numbers[index],
                                style: GoogleFonts.lato(
                                  fontSize: _screenWidth > 1000 ? 30 : 22,
                                  color: Colors.white,
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.normal,
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Row(
                    spacing: 15,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.amber,
                        radius: 60,
                        child: CircleAvatar(
                          backgroundColor: Colors.blue,
                          radius: 30,
                          child: Center(
                            child: Text(
                              _bingoGameProvider.calledNumber.toString(),
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      _checkbutton(context),
                      Column(
                        spacing: 10,
                        children: [
                          _button(
                            text: "Start New Game",
                            icon: Icons.games,
                            onTap: () {
                              _showBottomSheetForStartingGame();
                            },
                          ),
                          _button(
                            text: " Pause Game ",
                            icon: Icons.play_arrow,
                            onTap: () {
                              if (_startGame) {
                                _bingoGameProvider.togglePauseResume();
                              }
                            },
                          ),
                          _button(
                            text: "Reset Board",
                            icon: Icons.refresh_rounded,
                            onTap: () {
                              if (_startGame) {
                                _bingoGameProvider.resetBoard();
                                _startGame = false;
                                isAnimated = [];
                              }
                            },
                          ),
                          _button(
                            text: "Shuffle Board",
                            icon: Icons.shuffle_sharp,
                            onTap: () {},
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                _screenWidth.toString(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _button({
    required String text,
    required IconData icon,
    required Function()? onTap,
  }) {
    return ElevatedButton(
      onPressed: onTap,
      child: Row(
        spacing: 5,
        children: [
          Text(text),
          Icon(icon),
        ],
      ),
    );
  }
}

_checkbutton(BuildContext context) {
  return GestureDetector(
    onTap: () {
      _showBottomSheet(context);
    },
    child: Container(
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text("Check"),
      ),
    ),
  );
}

void _showBottomSheet(BuildContext context) {
  BingoGameLogicProvider _bingoGameProvider =
      Provider.of<BingoGameLogicProvider>(context, listen: false);
  TextEditingController textController = TextEditingController();
  showDialog(
    context: context,
    builder: (context) => Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: 600,
        height: 400,
        padding: EdgeInsets.all(16),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 200,
                    height: 60,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: textController,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          WidgetStateProperty.all(Colors.blueAccent),
                    ),
                    onPressed: () {
                      bool isWinner =
                          _bingoGameProvider.isWinner(textController.text);
                      if (isWinner) {
                        _bingoGameProvider.callNumber(76);
                      } else {
                        _bingoGameProvider.callNumber(77);
                      }
                    },
                    child: Text(
                      "Check",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            WidgetStateProperty.all(Colors.blueAccent)),
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      "Cancel",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Column reusableTextfield({
  required String hintText,
  required String mainText,
  required TextEditingController controller,
}) {
  return Column(
    children: [
      Text(mainText,
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold)),
      SizedBox(
        width: 300,
        child: TextField(
          keyboardType: TextInputType.number,
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.black),
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.blueAccent),
            ),
            contentPadding: EdgeInsets.symmetric(
              vertical: 15,
              horizontal: 20,
            ),
          ),
        ),
      ),
    ],
  );
}

Column reusableColumn({
  required String mainText,
  required int value,
  required VoidCallback onIncrease,
  required VoidCallback onDecrease,
}) {
  return Column(
    children: [
      Text(
        mainText,
        style: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(
        width: 300,
        child: Row(
          children: [
            // Decrease Button
            IconButton(
              onPressed: onDecrease,
              icon: Icon(Icons.remove, color: Colors.blueAccent),
            ),
            // Read-Only Display Field
            Expanded(
              child: TextField(
                readOnly: true,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.blueAccent),
                  ),
                ),
                controller: TextEditingController(text: value.toString()),
              ),
            ),
            // Increase Button
            IconButton(
              onPressed: onIncrease,
              icon: Icon(Icons.add, color: Colors.blueAccent),
            ),
          ],
        ),
      ),
    ],
  );
}

gameType(BuildContext context) {
  BingoGameLogicProvider bingoGameLogicProvider =
      Provider.of<BingoGameLogicProvider>(context);
  return Column(
    children: [
      Text(
        "Game Type",
        style: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(
        width: 300,
        child: SpinBox(
          decoration: InputDecoration(
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.blueAccent),
            ),
          ),
          min: 1,
          max: 5,
          value: 2,
          onChanged: (value) {
            bingoGameLogicProvider.gameTypeFunc(value.toInt());
          },
        ),
      ),
    ],
  );
}
