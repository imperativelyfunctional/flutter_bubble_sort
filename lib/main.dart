import 'dart:math';

import 'package:clay_containers/widgets/clay_container.dart';
import 'package:clay_containers/widgets/clay_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tex/flutter_tex.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.deepPurple,
    ),
    home: const BubbleSort(),
  ));
}

class BubbleSort extends StatefulWidget {
  const BubbleSort({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _BubbleSortWidget();
  }
}

const defaultBackgroundColor = Color(0xFFFFFFFF);
const highlightedBackgroundColor = Color(0xFFA9E4F3);
const completedBackgroundColor = Color(0xFF9EEC50);
const defaultTextColor = Colors.deepPurple;
const completedTextColor = Colors.orange;

class _BubbleSortWidget extends State<BubbleSort> {
  static const int maxInt = 1000;
  final List<CellModel> numbers = List.generate(
      8,
      (index) => CellModel(
          number: Random().nextInt(maxInt),
          backgroundColor: defaultBackgroundColor,
          textColor: defaultTextColor));

  @override
  Widget build(BuildContext context) {
    var unit = (MediaQuery.of(context).size.width - 70) / 8;
    return Scaffold(
      appBar: AppBar(
        title: RichText(
          text: TextSpan(
            style: const TextStyle(fontSize: 20),
            children: [
              TextSpan(
                  text: '轻松搞懂数据结构和算法',
                  style: GoogleFonts.zcoolKuaiLe(color: Colors.yellowAccent)),
              TextSpan(
                  text: '【',
                  style:
                      GoogleFonts.zcoolKuaiLe(color: Colors.deepOrangeAccent)),
              TextSpan(
                  text: '排序系列',
                  style: GoogleFonts.zcoolKuaiLe(color: Colors.blue)),
              TextSpan(
                  text: '】',
                  style:
                      GoogleFonts.zcoolKuaiLe(color: Colors.deepOrangeAccent))
            ],
          ),
        ),
      ),
      backgroundColor: const Color(0xFFF2F2F2),
      body: Stack(children: [
        GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 40,
            crossAxisSpacing: 0.5,
            mainAxisSpacing: 0.5,
          ),
          itemCount: 5000,
          itemBuilder: (context, index) {
            return Container(
              color: Colors.white70,
            );
          },
        ),
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40),
                  child: Text(
                    'Bubble Sort - 🫧冒泡排序',
                    style: GoogleFonts.actor(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Colors.orange),
                  )),
              ConstrainedBox(
                  constraints: BoxConstraints(minHeight: unit, maxHeight: unit),
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: numbers.length,
                      itemBuilder: (context, index) {
                        var cell = numbers[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: ClayContainer(
                            emboss: false,
                            color: cell.backgroundColor,
                            height: unit,
                            width: unit,
                            child: Center(
                              child: FittedBox(
                                child: ClayText(cell.number.toString(),
                                    emboss: true, color: cell.textColor),
                              ),
                            ),
                          ),
                        );
                      })),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            for (var i = 0; i < 8; i++) {
                              numbers[i] = CellModel(
                                  number: Random().nextInt(maxInt),
                                  backgroundColor: defaultBackgroundColor,
                                  textColor: defaultTextColor);
                            }
                          });
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.lightGreen),
                        ),
                        child: const Text('隨機生成數字')),
                    ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.blue),
                        ),
                        onPressed: () async {
                          var length = numbers.length;
                          for (int i = 0; i < length - 1; i++) {
                            for (int j = 0; j < length - 1 - i; j++) {
                              for (int m = 0; m < length; m++) {
                                numbers[m].backgroundColor = (m < length - i)
                                    ? defaultBackgroundColor
                                    : completedBackgroundColor;
                                numbers[m].textColor = (m < length - i)
                                    ? defaultTextColor
                                    : completedTextColor;
                              }
                              await Future.delayed(
                                  const Duration(seconds: 1), () {
                                setState(() {
                                  numbers[j].backgroundColor =
                                      highlightedBackgroundColor;
                                  numbers[j + 1].backgroundColor =
                                      highlightedBackgroundColor;
                                });
                              });

                              await Future.delayed(
                                  const Duration(seconds: 1), () {
                                setState(() {
                                  if (numbers[j].number >
                                      numbers[j + 1].number) {
                                    var tmp = numbers[j];
                                    numbers[j] = numbers[j + 1];
                                    numbers[j + 1] = tmp;
                                  }
                                });
                              });
                            }
                          }
                          setState(() {
                            numbers[1].backgroundColor =
                                completedBackgroundColor;
                            numbers[1].textColor = completedTextColor;
                          });
                          await Future.delayed(
                              const Duration(milliseconds: 500), () {
                            setState(() {
                              numbers[0].backgroundColor =
                                  completedBackgroundColor;
                              numbers[0].textColor = completedTextColor;
                            });
                          });
                        },
                        child: const Text('展示排序演示'))
                  ],
                ),
              ),
              TeXView(
                  child: _teXViewWidget(
                      r"<h4>Run time complexity</h4>", r"""<p>    
              <center> <h3>操作次數</h3></center>
             $$ (𝑛−1)+(𝑛−2)+...+2+1=\frac{𝑛(𝑛−1)}{2}  $$
        <table width="100%">
          <td>
               <center><h3>算法運行時間</h3></center>
    <center>$$ O(n^2) $$</center><br>
          </td>
                    <td>
               <center><h3>空間複雜度</h3></center>
    <center>$$ O(1) $$</center><br>
          </td>
        </table>
    </p>"""))
            ],
          ),
        ),
      ]),
    );
  }
}

TeXViewWidget _teXViewWidget(String title, String body) {
  return TeXViewColumn(
      style: const TeXViewStyle(
          margin: TeXViewMargin.all(5),
          padding: TeXViewPadding.all(5),
          borderRadius: TeXViewBorderRadius.all(5),
          border: TeXViewBorder.all(TeXViewBorderDecoration(
              borderWidth: 2,
              borderStyle: TeXViewBorderStyle.groove,
              borderColor: Colors.green))),
      children: [
        TeXViewDocument(title,
            style: const TeXViewStyle(
                padding: TeXViewPadding.all(5),
                borderRadius: TeXViewBorderRadius.all(5),
                textAlign: TeXViewTextAlign.center,
                width: 250,
                margin: TeXViewMargin.zeroAuto(),
                backgroundColor: Colors.amber)),
        TeXViewDocument(body,
            style: const TeXViewStyle(margin: TeXViewMargin.only(top: 10)))
      ]);
}

extension Sort on List<int> {
  void bubbleSort() {
    for (int i = 0; i < length - 1; i++) {
      for (int j = 0; j < length - 1 - i; j++) {
        if (this[j] > this[j + 1]) {
          int tmp = this[j];
          this[j] = this[j + 1];
          this[j + 1] = tmp;
        }
      }
    }
  }
}

class CellModel {
  int number;
  Color backgroundColor;
  Color textColor;

  CellModel(
      {required this.number,
      required this.backgroundColor,
      required this.textColor});
}
