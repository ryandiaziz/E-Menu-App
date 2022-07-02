// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:e_menu/infrastruktur/product/product_repository.dart';

// import '../../../infrastruktur/product/product_repository.dart';

// part 'product_state.dart';

// class ProductCubit extends Cubit<ProductState> {
//   ProductCubit() : super(ProductInitial());

//   void getDataProduct() {
//     try {
//       emit(ProductLoading());
//       ProductRepository().getDataProduct().then((value) {
//         emit(ProductSuccess(value));
//       });
//     } catch (e) {}
//   }
// }
