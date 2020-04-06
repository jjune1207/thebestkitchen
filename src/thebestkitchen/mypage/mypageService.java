package thebestkitchen.mypage;

import java.util.ArrayList;


public class mypageService {
	private mypageDao mypageDao;
	private static mypageService _instance;
	
	public mypageService() throws Exception{
		mypageDao = new mypageDao();
		System.out.println("mypageService()생성자:"+this);
	}
	
	public static mypageService getInstance() throws Exception {
		if(mypageService._instance == null) {
			mypageService._instance = new mypageService();
		}
		return mypageService._instance;
	}	
	
	public ArrayList<JumunList> jumunprint(String memberId) throws Exception {
		return mypageDao.jumunprint(memberId);
	}
	
	public ArrayList<ProductInquiry> inquiryprint(String memberId) throws Exception {
		return mypageDao.inquiryprint(memberId);
	}
	
}
