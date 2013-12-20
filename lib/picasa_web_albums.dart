library picasa_web_album;

/*
 * A User has a set of Albums   -> url = https://picasaweb.google.com/data/feed/api/user/101488109748928583216
 * An Ablum has a ser of Photos -> url for each album = https://picasaweb.google.com/data/feed/api/user/101488109748928583216/albumid/5938894451891583841?alt=json
 */

import "dart:async";
import 'package:json_object/json_object.dart';
import 'package:http/http.dart' as http;

class Photo{
  JsonObject json;
  Photo( this.json);
  
  String get title => json.title.$t;
  String get summary => json.summary.$t;
  String url( {imgmax:'d'}){
    if( imgmax=='d'){
      return json.media$group.media$content[0].url;
    }else{
      String defaultUrl = url(); 
      return defaultUrl.replaceFirst("/d", "/s${imgmax}");
    }
  }

}


class Album {
  
  JsonObject json;
  Album( this.json);
  
  String get title => json.title.$t;
  String get rights => json.rights.$t;
  
  Future<List<Photo>> get photos{
    
    String url = getAlbumUri();
    return http.get( url ).then( (response){
      
      List<Photo> result = [];
      
      JsonObject json = new JsonObject.fromJsonString( response.body);
      List<JsonObject> jsonEntries = json.feed.entry;
      jsonEntries.forEach( (e)=> result.add( new Photo( e)));
      
      return result;
    });
  }
    
  
  String getAlbumUri(){
    List<JsonObject> links = json.link;
    JsonObject link = links.firstWhere( (JsonObject e)=> e.rel.startsWith( "http://schemas"));
    return "${link.href}&imgmax=d";
  }
}

  
class User{
  
  String id;
  User( this.id);
      
  List<Album> loadFromJson( JsonObject json){       
    
    List<JsonObject> entries = json.feed.entry;
    List<Album> result = [];
    entries.forEach( (e)=> result.add( new Album( e)));
    return result;
  }


  Future<List<Album>> albums(){
    String myAlbum = "https://picasaweb.google.com/data/feed/api/user/${id}?alt=json";
    return http.get( myAlbum ).then( (response){
      JsonObject json = new JsonObject.fromJsonString( response.body);
      return loadFromJson( json);
    });    
  }
}