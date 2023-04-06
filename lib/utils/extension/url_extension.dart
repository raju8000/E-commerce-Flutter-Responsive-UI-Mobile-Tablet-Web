import 'dart:convert';

extension UrlExtension on Map{
  Map<String,String>? get encode => {"parameter" : json.encode(this)};

  Map<String,dynamic> get decode => json.decode(this['parameter']);
}