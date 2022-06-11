enum StatusServiceOrder {
  U,
  A,
  S,
  T,
  D,
}

class ServiceOrder {
  String? createdAt;
  Client? client;
  StatusServiceOrder? status;
  String? statusDescription;
  List<ServiceOrderDetail>? serviceOrderDetail;

  ServiceOrder(
      {this.createdAt, this.client, this.status, this.statusDescription, this.serviceOrderDetail});

  ServiceOrder.fromJson(Map<String, dynamic> json) {
    createdAt = json['created_at'];
    client = json['client'] != null ? Client.fromJson(json['client']) : null;
    status = json['status'];
    statusDescription = json['get_status_display'];
    if (json['fk_service_order'] != null) {
      serviceOrderDetail = <ServiceOrderDetail>[];
      json['fk_service_order'].forEach((v) {
        serviceOrderDetail!.add(ServiceOrderDetail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['created_at'] = createdAt;
    if (client != null) {
      data['client'] = client!.toJson();
    }
    data['status'] = status;
    data['get_status_display'] = statusDescription;
    if (serviceOrderDetail != null) {
      data['fk_service_order'] =
          serviceOrderDetail!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Client {
  int? id;
  String? name;
  String? address;
  String? email;
  String? lon;
  String? lat;
  bool? active;

  Client(
      {this.id,
      this.name,
      this.address,
      this.email,
      this.lon,
      this.lat,
      this.active});

  Client.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
    email = json['email'];
    lon = json['lon'];
    lat = json['lat'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['address'] = address;
    data['email'] = email;
    data['lon'] = lon;
    data['lat'] = lat;
    data['active'] = active;
    return data;
  }
}

class ServiceOrderDetail {
  int? article;
  int? quantity;

  ServiceOrderDetail({this.article, this.quantity});

  ServiceOrderDetail.fromJson(Map<String, dynamic> json) {
    article = json['article_name'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['article_name'] = article;
    data['quantity'] = quantity;
    return data;
  }
}