package thebestkitchen.product;

import java.util.ArrayList;

public class ProductService {
   private ProductDao productDao;
   
   public ProductService() throws Exception {
      productDao = new ProductDao();
   }
   //상품등록
   public boolean registerProduct(Product product) throws Exception{
      return productDao.create(product);
   }
   
   //상품수정
   public boolean productUpdate(Product product) throws Exception{
      return productDao.update(product);
      
   }   
   
   //상품삭제
   public boolean productDelete(int p_no) throws Exception{
      return productDao.delete(p_no);
   }
   
   //상품전체 반환
   public ArrayList<Product> productList() throws Exception {
      return productDao.getProductList();
   }
   
   //상품번호로 검색
   public Product findByP_no(int p_no) throws Exception {
      return productDao.findByP_no(p_no);
   }
   
   //상품이름으로 검색
   public ArrayList<Product> findByP_nameList(String p_name) throws Exception {
      return productDao.findByP_nameList(p_name);
   }
   
   //상품 낮은가격으로 정렬
   public ArrayList<Product> findByP_priceAscList() throws Exception {
      return productDao.findByP_priceAscList();
   }
   
   //상품 높은가격으로 정렬
   public ArrayList<Product> findByP_priceDescList() throws Exception {
      return productDao.findByP_priceDescList();
   }
   
   //주문에 추가하기
   public boolean jumunAdd(int p_no, String m_id, String p_desc, int p_price) throws Exception {
      if(productDao.isExistJumun(p_no, m_id)) {
         return productDao.updateOne(p_no, m_id);
      }
      return productDao.jumunAdd(p_no, m_id, p_desc, p_price);
   }
   //주문에 추가하기(상품상세페이지 : 수량 추가)
   public boolean jumunAddPlusQty(int p_no, String m_id, String p_desc, int p_qty, int p_price, String payment) throws Exception {
      return productDao.jumunAddPlusQty(p_no, m_id, p_desc, p_qty, p_price, payment);
   }

}






