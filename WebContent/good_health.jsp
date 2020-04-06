<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
    <meta name="keywords" content="">
    <meta name="description" content="건강한 나눔">
    <meta property="og:type" content="website">
    <meta property="og:title" content="더테스트키친">
    <meta property="og:description" content="건강한 나눔">
    <meta property="og:url" content="http://www.thetestkitchen.co.kr">
        <meta name="naver-site-verification" content="eb128fb6cdd8220254ad15ad63db79742d96390f"/>

    <link rel="stylesheet" type="text/css" href="./style/css/import.css">
    <script src="./js/jquery-1.7.2.js"></script>
    <script src="./js/lib/handlebars/handlebars-v3.1.0.js"></script>
    <script src="./js/lib/jquery/jquery-handlebars.js"></script>
    <script type="text/javascript" src="https://wcs.naver.net/wcslog.js"></script>
    <script src="./js/lib/swiper.min.js"></script>
    <script src="./js/imagesloaded.pkgd.min.js"></script>
    <script src="./js/module/common.js?go2"></script>
    <script src="./js/module/appinfo.js?go2"></script>
    <script src="./js/utils/productUtils.js?go2"></script>
    <script src="./js/module/paging.js?go2"></script>
    <script src="./js/module/productsList.js?go2"></script>
    <script src="./js/module/board.js?go2"></script>
    <script src="./js/module/metaTagBinder.js?go2"></script>
    <style>
        div[data-type] {
            display: none;
        }
    </style>
    <script id="template-paging" type="text/x-handlebars-template">
        <a href="javascript:;" class="btn-prev"><img src="style/img/common/btn-list-prev.png"></a>
        {{#each pages}}
        <a href="javascript:;" class="btn-page" data-page="{{this}}">{{this}}</a>
        {{/each}}
        <a href="javascript:;" class="btn-next"><img src="style/img/common/btn-list-next.png"></a>
    </script>
    <script id="template-paging-one" type="text/x-handlebars-template">
        <a href="javascript:;" class="btn-prev"><img src="style/img/common/btn-list-prev.png"></a>
        <p class="now-paging"><strong class="page">1</strong> / <span class="totalPage">1</span></p>
        <a href="javascript:;" class="btn-next"><img src="style/img/common/btn-list-next.png"></a>
    </script>
    <script id="template-productCategory" type="text/x-handlebars-template">
        <div class="element-exhibition {{dataInfo.type}}"
             style="left: {{dataInfo.data-dimension-left}};top: {{dataInfo.data-dimension-top}};width: {{dataInfo.data-dimension-width}};height: {{dataInfo.data-dimension-height}}; z-index: {{dataInfo.data-dimension-zindex}};">
            <ul id="productList_{{dataInfo.productIndex}}">
            </ul>
            <div class="table-bot-cont">
                <div class="paging" id="productList_paging_{{dataInfo.productIndex}}">
                </div>
            </div>
            <p class="btn-row">
                <button type="button" id="hasMore_product_{{dataInfo.productIndex}}" class="btn white-2 style-3-4"
                        style="visibility:hidden">더보기
                </button>
            </p>
        </div>
    </script>
    <script id="template-productCategoryList" type="text/x-handlebars-template">
        {{#each products}}
        <li>
            <div>
                <a href="./common/product.html?pno={{productNo}}">
                    <div class="exhibition_vis">
                        <div class="exhibition_vis_line">
                            <img src="{{imageUrl}}" alt=""/>
                        </div>
                        {{#ifDiscount immediateDiscountAmt additionDiscountAmt}}
                        <div class="exhibition_discount">할인</div>
                        {{/ifDiscount}}
                        {{#eq saleStatusType 'STOP'}}
                        <div class="exhibition_soldout type3">판매중지</div>
                        {{else}}
                        {{#ifStockSoon stockCnt}}
                        <div class="exhibition_soldout type2">품절임박</div>
                        {{/ifStockSoon}}
                        {{#ifStockAlready stockCnt}}
                        <div class="exhibition_soldout type1">품절</div>
                        {{/ifStockAlready}}
                        {{/eq}}
                    </div>
                </a>
                <div class="exhibition_infor">
                    <p class="exhibition_tit">{{productName}}</p>
                    {{{priceHtml}}}
                    {{#ifPeriod salePeriodType productSalePeriodType}}
                    {{#ifReady saleStatusType}}
                    <p class="exhibition_selling impend"><span>판매임박</span>{{availabilityDate}}</p>
                    {{/ifReady}}
                    {{#ifOnsale saleStatusType}}
                    <p class="exhibition_selling"><span>판매중</span>{{availabilityDate}}</p>
                    {{/ifOnsale}}
                    {{#ifFinished saleStatusType}}
                    <p class="exhibition_selling end"><span>판매종료</span>{{availabilityDate}}</p>
                    {{/ifFinished}}
                    {{/ifPeriod}}
                </div>
            </div>
        </li>
        {{/each}}
    </script>
    <script id="template-productSlide" type="text/x-handlebars-template">
        <div style="left: {{dataInfo.data-dimension-left}};top: {{dataInfo.data-dimension-top}};width: {{dataInfo.data-dimension-width}};height: {{dataInfo.data-dimension-height}}; z-index: {{dataInfo.data-dimension-zindex}};">
            <div class="element-exhibition {{dataInfo.type}}" id="productSlide_{{dataInfo.productIndex}}">
                <div class="swiper-container">
                    <div class="swiper-wrapper">
                        {{#each productsRow}}
                        <div class="swiper-slide">
                            <ul>
                                {{#each columns}}
                                <li>
                                    <div>
                                        <a href="./common/product.html?pno={{productNo}}">
                                            <div class="exhibition_vis">
                                                <div class="exhibition_vis_line">
                                                    <img src="{{imageUrl}}" alt=""/>
                                                </div>
                                                {{#ifDiscount immediateDiscountAmt additionDiscountAmt}}
                                                <div class="exhibition_discount">할인</div>
                                                {{/ifDiscount}}
                                                {{#eq saleStatusType 'STOP'}}
                                                <div class="exhibition_soldout type3">판매중지</div>
                                                {{else}}
                                                {{#ifStockSoon stockCnt}}
                                                <div class="exhibition_soldout type2">품절임박</div>
                                                {{/ifStockSoon}}
                                                {{#ifStockAlready stockCnt}}
                                                <div class="exhibition_soldout type1">품절</div>
                                                {{/ifStockAlready}}
                                                {{/eq}}
                                            </div>
                                        </a>
                                        <div class="exhibition_infor">
                                            <p class="exhibition_tit">{{productName}}</p>
                                            {{{priceHtml}}}
                                            {{#ifPeriod salePeriodType productSalePeriodType}}
                                            {{#ifReady saleStatusType}}
                                            <p class="exhibition_selling impend"><span>판매임박</span>{{availabilityDate}}
                                            </p>
                                            {{/ifReady}}
                                            {{#ifOnsale saleStatusType}}
                                            <p class="exhibition_selling"><span>판매중</span>{{availabilityDate}}</p>
                                            {{/ifOnsale}}
                                            {{#ifFinished saleStatusType}}
                                            <p class="exhibition_selling end"><span>판매종료</span>{{availabilityDate}}</p>
                                            {{/ifFinished}}
                                            {{/ifPeriod}}
                                        </div>
                                    </div>
                                </li>
                                {{/each}}
                            </ul>
                        </div>
                        {{/each}}
                    </div>
                    <div class="swiper-button-prev"></div>
                    <div class="swiper-button-next"></div>
                    <div class="swiper-pagination"></div>
                </div>
            </div>
        </div>
    </script>
    <script type="text/javascript"
            src="//dapi.kakao.com/v2/maps/sdk.js?appkey=f6a522120e42146970ef720fd26ac668"></script>
    <script id="template-map" type="text/x-handlebars-template">
        <div class="element-wrapper"
             style="left: {{dataInfo.data-dimension-left}};top: {{dataInfo.data-dimension-top}};width: {{dataInfo.data-dimension-width}};height: {{dataInfo.data-dimension-height}}; z-index: {{dataInfo.data-dimension-zindex}};"
             data-range1-style="left: {{dataInfo.data-dimension-range1-left}};top: {{dataInfo.data-dimension-range1-top}};width: {{dataInfo.data-dimension-range1-width}};height: {{dataInfo.data-dimension-range1-height}}; z-index: {{dataInfo.data-dimension-zindex}};"
             data-range2-style="left: {{dataInfo.data-dimension-range2-left}};top: {{dataInfo.data-dimension-range2-top}};width: {{dataInfo.data-dimension-range2-width}};height: {{dataInfo.data-dimension-height}}; z-index: {{dataInfo.data-dimension-zindex}};">
            <div class="element-map" data-latitude="36.387513" data-longitude="127.315875"
                 style="width:100%;height:100%"></div>
        </div>
    </script>
    <script id="template-sns" type="text/x-handlebars-template">
        <div class="element-wrapper"
             style="left: {{dataInfo.data-dimension-left}};top: {{dataInfo.data-dimension-top}};width: {{dataInfo.data-dimension-width}};height: {{dataInfo.data-dimension-height}}; z-index: {{dataInfo.data-dimension-zindex}};"
             data-range1-style="left: {{dataInfo.data-dimension-range1-left}};top: {{dataInfo.data-dimension-range1-top}};width: {{dataInfo.data-dimension-range1-width}};height: {{dataInfo.data-dimension-range1-height}}; z-index: {{dataInfo.data-dimension-zindex}};"
             data-range2-style="left: {{dataInfo.data-dimension-range2-left}};top: {{dataInfo.data-dimension-range2-top}};width: {{dataInfo.data-dimension-range2-width}};height: {{dataInfo.data-dimension-height}}; z-index: {{dataInfo.data-dimension-zindex}};">
            <div class="element-sns {{nobg}}">
                <div class="sns">
                    {{#each items}}
                    <a href="{{link}}" target="instagram" style="background-image:url({{imageUrl}});"></a>
                    {{/each}}
                </div>
            </div>
        </div>
    </script>
    <script id="template-board-type1" type="text/x-handlebars-template">
        <div class="element-board"
             style="left: {{dataInfo.data-dimension-left}};top: {{dataInfo.data-dimension-top}};width: {{dataInfo.data-dimension-width}};height: {{dataInfo.data-dimension-height}}; z-index: {{dataInfo.data-dimension-zindex}};">
            <div class="element-board-{{dataInfo.type}}">
                <div class="element-board-searchbox">
                    <div class="searchbox-area">
                        <input type="text" id="searchword_{{dataInfo.boardIndex}}">
                        <button type="button" class="btn-search" id="boardSearch_{{dataInfo.boardIndex}}">
                            검색
                        </button>
                    </div>
                </div>
                <table>
                    <colgroup>
                        <col style="width: 66%;"/>
                        <col style="width: 11%;"/>
                        <col style="width: 10%;"/>
                        <col style="width: 13%;"/>
                    </colgroup>
                    <thead>
                    <tr>
                        <th scope="col">제목</th>
                        <th scope="col">글쓴이</th>
                        <th scope="col">조회수</th>
                        <th scope="col">등록일</th>
                    </tr>
                    </thead>
                    <tbody id="board_{{dataInfo.boardIndex}}"/>
                    <tbody id="noData_board_{{dataInfo.boardIndex}}" style="display:none;">
                    <tr>
                        <td colspan="4" class="no-list">
                            작성된 게시글이 없습니다.
                        </td>
                    </tr>
                    </tbody>
                </table>
                <div class="table-bot-cont">
                    <button type="button" class="btn-board-write" id="goAdd_{{dataInfo.boardIndex}}">글쓰기</button>
                    <div class="paging" id="board_paging_{{dataInfo.boardIndex}}">
                    </div>
                </div>
            </div>
        </div>
    </script>
    <script id="boardlist-type1-template" type="text/x-handlebars-template">
        {{#each boardlist}}
        <tr>
            <td class="list-alignL">
                <a href="javascript:void(0);" onclick="goDetail({{articleNo}}, {{boardNo}})">
                    <div class="list-tit">
                        {{#if secreted}}<span class="ico-locking">비밀글</span>{{/if}}
                        {{title}}
                    </div>
                    {{#if replied}}
                    <div class="comment_num">({{repliedCnt}})</div>
                    {{/if}}
                </a>
            </td>
            <td>{{registerName}}</td>
            <td>{{viewCnt}}</td>
            <td>{{registerYmdt}}</td>
        </tr>
        {{/each}}
    </script>
    <script id="template-board-type2" type="text/x-handlebars-template">
        <div class="element-board"
             style="left: {{dataInfo.data-dimension-left}};top: {{dataInfo.data-dimension-top}};width: {{dataInfo.data-dimension-width}};height: {{dataInfo.data-dimension-height}}; z-index: {{dataInfo.data-dimension-zindex}};">
            <div class="element-board-{{dataInfo.type}}">
                <ul id="board_{{dataInfo.boardIndex}}">

                </ul>
                <ul id="noData_board_{{dataInfo.boardIndex}}" style="display:none;">
                    <li class="no-list">
                        <div>
                            작성된 게시글이 없습니다.
                        </div>
                    </li>
                </ul>
                <button type="button" class="btn-board-write" id="goAdd_{{dataInfo.boardIndex}}">글쓰기</button>
                <a href="#" class="btn-list-more" id="hasMore_board_{{dataInfo.boardIndex}}"
                   style="visibility:hidden"><span>더보기</span></a>
            </div>
        </div>
    </script>
    <script id="boardlist-type2-template" type="text/x-handlebars-template">
        {{#each boardlist}}
        <li>
            <a href="#" onclick="goDetail({{articleNo}}, {{boardNo}})">

                <p class="list-check">
                    {{#if secreted}}<span class="ico-locking after-line-right">비밀글</span>{{/if}}<img src="style/img/common/ico-list-check.png" alt="조회" style="width: auto;">
                    {{viewCnt}}</p>
                <p class="list-name">{{title}}</p>
                {{#if replied}}<p class="comment_num">({{repliedCnt}})</p>{{/if}}
                <div class="list-infor">
                    <span>{{registerName}}</span><span>{{registerYmdt}}</span>
                </div>
            </a>
        </li>
        {{/each}}
    </script>
    <script id="template-board-type3" type="text/x-handlebars-template">
        <div class="element-board"
             style="left: {{dataInfo.data-dimension-left}};top: {{dataInfo.data-dimension-top}};width: {{dataInfo.data-dimension-width}};height: {{dataInfo.data-dimension-height}}; z-index: {{dataInfo.data-dimension-zindex}};">
            <div class="element-board-{{dataInfo.type}}">
                <div class="element-board-searchbox">
                    <div class="searchbox-area">
                        <input type="text" id="searchword_{{dataInfo.boardIndex}}">
                        <button type="button" class="btn-search" id="boardSearch_{{dataInfo.boardIndex}}">검색
                        </button>
                    </div>
                </div>
                <ul id="board_{{dataInfo.boardIndex}}"></ul>
                <ul id="noData_board_{{dataInfo.boardIndex}}" style="display:none;">
                    <li>
                        <div class="no-list">
                            작성된 게시글이 없습니다.
                        </div>
                    </li>
                </ul>
                <div class="table-bot-cont">
                    <button type="button" class="btn-board-write" id="goAdd_{{dataInfo.boardIndex}}">글쓰기</button>
                    <div class="paging" id="board_paging_{{dataInfo.boardIndex}}">
                    </div>
                </div>
            </div>
        </div>
    </script>
    <script id="boardlist-type3-template" type="text/x-handlebars-template">
        {{#each boardlist}}
        <li>
            <a href="#" onclick="goDetail({{articleNo}}, {{boardNo}})">
                <div class="list-name">
                    <p>{{#if secreted}}<span class="ico-locking">비밀글</span>{{/if}}
                        {{title}}
                    </p>
                    {{#if replied}}<p class="comment_num">({{repliedCnt}})</p>{{/if}}
                </div>
                <div class="list-infor">
                    <span>{{registerName}}</span>
                    <span>{{registerYmdt}}</span>
                    <span>조회수 {{viewCnt}}</span>
                </div>
            </a>
        </li>
        {{/each}}
    </script>
    <title></title>
</head>
<body class="template large-width">
<div id="wrapper">
<jsp:include page="include_common_top.jsp"></jsp:include>
    <main data-pagewidth="wide" id="main" style="font-family: &quot;Nanum Gothic&quot;, NanumGothic, ng, 돋움, Dotum, &quot;Apple SD Gothic Neo&quot;, sans-serif; background-color: rgb(255, 255, 255);"><div class="editor-canvas" style="min-height: 584px;"><div class="bg-editor-canvas"><div class="bg-view-pc" style="background-size: 100% 100%; background-position: center center;"></div><div class="bg-view-mobile" style="background-size: 100% 100%; background-position: center center;"></div></div><div class="wrap"><div class="columnArea column-3"><div class="column" style="min-height: 584px;"><div class="element-wrapper" style="top: -0.34%;left: -1.93%;width: 102.57%;height: 106.51%;z-index: 100;"><div class="element-cover element-image no-bg"><img src="//rlyfaazj0.cdn.toastcloud.com/readyshop/19550/풀-1.png"></div></div></div><div class="column" style="min-height: 584px;"><div class="element-wrapper" style="top: -1.71%;left: -0.86%;width: 101.28%;height: 102.05%;z-index: 101;"><div class="element-cover element-image no-bg"><img src="//rlyfaazj0.cdn.toastcloud.com/readyshop/19550/가끔.jpg"></div></div><div class="element-wrapper" style="top: 26.54%;left: 0.86%;width: 98.29%;height: 61.82%;z-index: 102;"><div class="element-cover element-txt top align-center" style="width: 100%; height: 100%"><p style="width: 100%;word-break: break-all;white-space: normal;font-size: 1.263157894736842rem;letter-spacing: 0em;line-height: 2.0;font-family: NanumSquare;font-weight: normal;text-decoration: none;color: #000">먹거리가 우리 식탁에 오르기까지<br>다양한 과정을 거치게 됩니다.<br>그 과정 중에 환경과 동물에<br>수많은 영향을 미치게 되는데<br>이 영향이 윤리적으로 바르지 않다는<br>인식으로부터 시작되어<br>동물성 제품을 섭취하지 않는 것이<br>비거니즘입니다.</p></div></div><div class="element-wrapper" style="top: 9.93%;left: 1.07%;width: 97.64%;height: 7.53%;z-index: 102;"><div class="element-cover element-txt top align-center" style="width: 100%; height: 100%"><p style="width: 100%;word-break: break-all;white-space: normal;font-size: 1.5789473684210527rem;letter-spacing: 0em;line-height: 1.0;font-family: NanumSquare Bold;font-weight: normal;text-decoration: none;color: #000">가끔은 채식, 비건</p></div></div></div><div class="column" style="min-height: 584px;"><div class="element-wrapper" style="top: -0.17%;left: -26.12%;width: 126.34%;height: 101.03%;z-index: 100;"><div class="element-cover element-image no-bg"><img src="//rlyfaazj0.cdn.toastcloud.com/readyshop/19550/풀4.png"></div></div></div></div></div></div><div class="editor-canvas" style="min-height: 849px;"><div class="bg-editor-canvas"><div class="bg-view-pc" style="background-size: 100% 100%; background-position: center center;"></div><div class="bg-view-mobile" style="background-size: 100% 100%; background-position: center center;"></div></div><div class="wrap"><div class="columnArea column-3"><div class="column" style="min-height: 849px;"><div class="element-wrapper" style="top: 12.72%;left: 0.43%;width: 100%;height: 74.2%;z-index: 100;"><div class="element-cover element-image no-bg"><img src="//rlyfaazj0.cdn.toastcloud.com/readyshop/19550/비건인증그림자.png"></div></div></div><div class="column" style="min-height: 849px;"><div class="element-wrapper" style="top: 23.09%;left: 23.34%;width: 56.53%;height: 8.24%;z-index: 101;"><div class="element-cover element-txt top align-center" style="width: 100%; height: 100%; background-color: rgb(255, 255, 255);"><p style="width: 100%;word-break: break-all;white-space: normal;font-size: 2.3684210526315788rem;letter-spacing: 0em;line-height: 1.0;font-family: Poppins Medium;font-weight: normal;text-decoration: none;color: #147c6b">Go Vegan!</p></div></div><div class="element-wrapper" style="top: 39.29%;left: 0.21%;width: 99.58%;height: 23.02%;z-index: 102;"><div class="element-cover element-txt top align-center" style="width: 100%; height: 100%; background-color: rgb(255, 255, 255);"><p style="width: 100%;word-break: break-all;white-space: normal;font-size: 1.1578947368421053rem;letter-spacing: 0em;line-height: 2.0;font-family: NanumSquare;font-weight: normal;text-decoration: none;color: #000">더테스트키친의 제품은<br>동물성 재료, 동물 테스트,<br>유전자 변형 생물(GMO)의 사용 여부와<br>동물성 재료 교차 오염을 포함한<br>주방 및 위생 표준 상태를 기준으로 심사하는<br>영국 비건 협회의 인증을 받은 제품입니다.</p></div></div></div><div class="column" style="min-height: 849px;"><div class="element-wrapper" style="top: 12.13%;left: -0.21%;width: 100%;height: 70.32%;z-index: 100;"><div class="element-cover element-image no-bg"><img src="//rlyfaazj0.cdn.toastcloud.com/readyshop/19550/비건협회(1).png"></div></div><div class="element-wrapper" style="top: 38.95%;left: -0.21%;width: 99.79%;height: 24.97%;z-index: 101;"><div class="element-cover element-txt top align-center" style="width: 100%; height: 100%; background-color: rgb(255, 255, 255);"><p style="width: 100%;word-break: break-all;white-space: normal;font-size: 1.1578947368421053rem;letter-spacing: 0em;line-height: 2.0;font-family: NanumSquare;font-weight: normal;text-decoration: none;color: #000">The Vegan Society는<br>유럽, 미국, 캐나다, 호주, 인도 등의 나라가<br>등록되어 있으며 정통 비건 제품의<br>국제 표준을 대표하는 협회입니다.<br><br></p></div></div></div></div></div></div><div class="editor-canvas" style="min-height: 630px;"><div class="bg-editor-canvas"><div class="bg-view-pc" style="background-size: 100% 100%; background-position: center center;"></div><div class="bg-view-mobile" style="background-size: 100% 100%; background-position: center center;"></div></div><div class="wrap"><div class="columnArea column-3"><div class="column" style="min-height: 630px;"><div class="element-wrapper" style="top: 0%;left: -0.21%;width: 100.43%;height: 100.32%;z-index: 100;"><div class="element-cover element-image no-bg"><img src="//rlyfaazj0.cdn.toastcloud.com/readyshop/19550/ore.png"></div></div><div class="element-wrapper" style="top: 63.81%;left: 1.07%;width: 98.93%;height: 25.08%;z-index: 105;"><div class="element-cover element-txt top align-center" style="width: 100%; height: 100%"><p style="width: 100%;word-break: break-all;white-space: normal;font-size: 1.263157894736842rem;letter-spacing: 0em;line-height: 2.0;font-family: NanumSquare;font-weight: normal;text-decoration: none;color: #000">우리땅에서 자란 우리밀, 현미, <br>현미유와 제철에만 수확 가능<br>한 과일과 채소, 유기농 설탕과<br>대나무통에서 구운 죽염 등 <br>엄선한 재료를 사용합니다.</p></div></div><div class="element-wrapper" style="top: 53.97%;left: 1.07%;width: 98.93%;height: 6.35%;z-index: 107;"><div class="element-cover element-txt top align-center" style="width: 100%; height: 100%"><p style="width: 100%;word-break: break-all;white-space: normal;font-size: 1.4736842105263157rem;letter-spacing: 0em;line-height: 1.0;font-family: NanumSquare Bold;font-weight: normal;text-decoration: none;color: #000">친환경 재료</p></div></div></div><div class="column" style="min-height: 630px;"><div class="element-wrapper" style="top: -0.16%;left: -0.21%;width: 100.86%;height: 100.79%;z-index: 100;"><div class="element-cover element-image no-bg"><img src="//rlyfaazj0.cdn.toastcloud.com/readyshop/19550/오렌2.png"></div></div><div class="element-wrapper" style="top: 63.81%;left: 0.64%;width: 98.93%;height: 25.08%;z-index: 105;"><div class="element-cover element-txt top align-center" style="width: 100%; height: 100%"><p style="width: 100%;word-break: break-all;white-space: normal;font-size: 1.263157894736842rem;letter-spacing: 0em;line-height: 2.0;font-family: NanumSquare;font-weight: normal;text-decoration: none;color: #000">합성 착향료, 착색료 등과<br> 같은 인공적인 첨가물을 <br>넣지 않고 재료 본연의 향과 <br> 색, 그리고 맛을&nbsp;<br>크래커에 담았습니다.</p></div></div><div class="element-wrapper" style="top: 53.97%;left: 0.64%;width: 98.93%;height: 6.35%;z-index: 104;"><div class="element-cover element-txt top align-center" style="width: 100%; height: 100%"><p style="width: 100%;word-break: break-all;white-space: normal;font-size: 1.4736842105263157rem;letter-spacing: 0em;line-height: 1.0;font-family: NanumSquare Bold;font-weight: normal;text-decoration: none;color: #000">자연 그대로</p></div></div></div><div class="column" style="min-height: 630px;"><div class="element-wrapper" style="top: -0.63%;left: -1.07%;width: 101.07%;height: 101.11%;z-index: 100;"><div class="element-cover element-image no-bg"><img src="//rlyfaazj0.cdn.toastcloud.com/readyshop/19550/오렌1.png"></div></div><div class="element-wrapper" style="top: 53.97%;left: 0.86%;width: 98.93%;height: 6.35%;z-index: 101;"><div class="element-cover element-txt top align-center" style="width: 100%; height: 100%"><p style="width: 100%;word-break: break-all;white-space: normal;font-size: 1.4736842105263157rem;letter-spacing: 0em;line-height: 1.0;font-family: NanumSquare Bold;font-weight: normal;text-decoration: none;color: #000">최소한의 가공</p></div></div><div class="element-wrapper" style="top: 63.81%;left: 0.43%;width: 98.93%;height: 25.08%;z-index: 102;"><div class="element-cover element-txt top align-center" style="width: 100%; height: 100%"><p style="width: 100%;word-break: break-all;white-space: normal;font-size: 1.263157894736842rem;letter-spacing: 0em;line-height: 2.0;font-family: NanumSquare;font-weight: normal;text-decoration: none;color: #000">반죽과 성형을 거쳐<br>오븐에 굽는 과정으로<br>크래커를 만듭니다.</p></div></div></div></div></div></div></main>

<jsp:include page="include_common_bottom.jsp"></jsp:include>
</div>
</body>
</html>
