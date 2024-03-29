enum StatusServiceOrder {
  O,
  R,
  A,
  S,
  T,
  D,
  P
}

class ServiceOrderModel {
  int? id;
  String? createdAt;
  String? deliveryDate;
  Client? client;
  StatusServiceOrder? status;
  String? statusDescription;
  List<ServiceOrderDetail>? serviceOrderDetail;
  String? tailNumber;

  ServiceOrderModel(
      {this.createdAt,
      this.deliveryDate,
      this.client,
      this.status,
      this.statusDescription,
      this.serviceOrderDetail,
      this.id});

  ServiceOrderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    deliveryDate = json['delivery_date'];
    var clientJson = json['client'];

    client = Client(
        clientJson['id'],
        clientJson['name'].toString(),
        clientJson['address'].toString(),
        clientJson['email'].toString(),
        clientJson['lon'].toString(),
        clientJson['lat'].toString(),
        clientJson['active'].toString());

    status = _mapToStatus(json['status']);

    statusDescription = json['get_status_display'];
    tailNumber = json['tail_number'];

    if (json['fk_service_order'] != null) {
      serviceOrderDetail = <ServiceOrderDetail>[];
      json['fk_service_order'].forEach((v) {
        serviceOrderDetail!.add(ServiceOrderDetail.fromJson(v));
      });
    }
  }

  String getClientName() {
    return 'ANGEL';
  }

  StatusServiceOrder _mapToStatus(String status) {
    switch (status) {
      case "A":
        return StatusServiceOrder.A;
      case "R":
        return StatusServiceOrder.R;
      case "O":
        return StatusServiceOrder.O;
      case "S":
        return StatusServiceOrder.S;
      case "T":
        return StatusServiceOrder.T;
      case "P":
        return StatusServiceOrder.P;
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
      case StatusServiceOrder.O:
        statusString = 'O';
        break;
      case StatusServiceOrder.R:
        statusString = 'R';
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
    data['delivery_date'] = deliveryDate;
    if (client != null) {
      data['client'] = client!.toJson();
    }
    data['status'] = status;
    data['get_status_display'] = statusDescription;
    data['tail_number'] = tailNumber;

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

  Client(this.id, this.name, this.address, this.email, this.lon, this.lat,
      this.active);

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
