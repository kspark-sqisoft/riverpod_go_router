import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:riverpod_go_router/main.dart';
import 'package:riverpod_go_router/pages/products/models/product.dart';
import 'package:riverpod_go_router/pages/products/repositories/product_repository.dart';
import 'package:riverpod_go_router/providers/auth_state_provider.dart';
import 'package:riverpod_go_router/providers/theme_provider.dart';
import 'package:riverpod_go_router/router/route_names.dart';
import 'package:riverpod_go_router/router/router_state_full_shell_provider.dart';

class ProductsPage extends ConsumerStatefulWidget {
  const ProductsPage({
    super.key,
  });

  @override
  ConsumerState<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends ConsumerState<ProductsPage> {
  final ScrollController _scrollController = ScrollController();
  final PagingController<int, Product> _pagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    print('ProductsPage initState');
    _pagingController.addPageRequestListener((pageKey) {
      _fetchProducts(pageKey);
    });
    super.initState();
  }

  @override
  void dispose() {
    print('ProductsPage dispose');
    _pagingController.dispose();
    _scrollController.dispose();

    super.dispose();
  }

  Future<void> _fetchProducts(int pageKey) async {
    try {
      final newProducts =
          await ref.read(productRepositoryProvider).getProducts(pageKey);
      final isLastPage = newProducts.length < limit;

      if (isLastPage) {
        _pagingController.appendLastPage(newProducts);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(newProducts, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(changeRouteProvider, (p, n) {
      if (n.routeType == ChangeRouteType.going && n.routeName == '/products') {
        _scrollController.animateTo(0,
            duration: const Duration(milliseconds: 500), curve: Curves.linear);
      }
    });
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'PRODUCT',
                    style:
                        TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    onPressed: () {
                      ref.read(themeProvider.notifier).toggleTheme();
                    },
                    icon: const Icon(Icons.light_mode),
                  ),
                ],
              ),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async => _pagingController.refresh(),
                  child: PagedListView<int, Product>.separated(
                    shrinkWrap: true,
                    pagingController: _pagingController,
                    scrollController: _scrollController,
                    builderDelegate: PagedChildBuilderDelegate(
                      itemBuilder: (context, product, index) {
                        return GestureDetector(
                          onTap: () {
                            context.goNamed(RouteNames.product,
                                pathParameters: {'id': product.id.toString()});
                          },
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 20,
                              ),
                              CircleAvatar(
                                radius: 30,
                                backgroundImage:
                                    NetworkImage(product.thumbnail),
                                child: Text(
                                  product.id.toString(),
                                  style:
                                      const TextStyle(color: Colors.lightGreen),
                                ),
                              ),
                              Expanded(
                                child: ListTile(
                                  title: Text(product.title),
                                  subtitle: Text(product.brand),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      noMoreItemsIndicatorBuilder: (context) => const Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 20.0),
                          child: Text(
                            'No more products!',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                      firstPageErrorIndicatorBuilder: (context) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 50,
                            horizontal: 30,
                          ),
                          child: Column(
                            children: [
                              const Text(
                                'Something went wrong',
                                style: TextStyle(fontSize: 20),
                              ),
                              const SizedBox(height: 20),
                              Text(
                                '${_pagingController.error}',
                                style: const TextStyle(fontSize: 18),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 20),
                              OutlinedButton(
                                onPressed: () => _pagingController.refresh(),
                                child: const Text(
                                  'Try Again!',
                                  style: TextStyle(fontSize: 20),
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                    separatorBuilder: (context, index) {
                      return const Divider();
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            await ref.watch(authStateProvider.notifier).setAuthenticate(false);
          },
          icon: const Icon(Icons.exit_to_app),
          label: const Text('Sign Out'),
        ),
      ),
    );
  }
}
