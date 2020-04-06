const metaTagBinder = {
    productIndex: 0,
    boardIndex: 0,
    instagramMediaApi: '//api.instagram.com/v1/users/self/media/recent/?access_token={access_token}&count=21',
    dataTypes: {

        map: {
            bind: function (elem, dataInfo) {
                metaTagBinder.bindWrapper(elem, {dataInfo: dataInfo}, "template-map");
            }
        },
        sns: {
            bind: function (elem, dataInfo) {
                if(!deployInfo.instagramAccessToken) {
                    return;
                }
                var url = metaTagBinder.instagramMediaApi.replace('{access_token}', deployInfo.instagramAccessToken)
                $.ajax({
                    url: url,
                    type: 'GET',
                    dataType: 'jsonp',
                    success: function (res) {
                        var items = res && res.data && res.data.map(function (data) {
                            return {
                                imageUrl: data.images.standard_resolution.url,
                                link: data.link
                            }
                        })
                        metaTagBinder.bindWrapper(elem, {
                            dataInfo: dataInfo,
                            items: items,
                            nobg: items.length > 0 ? "no-bg" : ""
                        }, "template-sns");
                        snsManager.init();
                        resizeManager.resize();
                    }
                })
            }
        },
        board: {
            bind: function (elem, dataInfo) {
                metaTagBinder.boardIndex++;
                dataInfo.boardIndex = metaTagBinder.boardIndex;
                if(dataInfo['data-board-boardtype'] == 'card') {
                    dataInfo['type'] = 'type2'
                }
                else if(dataInfo['data-board-boardtype'] == 'complex') {
                    dataInfo['type'] = 'type3'
                }
                else {
                    dataInfo['type'] = 'type1'
                }
                var boardNo = dataInfo['data-board-boardid'];
                if(!boardNo || boardNo == 'null') {
                    return
                }
                metaTagBinder.bindWrapper(elem, {dataInfo: dataInfo}, "template-board-" + dataInfo['type'] );
                var pageSize = dataInfo['data-board-count'];
                var board = new Board(boardNo, pageSize, {
                    board: $('#board_' + metaTagBinder.boardIndex),
                    more: $('#hasMore_board_' + metaTagBinder.boardIndex),
                    keyword: $('#searchword_' + metaTagBinder.boardIndex),
                    add: $('#goAdd_' + metaTagBinder.boardIndex),
                    empty: $('#noData_board_' + metaTagBinder.boardIndex),
                    search: $('#boardSearch_' + metaTagBinder.boardIndex)
                }, deployInfo.boards[boardNo],
                dataInfo['type'])
                board.ready(function(totalCount) {
                    if(dataInfo['type'] == 'type3') {
                        new PagingOne(totalCount, pageSize, $('#board_paging_' + dataInfo.boardIndex), function(page) {
                            board.paging(page);
                        })
                    } else if(dataInfo['type'] == 'type1') {
                        new Paging(totalCount, pageSize, $('#board_paging_' + dataInfo.boardIndex), function(page) {
                            board.paging(page);
                        })
                    }
                });
            }
        },
        footerShopinfo: {
            bind: function (elem, dataInfo) {

                switch (dataInfo['data-text-textalign'].toLowerCase()) {
                    case 'left' :
                        dataInfo['data-class-textalign'] = 'align-left';
                        break;
                    case 'center' :
                        dataInfo['data-class-textalign'] = 'align-center';
                        break;
                    case 'right' :
                        dataInfo['data-class-textalign'] = 'align-right';
                        break;
                    case 'justify' :
                        dataInfo['data-class-textalign'] = 'align-justify';
                        break;
                }

                switch (dataInfo['data-text-verticalalign'].toLowerCase()) {
                    case 'top' :
                        dataInfo['data-class-verticalalign'] = 'top';
                        break;
                    case 'middle' :
                        dataInfo['data-class-verticalalign'] = 'mid';
                        break;
                    case 'bottom' :
                        dataInfo['data-class-verticalalign'] = 'bot';
                        break;
                }

                metaTagBinder.bindWrapper(elem, {dataInfo: dataInfo}, "template-footer-shopinfo");
            }
        },
        footerPolicy: {
            bind: function (elem, dataInfo) {

                switch (dataInfo['data-text-textalign'].toLowerCase()) {
                    case 'left' :
                        dataInfo['data-class-textalign'] = 'align-left';
                        break;
                    case 'center' :
                        dataInfo['data-class-textalign'] = 'align-center';
                        break;
                    case 'right' :
                        dataInfo['data-class-textalign'] = 'align-right';
                        break;
                    case 'justify' :
                        dataInfo['data-class-textalign'] = 'align-justify';
                        break;
                }

                switch (dataInfo['data-text-verticalalign'].toLowerCase()) {
                    case 'top' :
                        dataInfo['data-class-verticalalign'] = 'top';
                        break;
                    case 'middle' :
                        dataInfo['data-class-verticalalign'] = 'mid';
                        break;
                    case 'bottom' :
                        dataInfo['data-class-verticalalign'] = 'bot';
                        break;
                }

                metaTagBinder.bindWrapper(elem, {dataInfo: dataInfo, root: shop.getRoot()}, "template-footer-policy");
            }
        },
        product: {
            bind: function (elem, dataInfo) {
                if(dataInfo['data-product-columncount'] == '0') {
                    dataInfo.type = 'type4'
                } else {
                    dataInfo.type = 'type' + dataInfo['data-product-columncount']
                }
                metaTagBinder.productIndex++;
                dataInfo.productIndex = metaTagBinder.productIndex;
                metaTagBinder.bindWrapper(elem, {dataInfo: dataInfo}, "template-productCategory");
                var type = dataInfo['data-product-type'];
                var id = dataInfo['data-product-id'];
                var pageSize = dataInfo['data-product-productcount'];
                var productList = $('#productList_' + metaTagBinder.productIndex);
                var sortBy =  dataInfo['data-product-sortby'];
                var by = sortBy === 'new' ? 'SALE_YMD' : sortBy === 'sale' ? 'POPULAR' : sortBy === 'recent' ? 'RECENT_PRODUCT' : 'ADMIN_SETTING';
                var products = new ProductsList(type, 1, pageSize, id, by, {
                    productList: productList
                });
                products.getProducts(function(totalCount) {
                    if(dataInfo['data-product-columncount'] != '0') {
                        new Paging(totalCount, pageSize, $('#productList_paging_' + dataInfo.productIndex), function(page) {
                            products.paging(page);
                        })
                    }
                });

            }
        },
        productSlide: {
            bind: function (elem, dataInfo) {
                metaTagBinder.fetchProducts(dataInfo, function (products) {
                    if(dataInfo['data-product-columncount'] == '0') {
                        dataInfo.type = 'type4'
                    } else {
                        dataInfo.type = 'type' + dataInfo['data-product-columncount']
                    }
                    metaTagBinder.productIndex++;
                    dataInfo.productIndex = metaTagBinder.productIndex;
                    var count = dataInfo['data-product-productcount'];
                    var productsRow = []
                    var productsColumn = {
                        columns: []
                    }
                    products.forEach(function (product) {
                        productsColumn.columns.push(product)
                        if (productsColumn.columns.length == count) {
                            productsRow.push($.extend({}, productsColumn));
                            productsColumn.columns = [];
                        }
                    });
                    if (productsColumn.columns.length > 0) {
                        productsRow.push($.extend({}, productsColumn));
                    }

                    var data = {
                        dataInfo: dataInfo,
                        productsRow: productsRow
                    }
                    metaTagBinder.bindWrapper(elem, data, "template-productSlide");
                    metaTagBinder.swiper($('#productSlide_' + metaTagBinder.productIndex + " .swiper-container"),'productSlide');
                    productUtils.imgResize('.exhibition_vis img')
                });
            }
        }
    },
    bind: function (target) {
        $(target).find("[data-type]").each(function () {
            var dataInfo = metaTagBinder.attributeToObject(this);
            var elem = $(this);
            var dataType = dataInfo['data-type'];
            metaTagBinder.dataTypes[dataType].bind(elem, dataInfo);
        });
    },
    attributeToObject: function (element) {
        var attributes = element.attributes;
        return Object.keys(attributes).map(function (key) {
            return attributes[key];
        }).reduce(function (a, b) {
            a[b.name] = b.value;
            return a;
        }, {})
    },
    bindWrapper: function (elem, data, templateId) {
        var templateElem = document.getElementById(templateId);
        if (templateElem) {
            var template = Handlebars.compile(templateElem.innerHTML);
            var html = template(data)
            elem.replaceWith(html);
        }
    },
    fetchProducts: function (dataInfo, cb) {
        if (dataInfo['data-product-type'] === 'category') {
            this.featchProductsByCategory(dataInfo, cb);
        } else if (dataInfo['data-product-type'] === 'section') {
            this.fetchProductsBySection(dataInfo, cb);
        }
    },
    fetchProductsBySection: function (dataInfo, cb) {
        var id = dataInfo['data-product-id']
        var sortBy =  dataInfo['data-product-sortby'];
        var by = sortBy === 'new' ? 'SALE_YMD' : sortBy === 'sale' ? 'POPULAR' : sortBy === 'recent' ? 'RECENT_PRODUCT' : 'ADMIN_SETTING';
        var direction = by === 'ADMIN_SETTING' ? 'ASC' : 'DESC';
        var count = dataInfo['data-product-productcount'];
        shop.ajax({
            url: deployInfo.apiUrl + '/display/sections/' + id + '?by=' + by + '&direction=' + direction + '&pageNumber=1&pageSize=36&hasTotalCount=true',
            type: 'GET',
            header: {
                Version: '1.1'
            },
            success: function (res) {
                cb(res.products.map(productUtils.productMapper));
            }
        })
    },
    featchProductsByCategory: function (dataInfo, cb) {
        var id = dataInfo['data-product-id'];
        var by = dataInfo['data-product-sortby'] === 'new' ? 'SALE_YMD' : dataInfo['data-product-sortby'] === 'sale' ? 'POPULAR' : dataInfo['data-product-sortby'] === 'recent' ? 'RECENT_PRODUCT' : '';
        shop.ajax({
            url: deployInfo.apiUrl + '/products/search?order.by=' + by + '&order.direction=DESC&fromDB=true&hasTotalCount=true&pageNumber=1&pageSize=36' + (id !== 'all' ? '&categoryNos=' + id : ''),
            type: 'GET',
            success: function (res) {
                cb(res.items.map(productUtils.productMapper));
            }
        })
    },
    swiper: function ($elem,kind) {
        if(!$elem) {
            $elem = $('.swiper-container')
        }
        var pagination = {};
        if(kind == 'productSlide'){
            pagination = {
                el: '.swiper-pagination',
                clickable: true
            };
        }else{
            pagination = {
                el: '.swiper-pagination',
                type: 'fraction' // 페이지네이션 타입을 꼭 넣어줘야 함,
            };
        }
        $elem .each(function (i, el) {
            var swiper = new Swiper(el, {
                navigation: {
                    nextEl: '.swiper-button-next',
                    prevEl: '.swiper-button-prev',
                    disabledClass: 'no-class'
                },
                pagination: pagination,
                observer: true,
                observeParents: true
            });
        });
    },
    daumMap: function () {
        if(typeof daum === "undefined") {
            return
        }
        $('.element-map').each(function (index, container) {
            var latitude = $(container).attr("data-latitude");
            var longitude = $(container).attr("data-longitude");

            // 마커가 표시될 위치입니다
            var markerPosition = new daum.maps.LatLng(parseFloat(latitude), parseFloat(longitude));
            var options = {
                center: markerPosition,
                level: 3
            };

            var map = new daum.maps.Map(container, options);

            // 마커를 생성합니다
            var marker = new daum.maps.Marker({
                position: markerPosition
            });

            // 마커가 지도 위에 표시되도록 설정합니다
            marker.setMap(map);
        });
    }

}

