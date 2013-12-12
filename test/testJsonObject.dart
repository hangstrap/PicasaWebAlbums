
import 'package:json_object/json_object.dart';
@proxy
abstract class Language {
  String language;
  List targets;
  Map website;
}

/** Implementation class extends JsonObject, and uses the structure
 *  defined by implementing the Language abstract class. 
 *  JsonObject's noSuchMethod() function provides the actual underlying
 *  implementation.
 */
@proxy
class LanguageImpl extends JsonObject implements Language {
  LanguageImpl(); 
  
  factory LanguageImpl.fromJsonString(string) {
    return new JsonObject.fromJsonString(string, new LanguageImpl());
  }
}
void main (){
  
  
  
}