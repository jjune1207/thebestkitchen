package thebestkitchen.mypage.jumunutil;
//페이징 처리에  필요한 정보 계산 유틸 클래스
public class JumunPageCalculator{	
	public static JumunListPageDto getPagingInfo(
												int selectPage,
												int rowCountPerPage,
												int pageCountPerPage, 
												int totalRecordCount){
		JumunListPageDto inquiryListPageDto = new JumunListPageDto();
		int totalPageCount = 1;    			// 전체페이지수
		int startPageNo = 1;        		// 한 화면(그룹)에서 시작페이지 번호
		int endPageNo = 1;         			// 한 화면(그룹)에서 끝페이지 번호
		int selectPageNo = 1;      			// 선택된 페이지 번호
		int previousGroupStartPageNo = 1;  	// 이전 그룹의 시작페이지 번호
		int nextGroupStartPageNo = 1;       // 다음 그룹의 시작페이지
		int groupNo = 0;           			// 페이지별 그룹넘버
		
		int startRow = 0; // 몇번째 레코드부터..
		int endRow   = 0; // 몇번째 레코드까지..
		
		
		//**********  DB 레코드수에 따른 계산  *********************
		// 1.전체 페이지수 계산
		int modula = 0;
		if (totalRecordCount > 1){ //1개 이상의 레코드가 존재하면...
			modula = (totalRecordCount) % rowCountPerPage;
			if (modula != 0){//나머지가 2, 3, 4, 5,...., 9이면
				modula = 1;
			}else{// 나머지가 0이면(딱 떨어지면)
				modula = 0;
			}		
			totalPageCount = (totalRecordCount)/rowCountPerPage + modula;
		}else{
			totalPageCount = 1;
		}		

		// 사용자가 페이지번호를 선택할 때마다 각각의 결과값 다르다.
		// 2.한 화면(그룹) 에서 보여지는 그룹넘버,
		selectPageNo = selectPage;		
		groupNo = (selectPageNo-1)/pageCountPerPage;
		// 만일 pageCountPerPage 를 10 으로 설정하였을 경우
		/*  
		      1  2  3  4   5  6 7 8 9 10▶ --> 0
	 	  ◀  10  11 12 13  14 15 16 17 18 19 20▶ --> 1
		 */
		// 3.한 화면(그룹) 에서 시작페이지와 끝페이지 
		startPageNo = groupNo*pageCountPerPage + 1;
		endPageNo   = groupNo*pageCountPerPage+pageCountPerPage;
		// 4.이전 화면그룹의 시작페이지와 끝페이지 (◀)
		previousGroupStartPageNo = startPageNo - pageCountPerPage;		
		if(previousGroupStartPageNo < 0){// groupNo이 0인 경우(페이지 인덱스가 0~10사이)
			previousGroupStartPageNo = 0;
		}
		nextGroupStartPageNo = startPageNo + pageCountPerPage;
		
		//if (startPageNo > totalPageCount)   startPageNo = startPageNo - pageCountPerPage + 1;
		//데이터의 유효성(마지막페이지가 총페이지보다 크면 마지막페이지가 총페이지)
		if (endPageNo > totalPageCount)     endPageNo = totalPageCount;
		
		// 5. 보여줘여할 게시물 테이블 데이타의 시작번호,끝번호
		if (selectPageNo == 1 && selectPageNo == totalPageCount){// 1페이지인경우..
			startRow=1;
			endRow = totalRecordCount;
		}else if (selectPageNo < totalPageCount){
			startRow=rowCountPerPage*selectPageNo-rowCountPerPage + 1;
			endRow = rowCountPerPage*selectPageNo-rowCountPerPage + rowCountPerPage;
		}else if ( selectPageNo == totalPageCount){ // 끝페이지인경우..
			startRow=rowCountPerPage * selectPageNo - rowCountPerPage + 1;
			endRow = totalRecordCount;
		}
		
		
		// 페이징처리에 필요한 정보를 ListResultBean에 세팅
		inquiryListPageDto.setStartPageNo(startPageNo);
		inquiryListPageDto.setEndPageNo(endPageNo);
		inquiryListPageDto.setSelectPageNo(selectPageNo);
		inquiryListPageDto.setTotalRecordCount(totalRecordCount);
		inquiryListPageDto.setTotalPageCountCount(totalPageCount);
		inquiryListPageDto.setPreviousGroupStartPageNo(previousGroupStartPageNo);
		inquiryListPageDto.setNextGroupStartPageNo(nextGroupStartPageNo);
		inquiryListPageDto.setStartRowNum(startRow);
		inquiryListPageDto.setEndRowNum(endRow);
		//resultBean.setShowPrevious(isShowPreviousIcon(selectPageNo));
		//resultBean.setShowNext(isShowNextIcon(selectPageNo, totalPageCount));
		inquiryListPageDto.setShowPreviousGroup(isShowPreviousMoreIcon(groupNo,totalPageCount));
		inquiryListPageDto.setShowNextGroup(isShowNextMoreIcon(endPageNo,totalPageCount));
		inquiryListPageDto.setShowFirst(isShowFirstIcon(groupNo,totalPageCount));
		inquiryListPageDto.setShowLast(isShowLastIcon(endPageNo,totalPageCount));
		System.out.println("***************페이지정보***************");
		System.out.println("01.한화면에보여질페이지수\t:"+pageCountPerPage);
		System.out.println("02.한페이지에보여줄게시물수\t:"+rowCountPerPage);
		System.out.println("03.요청페이지번호\t\t:"+inquiryListPageDto.getSelectPageNo());
		System.out.println("04.전체게시물수\t\t\t:"+inquiryListPageDto.getTotalRecordCount());
		System.out.println("05.전체페이지수\t\t\t:"+inquiryListPageDto.getTotalPageCount());
		System.out.println("06.요청페이지그룹번호\t\t:"+groupNo);
		System.out.println("07.요청페이지그룹시작번호\t:"+inquiryListPageDto.getStartPageNo());
		System.out.println("08.요청페이지그룹끝번호\t\t:"+inquiryListPageDto.getEndPageNo());
		System.out.println("09.이전페이지그룹시작번호\t:"+inquiryListPageDto.getPreviousGroupStartPageNo());
		System.out.println("10.다음페이지그룹시작번호\t:"+inquiryListPageDto.getNextGroupStartPageNo());
		System.out.println("11.DB에서select할게시물시작번호 :"+inquiryListPageDto.getStartRowNum());
		System.out.println("12.DB에서select할게시물끝번호   :"+inquiryListPageDto.getEndRowNum());
		System.out.println("13.이전페이지그룹보여주기◀\t:"+inquiryListPageDto.isShowPreviousGroup());
		System.out.println("14.다음페이지그룹보여주기▶\t:"+inquiryListPageDto.isShowNextGroup()); 		
		System.out.println("15.처음페이지보여주기◀◀  \t:"+inquiryListPageDto.isShowFirst());
		System.out.println("16.마지막페이지보여주기▶▶\t:"+inquiryListPageDto.isShowLast()); 		
		System.out.println("**************************************");
		
		return inquiryListPageDto;				
	}
	// 페이지에 [이전페이지] 출력여부를 판단하는 메소드
	/* 
	public static boolean isShowPreviousIcon(int sPage){
		boolean isShow = false;	
		if (sPage > 1) isShow = true;
		return isShow;

	  }
    */
	  // 페이지에 [다음페이지] 출력여부를 판단하는 메소드
	/*
	public static boolean isShowNextIcon(int sPage,int pCount){
		  boolean isShow = false;
		  if (sPage < pCount) isShow = true;
		  return isShow;
	  }	  
     */
	  // 페이지에 [이전 그룹] 출력여부를 판단하는 메소드
	  public  static boolean isShowPreviousMoreIcon(int groupNo,int totalPageCount) {
		  /*  
	      	  1  2  3  4   5 ▶ --> 0
	 	  ◀  6  7  8  9  10 ▶ --> 1
		  ◀ 11 12 13 14  15 ▶ --> 2
		   */
		  boolean isShow = false;
		  int modula = 0;
		  modula = groupNo % totalPageCount;
		  if (modula !=0 ) modula = 1;		  
		  if ((groupNo / totalPageCount + modula) >0) {
			  isShow =true;
		  }else{
			  isShow = false;
		  }
		 		  
		  return isShow;
	  }
	  

