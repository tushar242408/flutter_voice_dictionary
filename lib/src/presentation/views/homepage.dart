import 'dart:convert';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:task1/src/data/network/search_data.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);



  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

bool _load =false;

  var _speechData;
  SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = '';

  @override
  void initState() {
    super.initState();
    _initSpeech();
  }


  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }


  void _startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult);
    setState(() {});
  }

  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});

  }

  void _onSpeechResult(SpeechRecognitionResult result)async {
    setState(() {
      _load=false;
    });
      _lastWords = result.recognizedWords;


   _speechData=await ApiHandler().getData(_lastWords);
   await Future.delayed(Duration(
     seconds: 1,
   ));
setState(() {
  _load=true;
});
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Center(child: const Text('PingoLearn-Round 1')),
      ),
      body: Center(

        child: Column(
          children: [
            SizedBox(height: 20,),
            _lastWords==''?Text(
              // If listening is active show the recognized words
              _speechToText.isListening
                  ? 'Your word:\n$_lastWords'
                  : _speechEnabled
                  ? 'Press the button to start speaking'
                  : 'Speech not available',
              style: const TextStyle(
                fontSize:28,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ):Text(
              'Your word:\n$_lastWords',
              style: TextStyle(
                fontSize:23,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            _load?_speechData!=null?
            Column(
              children: [
                _textBlock('Meaning','${_speechData.definitions![0].definition??''}'),
                _textBlock('Example','${_speechData.definitions![0].example??''}'),




                '${_speechData.definitions![0].imageUrl}'!='null'?   Container(
                    child: Image.network('${_speechData.definitions![0].imageUrl}',height: 150,
                      width: 150,fit: BoxFit.fill,)):Container(
                  child: Image.asset('assets/images/image_not_found.png',height: 150,
                    width: 150,fit: BoxFit.fill,),),
                    ],
                  ):

            Container(
              child: Image.asset('assets/images/image_not_found.png',height: 150,
                width: 150,fit: BoxFit.fill,),
            ):Container(),

              ],
            )

      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AvatarGlow(
        animate: _speechToText.isListening ,
        glowColor: Theme.of(context).primaryColor,
        endRadius: 75.0,
        duration: const Duration(milliseconds: 2000),
        repeatPauseDuration: const Duration(milliseconds: 100),
        repeat: true,
        child: FloatingActionButton(
          onPressed:  _speechToText.isNotListening ? _startListening : _stopListening,
          child: Icon(_speechToText.isNotListening  ? Icons.mic : Icons.mic_none),
        ),
      ),
    );
  }
  Widget _textBlock(String title,String data){
    return Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.black12.withOpacity(0.04),
      ),
      child: Column(
        children: [
           Text(title, style: const TextStyle(
            fontSize:20,
            fontWeight: FontWeight.w700,
          ),
            textAlign: TextAlign.center,),
          Text(data, style: const TextStyle
            (
            fontSize:17,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w300,
          ),
            textAlign: TextAlign.center,),

        ],
      ),
    );
  }

}
