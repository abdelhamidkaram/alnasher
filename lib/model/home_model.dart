class HomeModel {
  bool? status;
  String? message;
  DataResponse? dataResponse;

  HomeModel({this.status, this.message, this.dataResponse});

  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    dataResponse = json['data_response'] != null
        ? DataResponse.fromJson(json['data_response'])
        : null;
  }


}

class DataResponse {
  User? user;
  List<HomeBanner>? banner;
  List<HomeCategory>? category;
  List<Ad>? ads;


  DataResponse({this.user, this.banner, this.category});

  DataResponse.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    if (json['banner'] != null) {
      banner = <HomeBanner>[];
      json['banner'].forEach((v) {
        banner!.add(HomeBanner.fromJson(v));
      });
    }
    if (json['category'] != null) {
      category = <HomeCategory>[];
      json['category'].forEach((v) {
        category!.add(HomeCategory.fromJson(v));
      });
    }

    if (json['ads'] != null) {
      ads = <Ad>[];
      json['ads'].forEach((v) {
        ads!.add(Ad.fromJson(v));
      });
    }
  }


}

class User {
  int? id;
  String? firstName;
  String? lastName;
  String? phone;
  String? email;
  String? gender;
  String? dob;
  String? about;
  String? image;

  User(
      {this.id,
        this.firstName,
        this.lastName,
        this.phone,
        this.email,
        this.gender,
        this.dob,
        this.about,
        this.image});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    phone = json['phone'];
    email = json['email'];
    gender = json['gender'];
    dob = json['dob'];
    about = json['about'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['phone'] = phone;
    data['email'] = email;
    data['gender'] = gender;
    data['dob'] = dob;
    data['about'] = about;
    data['image'] = image;
    return data;
  }
}

class HomeBanner {
  int? id;
  String? title;
  String? des;
  String? image;
  String? phone;
  String? whatsapp;
  String? description;

  HomeBanner({this.id, this.title, this.des, this.image , this.whatsapp , this.phone , this.description});

  HomeBanner.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    des = json['des'];
    image = json['image'];
    description = json['description'];
    phone = json['phone'];
    whatsapp = json['whatsapp'];
  }

}

class HomeCategory {
  int? id;
  String? name;
  String? image;
  String? show;
  List<Ad>? ads;

  HomeCategory({this.id, this.name, this.image, this.show, this.ads});

  HomeCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    show = json['show'];
    if (json['ads'] != null) {
      ads = <Ad>[];
      json['ads'].forEach((v) {
        ads!.add(Ad.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['image'] = image;
    data['show'] = show;
    if (ads != null) {
      data['ads'] = ads!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Ad {
  int? id;
  String? title;
  String? price;
  String? paidType;
  String? phone;
  String? whatsapp;
  String? lat;
  String? des;
  String? expireAt;
  String? active;
  MainImage? mainImage;
  List<MainImage>? imageList;
  User? user;
  Cats? cats;
  bool? fav;

  Ad(
      {this.id,
        this.title,
        this.price,
        this.paidType,
        this.phone,
        this.whatsapp,
        this.lat,
        this.des,
        this.expireAt,
        this.active,
        this.mainImage,
        this.imageList,
        this.user,
        this.cats,
        this.fav});

  Ad.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    price = json['price'];
    paidType = json['paid_type'];
    phone = json['phone'];
    whatsapp = json['whatsapp'];
    lat = json['lat'];
    des = json['des'];
    expireAt = json['expire_at'];
    active = json['active'];
    mainImage = json['main_image'] != null
        ? MainImage.fromJson(json['main_image'])
        : null;
    if (json['image_list'] != null) {
      imageList = <MainImage>[];
      json['image_list'].forEach((v) {
        imageList!.add(MainImage.fromJson(v));
      });
    }
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    cats = json['cats'] != null ? Cats.fromJson(json['cats']) : null;
    fav = json['fav'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['price'] = price;
    data['paid_type'] = paidType;
    data['phone'] = phone;
    data['whatsapp'] = whatsapp;
    data['lat'] = lat;
    data['des'] = des;
    data['expire_at'] = expireAt;
    data['active'] = active;
    if (mainImage != null) {
      data['main_image'] = mainImage!.toJson();
    }
    if (imageList != null) {
      data['image_list'] = imageList!.map(( MainImage v) => v.toJson()).toList();
    }
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (cats != null) {
      data['cats'] = cats!.toJson();
    }
    data['fav'] = fav;
    return data;
  }
}

class MainImage {
  int? id;
  String? image;

  MainImage({this.id, this.image});

  MainImage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image'] = image;
    return data;
  }
}

class Cats {
  int? id;
  String? name;
  String? image;
  String? parentId;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  Cats(
      {this.id,
        this.name,
        this.image,
        this.parentId,
        this.createdAt,
        this.updatedAt,
        this.deletedAt});

  Cats.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    parentId = json['parent_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['image'] = image;
    data['parent_id'] = parentId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    return data;
  }
}
