//数据分页

// 创建一个闭包 -- 内部定义的方法只允许本插件使用    
(function ($) {

    //调用该方法获取最新数据并展示
    function refleshData(container, exeCountSql) {
        var $pagerinfo = $(container).find(".pagerinfo");
        //获取请求网址
        var url = getContainerUrl(container);
        //构建请求参数
        var param = "PageIndex=" + $pagerinfo.attr("data-pageindex") +
            "&orderField=" + $pagerinfo.attr("data-orderfield") +
            "&orderWay=" + $pagerinfo.attr("data-orderway") + getContainerFilter(container) + "&rand=" + Math.random();
        //URL参数合并  rui.tool.js
        url = joinUrl(url, param);

        //判断是否需要重新获取数据行数
        if (exeCountSql == true)
            url = url + "&exeCountSql=true";
        else
            url = url + "&exeCountSql=false";

        //执行刷新前钩子函数
        var options = $.data(container, "pager");
        options.refleshing();

        //异步请求
        $.ajax({
            type: 'get',
            dataType: "html",
            url: url,
            success: function (data) {
                //更新表格数据
                updateTableData(container, data);
                //刷新分页栏
                if (exeCountSql == true) {
                    initPager(container);
                }
                //设置表格事件和样式
                setTableEventAndStyle(container);
                //刷新后执行
                options.refleshed();
            }
        });
    }

    //构建EasyUI分页栏
    function initPager(container) {
        //获取分页插件对应的对外参数（paging，paged，refleshing，refleshed）
        var options = $.data(container, "pager");
        //获取相关标记
        var $pager = $(container).find(".pager");
        var $pagerinfo = $(container).find(".pagerinfo");

        //利用相关参数生成分页组件
        $($pager).pagination({
            total: $pagerinfo.attr("data-rowcount"),
            pageSize: $pagerinfo.attr("data-pagesize"),
            layout: ['first', 'prev', 'links', 'next', 'last'],
            displayMsg: "每页:" + $pagerinfo.attr("data-pagesize") + "; 总记录数:" + $pagerinfo.attr("data-rowcount") + "; 总页数:" + $pagerinfo.attr("data-pagecount"),
            onSelectPage: function (pageNumber, pageSize) {
                //分页前执行
                options.paging();

                //获取分页信息
                var $pagerinfo = $(container).find(".pagerinfo");
                //构造请求的URL
                var url = getContainerUrl(container);
                //构造请求的参数
                var param = "PageIndex=" + pageNumber +
                    "&exeCountSql=false" +
                    "&orderField=" + $pagerinfo.attr("data-orderfield") +
                    "&orderWay=" + $pagerinfo.attr("data-orderway") + getContainerFilter(container) + "&rand=" + Math.random();
                //URL参数合并  rui.tool.js
                url = joinUrl(url, param);

                //异步请求
                $.ajax({
                    type: 'get',
                    dataType: "html",
                    url: url,
                    success: function (data) {
                        //更新表格数据 rui.table.js
                        updateTableData(container, data);
                        //设置表格事件和样式  rui.table.js
                        setTableEventAndStyle(container);
                        //分页后执行
                        options.paged();
                    }
                });
            }
        });

        //如果只有一页，则隐藏分页栏
        if (parseInt($pagerinfo.attr("data-pagecount")) <= 1) {
            $($pager).hide();
        } else {
            $($pager).show();
        }
    }

    //对外公开的方法 -- 生成分页栏 
    //container 是包含有search,pager,showData三个层的容器,showData内部有pagerinfo,用来保存分页信息的
    $.fn.pager = function (options, param) {
        //当参数是方法名时调用插件方法
        if (typeof options == 'string') {
            return $.fn.pager.methods[options](this, param);
        }

        //info("pager分页插件开始");
        return this.each(function () {
            //参数默认值
            options = options || {};
            //默认参数
            var defaultoptions = $.fn.pager.defaultoptions;
            //参数覆盖合并
            var result = $.extend(true, {}, defaultoptions, options);
            var container = this;
            //存入缓存
            $.data(container, "pager", result);

            //获取展示容器和元素
            var $search = $(container).find(".search");
            var $pager = $(container).find(".pager");
            var $pagerinfo = $(container).find(".pagerinfo");
            var $showData = $(container).find(".showData");

            //初次加载 设置分页栏和表格样式
            initPager(container);
            //初次加载 设置表格事件和样式
            setTableEventAndStyle(container);

            //搜索按钮单击之后,异步搜索数据
            $(container).find(".opSearch").on("click", function () {
                var url = getContainerUrl(container);
                var param = "PageIndex=1" +
                    "&exeCountSql=true" + getContainerFilter(container) + "&rand=" + Math.random();
                if (url.indexOf('?') == -1)
                    url = url + "?" + param;
                else
                    url = url + "&" + param;

                //获取分页插件参数
                var options = $.data(container, "pager");

                //搜索前调用searching完成相关的判断
                var result = options.searching();
                if (result!= "") {
                    showError(result);
                    return false;
                }

                //分页前执行
                options.paging();

                //异步请求
                $.ajax({
                    type: 'get',
                    dataType: "html",
                    url: url,
                    success: function (data) {
                        //重新搜索后刷新表格数据
                        updateTableData(container, data);
                        //创建分页栏
                        initPager(container);
                        //设置表格事件和样式
                        setTableEventAndStyle(container);
                        //返回第一页
                        var total = $(container).find(".pagerinfo").attr("data-rowcount");
                        $($(container).find(".pager")).pagination('refresh', {
                            total: total,
                            pageNumber: 1
                        });
                        //分页后执行
                        options.paged();
                    }
                });
                return false;
            });

            //excel导出按钮点击后,回传搜索条件进行数据导出
            $(container).find(".opExlExport").on("click", function () {
                var url = $(this).attr("href");
                var param = "PageIndex=1" +
                    "&exeCountSql=false" + getContainerFilter(container) + "&rand=" + Math.random();
                if (url.indexOf('?') == -1)
                    url = url + "?" + param;
                else
                    url = url + "&" + param;

                //请求文件下载
                window.location.href = url;
                return false;
            });
        });
    };

    //插件方法列表 调用方法：$("#container").pager("reflesh",true);
    $.fn.pager.methods = {
        reflesh: function (jq, param) {
            return jq.each(function () {
                refleshData(this, param);
            });
        }
    };

    //默认参数列表，对外的钩子函数
    //调用方法： $("#container").pager({ paging: function () { }, paged: function () { } })
    $.fn.pager.defaultoptions = {
        //分页前执行
        paging: function () {
            //info("默认分页前");
        },
        //分页后执行
        paged: function () {
            //info("默认分页后");
        },
        //刷新前执行
        refleshing: function () {
            //info("默认刷新前");
        },
        //刷新后执行
        refleshed: function () {
            //info("默认刷新后");
        },
        //搜索之前
        searching: function () {
            //info("默认搜索前");
            return "";
        }
    };
})(jQuery);