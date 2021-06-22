//关于下拉框的相关处理
//下拉框联动
//下拉框chosen扩展

//利用返回的JSon数据更新ddl的数据项
function updateDdl(ddl, jsonList, hasSelected) {
    var oldValue = $(ddl).val();
    ddl.empty();
    if (hasSelected == true)
        ddl.append("<option value=''>=请选择=</option>");
    if (isNull(jsonList) == false) {
        for (var i = 0; i < jsonList.length; i++) {
            var code = jsonList[i].code;
            var name = jsonList[i].name;
            if (code == oldValue) {
                ddl.append("<option value='" + code + "' selected='selected'>" + name + "</option>");
            } else {
                ddl.append("<option value='" + code + "'>" + name + "</option>");
            }
        }
        //只有一项，自动选中
        if (jsonList.length == 1) {
            $(ddl).find("option").eq(1).attr("selected", "selected");
            $(ddl).trigger("change");
        }
    }
    if (hasSelected == false && isNull(jsonList) == true) {
        ddl.append("<option value=''>无选项</option>");
    }

    //如果使用了chosen，则刷新chosen的内容
    if (ddl.hasClass("inputSelect")) {
        $(ddl).trigger("chosen:updated");
    }
}

//根据下拉框数据和传入字段判断选中  ddl是哪个下拉框、jsonList是绑定的数组,hasSeleced是否有请选择，selectedValues是需要选中的项(允许多个)
function updateDdlWithValue(ddl, jsonList, hasSelected, selectedValues) {
    //清空ddl的数据
    ddl.empty();
    //判断条件为true
    if (hasSelected == true)
        ddl.append("<option value=''>=请选择=</option>");
    //如果jsonList不为空
    if (isNull(jsonList) == false) {
        for (var i = 0; i < jsonList.length; i++) {
            var code = jsonList[i].code;
            var name = jsonList[i].name;
            selectedValues += ",";
            if (selectedValues.indexOf(code + ",") != -1) {
                ddl.append("<option value='" + code + "' selected='selected'>" + name + "</option>");
            } else {
                ddl.append("<option value='" + code + "'>" + name + "</option>");
            }
        }
    }

    if (hasSelected == false && isNull(jsonList) == true) {
        ddl.append("<option value=''>无选项</option>");
    }

    //如果使用了chosen，则刷新chosen的内容
    if (ddl.hasClass("inputSelect")) {
        $(ddl).trigger("chosen:updated");
    }
}

//批量变更多个下拉框（出入库明细库位）    
function updateDdlList(ddlList, jsonList, hasSelected) {
    $(ddlList).each(function () {
        updateDdl($(this), jsonList, hasSelected);
    });
}

//变更下拉框的选中项
function changeDdl(ddl, value, splitTag) {
    var arr = String(value).split(splitTag);
    $(ddl).find("option").each(function () {
        if (arr.indexOf($(this).attr("value")) > -1) {
            $(this).attr("selected", true);
        }
        else {
            $(this).attr("selected", false);
        }
    });

    //如果使用了chosen，则刷新chosen的内容
    if (ddl.hasClass("inputSelect")) {
        $(ddl).trigger("chosen:updated");
    }
}

//联动获取下级数据(父ddl需要添加 changeSubDdl样式,提供data-getUrl和data-subClass属性)
//参考组织-部门联动 ， 方法的参数要是 upCode
function changeSubDdlAuto(upDdl) {
    console.info("changeSubDdl");
    var upCode = $(upDdl).val();
    //获取下级数据的url
    var subUrl = $(upDdl).attr("data-getUrl");
    //下级下拉框的class选择符
    var subClass = $(upDdl).attr("data-subClass");
    changeSubDdl(upCode, subUrl, subClass);
}

//变更子方法
function changeSubDdl(upCode, subUrl, subClass) {
    if (isNull(upCode) == false && isNull(subUrl) == false && isNull(subClass) == false) {
        var noSelected = $("." + subClass).attr("data-noSelected");
        ajaxPost(subUrl, { upCode: upCode }, function (data) {
            showJsonResult(data, function (data) {
                if (isNull(noSelected))
                    updateDdl($("." + subClass), parseJSON(data.subList), true);
                else
                    updateDdl($("." + subClass), parseJSON(data.subList), false);
            });
        });
    }
}

//配置下拉框模糊查询组件
function configChosen() {
    if ($(".inputSelect").length == 0)
        return;

    //下拉框录入筛选扩展
    $(".inputSelect").chosen({
        allow_single_deselect: true,                //是否允许取消选择
        placeholder_text_multiple: "=请选择(多选)=",
        placeholder_text_single: "=请选择=",
        no_results_text: "没有匹配项目",              //查询不到显示的文本
        single_backstroke_delete: false,
        search_contains: true,                      //实现模糊查询
    });

    //下拉框自动适应大小
    $(".chosen-container").click(function () {
        var iMax = 0; //保存文字最大数
        $(this).find(".chosen-results li").each(function () {
            if (iMax < parseInt($(this).text().length)) {
                iMax = parseInt($(this).text().length);
            }
        });
        var sWidth = iMax * parseInt($(this).css("fontSize"));
        var baseWidth = $(".chosen-container").width();
        if (sWidth < baseWidth)
            sWidth = baseWidth;
        if (sWidth > 400)
            sWidth = 400;
        if (sWidth < 150)
            sWidth = 150;
        $(".chosen-drop").css({ "width": sWidth });
    })
}

$(document).ready(function () {

    //配置下拉框模糊查询组件
    configChosen();

    //绑定联动下级ddl
    $(".changeSubDdl").change(function () {
        changeSubDdlAuto($(this));
    });

    //处理下拉框的值,让只有一项的下拉框的"=请选择="自动变成"=无项目="
    $("select").each(function () {
        if ($(this).children().length == 1 && $(this).children().text() == "=请选择=") {
            $(this).children().html("=无选项=");
        }
    });
});
