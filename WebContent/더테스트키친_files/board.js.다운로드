$(function () {
    var boardNo = shop.getUrlParam('boardNo');
    if(boardNo) {
        var board = new Board(boardNo, 10, {
            board: $('#board'),
            more: $('#hasMore'),
            keyword: $('#searchword'),
            add: $('#goAdd'),
            empty: $('#noData'),
            search: $('#boardSearch')
        }, deployInfo.boards[boardNo]);
        board.ready();
    }
})

function Board(boardNo, pageSize, elements, config, type) {
    this.boardNo = boardNo;
    this.pageNumber = 1;
    this.pageSize = pageSize;
    this.keyword = '';
    this.list = [];
    this.searchFlag = false;
    this.config = config;
    this.ready = function (callback) {
        if(!config)
            return;
        var that = this;
        this.getBoard(callback);
        if ((config.memberWrite && shop.isLogin()) || config.guestWrite) {
            elements.add.show();
        }
        elements.keyword.on('keypress', function(e) {
            var keyCode = e.keyCode || e.which;
            if (keyCode === 13) {
                e.preventDefault();
                that.search(callback);
                return false;
            }
        })
        elements.search.click(function () {
            that.search(callback);
        })

        if(!config.memberWrite) {
            elements.add.css("display", "none")
        }
        else {
            elements.add.click(function () {
                window.location.href = shop.getRoot() + 'common/boardadd.html?boardNo=' + that.boardNo;
            })
        }

        if(config.title) {
            $(".title").text(config.title)
        }

        elements.more.on('click', $.proxy(this.more, this))
    }
    this.search = function(callback) {
        if ($.trim(elements.keyword.val()) === '') {
            alert('검색어를 입력하세요.');
            return;
        }
        this.list = [];
        this.pageNumber = 1;
        this.keyword = encodeURIComponent($.trim(elements.keyword.val()));
        if (this.searchFlag) {
            return;
        }
        this.searchFlag = true;
        this.getBoard(callback);
    }
    this.getBoard = function (callback) {
        var that = this;
        shop.ajax({
            url: deployInfo.apiUrl + '/boards/' + this.boardNo + '/articles?hasTotalCount=true&pageNumber=' + that.pageNumber + '&pageSize=' + that.pageSize + (that.keyword ? ('&keyword=' + that.keyword) : ''),
            type: 'GET',
            data: null,
            success: $.proxy(function (res) {
                var totalPageNum = Math.ceil(res.totalCount / that.pageSize);
                if (totalPageNum === 0) {
                    elements.more.css('display', 'none');
                    elements.empty.css('display', '');
                    elements.board.css('display', 'none');
                    that.list = [];
                } else {
                    var items = res.items;
                    for (var i = 0; i < items.length; i++) {
                        items[i].registerYmdt = items[i].registerYmdt.substring(0, 10);
                        items[i].boardNo = that.boardNo;
                        items[i].registerName =  this.registerNameMasking(items[i].registerName)
                    }
                    if(type != 'type2') {
                        that.list = [];
                    }
                    $.merge(that.list, items);
                    var hasMore = true;
                    if (totalPageNum === that.pageNumber) {
                        hasMore = false;
                    }
                    hasMore ? elements.more.css('visibility', 'visible') : elements.more.css('visibility', 'hidden');
                    elements.more.css('display', 'block');
                    elements.empty.css('display', 'none');
                    elements.board.css('display', '');
                    $('#boardlist-' + type + '-template').renderTemplate({'boardlist': that.list}, elements.board);
                    if(callback) {
                        callback(res.totalCount);
                    }
                }
            }, this),

            complete: $.proxy(function () {
                this.searchFlag = false;
            }, this)
        })
    }
    this.more = function() {
        this.pageNumber += 1;
        this.getBoard();
    }

    this.paging = function(page) {
        this.pageNumber = page;
        this.getBoard();
    }

    this.registerNameMasking = function(name) {
        if(name == '운영자') {
            return name
        }
        if(!name) {
            return '비회원'
        }
        //email은 서버에서 마스킹
        if(name.indexOf("@") > 0) {
            return name
        }
        if(name.length > 2) {
            return name.substr(0,1) + name.replace(/./gi, "*").substr(1, name.length -2) + name.substr(name.length - 1)
        } else {
            return name.substr(0,1) + "*"
        }

    }

}

function goDetail(articleNo, boardNo) {
    window.location.href = shop.getRoot() + 'common/boarddetail.html?articleno=' + articleNo + '&boardNo=' + boardNo;
}
