class chatlisttr {
  String? result;
  String? message;
  List<FilteredMessages>? filteredMessages;

  chatlisttr({this.result, this.message, this.filteredMessages});

  chatlisttr.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    message = json['message'];
    if (json['filteredMessages'] != null) {
      filteredMessages = <FilteredMessages>[];
      json['filteredMessages'].forEach((v) {
        filteredMessages!.add(FilteredMessages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['result'] = result;
    data['message'] = message;
    if (filteredMessages != null) {
      data['filteredMessages'] =
          filteredMessages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FilteredMessages {
  String? friendId;
  String? fname;
  String? lname;
  String? mobileNumber;
  String? image;
  String? text;
  int? status;
  int? sendStatus;
  String? createdAt;
  String? updatedAt;
  int? msgCount;

  FilteredMessages(
      {this.friendId,
        this.fname,
        this.lname,
        this.mobileNumber,
        this.image,
        this.text,
        this.status,
        this.sendStatus,
        this.createdAt,
        this.updatedAt,
        this.msgCount});

  FilteredMessages.fromJson(Map<String, dynamic> json) {
    friendId = json['friendId'];
    fname = json['fname'];
    lname = json['lname'];
    mobileNumber = json['mobile_number'];
    image = json['image'];
    text = json['text'];
    status = json['status'];
    sendStatus = json['send_status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    msgCount = json['msgCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['friendId'] = friendId;
    data['fname'] = fname;
    data['lname'] = lname;
    data['mobile_number'] = mobileNumber;
    data['image'] = image;
    data['text'] = text;
    data['status'] = status;
    data['send_status'] = sendStatus;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['msgCount'] = msgCount;
    return data;
  }
}
