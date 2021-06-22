//showData 加上layTable 启用layTable
//showData 加上cbxCol，启用选择列
//showData 加上fixHeader , ruiTable时生成固定表头

//将请求回应的表格数据替换到.showData中
function updateTableData(container, htmlData) {
    console.info("updateTableData");
    //替换表格数据
    var $showData = $(container).find(".showData");
    $($showData).html(htmlData);
}

//设置表格的事件绑定和相关样式
function setTableEventAndStyle(container) {  
    console.info("setTableEventAndStyle")

    //.noTable前端自定义列表展示
    //如果前端的列表展示不用表格，或者要自定义表格样式，就给showData增加noTable选择符
    if ($(container).find(".showData").hasClass("noTable"))
        return;

    //页面权限控制
    privCtl();

    //下拉框扩展
    configChosen();

    //给表格加上ruiTable选择符
    $(container).find(".showData>table").addClass("ruiTable");

    //设置操作列宽度
    setTableOpColSize(container);

    //使用layTable表格风格
    if ($(container).find(".showData").hasClass("layTable") == true) {
        console.info("使用--layTable");
        layTable.setLayTable(container);
    }
    //使用ruiTable表格风格
    if ($(container).find(".showData").hasClass("layTable") == false) {
        console.info("使用--ruiTable");
        ruiTable.setRuiTable(container);
    }
}

//设置操作列的宽度 修改data-option中的宽度属性
function setTableOpColSize(container) {
    console.info("setOpColSize");
    var opTh = $(container).find(".showData thead th:contains('操作')");
    if ($(opTh).length > 0 && $(opTh).text() == "操作") {
        //获取最大宽度值
        var $maxWidth = 0;
        $(container).find(".ruiTable .opRow").each(function () {
            var $width = 0;
            $(this).find("a").each(function () {
                if ($(this).attr("data-Show") == "True" || $(this).attr("data-Show") == undefined) {
                    $width += $.trim($(this).text()).length + 0.6;
                }
            });
            if ($maxWidth < $width)
                $maxWidth = Math.ceil($width);
        });
        //保证最小宽度2em
        if ($maxWidth < 2)
            $maxWidth = 2;

        //给表头操作列增加width属性
        var option = eval("(" + $(opTh).attr("data-option") + ")");
        option.width = parseInt($(opTh).css("font-size")) * $maxWidth;
        console.info(option);
        console.info(JSON.stringify(option));
        $(opTh).attr("data-option", objToStr(option));
    }
}

//获取列表配置的URL
function getContainerUrl(container) {
    var url = "";
    if ($(container).attr("data-url") != undefined) {
        url = $(container).attr("data-url");
    } else {
        console.info("container未配置data-url属性");
    }
    console.info(url);
    return url;
}

//获取列表的搜索条件
function getContainerFilter(container) {
    var filter = "";
    var $search = $(container).find(".search")
    if ($search != undefined)
        filter = $($search).find("input,select").serialize();
    if (filter.length > 0)
        filter = "&" + filter;
    return filter;
}

//获取列表的配置宽度
function getContainerWidth(container) {
    //如果配置了data-width,则用合适的宽度
    var containerWidth = $(container).width();
    if ($(container).attr("data-width") != undefined) {
        var configWidth = parseInt($(container).attr("data-width"));
        if (containerWidth < configWidth) {
            containerWidth = configWidth;
        }
    }
    return containerWidth;
}

$(document).ready(function () {

    //如果无搜索条件则隐藏搜索层
    $(".search").each(function () {
        if ($.trim($(this).text()).length == 0) {
            $(this).hide();
        }
    });

    //如果无操作则隐藏操作层
    $(".toolbar").each(function () {
        if ($.trim($(this).text()).length == 0) {
            $(this).hide();
        }
    });
});





