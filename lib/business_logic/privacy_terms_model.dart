class TearmsAndConditions {
  List<Tearms>? tearms;

  TearmsAndConditions({this.tearms});

  TearmsAndConditions.fromJson(Map<String, dynamic> json) {
    if (json['tearms'] != null) {
      tearms = <Tearms>[];
      json['tearms'].forEach((v) {
        tearms!.add(Tearms.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (tearms != null) {
      data['tearms'] = tearms!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Tearms {
  String? sId;
  String? title;
  String? description;
  String? createdAt;
  int? iV;

  Tearms({this.sId, this.title, this.description, this.createdAt, this.iV});

  Tearms.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    description = json['description'];
    createdAt = json['createdAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['title'] = title;
    data['description'] = description;
    data['createdAt'] = createdAt;
    data['__v'] = iV;
    return data;
  }
}

class PrivacyAndPolicy {
  List<Policy>? policy;

  PrivacyAndPolicy({this.policy});

  PrivacyAndPolicy.fromJson(Map<String, dynamic> json) {
    if (json['policy'] != null) {
      policy = <Policy>[];
      json['policy'].forEach((v) {
        policy!.add(Policy.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (policy != null) {
      data['policy'] = policy!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Policy {
  String? sId;
  String? title;
  String? description;
  String? createdAt;
  int? iV;

  Policy({this.sId, this.title, this.description, this.createdAt, this.iV});

  Policy.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    description = json['description'];
    createdAt = json['createdAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['title'] = title;
    data['description'] = description;
    data['createdAt'] = createdAt;
    data['__v'] = iV;
    return data;
  }
}
