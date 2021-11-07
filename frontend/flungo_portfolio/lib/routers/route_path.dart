class RoutePath {
  static const homePath = '/';
  static const unknownPath = 'NotFound404!';
  final bool _isUnknown;
  final String _pathName;
  final Map<String, String>? _parameters;

  RoutePath.home()
      : _isUnknown = false,
        _parameters = null,
        _pathName = homePath;

  RoutePath.unknown()
      : _isUnknown = true,
        _parameters = null,
        _pathName = unknownPath;

  RoutePath.page(this._pathName, this._parameters) : _isUnknown = false;

  bool get isHomePage => _pathName == homePath;

  bool get isOtherPage => _isUnknown == false && _pathName != homePath;

  bool get isUnknown => _isUnknown == true;

  String get pathName => _pathName;

  Map<String, String>? get uriQueryParameters => _parameters;
}
