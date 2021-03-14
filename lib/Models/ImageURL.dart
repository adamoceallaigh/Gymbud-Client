class ImageURL {
  final String path;

  ImageURL(this.path);

  ImageURL.fromJson(Map<String, dynamic> json) : this.path = json["path"];
}
