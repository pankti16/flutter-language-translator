import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

class LangMenuItem {
  final int id;
  final String langLabel;
  final String langCode;

  LangMenuItem(this.id, this.langLabel, this.langCode);
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Language Translator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Language Translator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final translator = GoogleTranslator();
  
  Key textFieldOriginKey = const Key('TextFieldOrigin');
  Key textFieldDestinationKey = const Key('TextFieldDestination');
  Key dropDownOriginKey = const Key('DropDownOrigin');
  Key dropDownDestinationKey = const Key('DropDownDestination');

  final TextEditingController textFieldOriginController = TextEditingController();
  final TextEditingController textFieldDestinationController = TextEditingController();

  final List<LangMenuItem> languageList = [
    LangMenuItem(1, 'English', 'en'),
    LangMenuItem(2, 'Hindi', 'hi'),
    LangMenuItem(3, 'Gujarati', 'gu'),
    LangMenuItem(4, 'Arabic', 'ar'),
    LangMenuItem(5, 'Chinese(Simplified)', 'zh-Hans'),
    LangMenuItem(6, 'Chinese(Traditional)', 'zh-Hant'),
    LangMenuItem(7, 'Tamil', 'ta'),
    LangMenuItem(8, 'Telugu', 'te'),
    LangMenuItem(9, 'Marathi', 'mr'),
  ];

  late LangMenuItem originMenuItem;
  late LangMenuItem destinationMenuItem;

  @override
  void initState() {
    originMenuItem = languageList.first;
    destinationMenuItem = languageList.elementAt(1);
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    textFieldOriginController.dispose();
    textFieldDestinationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                height: 150.0,
                child: TextField(
                  key: textFieldOriginKey,
                  controller: textFieldOriginController,
                  expands: true,
                  minLines: null,
                  maxLines: null,
                  decoration: InputDecoration(
                    hintText: '${originMenuItem.langLabel} text',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    )
                  ),
                  onChanged: (String text) async {
                    if (text.isEmpty) return;
                    Translation translatedString = await translator.translate(text, from: originMenuItem.langCode, to: destinationMenuItem.langCode);
                    textFieldDestinationController.value = TextEditingValue(
                      text: translatedString.text.toString(),
                    );
                    // textFieldDestinationController.text = translatedString.text.toString();
                  },
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget> [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: DropdownButton(
                      key: dropDownOriginKey,
                      items: languageList.where((LangMenuItem val) => (val != destinationMenuItem))
                      .map((LangMenuItem val) => 
                        DropdownMenuItem(
                          value: val,
                          child: Text(val.langLabel, style: const TextStyle(fontSize: 10.0, color: Colors.black),),
                        ),
                      ).toList(),
                      onChanged: (item) {
                        setState(() {
                          originMenuItem = item!;
                        });
                      },
                      hint: Text(originMenuItem.langLabel),
                      style: const TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold,),
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward_rounded,
                    size: 15.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: DropdownButton(
                      key: dropDownDestinationKey,
                      items: languageList.where((LangMenuItem val) => (val != originMenuItem))
                      .map((LangMenuItem val) => 
                        DropdownMenuItem(
                          value: val,
                          child: Text(val.langLabel, style: const TextStyle(fontSize: 10.0, color: Colors.black),),
                        ),
                      ).toList(),
                      onChanged: (item) {
                        setState(() {
                          destinationMenuItem = item!;
                        });
                        textFieldOriginController.clear();
                        textFieldDestinationController.clear();
                      },
                      hint: Text(destinationMenuItem.langLabel),
                      style: const TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold,),
                    ),
                  ),
                ],
              ),
               const SizedBox(
                height: 10.0,
              ),
               Container(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                height: 150.0,
                child: TextField(
                  key: textFieldDestinationKey,
                  controller: textFieldDestinationController,
                  expands: true,
                  minLines: null,
                  maxLines: null,
                  decoration: InputDecoration(
                    hintText: '${destinationMenuItem.langLabel} text',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    )
                  ),
                  onChanged: (String text) async {
                    if (text.isEmpty) return;
                    Translation translatedString = await translator.translate(text, from: destinationMenuItem.langCode, to: originMenuItem.langCode);
                    textFieldOriginController.value = TextEditingValue(
                      text: translatedString.text.toString(),
                    );
                    // textFieldOriginController.text = translatedString.text.toString();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
