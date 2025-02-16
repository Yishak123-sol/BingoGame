import 'package:flutter/material.dart';

class BingoPage extends StatelessWidget {
  const BingoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 50,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          color: Colors.blue,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  spacing: 15,
                  children: [
                    Row(
                      spacing: 10,
                      children: [
                        Column(
                          spacing: 5,
                          children: [
                            Container(
                              height: 70,
                              width: 70,
                              color: Colors.black,
                              child: Text(
                                "",
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                            Text(
                              "Total Calls",
                              style: TextStyle(fontSize: 20),
                            )
                          ],
                        ),
                        Column(
                          spacing: 5,
                          children: [
                            Container(
                              height: 70,
                              width: 70,
                              color: Colors.black,
                              child: Text(
                                "",
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                            Text(
                              "Previous Call",
                              style: TextStyle(fontSize: 20),
                            )
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              children: [
                                Text("B"),
                                Text("I"),
                                Text("N"),
                                Text("G"),
                                Text("O"),
                              ],
                            ),
                          ),
                        ),
                        Column(children: [
                          Row(
                            children: [
                              Text('1'),
                              Text('2'),
                              Text('3'),
                              Text('4'),
                              Text('5'),
                              Text('6'),
                              Text('7'),
                              Text('8'),
                              Text('9'),
                              Text('10'),
                              Text('11'),
                              Text('12'),
                              Text('13'),
                              Text('14'),
                              Text('15'),
                            ],
                          ),
                          Row(
                            children: [
                              Text('16'),
                              Text('17'),
                              Text('18'),
                              Text('19'),
                              Text('20'),
                              Text('21'),
                              Text('22'),
                              Text('23'),
                              Text('24'),
                              Text('25'),
                              Text('26'),
                              Text('27'),
                              Text('28'),
                              Text('29'),
                              Text('30'),
                            ],
                          ),
                          Row(
                            children: [
                              Text('31'),
                              Text('32'),
                              Text('33'),
                              Text('34'),
                              Text('35'),
                              Text('36'),
                              Text('37'),
                              Text('38'),
                              Text('39'),
                              Text('40'),
                              Text('41'),
                              Text('42'),
                              Text('43'),
                              Text('44'),
                              Text('45'),
                            ],
                          ),
                          Row(
                            children: [
                              Text('46'),
                              Text('47'),
                              Text('48'),
                              Text('49'),
                              Text('50'),
                              Text('51'),
                              Text('52'),
                              Text('53'),
                              Text('54'),
                              Text('55'),
                              Text('56'),
                              Text('57'),
                              Text('58'),
                              Text('59'),
                              Text('60'),
                            ],
                          ),
                          Row(
                            children: [
                              Text('61'),
                              Text('62'),
                              Text('63'),
                              Text('64'),
                              Text('65'),
                              Text('66'),
                              Text('67'),
                              Text('68'),
                              Text('69'),
                              Text('70'),
                              Text('71'),
                              Text('72'),
                              Text('73'),
                              Text('74'),
                              Text('75'),
                            ],
                          )
                        ])
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