const resizeManager = {
    standardWidth1Column: 1200,
    standardWidth2Column: 600,
    standardWidth3Column: 400,
    resizeWidthStage1: 768,
    resizeWidthStage2: 481,
    $editorCanvas: null,
    init: function() {
        var that = this;
        //todo: product, board의 min-height 강제 제거를 스크립트에서 처리함. 이후 디자인센터에서 올려주는 값 자체에서 빠지는게 좋겠다.
        var productAndBoard = $('.editor-canvas:has(div[data-type=product]), .editor-canvas:has(div[data-type=productSlide]), .editor-canvas:has(div[data-type=board])')
        productAndBoard.each(function() {
            // $(this).css('min-height', '')
            // $(this).find('.column').css('min-height', '')
        })
        this.$editorCanvas = $('.editor-canvas:has(.column-1), .editor-canvas:has(.column-2), .editor-canvas:has(.column-3)')
                            // .filter(':not(:has(div[data-type=product]))')
                            // .filter(':not(:has(div[data-type=productSlide]))')
                            .filter(':not(:has(div[data-type=board]))');
                            //.filter(':not(:has(div.footer-shopinfo))')
                            //.filter(':not(:has(div.footer-policy))');

        this.$editorCanvas.each(function () {
            var $this = $(this);
            var minHeight = $this.css('min-height').replace('px', '')
            var standardWidth = $this.find('.wrap .column-1').length ? that.standardWidth1Column : $this.find('.wrap .column-2').length ? that.standardWidth2Column : that.standardWidth3Column;
            var setColum = $this.find('.wrap .column-1').length ? 1 : $this.find('.wrap .column-2').length ? 2 : 3;
            $this.css('min-height', '');
            $this.find('div.column').css('min-height', '');
            var rate = minHeight / standardWidth;
            var rate1 = minHeight / resizeManager.resizeWidthStage1;
            var rate2 = minHeight / resizeManager.resizeWidthStage2;
            $this.attr('data-rate', rate);
            $this.attr('data-rate1', rate1);
            $this.attr('data-rate2', rate2);
            $this.attr('data-standard-width', standardWidth);
            $this.attr('data-column-set', setColum);

            var $resizeSelector = $this.find('.element-wrapper');
            $resizeSelector.each(function(){
                var style = $(this).prop('style').cssText;
                var styleTop = $(this).prop('style').top;

                $(this).attr('data-ori-style', style);
                $(this).attr('data-top-style', styleTop);
            })
            that.resizeSection($this);
        })
        metaTagBinder.daumMap();
    },
    resize: function() {
        var that = this;
        this.$editorCanvas.each(function () {
            that.resizeSection($(this));
        })
    },
    resizeSection: function($elem) {
        var standardWidth = $elem.attr('data-standard-width');
        var rate = $elem.attr('data-rate');
        var rate1 = $elem.attr('data-rate1');
        var rate2 = $elem.attr('data-rate2');
        var setColum = $elem.attr('data-column-set');
        var width = $elem.width();
        var columns = $elem.find('.column, .bg-editor-canvas');
        if (width < 1024) {
            // $('.element-wrapper:has(p)').each(function() {
            //     $(this).css('height', $(this).find('p').height() + "px")
            // })
            var newHeight = Math.floor(rate * width);

            columns.each(function() {
                var $column = $(this);
                $column.width('100%');
                $column.css('min-height', newHeight + 'px');
                $elem.css({'min-height': newHeight + 'px'});

                /*
                var adjustElements = $column.find('.element-cover').filter(function(index) {
                    return $(this).css('height').endsWith('px')
                    //return $(this).hasClass('element-txt') && $(this).css('height').endsWith('px')
                })

                var bottoms = adjustElements.map(function() {
                    var height = Math.max($(this).parents(".element-wrapper").height(), $(this).height(), $(this).find("p") && $(this).find("p").height() || 0)
                    var top = Math.max($(this).parents(".element-wrapper").position().top, $(this).position().top)
                    return height + top;
                }).toArray().reduce(function(a,b) {
                    return Math.max(a,b)
                }, 0)
                if(bottoms > $column.height()) {
                    $column.css('min-height', bottoms + 'px')
                }
                */

                if ($column.data('mobileoptimize') == true) {
                    var $resizeSelector = $column.find('.element-wrapper');
                    var swiperControl = $column.find('.swiper-control-wrap');
                    var modiHeight = 0;

                    if ($elem.innerWidth() > resizeManager.resizeWidthStage1) {
                        $resizeSelector.each(function(){
                            $(this).prop('style', $(this).data('oriStyle'));
                        })
                        $column.css('min-height', Math.floor(newHeight + 'px'));
                        $column.parent().parent().parent().css('min-height', Math.floor(newHeight + 'px'));
                        // $column.parent().parent().parent().find('.bg-editor-canvas').css('height', Math.floor(newHeight + 'px'));
                        swiperControl.css('position','');
                        swiperControl.css('margin','');
                        swiperControl.css('width','');
                    } else {
                        if ($elem.innerWidth() <= resizeManager.resizeWidthStage1 && $elem.innerWidth() > resizeManager.resizeWidthStage2) {
                            $resizeSelector.each(function(){
                                $(this).prop('style', $(this).data('range1Style'));
                            })
                            modiHeight += rate1 * $elem.innerWidth();
                        } else if ($elem.innerWidth() <= resizeManager.resizeWidthStage2) {
                            $resizeSelector.each(function(){
                                $(this).prop('style', $(this).data('range2Style'));
                            })
                            modiHeight += rate2 * $elem.innerWidth();
                        }
                        swiperControl.css('position','relative');
                        swiperControl.css('margin','0 auto');
                        swiperControl.css('width',$elem.innerWidth() + 'px');
                        $column.css('min-height', Math.floor(modiHeight) + 'px');
                        $column.parent().parent().parent().css('min-height', Math.floor(modiHeight) + 'px');
                        // $column.parent().parent().parent().find('.bg-editor-canvas').css('height', Math.floor(modiHeight) + 'px');
                    }
                }
            })

        } else {
            $elem.find('.column').width('');
            var newHeight = Math.floor(rate * standardWidth);
            $elem.find('div.column').css('min-height', newHeight + 'px');
            $elem.css({'min-height': newHeight + 'px'});
        }

        // 텍스트 요소 높이가 섹션을 넘는 경우
        columns.each(function() {
            var $column = $(this);
            var tempBottom = [];
            var chkFooter = 0;
            if ($column.find('.element-txt').length > 0) {
                var $elementWapper = $column.find('.element-wrapper');
                $elementWapper.each(function(){
                    chkFooter = $(this).find('.footer-shopinfo').length;
                    if($column.height() < ($(this).find('.element-txt').height() + $(this).position().top)) {
                        var tempMarginBottom = ($(this).find('.element-txt').height() + $(this).position().top) - $column.height();
                        tempBottom.push(tempMarginBottom);
                    }
                })
                var setMarginBottom = Math.max.apply(null, tempBottom);
                if(chkFooter > 0) {
                    setMarginBottom += 20;
                }
                $column.css('margin-bottom', setMarginBottom + 'px');
            }
        })

        // 모바일 헤더 겹치기 예외 처리
        if ($('#header #header_mobile').hasClass('overrap-mode') && !window.location.pathname.startsWith('/common')) {
            $('#header #header_mobile').find('.editor-canvas:first').css('min-height', '70px');
        }
    }
}

