import '../lib/picasa_web_albums.dart';
import 'package:unittest/unittest.dart';
import 'dart:io';

void main(){
  
  test( "Load album from json",() {
    Album album = new Album.fromJsonString( getJsonForAlbum());
    expect( album.title, equals( "Tessa d\'Jappervilla"));
    expect( album.rights, equals( "public"));
    expect( album.getAlumUri(), equals( "https://picasaweb.google.com/data/feed/api/user/101488109748928583216/albumid/5938894451891583841?alt=json"));
  });
}


String getJsonForAlbum(){
  return new File(  "album.json").readAsStringSync();  
}

