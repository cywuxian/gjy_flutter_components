import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_components/picker/Picker.dart';
import 'package:flutter_components_example/widget/TitleWidget.dart';

class PickerView extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return PickerViewState();
  }

}

class PickerViewState extends State<PickerView> {

  String value = "2";
  String text = "ζ’¨ε­π";

  List<String> multipleColumnsSelectedValue = ["1", "18"];
  List<String> multipleColumnsSelectedText = ["ηθ", "ηΎπ"];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          TitleWidget(title: 'Picker ιζ©ε¨',),
          Padding(padding: const EdgeInsets.symmetric(horizontal: 15),
            child: FlatButton(
              child: Text('ε½εε·²ιοΌ$text'),
              onPressed: () {
                Picker.show(context, dataSource: {
                  "0": {
                    "1": "θΉζπ",
                    "2": "ζ’¨ε­π",
                    "3": "ζ‘ε­π"
                  },
                }, level: 1,
                  value: [value],
                  onConfirm: (values, texts) {
                    setState(() {
                      value = values.first;
                      text = texts.first;
                    });
                  }
                );
              },
            ),
          ),
          Padding(padding: const EdgeInsets.symmetric(horizontal: 15),
            child: FlatButton(
              child: Text('γcupertinoι£ζ Όγε½εε·²ιοΌ$text'),
              onPressed: () {
                Picker.show(context, dataSource: {
                  "0": {
                    "1": "θΉζπ",
                    "2": "ζ’¨ε­π",
                    "3": "ζ‘ε­π"
                  },
                }, level: 1,
                    value: [value],
                    onConfirm: (values, texts) {
                      setState(() {
                        value = values.first;
                        text = texts.first;
                      });
                    },
                    useCupertinoStyle: true
                );
              },
            ),
          ),
          Padding(padding: const EdgeInsets.symmetric(horizontal: 15),
            child: FlatButton(
              child: Text('γmaterialι£ζ Όγε½εε·²ιοΌ$text'),
              onPressed: () {
                Picker.show(context, dataSource: {
                  "0": {
                    "1": "θΉζπ",
                    "2": "ζ’¨ε­π",
                    "3": "ζ‘ε­π"
                  },
                }, level: 1,
                  value: [value],
                  onConfirm: (values, texts) {
                    setState(() {
                      value = values.first;
                      text = texts.first;
                    });
                  },
                  useCupertinoStyle: false
                );
              },
            ),
          ),
          Padding(padding: const EdgeInsets.symmetric(horizontal: 15),
            child: FlatButton(
              child: Text('ε€ειζ©οΌ${multipleColumnsSelectedText.join("/")}'),
              onPressed: () {
                Picker.show(context, dataSource: {
                  "0": {
                    "1": "ηθ",
                    "2": "ζεΊ§"
                  },
                  "1": {
                    "11": "ιΌ π­",
                    "12": "ηπ",
                    "13": "θπ―",
                    "14": "επ°",
                    "15": "ιΎπ²",
                    "16": "θπ",
                    "17": "ι©¬π",
                    "18": "ηΎπ",
                    "19": "η΄π",
                    "110": "ιΈ‘π",
                    "111": "ηπΆ",
                    "112": "ηͺπ·"
                  },
                  "2": {
                    "21": "η½ηΎεΊ§βοΈ",
                    "22": "ιηεΊ§βοΈ",
                    "23": "εε­εΊ§βοΈ",
                    "24": "ε·¨θΉεΊ§βοΈ",
                    "25": "η?ε­εΊ§βοΈ",
                    "26": "ε€ε₯³εΊ§βοΈ",
                    "27": "ε€©η§€εΊ§βοΈ",
                    "28": "ε€©θεΊ§βοΈ",
                    "29": "ε°ζεΊ§βοΈ",
                    "210": "ι­θεΊ§β",
                    "211": "ζ°΄ηΆεΊ§βοΈ",
                    "212": "ει±ΌεΊ§βοΈ"
                  }
                }, level: 2,
                    value: multipleColumnsSelectedValue,
                    onConfirm: (values, texts) {
                      setState(() {
                        multipleColumnsSelectedValue = values;
                        multipleColumnsSelectedText = texts;
                      });
                    },
                    useCupertinoStyle: true
                );
              },
            ),
          ),
          Padding(padding: const EdgeInsets.symmetric(horizontal: 15),
            child: FlatButton(
              child: Text('ε°εΊιζ©οΌ${multipleColumnsSelectedText.join("/")}'),
              onPressed: () {

                Picker.showChinaAreaPicker(context, onConfirm: (values, texts) {

                });
              },
            ),
          ),
        ],
      ),
    );
  }

}