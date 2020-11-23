class Gallery{
  int id;
  String title;
  String uploader;
  String subtitle;
  String details;
  String imageUrl;
  String createdAt;
  String updatedAt;
  String deletedAt;
  int executedBy;

  Gallery({this.id, this.title, this.subtitle, this.details, this.imageUrl, this.uploader, this.createdAt, this.deletedAt, this.executedBy, this.updatedAt});

  Gallery.formMap(Map<String, dynamic> mapper){
    id = mapper['id'];
    title = mapper['title'];
    uploader = mapper['uploader'];
    subtitle = mapper['subtitle'];
    details = mapper['details'];
    imageUrl = mapper['image_url'];
    createdAt = mapper['created_at'];
    updatedAt = mapper['updated_at'];
    deletedAt = mapper['deleted_at'];
    executedBy = mapper['executed_by'];
  }
}