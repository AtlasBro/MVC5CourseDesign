//母版页引用的

//easyui Window对话框的相关封装方法 - 模态对话框
//主要用于新增，修改，详情等模态对话框页面

//处理对话框内容得刷新
//type2 调用父页面的数据刷新方法
//type3 让父窗口整个网页刷新
function handleDialogReflesh(pwin, refleshType) {
    //局部刷新 - 调父页面的刷新方法
    if (refleshType == "type2") {
        pwin.refleshData(true);
    }
    //整页刷新  - 变更网址
    if (refleshType == "type3") {
        var pUrl = pwin.location.href;
        pwin.location.href = pUrl;
    }
}

//处理对话框关闭前事件
function handleDialogClosing(pwin, refleshType) {
    if (refleshType == "type2" || refleshType == "type3") {
        var $checkSave = $("#checkSave", pwin.frames["iframeDialog"].document);
        //关闭前 - 处理本页面的未保存到单据(废弃)
        if ($checkSave.length == 1) {
            if ($($checkSave).attr("data-isSave") != "是") {
                var keyCode = $($checkSave).val();
                var url = $($checkSave).attr("data-url");
                //如果没保存，则删除该单据
                ajaxPost(url, { keyCode: keyCode }, function (data) {

                });
            }
        }
    }
}

//弹窗显示网页（刷新主页面,主界面需要定义refleshData方法类重新获取数据） - 给主页面元素调用的方法，在框架页面上显示模态窗口
//refleshType :type1不刷新，type2局部刷新，type3整页刷新
function openDialog(title, url, pwin, refleshType, max) {
    var navWidth = $(pwin).width();
    var navHeight = $(pwin).height();
    var width = $(pwin).width() * 0.9;
    var height = $(pwin).height() * 0.9;
    //如果没有则添加
    if ($("#divDialog").length == 0) {
        var dialog = $("<div id='divDialog' style='text - align: right;'></div>")
        $("body").append(dialog);
    }
    $("#divDialog").window({
        title: title,
        content: "<iframe id=\"iframeDialog\" data-opentype='dialog' name=\"iframeDialog\" frameborder=\"0\" width=\"100%\" height=\"100%\" src=\"" + url + "\"></iframe>",
        width: width,
        height: height,
        top: (navHeight - height) / 2,
        left: (navWidth - width) / 2,
        maximizable: true,
        minimizable: false,
        collapsible: false,
        modal: true,
        onBeforeClose: function () {
            handleDialogClosing(pwin, refleshType);
        },
        onClose: function () {
            handleDialogReflesh(pwin, refleshType);
        }
    });
    if (isNull(max) == false)
        $("#divDialog").window("maximize");
}

//关闭对话框
function closeDialog() {
    $("#divDialog").window('close');
}

//主表相关字段变更后,自动保存主表,并自动刷新明细的数据
//为变更后需要自动保存的表单增加 class=autoSaveMaster
//通过[saveBefore]-[saveAfter] 设定保存前和保存后执行的代码
function autoSaveMaster(sender) {
    var form = getForm($(sender));

    //保存前的执行的代码 - 可选
    if (window.saveBefore != undefined) {
        var result = window.saveBefore();
        if (result != "") {
            showError(result);
            return false;
        }
    }
    var url = form.attr("action");
    url = joinUrl(url, "auto=true");
    ajaxFormUrl(form, url, function (data) {
        showJsonResult(data, function () {
            //保存后执行的代码 - 可选
            if (window.saveAfter != undefined) {
                window.saveAfter(data);
            }
            //保存后刷新本页面的数据
            window.refleshData(true);
        });
    });
}

//设置从界面对话框的样式
function setDialogCSS() {
    if ($(".dialog").length > 0) {

        //给对话框页面的标题栏右侧增加：和空格
        $(".dialog .display-label,.dialog .editor-label").each(function () {
            $(this).html($(this).html() + ":&nbsp;");
        });

        //为不同的表单增加必填样式
        $(".dialog .must").each(function () {
            $(this).html("<b>*</b>" + $(this).html());
            $(this).next("div").find("input").addClass("required");
            $(this).next("div").find("select").addClass("required");
            $(this).next("div").find("textarea").addClass("required");
        });

        //设置表单只读(对select,radio,checkbox不起作用)
        $(".dialog .read input").attr("readonly", "readonly");
        $(".dialog .read input").attr("unselectable", "on");  //不让光标上去
        $(".dialog .read textarea").attr("readonly", "readonly");
        $(".dialog .read input[type='radio']").attr("disabled", "disabled");
        $(".dialog .read input[type='checkbox']").attr("disabled", "disabled");
        $(".dialog .read select").attr("disabled", "disabled");

        //对话框界面，某个字段变更后，自动保存数据
        $(".autoSaveMaster").change(function () {
            autoSaveMaster($(this));
        });
    }
}

$(document).ready(function () {
    //单击class="showDialog"的超链接元素时，弹窗显示该页面
    $("body").on("click", ".showDialog", function (event) {
        var title = $(this).attr("data-title");
        if (isNull(title))
            title = $(this).text();
        openDialog(title, event.currentTarget.href, window, "type1", false);
        return false;
    });

    //单击class="showDialogM"的超链接元素时，弹窗显示该页面(最大化)
    $("body").on("click", ".showDialogM", function (event) {
        var title = $(this).attr("data-title");
        if (isNull(title))
            title = $(this).text();
        openDialog(title, event.currentTarget.href, window, "type1", true);
        return false;
    });

    //单击class="showDialogR"的超链接元素时，弹窗显示该页面
    $("body").on("click", ".showDialogR", function (event) {
        var title = $(this).attr("data-title");
        if (isNull(title))
            title = $(this).text();
        openDialog(title, event.currentTarget.href, window, "type2", false);
        return false;
    });

    //单击class="showDialogRM"的超链接元素时，弹窗显示该页面(最大化)
    $("body").on("click", ".showDialogRM", function (event) {
        var title = $(this).attr("data-title");
        if (isNull(title))
            title = $(this).text();
        openDialog(title, event.currentTarget.href, window, "type2", true);
        return false;
    });

    //单击class="showDialogRR"的超链接元素时，弹窗显示该页面
    $("body").on("click", ".showDialogRR", function (event) {
        var title = $(this).attr("data-title");
        if (isNull(title))
            title = $(this).text();
        openDialog(title, event.currentTarget.href, window, "type3", false);
        return false;
    });

    //单击class="showDialogRRM"的超链接元素时，弹窗显示该页面(最大化)
    $("body").on("click", ".showDialogRRM", function (event) {
        var title = $(this).attr("data-title");
        if (isNull(title))
            title = $(this).text();
        openDialog(title, event.currentTarget.href, window, "type3", true);
        return false;
    });

    //设置对话框的样式
    setDialogCSS();
});