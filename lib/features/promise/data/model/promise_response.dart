class PromiseResponse {
  Promise? promise;

  PromiseResponse({this.promise});

  PromiseResponse.fromJson(Map<String, dynamic> json) {
    promise =
    json['promise'] != null ? new Promise.fromJson(json['promise']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.promise != null) {
      data['promise'] = this.promise!.toJson();
    }
    return data;
  }
}

class Promise {
  String? id;
  String? fromUserId;
  Null? toUserId;
  String? toPhone;
  String? text;
  String? dueAt;
  String? status;
  String? createdAt;
  Null? completedAt;
  Null? remindedAt;

  Promise(
      {this.id,
        this.fromUserId,
        this.toUserId,
        this.toPhone,
        this.text,
        this.dueAt,
        this.status,
        this.createdAt,
        this.completedAt,
        this.remindedAt});

  Promise.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fromUserId = json['from_user_id'];
    toUserId = json['to_user_id'];
    toPhone = json['to_phone'];
    text = json['text'];
    dueAt = json['due_at'];
    status = json['status'];
    createdAt = json['created_at'];
    completedAt = json['completed_at'];
    remindedAt = json['reminded_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['from_user_id'] = this.fromUserId;
    data['to_user_id'] = this.toUserId;
    data['to_phone'] = this.toPhone;
    data['text'] = this.text;
    data['due_at'] = this.dueAt;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['completed_at'] = this.completedAt;
    data['reminded_at'] = this.remindedAt;
    return data;
  }
}
