class Product {
  int? id;
  String? name;
  String? slug;
  String? description;
  int? stock;
  int? sold;
  String? price;
  int? weight;
  String? createdAt;
  String? updatedAt;
  List<ProductImages>? productImages;
  Seller? seller;
  List<Categories>? categories;
  List<Reviews>? reviews;
  List<PersonalReviews>? personalReviews;
  List<ShowedReviews>? showedReviews;

  Product(
      {this.id,
      this.name,
      this.slug,
      this.description,
      this.stock,
      this.sold,
      this.price,
      this.weight,
      this.createdAt,
      this.updatedAt,
      this.productImages,
      this.seller,
      this.categories,
      this.reviews,
      this.personalReviews,
      this.showedReviews});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    description = json['description'];
    stock = json['stock'];
    sold = json['sold'];
    price = json['price'];
    weight = json['weight'];
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
    if (json['personal_reviews'] != null) {
      personalReviews = <PersonalReviews>[];
      json['personal_reviews'].forEach((v) {
        personalReviews!.add(new PersonalReviews.fromJson(v));
      });
    }
    if (json['showed_reviews'] != null) {
      showedReviews = <ShowedReviews>[];
      json['showed_reviews'].forEach((v) {
        showedReviews!.add(new ShowedReviews.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['description'] = this.description;
    data['stock'] = this.stock;
    data['sold'] = this.sold;
    data['price'] = this.price;
    data['weight'] = this.weight;
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
    if (this.personalReviews != null) {
      data['personal_reviews'] =
          this.personalReviews!.map((v) => v.toJson()).toList();
    }
    if (this.showedReviews != null) {
      data['showed_reviews'] =
          this.showedReviews!.map((v) => v.toJson()).toList();
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

class Seller {
  String? code;
  String? email;
  String? name;
  String? description;
  String? photo;

  Seller({this.code, this.email, this.name, this.description, this.photo});

  Seller.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    email = json['email'];
    name = json['name'];
    description = json['description'];
    photo = json['photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['email'] = this.email;
    data['name'] = this.name;
    data['description'] = this.description;
    data['photo'] = this.photo;
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
  int? id;
  String? email;
  String? firstname;
  String? lastname;
  String? photo;
  String? createdAt;
  String? updatedAt;

  User(
      {this.id,
      this.email,
      this.firstname,
      this.lastname,
      this.photo,
      this.createdAt,
      this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    photo = json['photo'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['photo'] = this.photo;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class PersonalReviews {
  int? id;
  int? rating;
  String? text;
  int? productId;
  int? userId;
  String? createdAt;
  String? updatedAt;
  User? user;

  PersonalReviews(
      {this.id,
      this.rating,
      this.text,
      this.productId,
      this.userId,
      this.createdAt,
      this.updatedAt,
      this.user});

  PersonalReviews.fromJson(Map<String, dynamic> json) {
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

class ShowedReviews {
  int? id;
  int? rating;
  String? text;
  int? productId;
  int? userId;
  String? createdAt;
  String? updatedAt;
  User? user;

  ShowedReviews(
      {this.id,
      this.rating,
      this.text,
      this.productId,
      this.userId,
      this.createdAt,
      this.updatedAt,
      this.user});

  ShowedReviews.fromJson(Map<String, dynamic> json) {
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
