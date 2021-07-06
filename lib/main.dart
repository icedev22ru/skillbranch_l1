import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  BodyPart? defendingBodyPart;
  BodyPart? attackingBodyPart;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(213, 222, 240, 1),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 35),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(child: Center(child: Text("You"))),
                Expanded(child: Center(child: Text("Enemy"))),
              ],
            ),
            Column(
              children: [
                SizedBox(height: 11),
                Row(children: [
                  Expanded(child: Center(child: Text("1"))),
                  Expanded(child: Center(child: Text("1"))),
                ]),
                Row(children: [
                  Expanded(child: Center(child: Text("1"))),
                  Expanded(child: Center(child: Text("1"))),
                ]),
                Row(children: [
                  Expanded(child: Center(child: Text("1"))),
                  Expanded(child: Center(child: Text("1"))),
                ]),
                Row(children: [
                  Expanded(child: Center(child: Text("1"))),
                  Expanded(child: Center(child: Text("1"))),
                ]),
                Row(children: [
                  Expanded(child: Center(child: Text("1"))),
                  Expanded(child: Center(child: Text("1"))),
                ]),
              ],
            ),
            Expanded(child: SizedBox()),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  children: [
                    Text("Defend".toUpperCase()),
                    SizedBox(height: 14),
                    BodyPartButton(
                      selected: defendingBodyPart == BodyPart.head,
                      bodyPart: BodyPart.head,
                      bodyPartSetter: _selectDefendingBodyPart,
                    ),
                    SizedBox(height: 14),
                    BodyPartButton(
                      bodyPart: BodyPart.torso,
                      selected: defendingBodyPart == BodyPart.torso,
                      bodyPartSetter: _selectDefendingBodyPart,
                    ),
                    SizedBox(height: 14),
                    BodyPartButton(
                      bodyPart: BodyPart.legs,
                      selected: defendingBodyPart == BodyPart.legs,
                      bodyPartSetter: _selectDefendingBodyPart,
                    ),
                    SizedBox(height: 14),
                  ],
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  children: [
                    Text("Attack".toUpperCase()),
                    SizedBox(height: 14),
                    BodyPartButton(
                      bodyPart: BodyPart.head,
                      selected: attackingBodyPart == BodyPart.head,
                      bodyPartSetter: _selectAttackingBodyPart,
                    ),
                    SizedBox(height: 14),
                    BodyPartButton(
                      bodyPart: BodyPart.torso,
                      selected: attackingBodyPart == BodyPart.torso,
                      bodyPartSetter: _selectAttackingBodyPart,
                    ),
                    SizedBox(height: 14),
                    BodyPartButton(
                      bodyPart: BodyPart.legs,
                      selected: attackingBodyPart == BodyPart.legs,
                      bodyPartSetter: _selectAttackingBodyPart,
                    ),
                    SizedBox(height: 14)
                  ],
                ),
              ),
              SizedBox(width: 16)
            ]),
            SizedBox(
              height: 14,
            ),
            Row(children: [
              SizedBox(
                width: 16,
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    if (defendingBodyPart != null &&
                        attackingBodyPart != null) {
                      setState(() {
                        defendingBodyPart = null;
                        attackingBodyPart = null;
                      });
                    }
                  },
                  child: ColoredBox(
                      color:
                          defendingBodyPart == null || attackingBodyPart == null
                              ? Colors.black38
                              : Colors.black87,
                      child: SizedBox(
                        height: 40,
                        child: Center(
                            child: Text(
                          "Go".toUpperCase(),
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                              fontSize: 16),
                        )),
                      )),
                ),
              ),
              SizedBox(
                width: 16,
              ),
            ]),
            SizedBox(
              height: 16,
            )
          ],
        ),
      ),
    );
  }

  _selectDefendingBodyPart(final BodyPart value) {
    setState(() {
      defendingBodyPart = value;
    });
  }

  _selectAttackingBodyPart(final BodyPart value) {
    setState(() {
      attackingBodyPart = value;
    });
  }
}

class BodyPart {
  final String name;

  const BodyPart._(this.name);
  static const head = BodyPart._("Head");
  static const torso = BodyPart._("Torso");
  static const legs = BodyPart._("Legs");

  String toString() {
    return 'BodyPart:{name:$name}';
  }
}

class BodyPartButton extends StatelessWidget {
  final BodyPart bodyPart;
  final bool selected;
  final ValueSetter<BodyPart> bodyPartSetter;

  BodyPartButton(
      {Key? key,
      required this.bodyPart,
      required this.selected,
      required this.bodyPartSetter})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          bodyPartSetter(bodyPart);
        },
        child: ColoredBox(
            color: selected
                ? const Color.fromRGBO(28, 121, 206, 1)
                : Colors.black38,
            child: SizedBox(
              height: 40,
              child: Center(child: Text(bodyPart.name.toUpperCase())),
            )));
  }
}
