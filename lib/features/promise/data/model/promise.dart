class Promise {
  String? text;
  String? toPhone;
  String? toName;
  String? dueAt;

  Promise({this.text, this.toPhone, this.toName, this.dueAt});

  Promise.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    toPhone = json['toPhone'];
    toName = json['toName'];
    dueAt = json['dueAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['text'] = text;
    data['toPhone'] = toPhone;
    data['toName'] = toName;
    data['dueAt'] = dueAt;
    return data;
  }
}
