package thebestkitchen.product;

public class ProductSQL {
   public static final String PRODUCT_CREATE =
         "INSERT INTO product VALUES(product_no_seq.NEXTVAL, ?, ?, ?, DEFAULT)";
   public static final String PRODUCT_UPDATE =
         "UPDATE product SET p_name = ?, p_price = ?, "
               + "p_desc = ?, p_qty = ? WHERE p_no = ?";
   public static final String PRODUCT_DELETE = 
         "DELETE FROM product WHERE p_no = ?";
   public static final String PRODUCT_LIST =
         "SELECT * FROM product";
   public static final String PRODUCT_P_NO = 
         "SELECT * FROM product WHERE p_no = ?";
   public static final String PRODUCT_P_NAME_LIST =
         "SELECT * FROM product WHERE p_name = ?";
   public static final String PRODUCT_P_PRICE_ASC_LIST =
         "SELECT * FROM product ORDER BY p_price ASC";
   public static final String PRODUCT_P_PRICE_DESC_LIST =
         "SELECT * FROM product ORDER BY p_price DESC";
   public static final String PRODUCT_TO_JUMUN_INSERT = 
   //p_no, m_id, p_desc, j_date, p_qty, p_price, j_dprice, j_address, j_phone"
         "INSERT INTO jumun VALUES"
         + " (to_number(concat(replace(to_char(sysdate, 'YYYY/MM/DD'), '/', ''), "
         + " to_char(lpad(jumun_no_seq.nextval, 3, 0)))),"
         + " ?, ?, ?, sysdate, 1, ?, 3000, null, null, DEFAULT)";
   public static final String PRODUCT_DETAIL_TO_JUMUN_PLUS_QTY_INSERT = 
   //p_no, m_id, p_desc, j_date, p_qty, p_price, j_dprice, j_address, j_phone, j_payment"
         "INSERT INTO jumun VALUES"
         + " (to_number(concat(replace(to_char(sysdate, 'YYYY/MM/DD'), '/', ''), "
         + " to_char(lpad(jumun_no_seq.nextval, 3, 0)))),"
         + " ?, ?, ?, sysdate, ?, ?, 3000, null, null, ?)";
   public final static String PRODUCT_UPDATE_ONE = 
         "UPDATE jumun SET j_qty = j_qty+1, j_price = (j_qty+1)*(SELECT p_price FROM product WHERE p_no = ?) WHERE p_no = ? AND m_id = ? ";
   public final static String PRODUCT_ISEXIST_JUMUN =
	         "SELECT count(*) FROM jumun WHERE p_no = ? and m_id = ? and j_payment = 'N'";
}