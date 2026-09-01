import 'package:flutter_tts/flutter_tts.dart';
import 'package:space_anywhere/core/constants/app_constants.dart';

class FlutterTtsHelper {
  final _player = FlutterTts();

  static const error =
      "Caso o botão de áudio não reproduza o som, "
      "aguarde alguns minutos e selecione novamente o idioma. "
      "Se, mesmo assim, o áudio não for reproduzido, será necessário instalar "
      "manualmente a voz do idioma selecionado em seu dispositivo.";

  Future<void> init() async {
    await _player.setVolume(1.0);
    await _player.setSpeechRate(0.5);
    await _player.setLanguage(defaultLangFlag);
  }

  Future<void> setLanguage({required String langFlag}) async {
    await _player.setLanguage(langFlag);
  }

  Future<void> play({required String translation}) async {
    await _player.stop();
    await _player.speak(translation);
  }
}
