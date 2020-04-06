   package thebestkitchen.product;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.InitialContext;
import javax.sql.DataSource;

import thebestkitchen.cart.CartSQL;
import thebestkitchen.rdbms.ConnectionFactory;

public class ProductDao {
   private DataSource dataSource;
   
   public ProductDao(DataSource dataSource) throws Exception{
      this.dataSource = dataSource;
   }
   
   public ProductDao() throws Exception{
      InitialContext ic=new InitialContext();
      dataSource=(DataSource)ic.lookup("java:/comp/env/jdbc/OracleDB");
   }
   
   /*
    * Product 테이블(DB)에 상품을 등록하는 메서드 = 
   * 상품상세페이지의 상품을 등하는 메서드(관리자) : C
    */
   public boolean create(Product product) throws Exception {
      boolean isSuccess = false;
       Connection con = null;
      PreparedStatement pstmt = null;
      
      try {
         con = dataSource.getConnection();
         pstmt = con.prepareStatement(ProductSQL.PRODUCT_CREATE);
         pstmt.setString(1, product.getP_name());
         pstmt.setInt(2, product.getP_price());
         pstmt.setString(3, product.getP_desc());
         int insertRowCount = pstmt.executeUpdate();
         if(insertRowCount == 1) {
            isSuccess = true;
         }
      } catch(Exception e) {
         e.printStackTrace();
         isSuccess = false;
      } finally {
         if (pstmt != null)
            pstmt.close();
         if(con != null)
            con.close();
      }
      return isSuccess;
   }
   
   /*
    * Product 테이블(DB)의 상품을 수정하는 메서드 = 
    * 상품상세페이지의 상품을 수정하는 메서드(관리자) : U
    */
   public boolean update (Product product) throws Exception{
      boolean updateOK = false;
      Connection con = null;
      PreparedStatement pstmt = null;
      try {
         con = dataSource.getConnection();
         pstmt = con.prepareStatement(ProductSQL.PRODUCT_UPDATE);
         pstmt.setString(1, product.getP_name());
         pstmt.setInt(2, product.getP_price());
         pstmt.setString(3, product.getP_desc());
         pstmt.setInt(4, product.getP_qty());
         pstmt.setInt(5, product.getP_no());
         int updateRowCount = pstmt.executeUpdate();
         if(updateRowCount == 1) {
            updateOK = true;
         }
      } catch (Exception e) {
         e.printStackTrace();
         updateOK = false;
      } finally {
         if (pstmt != null)
            pstmt.close();
         if (con != null)
            try {
               con.close();
            }catch (Exception e) {
               e.printStackTrace();
            }
      }
      return updateOK;
   }
   
   /*
    * Product 테이블(DB)의 해당 로우와
    * 상품상세페이지의 상품을 삭제하는 메서드(관리자) : D
    */
   
   public boolean delete(int p_no) throws Exception{
      boolean deleteOK = false;
      Connection con = null;
      PreparedStatement pstmt = null;
      try {
         con = dataSource.getConnection();
         pstmt = con.prepareStatement(ProductSQL.PRODUCT_DELETE);
         pstmt.setInt(1, p_no);
         int deleteRowCount = pstmt.executeUpdate();
         if(deleteRowCount == 1) {
            deleteOK = true;
         }
      } catch (Exception e) {
         e.printStackTrace();
         deleteOK = false;
      } finally {
         if (pstmt != null)
            pstmt.close();
         if (con != null)
            try {
               con.close();
            } catch (Exception e) {
               e.printStackTrace();
            }
      }
      return deleteOK;
   }
   
   //상품전체 조회
   public ArrayList<Product> getProductList() throws Exception {
      Connection con = null;
      PreparedStatement pstmt = null;
      ResultSet rs = null;
      ArrayList<Product> productList = null;
      try {
         con = dataSource.getConnection();
         pstmt = con.prepareStatement(ProductSQL.PRODUCT_LIST);
         rs = pstmt.executeQuery();
         
         productList = new ArrayList<Product>();
         Product product = null;
         
         while (rs.next()) {
            product = new Product();
            product.setP_no(rs.getInt("p_no"));
            product.setP_name(rs.getString("p_name"));
            product.setP_price(rs.getInt("p_price"));
            product.setP_desc(rs.getString("p_desc"));
            product.setP_qty(rs.getInt("p_qty"));
            productList.add(product);
         }
      } catch (Exception e) {
         e.printStackTrace();
      } finally {
         if(rs != null)
            rs.close();
         if(pstmt != null)
            pstmt.close();
         if(con != null)
            con.close();
      }
      return productList;
   }
   
