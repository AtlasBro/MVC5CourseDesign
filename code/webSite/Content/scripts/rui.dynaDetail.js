//动态明细行

//将返回结果加入到明细行中(将返回的html插入到容器中)
function addToBody($container, $content) {
    $($container).find(".showData tbody").append($($content).find("tbody").html());
    //序号自动累加
    var count = 1;
    $($container).find(".showData tbody tr").each(function () {
        $(this).children("td:first").html(count++);
    })
}


//删除某个明细行(单击删除后，执行)
function deleteRow(listDelete) {
    //获取最初始的父级，与添加明细行中的父级相同
    var $container = $(listDelete).parents(".showData").parents();
    $(listDelete).parents("tr").remove();
    addToBody($container, "");
}


//获取已添加的明细行主键值 ，分割
function getAllDetail($container) {
    var result = "";
    $($container).find(".showData tbody tr").each(function () {
        result += $(this).attr("data-code") + ",";
    });
}



