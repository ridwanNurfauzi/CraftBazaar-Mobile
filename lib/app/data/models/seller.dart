class Seller {
  int? id;
  String? code;
  String? email;
  String? name;
  String? description;
  String? photo;
  String? createdAt;
  String? updatedAt;
  List<Products>? products;
  List<Subscribers>? subscribers;
  bool? subscribed;

  Seller(
      {this.id,
      this.code,
      this.email,
      this.name,
      this.description,
      this.photo,
      this.createdAt,
      this.updatedAt,
      this.products,
      this.subscribers,
      this.subscribed});

  Seller.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    email = json['email'];
    name = json['name'];
    description = json['description'];
    photo = json['photo'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
    if (json['subscribers'] != null) {
      subscribers = <Subscribers>[];
      json['subscribers'].forEach((v) {
        subscribers!.add(new Subscribers.fromJson(v));
      });
    }
    subscribed = json['subscribed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['email'] = this.email;
    data['name'] = this.name;
    data['description'] = this.description;
    data['photo'] = this.photo;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    if (this.subscribers != null) {
      data['subscribers'] = this.subscribers!.map((v) => v.toJson()).toList();
    }
    data['subscribed'] = this.subscribed;
    return data;
  }
}

class Products {
  String? name;
  String? slug;
  int? stock;
  int? sold;
  String? price;
  int? weight;
  int? sellerId;
  String? createdAt;
  String? updatedAt;
  List<ProductImages>? productImages;
  Seller? seller;
  List<Categories>? categories;
  List<Reviews>? reviews;

  Products(
      {this.name,
      this.slug,
      this.stock,
      this.sold,
      this.price,
      this.weight,
      this.sellerId,
      this.createdAt,
      this.updatedAt,
      this.productImages,
      this.seller,
      this.categories,
      this.reviews});

  Products.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    slug = json['slug'];
    stock = json['stock'];
    sold = json['sold'];
    price = json['price'];
    weight = json['weight'];
    sellerId = json['seller_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    if (json['product_images'] != null) {
      productImages = <ProductImages>[];
      json['product_images'].forEach((v) {
        productImages!.add(new ProductImages.fromJson(v));
      });
    }
    seller =
        json['seller'] != null ? new Seller.fromJson(json['seller']) : null;
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(new Categories.fromJson(v));
      });
    }
    if (json['reviews'] != null) {
      reviews = <Reviews>[];
      json['reviews'].forEach((v) {
        reviews!.add(new Reviews.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['stock'] = this.stock;
    data['sold'] = this.sold;
    data['price'] = this.price;
    data['weight'] = this.weight;
    data['seller_id'] = this.sellerId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.productImages != null) {
      data['product_images'] =
          this.productImages!.map((v) => v.toJson()).toList();
    }
    if (this.seller != null) {
      data['seller'] = this.seller!.toJson();
    }
    if (this.categories != null) {
      data['categories'] = this.categories!.map((v) => v.toJson()).toList();
    }
    if (this.reviews != null) {
      data['reviews'] = this.reviews!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductImages {
  String? filename;

  ProductImages({this.filename});

  ProductImages.fromJson(Map<String, dynamic> json) {
    filename = json['filename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['filename'] = this.filename;
    return data;
  }
}

class Categories {
  String? name;
  ProductCategories? productCategories;

  Categories({this.name, this.productCategories});

  Categories.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    productCategories = json['product_categories'] != null
        ? new ProductCategories.fromJson(json['product_categories'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    if (this.productCategories != null) {
      data['product_categories'] = this.productCategories!.toJson();
    }
    return data;
  }
}

class ProductCategories {
  int? productId;
  int? categoryId;

  ProductCategories({this.productId, this.categoryId});

  ProductCategories.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    categoryId = json['category_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['category_id'] = this.categoryId;
    return data;
  }
}

class Reviews {
  int? id;
  int? rating;
  String? text;
  int? productId;
  int? userId;
  String? createdAt;
  String? updatedAt;
  User? user;

  Reviews(
      {this.id,
      this.rating,
      this.text,
      this.productId,
      this.userId,
      this.createdAt,
      this.updatedAt,
      this.user});

  Reviews.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    rating = json['rating'];
    text = json['text'];
    productId = json['product_id'];
    userId = json['user_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['rating'] = this.rating;
    data['text'] = this.text;
    data['product_id'] = this.productId;
    data['user_id'] = this.userId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  String? email;
  String? firstname;
  String? lastname;
  String? photo;
  String? createdAt;
  String? updatedAt;

  User(
      {this.email,
      this.firstname,
      this.lastname,
      this.photo,
      this.createdAt,
      this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    photo = json['photo'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['photo'] = this.photo;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class Subscribers {
  int? id;
  int? subscriberId;
  int? sellerId;
  User? user;

  Subscribers({this.id, this.subscriberId, this.sellerId, this.user});

  Subscribers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subscriberId = json['subscriber_id'];
    sellerId = json['seller_id'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['subscriber_id'] = this.subscriberId;
    data['seller_id'] = this.sellerId;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}
