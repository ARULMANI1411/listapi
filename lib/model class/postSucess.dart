class Success {
  bool? success;

  Success({this.success});

  Success.fromJson(Map<String, dynamic> json) {
    success = json['success'] ?? false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    return data;
  }
}