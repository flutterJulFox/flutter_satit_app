import 'package:audioplayers/audioplayers.dart';

class AudioPlay {
  final String path;

  AudioPlay({this.path});

  Future play ()async {
    print('now is playing: $path');
    AudioPlayer audioPlayer = AudioPlayer();
// Play Device file
//    await audioPlayer.play(path, isLocal: true);
// Play Remote file
    await audioPlayer.play(path, isLocal:  false);
    
  }
  

}