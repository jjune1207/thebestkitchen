function Paging(totalCount, pageSize, elements, callback) {
    this.page = 1;

    var termSize = 5;

    this.range = [];

    var totalPage =  Math.ceil(totalCount / pageSize);

    this.setPage = function(page) {
        this.page = Number(page);
        $(elements).find('a.on').removeClass("on");
        $(elements).find('a[data-page=' + this.page + ']').addClass("on")
    }

    this.randering = function() {
        $('#template-paging').renderTemplate({'pages': this.range}, elements);
        $(elements).find('a[data-page=' + this.page + ']').addClass("on")
    }

    this.changeTerm = function(newPage) {
        var startIndex = newPage - ((newPage - 1) % termSize)
        this.range = [];
        for(var i=startIndex;i <= Math.min(startIndex + termSize - 1, totalPage);i++) {
            this.range.push(i)
        }
        this.page = newPage;

        this.randering();

    }

    this.changeTerm(1);

    this.pageChange = function(newPage) {
        this.page = Number(newPage);
        callback(this.page)
        $(elements).find('a.on').removeClass("on")
        $(elements).find('a[data-page=' + this.page + ']').addClass("on")
    }

    $(elements).on('click', '.btn-prev', $.proxy(function() {
        var newPage = this.page - 1;
        if(newPage < 1) {
            return;
        }
        this.changeTerm(newPage);
        this.pageChange(newPage)
    }, this))

    $(elements).on('click', '.btn-next', $.proxy(function() {
        var newPage = this.page + 1;
        if(newPage > totalPage) {
            return;
        }
        this.changeTerm(newPage);
        this.pageChange(newPage)
    }, this))

    const that = this;
    $(elements).on('click', '.btn-page', function() {
        that.pageChange($(this).attr("data-page"))
    });


}

function PagingOne(totalCount, pageSize, elements, callback) {
    this.page = 1;

    this.range = [];

    var totalPage =  Math.ceil(totalCount / pageSize);


    this.randering = function() {
        $('#template-paging-one').renderTemplate({}, elements);
    }
    this.randering();

    var pageElem = elements.find('.page')
    var totalPageElem = elements.find('.totalPage')
    totalPageElem.text(totalPage);


    $(elements).on('click', '.btn-prev', $.proxy(function() {
        this.page--;
        if(this.page < 1) {
            this.page = 1;
        }
        pageElem.text(this.page);
        callback(this.page)
    }, this))

    $(elements).on('click', '.btn-next', $.proxy(function() {
        this.page++;
        if(this.page > totalPage) {
            this.page = totalPage;
        }
        pageElem.text(this.page);
        callback(this.page)
    }, this))
}
