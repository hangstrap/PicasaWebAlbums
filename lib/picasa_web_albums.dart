library picasa_web_album;

import "dart:io";
import "dart:async";
import 'package:json_object/json_object.dart';
import 'package:http/http.dart' as http;

class Photo{
  JsonObject json;
  Photo( this.json);
  
  String get title => json.title.$t;
  String get url  => json.media$group.media$content[0].url;   

}


class Album {
  
  JsonObject json;
  Album( this.json);
  
  String get title => json.title.$t;
  String get rights => json.rights.$t;
  
  List<Photo> get photos => json.photos;
    
  
  String getAlumUri(){
    List<JsonObject> links = json.link;
    JsonObject link = links.firstWhere( (JsonObject e)=> e.rel.startsWith( "http://schemas"));
    return link.href;
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