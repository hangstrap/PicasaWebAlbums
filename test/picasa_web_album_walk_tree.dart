import '../lib/picasa_web_albums.dart' ;
import 'dart:async';


void main(){
  User user = new User( "101488109748928583216");
  Future< List<Album>> albumsFuture = user.albums();

  
  void processAlbumList( List<Album> albums){
    
    processAlbum( Album album){
      print( album.title);
      
      processPhotoList( List<Photo> photos){
        
        processPhoto(Photo photo){
          print( "${album.title}  ${photo.title}");
        }
        
        photos.forEach( processPhoto);
      }
      album.photos.then( processPhotoList);
    }
    albums.forEach( processAlbum);
  }
  
  user.albums().then( processAlbumList);
}