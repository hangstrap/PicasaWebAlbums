
import 'package:http/http.dart' as http;
import 'package:json_object/json_object.dart';
import "dart:async";


String myAlbum = "https://picasaweb.google.com/data/feed/api/user/101488109748928583216?alt=json";

//@proxy
abstract class Album{
  String myTitle;
}
//@proxy
class AlbumImpl extends JsonObject implements Album{


  
  AlbumImpl();

  String get myTitle => this.title.$t;  
  
  
  factory AlbumImpl.fromJsonString(string) {
    return new JsonObject.fromJsonString(string, new AlbumImpl());
  }
}

void main(){
  http.get( myAlbum ).then( (response){
    JsonObject json = new JsonObject.fromJsonString( response.body);
    Album album = new AlbumImpl.fromJsonString( json.feed.entry[0].toString());
    print( album.id);
    print( album.title);
    print( album.myTitle);
  });
}