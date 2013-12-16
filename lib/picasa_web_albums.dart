library picasa_web_album;
import "dart:io";
import 'package:json_object/json_object.dart';

class Photo{
  JsonObject json;
  Photo( this.json);

  factory Photo.fromJsonString(String jsonStr) {    
    return new Photo( new JsonObject.fromJsonString( jsonStr, new JsonObject()));
  }

}


class Album {
  
  JsonObject json;
  Album( this.json);
  
  String get title => json.title.$t;
  String get rights => json.rights.$t;
  
  List<Photo> get photos => json.photos;
  
  factory Album.fromJsonString(String jsonStr) {    
    return new Album( new JsonObject.fromJsonString( jsonStr, new JsonObject()));
  }
  
  String getAlumUri(){
    List<JsonObject> links = json.link;
    JsonObject link = links.firstWhere( (JsonObject e)=> e.rel.startsWith( "http://schemas"));
    return link.href;
  }
}

class UsersAlbums{

  List<Album> albums(){
    HttpClient client = new HttpClient();
  }
}