class Product{
  int? totalSize;
  int? typeId ;
  int? offset;
  late List<ProductModel> _products ;
  List<ProductModel> get products => _products ;

  Product({required totalSize , required typeId , required offset ,  required products}){
    this.totalSize =totalSize ;
    this.typeId = typeId ;
    this.offset = offset ;
    this._products = products ;
  }
  Product.fromJson(Map<String , dynamic> json){
    totalSize = json['totalize'] ;
    typeId = json['typeId'] ;
    offset = json['offset'] ;
   if(json['products'] != null){
     _products = <ProductModel>[];
     json['products'].forEach((element){
       products.add(ProductModel.fromJson(element));
     });
   }
  }

  Map<String , dynamic> toJson(){
    final Map<String,dynamic> data = Map<String ,dynamic>();
    data['totalSize'] =this.totalSize ;
    data['typeId'] =this.typeId ;
    data['offset'] =this.offset ;
    if(this.products != null){
      data['products'] =this.products.map((e) => e.toJson()).toList() ;

    }

    return data ;

  }

}

class ProductModel {
  int? id ;
  String? name ;
  String? description;
  int? price ;
  int? stars ;
  String? img ;
  String? location ;
  String? createdAt ;
  String? updatedAt ;
  int? typeId ;
  ProductModel({
    this.id ,
    this.name ,
    this.description ,
    this.price ,
    this.stars ,
    this.img ,
    this.location ,
    this.createdAt ,
    this.updatedAt,
    this.typeId
});

  ProductModel.fromJson(Map<String , dynamic> json){
    id= json ['id'];
    name= json ['name'];
    description= json ['description'];
    price= json ['price'];
    stars= json ['stars'];
    img= json ['img'];
    location= json ['location'];
    createdAt= json ['createdAt'];
    updatedAt= json ['updatedAt'];
    typeId= json ['typeId'];

  }

  Map<String , dynamic> toJson(){
    final Map<String,dynamic> data = Map<String ,dynamic>();
    data['id'] =this.id ;
    data['name'] =this.name ;
    data['description'] =this.description ;
    data['price'] =this.price ;
    data['stars'] =this.stars ;
    data['img'] =this.img ;
    data['location'] =this.location ;
    data['createdAt'] =this.createdAt ;
    data['updatedAt'] =this.updatedAt ;
    data['typeId'] =this.typeId ;

    return data ;

  }

}