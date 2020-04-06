function ProductsList(type, page, pageSize, id, by, elements) {

    this.page = page;
    this.pageSize = pageSize;
    this.id = id;
    this.totalCount = 0;
    this.list = [];
    this.direction = by === 'ADMIN_SETTING' ? 'ASC' : 'DESC';

    var that = this;

    this.getProducts = function(callback) {
        if (this.page > 1 && Math.ceil(this.totalCount / this.pageSize) < this.page) {
            return;
        }

        var url = ''
        var version = '1.0';
        if(type=='category') {
            url = deployInfo.apiUrl + '/products/search?order.by=' + by + '&order.direction=DESC&fromDB=true&hasTotalCount=true&pageNumber=' + this.page + '&pageSize=' + this.pageSize + (this.id !== 'all' ? '&categoryNos=' + this.id : '');
        } else {
            url = deployInfo.apiUrl + '/display/sections/' + this.id + '?by=' + by + '&direction=' + this.direction + '&pageNumber=' + this.page + '&pageSize=' + this.pageSize + '&hasTotalCount=true';
            version = '1.1';
        }

        shop.ajax({
            url: url,
            type: 'GET',
            header: {
                Version: version
            },
            success: $.proxy(function (res) {
                var totalPageNum = Math.ceil(res.totalCount / that.pageSize);
                if (totalPageNum === 0) {
                    that.list = [];
                } else {
                    if(type=='category') {
                        this.totalCount = res.totalCount;
                        var items = res.items.map(productUtils.productMapper);
                        this.list = items;

                    } else {
                        this.totalCount =  res.productTotalCount;
                        var items = res.products.map(productUtils.productMapper);
                        this.list = items;
                    }
                }
                $(elements.productList).html('')
                $('#template-productCategoryList').renderTemplate({'products': this.list}, elements.productList);
                productUtils.imgResize('.exhibition_vis img')
                if(callback) {
                    callback(this.totalCount)
                }
            }, this)
        })
    }

    this.paging = function(page) {
        this.page = page;
        this.getProducts();
    }

}
