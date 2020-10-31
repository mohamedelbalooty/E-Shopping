import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:raia_rgon/models/product.dart';
import '../consestsnt.dart';

class Store {

  final Firestore _fireStore = Firestore.instance;
  addProduct(Product product) {
    _fireStore.collection(KProductCollectionPath).add(<String, dynamic>{
      KProductName: product.pName,
      KProductPrice: product.pPrice,
      KProductDescription: product.pDescription,
      KProductCategory: product.pCategory,
      KProductImageLocation: product.pImageLocation
    });
  }

  Stream<QuerySnapshot> loadProduct(){
    return _fireStore.collection(KProductCollectionPath).snapshots();
  }
  deleteProduct(documentId){
    _fireStore.collection(KProductCollectionPath).document(documentId).delete();
  }
  editProduct(Map<String, dynamic> data, documentId){
    _fireStore.collection(KProductCollectionPath).document(documentId).updateData(data);
  }
  storeOrders(data, List<Product> products){
    var documentReference = _fireStore.collection(KOrders).document();
    documentReference.setData(data);
    for(var product in products){
      documentReference.collection(KOrderDetails).document().setData({
        KProductName: product.pName,
        KProductPrice: product.pPrice,
        KProductCategory: product.pQuantity,
        KProductImageLocation: product.pImageLocation
      });
    }
  }
  Stream<QuerySnapshot> loadOrders() {
    return _fireStore.collection(KOrders).snapshots();
  }

  Stream<QuerySnapshot> loadOrderDetails(documentId) {
    return _fireStore
        .collection(KOrders)
        .document(documentId)
        .collection(KOrderDetails)
        .snapshots();
  }
}
