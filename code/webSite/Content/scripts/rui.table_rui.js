
var ruiTable = (function () {

    //汇总设置表格用到的相关方法
    function setTable(container) {
        //设置表格奇数行样式 rui.table_rui.js
        setTableRowStyle(container);
        //设置表格大小 rui.table_rui.js
        setTableSize(container);
        //重构表格内容 rui.table_rui.js
        reBuildTable(container);

        //绑定排序列事件 rui.table_rui.js
        bindTableColSortEvent(container);

        //创建选择列
        createTableCbxCol(container);
        //分页后设置已勾选的勾选上
        setTableCbxSelectedOnPaged(container);
        //绑定行的勾选事件
        handleTableCbxEvent(container);
    }

    //对外公开的方法
    let out = {
        setRuiTable: setTable
    }
    return out;

    //设置ruiTable奇偶列样式和鼠标上去样式
    function setTableRowStyle(container) {
        console.info("setRuiTableRowStyle");

        //设定奇偶行的样式
        $(container).find(".showData tbody tr:even").addClass("even");
        $(container).find(".showData tbody tr:odd").addClass("odd");

        //如果没数据，则显示'暂无数据'
        if ($(container).find(".showData tbody tr").length == 0) {
            $(container).find(".showData").append("<div style='width:100%; color:blue; text-align:center; font-weight:900; margin-top:5px;'>无数据</div>");
        }
    }

    //设置ruiTable的大小
    function setTableSize(container) {
        console.info("setRuiTableSize");
        if ($(container).parent(".pageLayout").length > 0) {
            var tableWidth = getContainerWidth(container);
            $(container).find(".showData>table").css("width", tableWidth);
        } else {
            $("body").css("overflow-x", "hidden");
        }
    }

    //------------------------------------------------reBuildTable相关方法---------------开始
    //重构表格内容
    //生成固定表头列,生成表格列样式，应用表格列样式
    //1、所有的内容用div包裹起来
    //2、生成表格样式，应用表格样式
    //3、表格内容重组
    function reBuildTable(container) {
        $(container).find(".ruiTable thead th").wrapInner("<div></div>");
        $(container).find(".ruiTable tbody td").wrapInner("<div></div>");
        $(container).find(".ruiTable tfoot td").wrapInner("<div></div>");

        //绑定超出列效果
        bindTableTdDivOmit(container);

        //为表格单元格创建宽度样式
        createTableStyle(container);
        //应用样式
        applyTableStyle(container);

        //当.showData 后携带了 fixHeader样式，就生成固定表头
        if ($(container).find(".showData").hasClass("fixHeader")) {
            //创建固定表头
            createTableHeader(container);
        }
            
        //绑定窗口事件
        bindTableWindowEvent(container);
    }

    //绑定单元格内的div的,有...的时候弹出来显示
    function bindTableTdDivOmit(container) {
        var tipIndex = 0;

        //处理表头内容过多的显示问题
        $(container).find(".showData table th>div").mouseenter(function (e) {
            if ($(this).html() == $(this).text()) {
                var thisWidth = $(this)[0].clientWidth;
                var wordWidth = $(this)[0].scrollWidth;
                if (wordWidth > thisWidth) {
                    tipIndex = showTip($(this).text(), this, { tips: [2, 'black'], time: 60000, maxWidth: 400 });
                    console.info(tipIndex);
                }
            }
        });
        $(container).find(".showData table th>div").mouseout(function () {
            closeTip(tipIndex);
        })

        //处理表体内容过多的显示问题
        $(container).find(".showData table td:not(.cbxtd) div").mouseenter(function (e) {
            //不包含表单的才有效
            if ($(this).find("input").length == 0 && $(this).find("select").length == 0 && $(this).html() == $(this).text()) {
                var thisWidth = $(this)[0].clientWidth;
                var wordWidth = $(this)[0].scrollWidth;
                if (wordWidth > thisWidth) {
                    tipIndex = showTip($(this).text(), this, { tips: [2, 'black'], time: 60000, maxWidth: 400 });
                    console.info(tipIndex);
                }
            }
        });
        $(container).find(".showData table td:not(.cbxtd)>div").mouseout(function () {
            closeTip(tipIndex);
        })
    }

    //生成固定表头内容
    function createTableHeader(container) {
        if ($(container).parent(".pageLayout").length > 0) {
            var content = "<table class='ruiTable fixHeader'><thead>" + $(container).find(".showData .ruiTable thead").html() + "<thead></table>";
            $(container).find(".showData").prepend(content);
            var tableWidth = getContainerWidth(container);
            $(container).find("table.fixHeader").css("width", tableWidth);
            $(container).find("table.fixHeader").hide();
        }
    }

    //根据表格信息生成宽度样式,并应用样式
    //setTableSize 调用
    function createTableStyle(container) {
        console.info("createTableStyle");
        //添加样式容器
        $(container).find(".showData").append("<style type='text/css' class='ruiTable-Style'></style>");
        //生成样式
        var trIndex = 0;
        var cIndex = $(".container").index(container);
        $(container).find(".ruiTable thead tr").each(function () {
            var tdIndex = 0;
            $(this).find("th").each(function () {
                //获取行的宽度
                var owidth = getOptionValue($(this), "width");
                if (isNull(owidth)) {
                    var hWidth = $(this).width() - 5;
                    owidth = hWidth;
                }
                //获取数据排序方式
                var align = getOptionValue($(this), "align");
                align = isNull(align) == true ? "left" : align;

                var className = "ruiTable-cell-" + cIndex + "-" + trIndex + "-" + tdIndex;
                var styleStr = "." + className + "{ width:" + owidth + "px; text-align:" + align + ";}";
                $(container).find(".ruiTable-Style").append(styleStr);
                tdIndex++;
            });
            trIndex++;
        });
    }

    //应用样式
    function applyTableStyle(container) {
        var showData = $(container).find(".showData");
        var cIndex = $(".container").index(container);

        //应用表头样式
        $(container).find(".ruiTable thead tr").each(function () {
            var trIndex = 0;
            var tdIndex = 0;
            $(this).find("th>div").each(function () {
                var className = "ruiTable-cell-" + cIndex + "-" + trIndex + "-" + tdIndex;
                $(this).addClass(className);
                tdIndex++;
            });
        });
        //应用表体样式
        $(container).find(".ruiTable tbody tr").each(function () {
            var trIndex = 0;
            var tdIndex = 0;
            $(this).find("td>div").each(function () {
                var className = "ruiTable-cell-" + cIndex + "-" + trIndex + "-" + tdIndex;
                $(this).addClass(className);
                tdIndex++;
            });
        });
        //应用表尾样式
        $(container).find(".ruiTable tfoot tr").each(function () {
            var trIndex = 0;
            var tdIndex = 0;
            $(this).find("td>div").each(function () {
                var className = "ruiTable-cell-" + cIndex + "-" + trIndex + "-" + tdIndex;
                $(this).addClass(className);
                tdIndex++;
            });
        });
    }

    //绑定窗口事件
    function bindTableWindowEvent(container) {
        console.info("bindRuiTableWindowEvent");
        var search = $(container).find(".search");
        var toolbar = $(container).find(".toolbar");
        //当toolBar在search里边的时候，不移动的时候不跟着移动
        if ($(search).find(".toolbar").length > 0)
            toolbar = undefined;
        var fixHeader = $(container).find("table.fixHeader");
        //表格顶部
        var tTopLoc = $(container).find(".showData").offset().top;
        //表格高度
        var tHeight = $(container).find(".showData").height();
        //容器顶部
        var cTopLoc = $(container).offset().top;
        setTablePosition(container, search, toolbar, fixHeader, tTopLoc, cTopLoc, tHeight);

        //窗口滚动时
        $(window).scroll(function () {
            setTablePosition(container, search, toolbar, fixHeader, tTopLoc, cTopLoc, tHeight);
        });

        //窗口大小变更时
        $(window).resize(function () {
            //设置表格宽度
            setTableSize("#container");
        });
    }

    //滚动时位置控制
    function setTablePosition(container, search, toolbar, fixHeader, tTopLoc, cTopLoc, tHeight) {
        console.info("setRuiTablePosition");
        var left = $(window).scrollLeft();
        var top = $(window).scrollTop();
        $(search).css("left", left);
        $(toolbar).css("left", left);
        if (isNull(fixHeader) == false && fixHeader.length > 0) {
            console.info("top=" + top + ";topLoc=" + tTopLoc + ";cTopLoc=" + cTopLoc);
            if (top > tTopLoc) {
                //隐藏偏移大于表格偏移时显示
                $(fixHeader).show();
                $(fixHeader).css("top", top - cTopLoc - 3);
            }
            else if (top > tTopLoc + tHeight) {
                //隐藏偏移大于表格偏移+表格高度时,隐藏
                $(fixHeader).hide();
            }
            else {
                //隐藏偏移小于表格偏移是隐藏
                $(fixHeader).hide();
            }
        }
    }
    //------------------------------------------------reBuildTable相关方法---------------结束

    //绑定排序列的事件处理函数
    function bindTableColSortEvent(container) {
        console.info("bindSortEvent");
        $(container).find(".showData thead th[data-field]").on("click", function () {
            //更换排序方式
            var field = $(this).attr("data-field");
            var way = $(this).attr("data-order");
            way = way == "asc" ? "desc" : "asc";

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
        });
    }

    //生成批量勾选列
    function createTableCbxCol(container) {
        console.info("createRuiTableCbxCol");

        //如果需要选择框,则创建
        if ($(container).find(".showData").hasClass("cbxCol")) {
            $(container).find(".showData thead tr").prepend("<th class='cbxtd' data-option=\"{width:'20px'}\"><input class='trData' type='checkbox' /></th>");
            $(container).find(".showData tbody tr").prepend("<td class='cbxtd'><input class='trData' type='checkbox' /></td>");

            //将每行的标识数据放在checkbox列,方便批量选择
            $(container).find("tbody tr").each(function () {
                var id = $(this).data("id");
                var code = $(this).data("code");
                $(this).find(".trData").attr("data-id", id);
                $(this).find(".trData").attr("data-code", code);
            });
        }
    }

    //分页后让当前页已选中的项目选中
    function setTableCbxSelectedOnPaged(container) {
        console.info("_setRuiTableCbxSelectedOnPaged")
        if ($(container).find(".showData").hasClass("cbxCol")) {
            var selected = $(container).attr("data-selected");
            if (selected == undefined)
                selected = "";
            var selectedArray = stringSplit(selected, ',');
            //ruiTable的处理
            if ($(container).find(".showData").hasClass("layTable") == false) {
                for (var i = 0; i < selectedArray.length; i++) {
                    $(container).find(".showData .trData[data-code='" + selectedArray[i] + "']").attr("checked", true);
                    $(container).find(".showData .trData[data-code='" + selectedArray[i] + "']").parents("tr").addClass("cbxSelected");
                }
            }
        }
    }

    //处理checkBox的勾选事件
    function handleTableCbxEvent(container) {
        console.info("_handleRuiTableCbxEvent")
        //行内的CheckBox勾选事件
        $(container).find(".showData tbody").on("click", "td .trData", function () {
            if ($(this).is(":checked") == true) {
                $(this).parents("tr").addClass("cbxSelected");
                var value = $(this).attr("data-code");
                addSelectedValue(container, value);
            }
            else {
                $(this).parents("tr").removeClass("cbxSelected");
                var value = $(this).attr("data-code");
                removeSelectedValue(container, value);
            }
        });

        //表头的Checkbox勾选事件，将勾选和勾掉的项目实时存储在表单元素中
        $(container).find(".showData thead").on("click", "th .trData", function () {
            if ($(this).is(":checked")) {
                var result = "";
                //遍历行内的checkBox,让其选中,并获取行内的code
                $(this).parents(".container").find(".showData tbody .trData").each(function () {
                    $(this).parents("tr").addClass("cbxSelected");
                    $(this).prop("checked", true)
                    result += $(this).attr("data-code") + ",";
                });
                addSelectedValue(container, result);
            }
            else {
                var result = "";
                //遍历行内的checkBox,让其选中，并获取行内的code
                $(this).parents(".container").find(".showData tbody td .trData").each(function () {
                    $(this).parents("tr").removeClass("cbxSelected");
                    $(this).removeAttr("checked");
                    result += $(this).attr("data-code") + ",";
                });
                removeSelectedValue(container, result);
            }
        });
    }
})();