	  // 페이지에 [다음 그룹] 출력여부를 판단하는 메소드
	  public  static boolean isShowNextMoreIcon(int endPageNo,int totalPageCount) {
		  if (endPageNo < totalPageCount) 
				return true;
			else 
				return false;
	  }
	  
//	 페이지에 [처음으로] 아이콘 출력여부를 판단하는 메소드
	  public  static boolean isShowFirstIcon(int groupNo,int totalPageCount){
			int modula = 0;
			modula = groupNo % totalPageCount;
			if (modula!=0) modula = 1;
			if ((groupNo / totalPageCount + modula) > 0) 
				return true;
			else 
				return false;
			  
	  }  

	  // 페이지에 [마지막으로] 아이콘 출력여부를 판단하는 메소드
	  public  static boolean isShowLastIcon(int endPageNo,int totalPageCount) {
			if (endPageNo < totalPageCount)
				return true;
			else 
				return false;
	  } 
	  // 테스트 메인
	  public static void main(String[] args) {
		  /*
		  PageCounter.getPagingInfo(selectPage,rowCountPerPage,pageCountPerPage,totalRecordCount)
		  */
		  int selectPage =8;
		  int rowCountPerPage=10;
		  int pageCountPerPage=5;
		  int totalRecordCount=563;
		  JumunListPageDto resultBean = JumunPageCalculator.getPagingInfo(selectPage,rowCountPerPage,pageCountPerPage,totalRecordCount);
		  System.out.println("***************페이지정보***************");
			System.out.println("01.selectPage:\t\t\t"+resultBean.getSelectPageNo());
			System.out.println("02.rowCountPerPage:\t\t"+rowCountPerPage);
			System.out.println("03.pageCountPerPage:\t\t"+pageCountPerPage);
			System.out.println("02.totalRecordCount:\t\t"+resultBean.getTotalRecordCount());
			System.out.println("03.totalPageCount:\t\t"+resultBean.getTotalPageCount());
			System.out.println("04.pagegroupNo:\t\t\t"+(resultBean.getTotalPageCount()/pageCountPerPage==0?resultBean.getTotalPageCount()/pageCountPerPage-1 :resultBean.getTotalPageCount()/pageCountPerPage));
			System.out.println("05.startPageNo:\t\t\t"+resultBean.getStartPageNo());
			System.out.println("06.endPageNo:\t\t\t"+resultBean.getEndPageNo());
			System.out.println("07.startRowNum:\t\t\t"+resultBean.getStartRowNum());
			System.out.println("08.endRowNum:\t\t\t"+resultBean.getEndRowNum());
			System.out.println("09.previousGroupStartPageNo:\t"+resultBean.getPreviousGroupStartPageNo());
			System.out.println("10.nextGroupStartPageNo:\t"+resultBean.getNextGroupStartPageNo());
			System.out.println("11.isShowPreviousGroup:\t\t"+resultBean.isShowPreviousGroup());
			System.out.println("12.isShowNextGroup:\t\t"+resultBean.isShowNextGroup()); 		
			System.out.println("13.isShowFirst:\t\t\t"+resultBean.isShowFirst());
			System.out.println("14.isShowLast:\t\t\t"+resultBean.isShowLast()); 		
			System.out.println("**************************************");
	}
	  
	  
 }