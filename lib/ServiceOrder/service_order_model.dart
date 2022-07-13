enum StatusServiceOrder {
  U,
  A,
  S,
  T,
  D,
}

class ServiceOrderModel {
  int? id;
  String? createdAt;
  Client? client;
  StatusServiceOrder? status;
  String? statusDescription;
  List<ServiceOrderDetail>? serviceOrderDetail;

  ServiceOrderModel(
      {this.createdAt,
      this.client,
      this.status,
      this.statusDescription,
      this.serviceOrderDetail,
      this.id});

  ServiceOrderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    var clientJson = json['client'];

    client = Client(
        clientJson['id'],
        clientJson['name'].toString(),
        clientJson['address'].toString(),
        clientJson['email'].toString(),
        clientJson['lon'].toString(),
        clientJson['lat'].toString(),
        clientJson['active'].toString()
    );

    status = _mapToStatus(json['status']);

    statusDescription = json['get_status_display'];

    if (json['fk_service_order'] != null) {
      serviceOrderDetail = <ServiceOrderDetail>[];
      json['fk_service_order'].forEach((v) {
        serviceOrderDetail!.add(ServiceOrderDetail.fromJson(v));
      });
    }
  }

  StatusServiceOrder _mapToStatus(String status) {
    switch (status) {
      case "A":
        return StatusServiceOrder.A;
      case "U":
        return StatusServiceOrder.U;
      case "S":
        return StatusServiceOrder.S;
      case "T":
        return StatusServiceOrder.T;
      default:
        return StatusServiceOrder.D;
    }
  }

  static String statusObjectToString(StatusServiceOrder status) {
    String statusString = 'A';
    switch (status) {
      case StatusServiceOrder.A:
        statusString = 'A';
        break;
      case StatusServiceOrder.T:
        statusString = 'T';
        break;
      case StatusServiceOrder.U:
        statusString = 'U';
        break;
      case StatusServiceOrder.S:
        statusString = 'S';
        break;
      case StatusServiceOrder.D:
        statusString = 'D';
        break;
    }

    return statusString;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
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
  final int id;
  final String name;
  final String address;
  final String email;
  final String lon;
  final String lat;
  final String active;

  Client(this.id, this.name, this.address, this.email, this.lon, this.lat, this.active);

  // Client.fromJson(Map<String, dynamic> json) {
  //   id = json['id'];
  //   name = json['name'];
  //   address = json['address'];
  //   email = json['email'];
  //   lon = json['lon'];
  //   lat = json['lat'];
  //   active = json['active'];
  // }

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
  String? article;
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
