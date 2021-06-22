
//业务单据相关的操作

//单据保存 class="billSave",[saveBefore]/[saveAfter]/[data_formid]/[data_reflesh]/[data_close]
//单据确认(默认保存/默认关闭) class="billConfirm",href/[data_msg]/[data_formid]
//单据操作 class="billOp",href/[data_msg]/[data_save]_[data_formid]/[data_reflesh]/[data_close]
//列表批量保存 class="listBatchSave",href/[data_formid]/[data_reflesh]
//列表批量操作(默认刷新) class="listBatchOp",href/data_msg/[data_save]_[data_formid]/[data_only]/[data_cbx],回传参数:keyFieldValues
//列表删除(默认提示/默认刷新) class="listDelete",href/[data_save]_[data_formid]
//列表操作(默认刷新) class="listOp",href/[data_save]_[data_formid]/[data_msg]

//有data_save的,如果操作按钮不在form内，需要指定data_formid

//获取操作所操作的form对象
//如果操作未指定formID,则获取父form，如果指定了，通过formID获取form
function getForm(sender) {
    var form = null;
    if ($(sender).attr("data-formid") == undefined) {
        form = $(sender).parents("form");
    }else {
        form = $("#" + $(sender).attr("data-formid"));
    }
    console.info($(form).attr("action"));
    return form;
}

//列表批量操作，需要传递参数(url参数格式:a=值&b=值） 
//选择符定义为 listBatchOpPara,自己写代码调用方法
function listBatchOp(sender, param) {
    //操作网址 - 必须
    var url = $(sender).attr("href");
    if (isNull(url) == true)
        showError("必须设定操作的提交地址");
    url = joinUrl(url, param);
    //提醒内容 - 必须
    var msg = $(sender).attr("data-msg");
    if (isNull(msg) == true)
        showError("必须设定操作提醒");
    //是否保存 - 可选
    var save = $(sender).attr("data-save");
    //操作完毕后是否保持选择
    var cbx = $(sender).attr("data-cbx");
    //是否一个 - 可选
    var only = $(sender).attr("data-only");

    var container = $(sender).parents(".container");
    var selected = getCbxSelect(container);
    if (isNull(selected)) {
        showError("请选择操作行");
        return false;
    }
    if (isNull(only) == false && getLength(selected, ",") > 1) {
        showError("只能操作一个");
        return false;
    }
    //操作前先确认
    showConfirm(msg, function () {
        if (isNull(save)) {
            //不保存
            ajaxPost(url, { keyFieldValues: selected }, function (data) {
                showJsonResult(data, function () {
                    if (isNull(cbx))
                        clearCbxSelected(container);
                    refleshData(true);
                });
            });
        } else {
            //操作前先保存
            ajaxForm(getForm($(sender)), function (data) {
                showJsonResult(data, function () {
                    ajaxPost(url, { keyFieldValues: selected }, function (data) {
                        showJsonResult(data, function () {
                            if (isNull(cbx))
                                clearCbxSelected(container);
                            refleshData(true);
                        });
                    });
                });
            });
        }
    });
}

//根据选项自动关闭对话框或Tab
function autoClosed() {
    var opentype = $(window.frameElement).attr("data-opentype");
    console.info(opentype);
    //关闭tab
    if (opentype == "tab")
        window.parent.closeTab();
    //关闭对话框
    if (opentype == "dialog")
        window.parent.closeDialog();
    //关闭选择框
    if (opentype == "select")
        window.parent.closeSelect();
}