const footerManager = {
    $shopinfo: null,
    $policy: null,
    $column: null,
    init: function() {
        this.$shopinfo = $('footer div.element-wrapper:has(div.footer-shopinfo)')
        this.$shopinfo.attr('data-init-left', this.$shopinfo[0].style.left)
        this.$shopinfo.attr('data-init-top', this.$shopinfo[0].style.top)
        this.$shopinfo.attr('data-init-width', this.$shopinfo[0].style.width)
        this.$shopinfo.attr('data-init-height', this.$shopinfo[0].style.height)
        this.$shopinfo.find('ul > li').css('color',this.$shopinfo[0].style.color);
        this.$policy = $('footer div.element-wrapper:has(div.footer-policy)')
        this.$policy.attr('data-init-left', this.$policy[0].style.left)
        this.$policy.attr('data-init-top', this.$policy[0].style.top)
        this.$policy.find('ul > li > a').css('color',this.$policy[0].style.color);
        this.$column = this.$shopinfo.parent('.column');
        this.$column.attr('data-init-height', this.$column[0].style.minHeight)
        this.resize()
    },
    setMobile: function() {
        this.$shopinfo.css({
            'left': '15px',
            'top': '40px',
            'width': '100%',
            'height': '160px'
        })
        this.$policy.css({
            'left': '15px',
            'top': '15px',
            'cursor': 'unset'
        })
        this.$column.css({
            'min-height': '230px'
        })
    },
    setPc: function() {
        this.$shopinfo.css({
            'left': this.$shopinfo.attr('data-init-left'),
            'top': this.$shopinfo.attr('data-init-top'),
            'width': this.$shopinfo.attr('data-init-width'),
            'height': this.$shopinfo.attr('data-init-height')
        })
        this.$policy.css({
            'left': this.$policy.attr('data-init-left'),
            'top': this.$policy.attr('data-init-top')
        })
        this.$column.css({
            'min-height': this.$column.attr('data-init-height')
        })
    },
    resize: function() {
        var width = $('footer').width();
        if(width < 1024) {
            this.setMobile()
        } else {
            this.setPc();
        }
    }

}

