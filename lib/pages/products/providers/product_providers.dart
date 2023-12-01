import 'dart:async';

import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_go_router/pages/products/models/product.dart';
import 'package:riverpod_go_router/pages/products/repositories/product_repository.dart';

part 'product_providers.g.dart';

@riverpod
FutureOr<List<Product>> getProducts(GetProductsRef ref, int page) async {
  final cancelToken = CancelToken();
  Timer? timer;

  ref.onDispose(() {
    print('getProducts($page) disposed, timer canceled, token canceled');
    timer?.cancel();
    cancelToken.cancel();
  });

  ref.onCancel(() {
    print('getProducts($page) canceled');
  });

  ref.onResume(() {
    print('getProducts($page) resumed, timer canceled');
    timer?.cancel();
  });

  print('getProducts($page)');

  final products = await ref
      .watch(productRepositoryProvider)
      .getProducts(page, cancelToken: cancelToken);

  final keepAliveLink = ref.keepAlive();

  ref.onCancel(() {
    print('getProducts($page) canceled, timer started');
    timer = Timer(const Duration(seconds: 5), () {
      keepAliveLink.close();
    });
  });

  return products;
}

@riverpod
FutureOr<Product> getProduct(GetProductRef ref, int id) async {
  final cancelToken = CancelToken();
  Timer? timer;
  ref.onAddListener(() {
    print('getProduct($id) onAddListener');
  });
  ref.onRemoveListener(() {
    print('getProduct($id) onRemoveListener');
  });
  ref.onDispose(() {
    print('getProduct($id) disposed, timer canceled, token canceled');
    timer?.cancel();
    cancelToken.cancel();
  });

  ref.onCancel(() {
    print('getProduct($id) canceled');
  });

  ref.onResume(() {
    print('getProduct($id) resumed, timer canceled');
    timer?.cancel();
  });

  print('getProduct($id) created');

  final product = await ref
      .watch(productRepositoryProvider)
      .getProduct(id, cancelToken: cancelToken);
  /*
  if (cancelToken.isCancelled) {
    print('getProduct($id) request cancel');
    throw 'request cancel';
  }
  */
  //get 호출 성공 이후
  final keepAliveLink = ref.keepAlive();
  print('getProduct($id) keepAlive');
  ref.onCancel(() {
    print('getProduct($id) canceled, timer started');
    timer = Timer(const Duration(seconds: 5), () {
      keepAliveLink.close();
    });
  });
  return product;
}
