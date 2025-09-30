import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/cuibit/categori_cubit.dart';
import 'package:untitled/state/categore_state.dart';
import '../models/categories.dart';
import '../models/product.dart';
import '../pages/product_screen.dart';
import '../pages/categori_screen.dart';
import '../resposive_screen.dart';

class homescreen extends StatefulWidget {
  const homescreen({super.key});

  @override
  State<homescreen> createState() => _homescreenState();
}

class _homescreenState extends State<homescreen> {
  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveHelper(context);

    return Scaffold(
      appBar: AppBar(title: const Text("ECO APP !")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Center(
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.cyanAccent,
                  borderRadius: BorderRadius.circular(20),
                ),
                width: responsive.wp(90),
                height: responsive.hp(20),
                // ← Row places text and image side-by-side
                child: Row(
                  children: [
                    // Text area (left)
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "SHOP THE",
                            style: TextStyle(
                              fontSize: responsive.sp(6),
                              fontFamily: "Cairo",
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "NEW PRODUCT",
                            style: TextStyle(
                              fontSize: responsive.sp(5),
                              fontFamily: "Cairo",
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(width: responsive.wp(2)), // spacing
                    // Image area (right)
                    Expanded(
                      flex: 1,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          'images/elctric.png', // <-- your asset path
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                          // use cover or contain as you prefer
                          semanticLabel: 'Product image',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Text(
              'Categories',
              style: TextStyle(fontSize: responsive.sp(5), fontFamily: "Cairo"),
            ),
            const SizedBox(height: 16),
            BlocBuilder<CategoryCubit, CategoryState>(
              builder: (context, state) {
                if (state is CategoryLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is CategoryError) {
                  return Center(
                    child: Text(
                      "ERROR :${state.message}",
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: responsive.sp(5),
                        fontFamily: "Cairo",
                      ),
                    ),
                  );
                } else if (state is CategoryLoaded) {
                  final categories = state.categories;
                  return SizedBox(
                    height: responsive.hp(15),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                      padding: EdgeInsets.symmetric(horizontal: responsive.wp(4)),
                      itemBuilder: (context, index) {
                        final category = categories[index];
                        return Padding(
                          padding: EdgeInsets.only(right: responsive.wp(3)),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(16),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CategoryScreen(category: category),
                                ),
                              );
                            },
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Circular icon/image
                                Container(
                                  width: 56,
                                  height: 56,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                    border: Border.all(color: Colors.grey.shade300),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.05),
                                        blurRadius: 8,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.category_outlined,
                                      size: 24,
                                      color: Colors.grey.shade700,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 6),
                                // Label chip
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: Colors.amber,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    category.name,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontFamily: 'Cairo',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
            const SizedBox(height: 20),
            // Add a button to navigate to products screen
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'productscreen');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[600],
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: Text(
                  'View All Products',
                  style: TextStyle(
                    fontSize: responsive.sp(4),
                    fontFamily: 'Cairo',
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

          ],
        ),
      ),

    );
  }
  Widget _buildProductCard(Product product) {
    return GestureDetector(
      onTap: () {
        // TODO: Navigate to product details screen
         Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProductScreen(),));
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image with overlay and favorite button
            AspectRatio(
              aspectRatio: 16 / 11,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  // Product image
                  Image.asset(
                    product.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey[200],
                        child: const Icon(Icons.image, color: Colors.grey, size: 40),
                      );
                    },
                  ),
                  // Gradient overlay bottom
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black,
                            Colors.black,
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Favorite icon (placeholder action)
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(6.0),
                        child: Icon(Icons.favorite_border, size: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Content
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name
                  Text(
                    product.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Cairo',
                    ),
                  ),
                  const SizedBox(height: 4),
                  // Category
                  Text(
                    product.categoryName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                      fontFamily: 'Cairo',
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Price + Add button
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          product.formattedPrice,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            fontFamily: 'Cairo',
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                          child: Icon(Icons.add, color: Colors.black, size: 18),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}




