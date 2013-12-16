import 'package:json_object/json_object.dart';
import '../lib/picasa_web_albums.dart' ;
import 'package:unittest/unittest.dart';
import 'dart:io';
import 'dart:async';

void main(){
  group( "When loading from precanned json data", (){
    
    test( "should load album from json",() {
      Album album = new Album( getJsonForAlbum());
      expect( album.title, equals( "Tessa d\'Jappervilla"));
      expect( album.rights, equals( "public"));
      expect( album.getAlumUri(), equals( "https://picasaweb.google.com/data/feed/api/user/101488109748928583216/albumid/5938894451891583841?alt=json"));
    });
    
    test( "should load photo from json", (){
      Photo photo = new Photo( getJsonForPhoto());
      expect( photo.title, equals( "2013-10-26 09.36.22.jpg"));
      expect( photo.url, equals( "https://lh4.googleusercontent.com/-GGLasOTPgxk/UmsxCvL-zfI/AAAAAAAATno/wP-1Ql82kIs/2013-10-26%25252009.36.22.jpg"));
    });
    
    test("should load albums from json object", (){        
      List<Album> albums = new User("aa").loadFromJson( getJsonForUser());
      expect( albums.length, equals( 85));
      expect( albums.first.title, equals( "Tessa d\'Jappervilla"));
      expect( albums.last.title, equals( "Mana Island"));
    });
  });  
  
  group( "When loading from actual web service", (){
    
    User user ;
    setUp((){
      user = new User( "101488109748928583216");
    });
    
    test( "should return at least the current number of my albums", (){
      User user = new User( "101488109748928583216");
      Future< List<Album>> albumsFuture = user.albums();
      expect( albumsFuture.then( (albums)=> albums.length), completion( greaterThanOrEqualTo( 85)));      
    });
    test( "should return my first album correctly", (){
      User user = new User( "101488109748928583216");
      Future< List<Album>> albumsFuture = user.albums();
      expect( albumsFuture.then( (albums)=> albums.first.title), completion( equals( 'Tessa d\'Jappervilla')));      
    });
    test("", (){
      user.albums().then( (albums) => albums.forEach( (album)=>print( "${album.title} ${album.rights}")));
    });
  });
  
  
}

JsonObject getJsonForPhoto() {
  return new JsonObject.fromJsonString( new File(  "photo.json").readAsStringSync());
}


JsonObject getJsonForAlbum(){
  return new JsonObject.fromJsonString( new File(  "album.json").readAsStringSync());  
}


JsonObject getJsonForUser(){
  return new JsonObject.fromJsonString( new File(  "user.json").readAsStringSync(), new JsonObject())  ;
}
