class ResponseModel {
  final String _message;
  final bool _isSuccessful;
  // This give us ti get the data...
  // Private variable cant be wrap inside a curly braces ...
  ResponseModel(this._isSuccessful, this._message);

  // in other to make the private variable public....
  String get message => _message;
  bool get isSuccessful => _isSuccessful;
}
