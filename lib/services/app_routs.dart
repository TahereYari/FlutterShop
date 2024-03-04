import 'package:get/get.dart';
import 'package:myshop/screens/admin/category/add_category_screen.dart';
import 'package:myshop/screens/admin/category/categori_list.dart';
import 'package:myshop/screens/admin/category/update_category_screen.dart';
import 'package:myshop/screens/admin/comments/comment_list.dart';
import 'package:myshop/screens/admin/data_time.dart';
import 'package:myshop/screens/admin/date_time2.dart';
import 'package:myshop/screens/admin/discount/add_discount_screen.dart';
import 'package:myshop/screens/admin/discount/discount_list.dart';
import 'package:myshop/screens/admin/first_admin_screen.dart';
import 'package:myshop/screens/admin/invoice/invoice_list_screen.dart';
import 'package:myshop/screens/admin/invoice/invoice_product_screen.dart';
import 'package:myshop/screens/admin/offcode/add_offCode_screen.dart';
import 'package:myshop/screens/admin/offcode/offcode_list.dart';
import 'package:myshop/screens/admin/product/add_picturs_product.dart';
import 'package:myshop/screens/admin/product/add_product.dart';
import 'package:myshop/screens/admin/product/admin_product_screen.dart';
import 'package:myshop/screens/admin/product/product_list_screen.dart';
import 'package:myshop/screens/admin/store_screen.dart';
import 'package:myshop/screens/admin/user/add_user.dart';
import 'package:myshop/screens/admin/user/userAdmin_profile_screen.dart';
import 'package:myshop/screens/admin/user/user_list_admin.dart';
import 'package:myshop/screens/front/address_screen.dart';
import 'package:myshop/screens/front/discount_priveiwe.dart';
import 'package:myshop/screens/front/favorite_screen.dart';

import 'package:myshop/screens/front/first_screen_front.dart';
import 'package:myshop/screens/front/myBasket_Screen.dart';
import 'package:myshop/screens/front/preview_product.dart';
import 'package:myshop/screens/front/product_category.dart';
import 'package:myshop/screens/front/sales_screen.dart';
import 'package:myshop/screens/home_screen.dart';
import 'package:myshop/screens/logIn_screen.dart';
import 'package:myshop/screens/signUp_screen.dart';
import 'package:myshop/screens/splash_screen.dart';
import 'package:myshop/widgets/basket_screen.dart';
import 'package:myshop/widgets/front_search.dart';
import 'package:myshop/widgets/home_page_front.dart';

class AppRouts {
  static const String homeScreen = '/home';
  static const String splashScreen = '/splashScreen';
  static const String signUp = '/signUp';
  static const String logInScreen = '/logInScreen';
  static const String addCategoryScreen = '/addCategoryScreen';
  static const String categoryList = '/categoryList';
  static const String addProduct = '/addProduct';
  static const String updateCategoryScreen = '/updateCategoryScreen';
  static const String productListScreen = '/productListScreen';
  static const String adminProductScreen = '/adminProductScreen';
  static const String firstScreenFront = '/firstScreenFront';
  static const String homePageFront = '/homePageFront';
  static const String previewProduct = '/previewProduct';
  static const String addProductPicture = '/addProductPicture';
  static const String firstAdminScreen = '/firstAdminScreen';
  static const String userListAdmin = '/userListAdmin';
  static const String addUserAdmin = '/addUserAdmin';
  static const String dateTime = '/dateTime';
  static const String addDiscountScreen = '/addDiscountScreen';
  static const String addOffCodeScreen = '/addOffCodeScreen';
  static const String listDiscountScreen = '/listDiscountScreen';
  static const String listOffCodeScreen = '/listOffCodeScreen';
  static const String basketScreen = '/basketScreen';
  static const String addressScreen = '/addressScreen';
  static const String favoriteScreen = '/favoriteScreen';
  static const String frontSearchScreen = '/frontSearchScreen';
  static const String myBasketScreen = '/myBasketScreen';
  static const String saleScreen = '/saleScreen';
  static const String commentListScreen = '/commentListScreen';
  static const String invoiceListScreen = '/invoiceListScreen';
  static const String invoiceProductScreen = '/invoiceProductScreen';
  static const String storeScreen = '/storeScreen';
  static const String userAdminProfileScreen = '/userAdminProfileScreen';
  static const String productCategory = '/productCategory';
  static const String discountPreview = '/discountPreview';

  static const String homePageFrontScreen = '/homePageFrontScreen';

  static const String dateTimeScreen2 = '/dateTimeScreen2';

  static final List<GetPage> getPages = [
    GetPage(name: homeScreen, page: () => const HomeScreen()),
    GetPage(name: splashScreen, page: () => SplashScreen()),
    GetPage(name: signUp, page: () =>  SignUpScreen()),
    GetPage(name: logInScreen, page: () => LogInScreen(),),
    GetPage(name: addCategoryScreen, page: () => AddCategoryScreen(),),
    GetPage(name: categoryList, page: () => CategoryList(),),
    GetPage(name: addProduct, page: () => AddProduct(),),
    GetPage(name: updateCategoryScreen, page: () => UpdateCategoryScreen(),),
    GetPage(name: productListScreen, page: () => ProductListScreen(),),
    GetPage(name: adminProductScreen, page: () => AdminProductScreen(),),
    GetPage(name: firstScreenFront, page: () => FirstScreenFront(),),
    GetPage(name: homePageFront, page: () => HomePageFront(),),
    GetPage(name: previewProduct, page: () => PreviewProduct(),),
    GetPage(name: addProductPicture, page: () => AddPictureProduct(),),
    GetPage(name: firstAdminScreen, page: () => FirstAdminScreen(),),
    GetPage(name: userListAdmin, page: () => UserListAdmin(),),
    GetPage(name: addUserAdmin, page: () => AddUser(),),
    GetPage(name: dateTime, page: () => DateTimeScreen(),),
    GetPage(name: addDiscountScreen, page: () => AddDiscountScreen(),),
    GetPage(name: listDiscountScreen, page: () => DiscountList(),),
    GetPage(name: dateTimeScreen2, page: () => DateTimeScreen2(),),
    GetPage(name: listOffCodeScreen, page: () => OffCodeList(),),
    GetPage(name: addOffCodeScreen, page: () => AddOffCodeScreen(),),
    GetPage(name: basketScreen, page: () => BasketScreen(),),
    GetPage(name: homePageFrontScreen, page: () => HomePageFront(),),
    GetPage(name: addressScreen, page: () => AddressScreen(),),
    GetPage(name: favoriteScreen, page: () => FavoriteScreen(),),
    GetPage(name: frontSearchScreen, page: () => FrontSearchScreen(),),
    GetPage(name: myBasketScreen, page: () => MyBasketScreen(),),
    GetPage(name: saleScreen, page: () => SaleScreen(),),
    GetPage(name: commentListScreen, page: () => CommentListScreen(),),
    GetPage(name: invoiceListScreen, page: () => InvoiceListScreen(),),
    GetPage(name: invoiceProductScreen, page: () => InvoiceProductScreen(),),
    GetPage(name: storeScreen, page: () => StoreScreen(),),
    GetPage(name: userAdminProfileScreen, page: () => UserAdminProfile(),),
    GetPage(name: productCategory, page: () => ProductCategory(),),
    GetPage(name: discountPreview, page: () => DiscountPreveiw(),),
  ];
}
