/**
 * Created by nhnent on 2017. 2. 22..
 */

/**
 * jquery 문법으로 handlebars 에 대한 precompiling 및 render 함수 추가
 *
 * @author hanjin lee
 */

var handlebarsTemplates = new Object();
$(function () {
    $('.handlebars_template').each(function () {
        var source = $(this).html();
        var template = Handlebars.compile(source);
        handlebarsTemplates[$(this).attr('id')] = template;
    });

})

$.fn.extend({
    render: function (data) {
        if (this.length == 0) {
            console.log("NO Element about the ID");
            return;
        }
        var id = this.attr("id");
        if (!handlebarsTemplates[id]) {
            var source = $(this).html();
            var template = Handlebars.compile(source);
            handlebarsTemplates[id] = template;
        }
        var html = handlebarsTemplates[id](data);
        if ($(this).is('script')) {
            $(this).replaceWith(html);
        } else {
            $(this).html(html);
        }

        this.show();
    },

    renderTemplate: function (data, target) {
        if (this.length == 0) {
            console.log("NO Element about the ID");
            return;
        }
        var id = this.attr("id");
        if (!handlebarsTemplates[id]) {
            var source = $(this).html();
            var template = Handlebars.compile(source);
            handlebarsTemplates[id] = template;
        }

        var html = handlebarsTemplates[id](data);

        if ($(this).is('script')) {
            $(target).html(html);
        }

        this.show();
    },

    getRenderedTemplate: function (data) {
        if (this.length == 0) {
            console.log("NO Element about the ID");
            return;
        }
        var id = this.attr("id");
        if (!handlebarsTemplates[id]) {
            var source = $(this).html();
            var template = Handlebars.compile(source);
            handlebarsTemplates[id] = template;
        }

        return handlebarsTemplates[id](data);
    },
    
});

Handlebars.registerHelper({
    gt: function (v1, v2, options) {
        if (v1 > v2) {
            return options.fn(this);
        }
        return options.inverse(this);
    },
    ge: function (v1, v2, options) {
        if (v1 >= v2) {
            return options.fn(this);
        }
        return options.inverse(this);
    },
    lt: function (v1, v2, options) {
        if (v1 < v2) {
            return options.fn(this);
        }
        return options.inverse(this);
    },
    le: function (v1, v2, options) {
        if (v1 <= v2) {
            return options.fn(this);
        }
        return options.inverse(this);
    },
    eq: function (v1, v2, options) {
        if (v1 == v2) {
            return options.fn(this);
        }
        return options.inverse(this);
    },
    ne: function (v1, v2, options) {
        if (v1 != v2) {
            return options.fn(this);
        }
        return options.inverse(this);
    },
    math: function (lvalue, operator, rvalue, options) {
        lvalue = parseFloat(lvalue);
        rvalue = parseFloat(rvalue);

        return {
            "+": lvalue + rvalue,
            "-": lvalue - rvalue,
            "*": lvalue * rvalue,
            "/": lvalue / rvalue,
            "%": lvalue % rvalue
        }[operator];
    },
    pastTime: function (timestamp) {
        return ecs.util.pastTime(timestamp);
    },
    korCurrency: function (value) {
        return ecs.util.getKorCurrency(value);
    },

    /*
     * a helper to execute an IF statement with any expression BY
     * https://gist.github.com/akhoury/9118682
     */
    xif: function (expression, options) {
        return Handlebars.helpers["x"].apply(this, [expression, options]) ? options.fn(this) : options.inverse(this);
    },

    /*
     * a helper to execute javascript expressions BY
     * https://gist.github.com/akhoury/9118682
     */
    x: function (expression, options) {
        expression = expression.replace(/&gt;/g, '>');
        expression = expression.replace(/&lt;/g, '<');
        expression = expression.replace(/&amp;/g, '&');

        var fn = function () {
        }, result;
        try {
            fn = Function.apply(this, ["window", "return " + expression + " ;"]);
        } catch (e) {
            console.warn("{{x " + expression + "}} has invalid javascript", e);
        }

        try {
            result = fn.call(this, window);
        } catch (e) {
            console.warn("{{x " + expression + "}} hit a runtime error", e);
        }
        return result;
    },
    // \n 을 <br> 로 치환합니다.
    toBr: function (value) {
        return value.replace(/\n/gi, '<br>');
    },

    lazy: function (url, optStr, options) {
        if (url != null) {
            url = url.replace("http://", "//").replace("https://", "//");
        }

        var optionStr = '';
        if ("string" == typeof optStr) {
            optionStr = optStr;
        }
        return '<img data-original="' + url + '" ' + optionStr + ' >';
    },

    img: function (url, optStr, options) {
        if (url != null) {
            url = url.replace("http://", "//").replace("https://", "//");
        }

        var optionStr = '';
        if ("string" == typeof optStr) {
            optionStr = optStr;
        }
        return '<img src="' + url + '" ' + optionStr + ' >';
    },

    dateFormat: function (timestamp, format) {
        return $.format.date(timestamp, format);
    },

    substring: function (value, start, end) {
        return value.substring(start, end);
    },

    loop: function (from, to, incr, block) {
        var accum = '';
        for (var i = from; i <= to; i += incr)
            accum += block.fn(i);
        return accum;
    },

    won: function (value) {
        return _.numberFormat(value) + "원";
    },

    ymd: function (timestamp) {
        return _.dateFormat(new Date(timestamp), 'Y-M-D');
    },

    toNumber: function (value) {
        return _.numberFormat(value);
    },

    notSalePeriod: function (buyable) {
        if (buyable == 'Y') {
            return '';
        } else {
            return 'not_open';
        }
    },

    format2decimal: function (num, options) {
        return (num).formatMoney(2, '.', ',');
    },

    mathformat2decimal: function (lvalue, operator, rvalue, options) {
        lvalue = parseFloat(lvalue);
        rvalue = parseFloat(rvalue);

        return ({
            "+": lvalue + rvalue,
            "-": lvalue - rvalue,
            "*": lvalue * rvalue,
            "/": lvalue / rvalue,
            "%": lvalue % rvalue
        }[operator]).formatMoney(2, '.', ',');
    },
    price: function (price) {
        if (price == "Free") {
            return price
        }
        return Util.numberWithCommas(String(price), "$")
    },
    addZero: function (num) {
        if (isNaN(num)) {
            return num;
        } else {
            if (num < 10 && num >= 0) {
                return "0" + num;
            } else {
                return num;
            }
        }
    }
});

Number.prototype.formatMoney = function (c, d, t) {
    var n = this,
        c = isNaN(c = Math.abs(c)) ? 2 : c,
        d = d == undefined ? "." : d,
        t = t == undefined ? "," : t,
        s = n < 0 ? "-" : "",
        i = String(parseInt(n = Math.abs(Number(n) || 0).toFixed(c))),
        j = (j = i.length) > 3 ? j % 3 : 0;
    return s + (j ? i.substr(0, j) + t : "") + i.substr(j).replace(/(\d{3})(?=\d)/g, "$1" + t) + (c ? d + Math.abs(n - i).toFixed(c).slice(2) : "");
};