$(function () {

    //窗口关闭
    $(".opClose").click(function () {
        autoClosed();
    });

    // --------------------------------------------单据操作：保存，确认，定制操作
    //单据保存专用方法
    //如果保存前需要执行代码则指定saveBefore - 可选
    //如果保存后需要执行代码则指定saveAfter - 可选
    //如果执行后需要刷新数据，则提供data-reflesh和refleshData方法
    //如果执行后需要关闭，则提供data-close
    $(".billSave").click(function () {
        var sender = $(this);
        //是否刷新 - 可选
        var reflesh = $(sender).attr("data-reflesh");
        //是否关闭 - 可选
        var closed = $(sender).attr("data-close");
        //保存前的执行的代码 - 可选
        if (window.saveBefore != undefined) {
            var result = window.saveBefore();
            if (result != "") {
                showError(result);
                return false;
            }
        }
        //获取保存的form对象
        var form = getForm($(sender));
        //validate验证通过后提交
        if ($(form).valid()) {
            ajaxForm($(form), function (data) {
                showJsonResult(data, function () {
                    //保存后执行的代码 - 可选
                    if (window.saveAfter != undefined) {
                        window.saveAfter(data);
                    }
                    //返回数据中有行号，则跳转到修改界面，也可用于整页刷新
                    if (isNull(data.rowID) == false) {
                        redirectUpdate(data.rowID, data.url);
                    }
                    //保存后关闭窗口
                    if (closed == "true") {
                        autoClosed();
                    }
                    //保存后刷新本页面的数据
                    if (reflesh == "true") {
                        window.refleshData(false);
                    }
                });
            });
        } else {
            showInfo("录入数据不合法");
        }
        return false;
    });

    //单据确认专用方法
    //确认时默认会进行数据保存
    //确认时默认显示确认提醒,需要指定data-msg
    $(".billConfirm").click(function () {
        var sender = $(this);
        //操作网址 - 必须
        var url = $(sender).attr("href");
        if (isNull(url) == true)
            showError("必须设定确认的提交地址");
        //提醒内容 - 可选
        var msg = $(sender).attr("data-msg");
        if (isNull(msg) == true)
            msg = "确认该操作？";
        //操作前先确认
        showConfirm(msg, function () {
            //操作前先保存
            ajaxForm(getForm($(sender)), function (data) {
                showJsonResult(data, function () {
                    //调用确认方法
                    ajaxPost(url, {}, function (data) {
                        showJsonResult(data, function () {
                            //操作成功后关闭
                            autoClosed();
                        });
                    });
                });
            });
        });
        return false;
    });

    //单据操作定制方法 #billOp -> .billOp
    //对保存和确认的补充，可以根据需求自由控制功能
    //如果操作前需要进行保存，需要指定data-save
    //如果操作时需要提醒，需要指定data-msg
    //如果操作后需要刷新，需要指定data-reflesh
    //如果操作后需要关闭，需要指定data-close
    $(".billOp").click(function () {
        var sender = $(this);
        //操作网址 - 必须
        var url = $(sender).attr("href");
        if (isNull(url) == true)
            showError("必须设定操作地址");
        //是否提醒 - 可选
        var msg = $(sender).attr("data-msg");
        //是否保存 - 可选
        var save = $(sender).attr("data-save");
        //是否关闭 - 可选
        var close = $(sender).attr("data-close");
        //是否刷新 - 可选
        var reflesh = $(sender).attr("data-reflesh");     
        if (isNull(msg)) {
            //不显示确认提醒
            if (isNull(save)) {
                //不保存
                ajaxPost(url, {}, function (data) {
                    showJsonResult(data, function () {
                        if (close == "true")
                            autoClosed();
                        if (reflesh == "true")
                            window.refleshData(true);
                    });
                });
            } else {
                //操作前先保存
                ajaxForm(getForm($(sender)), function (data) {
                    showJsonResult(data, function () {
                        //调用确认方法
                        ajaxPost(url, {}, function (data) {
                            showJsonResult(data, function () {
                                if (close == "true")
                                    autoClosed();
                                if (reflesh == "true")
                                    window.refleshData(true);
                            });
                        });
                    });
                });
            } 
        } else {
            //操作前先确认
            showConfirm(msg, function () {
                if (isNull(save)) {
                    //进行操作
                    ajaxPost(url, {}, function (data) {
                        showJsonResult(data, function () {
                            if (close == "true")
                                autoClosed();
                            if (reflesh == "true")
                                window.refleshData(true);
                        });
                    });
                } else {
                    //操作前先保存
                    ajaxForm(getForm($(sender)), function (data) {
                        showJsonResult(data, function () {
                            //调用确认方法
                            ajaxPost(url, {}, function (data) {
                                showJsonResult(data, function () {
                                    if (close == "true")
                                        autoClosed();
                                    if (reflesh == "true")
                                        window.refleshData(true);
                                });
                            });
                        });
                    });
                }
            });
        }
        return false;
    });

    // --------------------------------------------列表上操作：保存，批量操作
    //列表批量保存专用方法 .billBatchSave - > .listBatchSave
    //保存列表内可编辑列的值   通过action设置保存提交的请求地址
    $(".listBatchSave").click(function () {
        var sender = $(this);
        //操作网址 - 必须
        var url = $(this).attr("href");
        if (isNull(url) == true) {
            showError("必须设定操作地址");
            return false;
        }
        //刷新数据 - 可选
        var reflesh = $(this).attr("data-reflesh");
        //提交服务器
        ajaxFormUrl(getForm($(sender)), url, function (data) {
            showJsonResult(data, function () {
                if (reflesh == "true")
                    window.refleshData(false);
            });
        });
        return false;
    });

    //列表批量操作定制方法 .billBatchOp - > .listBatchOp
    //批量发布，批量修改某字段的值等，如果值是通过界面设置的，则将值附加到URL中提交给后台
    $(".listBatchOp").click(function () {
        listBatchOp($(this), "");
        return false;
    });

    // --------------------------------------------列表内操作：删除，定制操作
    //列表删除专用方法
    //默认会进行删除提醒 .billDelete -> .listDelete
    $(".showData").on("click", ".listDelete", function () {
        var sender = $(this);
        //操作网址 - 必须
        var url = $(this).attr("href");
        if (isNull(url) == true)
            showError("必须设定操作地址");
        //是否保存 - 可选
        var save = $(this).attr("data-save");
        //操作前先确认
        showConfirm("确认删除？", function () {
            if (isNull(save)) {
                //不保存
                ajaxPost(url, {}, function (data) {
                    showJsonResult(data, function () {
                        refleshData(true);
                    });
                });
            }
            else {
                //先保存
                ajaxForm(getForm($(sender)), function (e) {
                    ajaxPost(url, {}, function (data) {
                        showJsonResult(data, function () {
                            refleshData(true);
                        });
                    });
                });
            }
        });
        return false;
    });

    //列表操作定制方法 .billOp -> .listOP
    //例如：作废等相关操作
    $(".showData").on("click", ".listOp", function () {
        var sender = $(this);
        //操作网址 - 必须
        var url = $(this).attr("href");
        if (isNull(url) == true)
            showError("必须设定操作地址");
        //提醒内容 - 可选
        var msg = $(this).attr("data-msg");
        //是否保存 - 可选
        var save = $(this).attr("data-save");   
        if (isNull(msg)) {
            //不显示确认提醒
            if (isNull(save)) {
                //不保存
                ajaxPost(url, {}, function (data) {
                    showJsonResult(data, function () {
                        refleshData(true);
                    });
                });
            }
            else {
                //先保存
                ajaxForm(getForm($(sender)), function (e) {
                    //保存后调用操作
                    ajaxPost(url, {}, function (data) {
                        showJsonResult(data, function () {
                            refleshData(true);
                        });
                    });
                });
            }
        } else {
            //显示确认提醒
            showConfirm(msg, function () {
                if (isNull(save)) {
                    //不保存
                    ajaxPost(url, {}, function (data) {
                        showJsonResult(data, function () {
                            refleshData(true);
                        });
                    });
                }
                else {
                    //先保存
                    ajaxForm(getForm($(sender)), function (e) {
                        //保存后调用操作
                        ajaxPost(url, {}, function (data) {
                            showJsonResult(data, function () {
                                refleshData(true);
                            });
                        });
                    });
                }
            });
        }
        return false;
    });
});




