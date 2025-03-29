import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:biongoweb/apivariable.dart';
import 'package:flutter/material.dart';

class BingoGameLogicProvider with ChangeNotifier {
  List<int> calledNumberList = [];
  List<int> board = List.generate(75, (index) => index + 1);
  bool isPaused = false;
  bool end = false;
  int calledNumber = 0;
  bool isGameRunning = false;
  List<String> isAnimated = [];
  final AudioPlayer _player = AudioPlayer();
  List<bool> falseList = List.filled(120, false);
  List<int> selectedCartela = [];
  int gameType = 20;
  double winAmount = 0.0;

  bool isWinner(String text) {
    int idx = int.tryParse(text) ?? 0;
    if (idx == 0) return false;
    List<List<int>> card = bingoCards[idx - 1];
    int size = 5;
    for (int i = 0; i < size; i++) {
      // ignore: avoid_types_as_parameter_names
      if (card[i].every((num) => calledNumberList.contains(num))) {
        return true;
      }
    }

    // Check columns
    for (int col = 0; col < size; col++) {
      bool columnWin = true;
      for (int row = 0; row < size; row++) {
        if (!calledNumberList.contains(card[row][col])) {
          columnWin = false;
          break;
        }
      }
      if (columnWin) return true;
    }

    // Check main diagonal
    bool mainDiagonalWin = true;
    for (int i = 0; i < size; i++) {
      if (!calledNumberList.contains(card[i][i])) {
        mainDiagonalWin = false;
        break;
      }
    }

    if (mainDiagonalWin) return true;
    bool secondaryDiagonalWin = true;
    for (int i = 0; i < size; i++) {
      if (!calledNumberList.contains(card[i][size - 1 - i])) {
        secondaryDiagonalWin = false;
        break;
      }
    }
    if (secondaryDiagonalWin) return true;
    return false;
  }

  Future<void> callNumber(int number) async {
    String filePath = 'assets/audio/amharic/$number.mp3';
    await _player.play(UrlSource(filePath));
    notifyListeners();
  }

  Future<void> startGame() async {
    Random random = Random();
    end = false;
    notifyListeners();
    while (board.isNotEmpty && !isPaused) {
      int randomIndex = random.nextInt(board.length);
      int randomNumber = board[randomIndex];
      board.removeAt(randomIndex);
      calledNumber = randomNumber;
      await callNumber(randomNumber);
      calledNumberList.add(randomNumber);
      await Future.delayed(
        Duration(seconds: 3),
      );
      if (isPaused) {
        break;
      }
      if (end) {
        break;
      }
    }
    notifyListeners();
  }

  void togglePauseResume() {
    if (isPaused) {
      isPaused = false;
      startGame();
    } else {
      isPaused = true;
    }
    notifyListeners();
  }

  resetBoard() {
    board = List.generate(75, (index) => index + 1);
    calledNumberList = [];
    end = true;
    isPaused = false;
    notifyListeners();
  }

  ////helper
  ////
  ////
  ////

  bool isInCalled(String num) {
    final dynamic check = calledNumberList.contains(int.tryParse(num));
    if (check != null && check == true) {
      return true;
    } else {
      return false;
    }
  }

  void addCartela(int idx) {
    falseList[idx] = !falseList[idx];
    if (selectedCartela.contains(idx)) {
      selectedCartela.remove(idx);
    } else {
      selectedCartela.add(idx);
    }
    notifyListeners();
  }

  void clear() {
    for (int i = 0; i < falseList.length; i++) {
      falseList[i] = false;
    }
    notifyListeners();
  }

  void winAmountFunc(String betAmount) {
    int betA = int.tryParse(betAmount) ?? 0;

    if (betA != 0) {
      double winAmountss = (betA * selectedCartela.length * gameType) / 100;
      winAmount = winAmountss;
    }
    notifyListeners();
  }

  void gameTypeFunc(int gameT) {
    gameType = gameT * 10;
    notifyListeners();
  }
}
