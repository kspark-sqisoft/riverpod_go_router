import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_go_router/pages/products/models/product.dart';
import 'package:riverpod_go_router/providers/dio_provider.dart';

part 'product_repository.g.dart';

const limit = 20;
int totalProducts = 0;
int totalPages = 1;

@riverpod
ProductRepository productRepository(ProductRepositoryRef ref) =>
    ProductRepository(dio: ref.watch(dioProvider));

class ProductRepository {
  final Dio dio;
  ProductRepository({required this.dio}) {
    dio.options = BaseOptions(baseUrl: 'https://dummyjson.com');
  }

  Future<List<Product>> getProducts(
    int page, {
    CancelToken? cancelToken,
  }) async {
    try {
      print('productRepository getProducts($page)');
      final Response response = await dio.get(
        '/products',
        queryParameters: {
          'limit': limit,
          'skip': (page - 1) * limit,
        },
        cancelToken: cancelToken,
      );

      if (response.statusCode != 200) {
        throw 'Fail to fetch products';
      }

      final List productList = response.data['products'];

      totalProducts = response.data['total'];

      totalPages = totalProducts ~/ limit + (totalProducts % limit > 0 ? 1 : 0);

      final products = [
        for (final product in productList) Product.fromJson(product)
      ];

      return products;
    } catch (e) {
      rethrow;
    }
  }

  Future<Product> getProduct(
    int id, {
    CancelToken? cancelToken,
  }) async {
    try {
      print('productRepository getProduct($id)');
      final Response response = await dio.get(
        '/products/$id',
        cancelToken: cancelToken,
      );

      if (response.statusCode != 200) {
        throw 'Fail to fetch product with $id';
      }

      final product = Product.fromJson(response.data);

      return product;
    } catch (e) {
      rethrow;
    }
  }
}