   //상품번호로 찾기
   public Product findByP_no(int p_no) throws Exception {
         Connection con = null;
         PreparedStatement pstmt = null;
         ResultSet rs = null;
         Product product = null;
         
         try {
            con = dataSource.getConnection();
            pstmt = con.prepareStatement(ProductSQL.PRODUCT_P_NO);
            pstmt.setInt(1, p_no);
            rs = pstmt.executeQuery();
            
            if(rs.next()) {
               product = new Product();
               product.setP_no(rs.getInt("p_no"));
               product.setP_name(rs.getString("p_name"));
               product.setP_price(rs.getInt("p_price"));
               product.setP_desc(rs.getString("p_desc"));
               product.setP_qty(rs.getInt("p_qty"));
            }
         } catch (Exception e) {
            e.printStackTrace();
         } finally {
            if(rs != null)
               rs.close();
            if(pstmt != null)
               pstmt.close();
            if(con != null)
               con.close();
         }
         return product;
      }
   
   
   //상품이름으로 찾기
   public ArrayList<Product> findByP_nameList(String p_name) throws Exception {
      Connection con = null;
      PreparedStatement pstmt = null;
      ResultSet rs = null;
      ArrayList<Product> findByP_nameList = null;
      
      try {
         con = dataSource.getConnection();
         pstmt = con.prepareStatement(ProductSQL.PRODUCT_P_NAME_LIST);
         pstmt.setString(1, p_name);
         rs = pstmt.executeQuery();
         
         findByP_nameList = new ArrayList<Product>();
         Product product = null;
         
         while(rs.next()) {
            product = new Product();
            product.setP_no(rs.getInt("p_no"));
            product.setP_name(rs.getString("p_name"));
            product.setP_price(rs.getInt("p_price"));
            product.setP_desc(rs.getString("p_desc"));
            product.setP_qty(rs.getInt("p_qty"));
            findByP_nameList.add(product);
         }
      } catch (Exception e) {
         e.printStackTrace();
      } finally {
         if(rs != null)
            rs.close();
         if(pstmt != null)
            pstmt.close();
         if(con != null)
            con.close();
      }
      return findByP_nameList;
   }
   
   //상품 낮은 가격으로 정렬
   public ArrayList<Product> findByP_priceAscList() throws Exception {
      Connection con = null;
      PreparedStatement pstmt = null;
      ResultSet rs = null;
      ArrayList<Product> findByP_priceList = null;
      
      try {
         con = dataSource.getConnection();
         pstmt = con.prepareStatement(ProductSQL.PRODUCT_P_PRICE_ASC_LIST);
         rs = pstmt.executeQuery();
         
         findByP_priceList = new ArrayList<Product>();
         Product product = null;
         
         while (rs.next()) {
            product = new Product();
            product.setP_no(rs.getInt("p_no"));
            product.setP_name(rs.getString("p_name"));
            product.setP_price(rs.getInt("p_price"));
            product.setP_desc(rs.getString("p_desc"));
            product.setP_qty(rs.getInt("p_qty"));
            findByP_priceList.add(product);
         }
      } catch (Exception e) {
         e.printStackTrace();
      } finally {
         if(rs != null)
            rs.close();
         if(pstmt != null)
            pstmt.close();
         if(con != null)
            con.close();
      }
      return findByP_priceList;
   }
   
   //상품 높은 가격으로 정렬
   public ArrayList<Product> findByP_priceDescList() throws Exception {
      Connection con = null;
      PreparedStatement pstmt = null;
      ResultSet rs = null;
      ArrayList<Product> findByP_priceList = null;
      
      try {
         con = dataSource.getConnection();
         pstmt = con.prepareStatement(ProductSQL.PRODUCT_P_PRICE_DESC_LIST);
         rs = pstmt.executeQuery();
         
         findByP_priceList = new ArrayList<Product>();
         Product product = null;
         
         while (rs.next()) {
            product = new Product();
            product.setP_no(rs.getInt("p_no"));
            product.setP_name(rs.getString("p_name"));
            product.setP_price(rs.getInt("p_price"));
            product.setP_desc(rs.getString("p_desc"));
            product.setP_qty(rs.getInt("p_qty"));
            findByP_priceList.add(product);
         }
      } catch (Exception e) {
         e.printStackTrace();
      } finally {
         if(rs != null)
            rs.close();
         if(pstmt != null)
            pstmt.close();
         if(con != null)
            con.close();
      }
      return findByP_priceList;
   }
   
