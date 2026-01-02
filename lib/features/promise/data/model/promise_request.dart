class PromiseRequest {
  String? text;
  String? toPhone;
  String? toName;
  String? dueAt;

  PromiseRequest({this.text, this.toPhone, this.toName, this.dueAt});

  PromiseRequest.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    toPhone = json['toPhone'];
    toName = json['toName'];
    dueAt = json['dueAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['text'] = this.text;
    data['toPhone'] = this.toPhone;
    data['toName'] = this.toName;
    data['dueAt'] = this.dueAt;
    return data;
  }
}
