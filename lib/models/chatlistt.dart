class chatlistt {
  String? result;
  String? message;
  List<FinalMurged>? finalMurged;

  chatlistt({this.result, this.message, this.finalMurged});

  chatlistt.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    message = json['message'];
    if (json['finalMurged'] != null) {
      finalMurged = <FinalMurged>[];
      json['finalMurged'].forEach((v) {
        finalMurged!.add(FinalMurged.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['result'] = result;
    data['message'] = message;
    if (finalMurged != null) {
      data['finalMurged'] = finalMurged!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FinalMurged {
  String? iD;
  String? fname;
  String? lname;
  String? mobileNumber;
  String? image;
  String? shopName;
  String? text;
  int? status;
  int? sendStatus;
  String? createdAt;
  String? updatedAt;
  int? msgCount;

  FinalMurged(
      {this.iD,
        this.fname,
        this.lname,
        this.mobileNumber,
        this.image,
        this.shopName,
        this.text,
        this.status,
        this.sendStatus,
        this.createdAt,
        this.updatedAt,
        this.msgCount});

  FinalMurged.fromJson(Map<String, dynamic> json) {
    iD = json['ID'] ?? json["friendId"];
    fname = json['fname'];
    lname = json['lname'];
    mobileNumber = json['mobile_number'];
    image = json['image'];
    shopName = json['shop_name'];
    text = json['text'];
    status = json['status'];
    sendStatus = json['send_status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    msgCount = json['msgCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['fname'] = fname;
    data['lname'] = lname;
    data['mobile_number'] = mobileNumber;
    data['image'] = image;
    data['shop_name'] = shopName;
    data['text'] = text;
    data['status'] = status;
    data['send_status'] = sendStatus;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['msgCount'] = msgCount;
    return data;
  }
}
