import 'package:biongoweb/bingo_game_logic.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class TopRow extends StatefulWidget {
  const TopRow({
    super.key,
  });

  @override
  State<TopRow> createState() => _TopRowState();
}

class _TopRowState extends State<TopRow> {
  @override
  Widget build(BuildContext context) {
    Provider.of<BingoGameLogicProvider>(context);
    return Consumer<BingoGameLogicProvider>(
      builder: (context, bingoGameLogicProvider, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
              backgroundImage: AssetImage('assets/image/thumb.jpg'),
              radius: 30,
            ),
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    spacing: 5,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Checkbox(value: false, onChanged: (bool? value) {}),
                          Text('total'),
                          SizedBox(width: 10),
                          Checkbox(value: false, onChanged: (bool? value) {}),
                          Text('cards'),
                          SizedBox(width: 5),
                          Text(
                            '${bingoGameLogicProvider.winAmount} ETB',
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: 12,
                  top: -10, // To make it float on the border
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 4),
                    color: Colors.white, // Background to cover the border
                    child: Text(
                      'Win Amount',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              spacing: 10,
              children: [
                CircleAvatar(
                  radius: 15,
                  child: Icon(Icons.person),
                ),
                Icon(Icons.lock),
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text('Dashboard'),
                ),
                Container(
                  width: 130,
                  height: 40,
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: DropdownButton<String>(
                    value: 'English', // Default selected language
                    icon: Icon(Icons.arrow_drop_down, color: Colors.blue),
                    underline: SizedBox(), // Remove the default underline
                    isExpanded: true,
                    style: TextStyle(color: Colors.black),
                    items: ['English', 'Amharic', 'French', 'Spanish']
                        .map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child:
                            Text(value, style: TextStyle(color: Colors.black)),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {},
                  ),
                ),
              ],
            )
          ],
        );
      },
    );
  }
}

/////////
///
class InfoCard extends StatelessWidget {
  final String title;
  final String value;
  final String textCall;
  final Color color;

  const InfoCard({
    super.key,
    required this.textCall,
    required this.title,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      children: [
        Container(
          width: 80,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.black,
            border: Border.all(color: Colors.black, width: 2),
          ),
          child: Column(
            children: [
              Text(
                value,
                style: GoogleFonts.lato(
                  textStyle: Theme.of(context).textTheme.displayLarge,
                  fontSize: 22,
                  color: color,
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.normal,
                ),
              ),
            ],
          ),
        ),
        Column(
          children: [
            Text(
              title,
              style: GoogleFonts.lato(
                fontSize: 22,
                decoration: TextDecoration.none,
                fontWeight: FontWeight.bold,
                color: color,
                fontStyle: FontStyle.normal,
              ),
            ),
            Text(
              textCall,
              style: GoogleFonts.lato(
                fontSize: 22,
                decoration: TextDecoration.none,
                fontWeight: FontWeight.bold,
                color: color,
                fontStyle: FontStyle.normal,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
