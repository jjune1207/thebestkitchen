package thebestkitchen.product;

public class Product {
   private int p_no;
   private String m_id;
   private String p_name;
   private int p_price;
   private String p_desc;
   private int p_qty;
   
   public Product() {
      
   }

   public Product(int p_no, String m_id, String p_name, int p_price, String p_desc, int p_qty) {
      super();
      this.p_no = p_no;
      this.m_id = m_id;
      this.p_name = p_name;
      this.p_price = p_price;
      this.p_desc = p_desc;
      this.p_qty = p_qty;
   }
   

   public Product(int p_no, String p_name, int p_price, String p_desc, int p_qty) {
      super();
      this.p_no = p_no;
      this.p_name = p_name;
      this.p_price = p_price;
      this.p_desc = p_desc;
      this.p_qty = p_qty;
   }

   public int getP_no() {
      return p_no;
   }

   public void setP_no(int p_no) {
      this.p_no = p_no;
   }

   public String getM_id() {
      return m_id;
   }

   public void setM_id(String m_id) {
      this.m_id = m_id;
   }

   public String getP_name() {
      return p_name;
   }

   public void setP_name(String p_name) {
      this.p_name = p_name;
   }

   public int getP_price() {
      return p_price;
   }

   public void setP_price(int p_price) {
      this.p_price = p_price;
   }

   public String getP_desc() {
      return p_desc;
   }

   public void setP_desc(String p_desc) {
      this.p_desc = p_desc;
   }

   public int getP_qty() {
      return p_qty;
   }

   public void setP_qty(int p_qty) {
      this.p_qty = p_qty;
   }

   @Override
   public String toString() {
      return "Product [p_no=" + p_no + ", m_id=" + m_id + ", p_name=" + p_name + ", p_price=" + p_price + ", p_desc="
            + p_desc + ", p_qty=" + p_qty + "]";
   }
   
   

   
}

   