   //주문상품에 있을 경우 수량 업데이트
   public boolean updateOne(int p_no, String m_id) throws Exception {
         boolean updateOK = false;
      Connection con = null;
      PreparedStatement pstmt = null;
      
      try {
         con = dataSource.getConnection();
         pstmt = con.prepareStatement(ProductSQL.PRODUCT_UPDATE_ONE);
         pstmt.setInt(1, p_no);
         pstmt.setInt(2, p_no);
         pstmt.setString(3, m_id);
         int updateRowCount = pstmt.executeUpdate();
         if(updateRowCount == 1) {
            updateOK = true;
         }
      } catch (Exception e) {
            e.printStackTrace(); 
            updateOK = false;
      } finally {
         if (pstmt != null)
            pstmt.close();
         if (con != null)
            try {
               con.close();
            }catch (Exception e) {
               e.printStackTrace();
            }
      }
      return updateOK;
   }
   
 //주문상품 존재여부
   public boolean isExistJumun(int p_no , String m_id) throws Exception {
      Connection con =ConnectionFactory.getConnection();
      PreparedStatement pstmt = null;
      ResultSet rs = null;
      boolean isExist=false;
      try {
         con = dataSource.getConnection();
         pstmt = con.prepareStatement(ProductSQL.PRODUCT_ISEXIST_JUMUN);
         pstmt.setInt(1, p_no);
         pstmt.setString(2, m_id);
         rs = pstmt.executeQuery();
         int count=0;
         if (rs.next()) {
            count=rs.getInt(1);
         }
         if(count==0) {
            isExist=false;
         }else {
            isExist=true;
         }
      } finally {
         if (rs != null)
            rs.close();
         if (pstmt != null)
            pstmt.close();
         if (con != null)
            con.close();
      }
      return isExist;
   }
   
   //주문에 추가하기
   public boolean jumunAdd(int p_no, String m_id, String p_desc, int p_price) throws Exception {
      boolean isSuccess = false;
       Connection con = null;
      PreparedStatement pstmt = null;
      
      try {
         con = dataSource.getConnection();
         pstmt = con.prepareStatement(ProductSQL.PRODUCT_TO_JUMUN_INSERT);
         pstmt.setInt(1,  p_no);
         pstmt.setString(2, m_id);
         pstmt.setString(3, p_desc);
         pstmt.setInt(4, p_price);
         int insertRowCount = pstmt.executeUpdate();
         if(insertRowCount == 1) {
            isSuccess = true;
         }
      } catch(Exception e) {
         e.printStackTrace();
         isSuccess = false;
      } finally {
         if (pstmt != null)
            pstmt.close();
         if(con != null)
            con.close();
      }
      return isSuccess;
   }
   
   //주문에 수량까지 추가하기 
   public boolean jumunAddPlusQty(int p_no, String m_id, String p_desc, int p_qty, int p_price, String payment) throws Exception {
      boolean isSuccess = false;
       Connection con = null;
      PreparedStatement pstmt = null;
      
      try {
         con = dataSource.getConnection();
         pstmt = con.prepareStatement(ProductSQL.PRODUCT_DETAIL_TO_JUMUN_PLUS_QTY_INSERT);
         pstmt.setInt(1,  p_no);
         pstmt.setString(2, m_id);
         pstmt.setString(3, p_desc);
         pstmt.setInt(4, p_qty);
         pstmt.setInt(5, p_price);
         pstmt.setString(6, payment);
         int insertRowCount = pstmt.executeUpdate();
         if(insertRowCount == 1) {
            isSuccess = true;
         }
      } catch(Exception e) {
         e.printStackTrace();
         isSuccess = false;
      } finally {
         if (pstmt != null)
            pstmt.close();
         if(con != null)
            con.close();
      }
      return isSuccess;
   }
}