//当表格没有操作列的时候，在序列号中包含opRow样式，在showData选择符上增加data-opRow="序号"
var layTable = (function () {

    //汇总设置表格用到的相关方法
    function setTable(container) {
        //给里边的select增加 lay-ignore 忽略layTable渲染
        $(container).find(".showData>table td select").attr("lay-ignore", "");

        //创建选择列
        createTableCbxCol(container);

        //应用LayTable
        useLayTable(container);
    }

    //对外公开的方法
    let out = {
        setLayTable: setTable
    }
    return out;

    //使用layUITable渲染原表格
    function useLayTable(container) {
        //禁用垂直滚动条
        $("body").css("overflow-y", "hidden");

        //增加转换标示,并隐藏
        $(container).find(".ruiTable").attr("lay-filter", "layTable").css("display", "none");

        //增加表格属性-支持基础属性
        var option = {};
        //id标识
        option.id = "layTableID";
        //开启工具栏
        //option.toolbar = true; 
        //奇偶行
        //option.even = true;
        //小表格
        option.size = "sm";
        //每页行数
        option.limit = $(container).find(".pagerinfo").attr("data-pagesize");
        //如果有汇总行，则自动加1
        if ($(container).find(".sumRow").length > 0)
            option.limit = option.limit + 1;
        //自动行高
        option.height = "full-" + parseInt(($(container).find(".showData").offset().top + 2));
        //自动排序
        option.autoSort = false;
        //执行完毕
        option.done = function () {
            setTableRowStyle(container);
            if ($(container).find(".sumRow").length > 0) {
                $(container).find(".layui-table-main table tr").last().addClass("sumRow");
            }
            $(container).find(".ruiTable").remove();
        }
        //进行转换
        layui.use('table', function () {
            var table = layui.table;
            //转化静态表格
            console.info("layTable init");
            console.info(option);
            table.init('layTable', option);

            //绑定超出列效果
            bindTableTdDivOmit(container);

            //绑定排序列事件
            bindTableColSortEvent(container, table);

            //分页后设置已勾选的勾选上
            setTableCbxSelectedOnPaged(container);
            //绑定行的勾选事件
            handleTableCbxEvent(container, table);

        });
    }

    //设置Table奇偶列样式和鼠标上去样式
    function setTableRowStyle(container) {
        console.info("setLayTableRowStyle");

        //设定主体奇偶行的样式
        $(container).find(".showData .layui-table-main tbody tr:even").addClass("even");
        $(container).find(".showData .layui-table-main tbody tr:odd").addClass("odd");

        //设定左侧奇偶行的样式
        $(container).find(".showData .layui-table-fixed-l tbody tr:even").addClass("even");
        $(container).find(".showData .layui-table-fixed-l tbody tr:odd").addClass("odd");

        //设定右侧奇偶行的样式
        $(container).find(".showData .layui-table-fixed-r tbody tr:even").addClass("even");
        $(container).find(".showData .layui-table-fixed-r tbody tr:odd").addClass("odd");
    }

    //绑定单元格内的div的,有...的时候弹出来显示
    //处理div内容过多的问题
    function bindTableTdDivOmit(container) {
        console.info("bindLayTableTdDivOmit");
        var tipIndex = 0;
        $(container).find(".showData .layui-table-cell").mouseenter(function (e) {
            if (htmlDecode($(this).html().trim()) == $(this).text().trim()) {
                var thisWidth = $(this)[0].clientWidth;
                var wordWidth = $(this)[0].scrollWidth;
                if (wordWidth > thisWidth) {
                    tipIndex = showTip($(this).text(), this, { tips: [2, 'black'], time: 60000, maxWidth: 400 });
                }
            }
        });
        $(container).find(".showData .layui-table-cell").mouseout(function () {
            closeTip(tipIndex);
        })
    }

    //生成批量勾选列 ruiTable和layTable 一起处理
    function createTableCbxCol(container) {
        console.info("createRuiTableCbxCol");

        //如果需要选择框,则创建
        if ($(container).find(".showData").hasClass("cbxCol")) {
            $(container).find(".showData  thead tr").prepend("<th lay-data=\"{field:'cbx',checkbox:true, fixed:'left'}\"><input type='checkbox' /></th>");
            $(container).find(".showData  tbody tr").prepend("<td><input type='checkbox' /></td>");

            //将每行的标识数据放在操作列中,方便批量选择
            $(container).find("tbody tr").each(function () {
                var id = $(this).data("id");
                var code = $(this).data("code");
                $(this).find(".opRow").prepend("<input class='trData' type='hidden' data-code='" + code + "' data-id='" + id + "' />");
            });
        }

        //生成layTable行配置数据
        $(container).find("thead th").each(function () {
            $(this).attr("lay-data", $(this).data("option"));
        });
    }

    //分页后让当前页已选中的项目选中（分页组件调用）
    function setTableCbxSelectedOnPaged(container) {
        console.info("setLayTableCbxSelectedOnPaged")
        if ($(container).find(".showData").hasClass("cbxCol")) {
            var selected = $(container).attr("data-selected");
            if (selected == undefined)
                selected = "";
            var selectedArray = stringSplit(selected, ',');
            //layTable的处理
            if ($(container).find(".showData").hasClass("layTable") == true) {
                for (var i = 0; i < selectedArray.length; i++) {
                    //获取选择列对应的行号
                    var trData = $(container).find(".showData .trData[data-code='" + selectedArray[i] + "']");
                    var index = $(trData).eq(0).parents("tr").attr("data-index");

                    //处理列自动勾选
                    var tableBox = $(container).find('.layui-table-box');
                    //存在固定列
                    if (tableBox.find(".layui-table-fixed.layui-table-fixed-l").length > 0) {
                        tableDiv = tableBox.find(".layui-table-fixed.layui-table-fixed-l");
                    } else {
                        tableDiv = tableBox.find(".layui-table-body.layui-table-main");
                    }
                    var checkCell = tableDiv.find("tr[data-index=" + index + "]").find("td div.laytable-cell-checkbox div.layui-form-checkbox I");
                    if (checkCell.length > 0) {
                        checkCell.click();
                    }
                }
            }
        }
    }

    //处理layTable的checkBox的勾选问题
    function handleTableCbxEvent(container, table) {
        console.info("handleLayTableCbxEvent");
        var colName = $(container).find(".showData").attr("data-opRow");
        if (isNull(colName))
            colName = "操作";
        if ($(container).find(".showData").hasClass("cbxCol")) {
            table.on('checkbox(layTable)', function (obj) {
                //单个选中
                if (obj.checked == true && obj.type == 'one') {
                    var value = $("<div>" + obj.data[colName] + "</div>").find(".trData").attr("data-code");
                    addSelectedValue(container, value);
                    obj.tr.addClass('cbxSelected');
                }
                //单个取消选中
                if (obj.checked == false && obj.type == 'one') {
                    var value = $("<div>" + obj.data[colName] + "</div>").find(".trData").attr("data-code");
                    removeSelectedValue(container, value);
                    obj.tr.removeClass('cbxSelected');
                }
                //全部选中
                if (obj.checked == true && obj.type == 'all') {
                    $('.layui-table-body table.layui-table tbody tr').addClass('cbxSelected');
                    window.setTimeout(function () {
                        var checkStatus = table.checkStatus('layTableID'), data = checkStatus.data;
                        var result = "";
                        for (var i = 0; i < data.length; i++) {
                            result += $("<div>" + data[i][colName] + "</div>").find(".trData").attr("data-code") + ",";
                        }
                        addSelectedValue(container, result);
                        //将当前页选择数据保存在container data-all+页码,全部取消的时候要用
                        var pageIndex = getCurPageIndex(container);
                        $(container).attr("data-all" + pageIndex, result);
                    }, 10);
                }
                //全部取消选中
                if (obj.checked == false && obj.type == 'all') {
                    $('.layui-table-body table.layui-table tbody tr').removeClass('cbxSelected');
                    //从container上获取存放的数据data-all+页码
                    var pageIndex = getCurPageIndex(container);
                    var result = $(container).attr("data-all" + pageIndex);
                    if (isNull(result) == false) {
                        $(container).removeAttr("data-all" + pageIndex);
                        removeSelectedValue(container, result);
                    }
                }
            });
        }
    }

    //绑定列排序事件
    function bindTableColSortEvent(container, table) {
        console.info("bindLayTableSortEvent");
        //绑定排序事件
        table.on('sort(layTable)', function (obj) {
            var field = obj.field;
            var way = obj.type;
            if (isNull(way) == false) {
                var $pagerinfo = $(container).find(".pagerinfo");
                var url = getContainerUrl(container);

                var param = "PageIndex=" + $pagerinfo.attr("data-pageindex") +
                    "&exeCountSql=false" +
                    "&orderField=" + field +
                    "&orderWay=" + way + getContainerFilter(container) + "&rand=" + Math.random();
                if (url.indexOf('?') == -1)
                    url = url + "?" + param;
                else
                    url = url + "&" + param;

                //异步请求
                $.ajax({
                    type: 'get',
                    dataType: "html",
                    url: url,
                    success: function (data) {
                        //更新表格数据
                        updateTableData(container, data);
                        //设置表格事件和样式
                        setTableEventAndStyle(container);
                    }
                });
            }
        });
    }

    //获取当前查看的页
    function getCurPageIndex(container) {
        return $(container).find(".pagerinfo").attr("data-pageindex");
    }

})();
