class CategoryDataModel {
  final String categoryId;
  final String categoryName;
  final String categoryImage;

  CategoryDataModel({
    required this.categoryId,
    required this.categoryName,
    required this.categoryImage,
  });

  static List<CategoryDataModel> categoryList = [
    CategoryDataModel(
      categoryId: "general",
      categoryName: "General",
      categoryImage: "assets/images/general_picture.png",
    ),
    CategoryDataModel(
      categoryId: "business",
      categoryName: "Business",
      categoryImage: "assets/images/business_picture.png",
    ),
    CategoryDataModel(
      categoryId: "entertainment",
      categoryName: "Entertainment",
      categoryImage: "assets/images/entertainment_picture.png",
    ),
    CategoryDataModel(
      categoryId: "health",
      categoryName: "Health",
      categoryImage: "assets/images/health_picture.png",
    ),
    CategoryDataModel(
      categoryId: "sports",
      categoryName: "Sports",
      categoryImage: "assets/images/sport_picture.png",
    ),
    CategoryDataModel(
      categoryId: "technology",
      categoryName: "Technology",
      categoryImage: "assets/images/technology_picture.png",
    ),
    CategoryDataModel(
      categoryId: "science",
      categoryName: "Science",
      categoryImage: "assets/images/science_picture.png",
    ),
  ];
}
