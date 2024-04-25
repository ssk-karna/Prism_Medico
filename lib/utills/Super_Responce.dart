class SuperResponse<T> {
  int status;
  String? message;
  String? title;
  T data;

  SuperResponse({required this.status,  this.message,  this.title, required this.data});

  factory SuperResponse.fromJson(Map<dynamic, dynamic> json, T t) {
    return SuperResponse<T>(
        status: json['status'],
        message: json['msg'],
        title: json['title'],
        data: t);
  }
}