const snsManager = {
    sns: null,
    init: function() { //call after binding sns (metaTagBinder.dataTypes.sns)
        this.sns = $('.editor-canvas .element-wrapper:has(.sns)');
        this.resize();
    },
    resize: function() {
        if(!this.sns.length) {
            return
        }
        var width = $('body').width();
        if(width < resizeManager.standardWidth1Column) {
            /*
            this.sns.css({
                position: 'static'
            })
            */
        } else {
            this.sns.css({
                position: 'absolute'
            })
        }
    }
}

$(function () {
    if(deployInfo.pageWidth == 'narrow') {
        $('body').addClass("small-width")
        resizeManager.standardWidth1Column = 1024;
    } else if(deployInfo.pageWidth == 'wide') {
        $('body').addClass("large-width")
        resizeManager.standardWidth1Column = 1400;
    } else {
        $('body').addClass("normal-width")
    }

    resizeManager.standardWidth2Column = resizeManager.standardWidth1Column/2;
    resizeManager.standardWidth3Column = resizeManager.standardWidth1Column/3

    metaTagBinder.swiper();
    //resizeManager.init();
    metaTagBinder.bind($('body'));
    snsManager.init();

    $("#header").load(shop.getRoot() + "/header.html", function () {
        metaTagBinder.bind($('#header'));
        metaTagBinder.swiper();
    });

    $("#footer").load(shop.getRoot() + "/footer.html", function () {
        metaTagBinder.bind($('#footer'));
        //footerManager.init();
        resizeManager.init(); //하단로드시 리사이징 되게 수정 추후 변경 요망
    });

    $(window).resize(function () {
        resizeManager.resize();
        //footerManager.resize();
        snsManager.resize();
    })
});

