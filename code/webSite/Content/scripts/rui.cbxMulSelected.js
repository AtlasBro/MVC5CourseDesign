//checkBox多选的问题，翻页过程中能够保存以前勾选的项目

//如果需要清楚选择，则在工具栏中提供如下代码
//<a class="opClearCbx opBtn">清空选择</a>

//将选中的数据存储在container的属性中，获取选中项代码：$(container).attr("data-selected");

//获取已选择项目 - 格式为1,2,3,
function getCbxSelect(container) {
    var result = $(container).attr("data-selected");

    if (result == "")
        showInfo("未选择任何行");
    return result;
}

//清除存放的选择项目
function clearCbxSelected(container) {
    $(container).attr("data-selected", "");
}

//添加选择项目
function addSelectedValue(container, value) {
    console.info("_addSelectedValue=" + value);
    var selected = $(container).attr("data-selected");
    if (isNull(selected))
        selected = "";
    $(container).attr("data-selected", stringMerge(selected, value));
}

//移除选择项目
function removeSelectedValue(container, value) {
    console.info("_removeSelectedValue=" + value);
    var selected = $(container).attr("data-selected");
    if (isNull(selected))
        selected = "";
    $(container).attr("data-selected", stringRemove(selected, value));
}

$(document).ready(function () {
    //清除选择 - 将所有的checkBox勾选去除
    $(".opClearCbx").click(function () {
        $(this).parents(".container").attr("data-selected", "");
        refleshData(false);
    });
});