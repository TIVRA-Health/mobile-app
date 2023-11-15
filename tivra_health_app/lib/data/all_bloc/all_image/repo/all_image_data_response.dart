/// data : [{"_id":"6536adccbcd38d6f0f06e3e8","image_name":"custom","image_format":"svg+xml","image_data":"data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMjUiIGhlaWdodD0iMzMiIHZpZXdCb3g9IjAgMCAyNSAzMyIgZmlsbD0ibm9uZSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4NCjxwYXRoIGQ9Ik0xMiAyYy00LjQgMC04IDMuNi04IDhzMy42IDggOCA4IDgtMy42IDgtOC0zLjYtOC04LTh6bTAgMTRjLTIuMiAwLTQtMS44LTQtNCAwLTEuMS41LTIuMiAxLjMtMi45bDUuNS01LjUgMS40IDEuNC01LjYgNS42Yy0uOC43LTIgLjctMi44IDAtLjgtLjctMS4zLTEuOC0xLjMtMi45IDAtMi4yIDEuOC00IDQtNHM0IDEuOCA0IDRjMCAxLjEtLjUgMi4yLTEuMyAyLjlsLTUuNiA1LjYtMS40LTEuNCA1LjUtNS41Yy44LS43IDItLjcgMi44IDAgLjguNyAxLjMgMS44IDEuMyAyLjkgMCAyLjItMS44IDQtNCA0eiIgZmlsbD0id2hpdGUiLz4NCjxwYXRoIGQ9Ik0xNiA1LjVjLS44IDAtMS41LS43LTEuNS0xLjVzLjctMS41IDEuNS0xLjUgMS41LjcgMS41IDEuNS0uNyAxLjUtMS41IDEuNXptLTEuNyA0LjZjLS4zIDAtLjYtLjEtLjktLjNsLTIuMy0xLjQtMi4zIDEuNGMtLjMuMi0uNi4zLS45LjMtLjggMC0xLjUtLjctMS41LTEuNVYzYzAtLjguNy0xLjUgMS41LTEuNWg3Yy44IDAgMS41LjcgMS41IDEuNXY2LjZjMCAuOC0uNyAxLjUtMS41IDEuNWgtMi4zeiIgZmlsbD0iI0ZGNTcyMiIvPg0KPC9zdmc+DQo=","active":true}]

class AllImageResponse {
  AllImageResponse({
    this.data,
  });

  AllImageResponse.fromJson(dynamic json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(AllImageData.fromJson(v));
      });
    }
  }

  List<AllImageData>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// _id : "6536adccbcd38d6f0f06e3e8"
/// image_name : "custom"
/// image_format : "svg+xml"
/// image_data : "data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMjUiIGhlaWdodD0iMzMiIHZpZXdCb3g9IjAgMCAyNSAzMyIgZmlsbD0ibm9uZSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4NCjxwYXRoIGQ9Ik0xMiAyYy00LjQgMC04IDMuNi04IDhzMy42IDggOCA4IDgtMy42IDgtOC0zLjYtOC04LTh6bTAgMTRjLTIuMiAwLTQtMS44LTQtNCAwLTEuMS41LTIuMiAxLjMtMi45bDUuNS01LjUgMS40IDEuNC01LjYgNS42Yy0uOC43LTIgLjctMi44IDAtLjgtLjctMS4zLTEuOC0xLjMtMi45IDAtMi4yIDEuOC00IDQtNHM0IDEuOCA0IDRjMCAxLjEtLjUgMi4yLTEuMyAyLjlsLTUuNiA1LjYtMS40LTEuNCA1LjUtNS41Yy44LS43IDItLjcgMi44IDAgLjguNyAxLjMgMS44IDEuMyAyLjkgMCAyLjItMS44IDQtNCA0eiIgZmlsbD0id2hpdGUiLz4NCjxwYXRoIGQ9Ik0xNiA1LjVjLS44IDAtMS41LS43LTEuNS0xLjVzLjctMS41IDEuNS0xLjUgMS41LjcgMS41IDEuNS0uNyAxLjUtMS41IDEuNXptLTEuNyA0LjZjLS4zIDAtLjYtLjEtLjktLjNsLTIuMy0xLjQtMi4zIDEuNGMtLjMuMi0uNi4zLS45LjMtLjggMC0xLjUtLjctMS41LTEuNVYzYzAtLjguNy0xLjUgMS41LTEuNWg3Yy44IDAgMS41LjcgMS41IDEuNXY2LjZjMCAuOC0uNyAxLjUtMS41IDEuNWgtMi4zeiIgZmlsbD0iI0ZGNTcyMiIvPg0KPC9zdmc+DQo="
/// active : true

class AllImageData {
  AllImageData({
    this.id,
    this.imageName,
    this.imageFormat,
    this.imageData,
    this.active,
  });

  AllImageData.fromJson(dynamic json) {
    id = json['_id'];
    imageName = json['image_name'];
    imageFormat = json['image_format'];
    imageData = json['image_data'];
    active = json['active'];
  }

  String? id;
  String? imageName;
  String? imageFormat;
  String? imageData;
  bool? active;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['image_name'] = imageName;
    map['image_format'] = imageFormat;
    map['image_data'] = imageData;
    map['active'] = active;
    return map;
  }
}
