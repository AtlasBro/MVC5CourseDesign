
//单据审批页面所用代码

//审批通过方法
//logRowID审批日志行号；relatedRowID关联单据行号；chkResult审批的结果：pass或者reject
function auditPass(logRowID, relatedRowID, chkResult) {
    if (confirm("确认审批？")) {
        var auditRemark = $("#auditRemark").val();
        //审批通过
        if (chkResult == "pass") {
            //处理财务审批时间
            var financeDataTime = $(".financeDataTime").val();
            if (financeDataTime == undefined)
                financeDataTime = "";

            //调用审批通过方法
            var url = "/admin/afAuditCenter/auditPass";
            ajaxPost(url, { logRowID: logRowID, auditRemark: auditRemark, passDate: financeDataTime }, function (data) {
                showJsonResult(data, function () {
                    $(".auditTool").hide();
                    $(".opAuditSave").hide();
                })
            });
        }
        //审批驳回
        if (chkResult == "reject") {
            //获取驳回的节点
            var rejectItem = $('input:radio[name="rejectItem"]:checked').val();
            //调用审批驳回方法
            var url = "/admin/afAuditCenter/auditReject";
            ajaxPost(url, { logRowID: logRowID, relatedRowID: relatedRowID, nodeCode: rejectItem, auditRemark: auditRemark }, function (data) {
                showJsonResult(data, function () {
                    $(".auditTool").hide();
                    $(".opAuditSave").hide();
                })
            });
        }
    }
}

//点击驳回后，通过此方法生成驳回的列表
//获取驳回列表并显示,默认选中第一个
function getRejectList() {
    //获取驳回列表的数据
    var logRowID = $('input[value="reject"]').attr("data-logrowID");
    //请求服务器，获取驳回的列表
    ajaxHtml("/admin/afAuditCenter/auditReject", { logRowID: logRowID }, function (data) {
        $(".rejectList").html(data);
        setGridStyle("#container");
        $(".rejectList input[type='radio']").eq(0).attr("checked","true");
        $(".rejectList").show();
    });
}

//单据审批界面控制逻辑
$(document).ready(function () {
    $(".rejectList").hide();

    //审批提交，提交的时候，保存审批填入的数据，保存成功后，调用审批通过方法
    $("#auditSubmit").click(function () {
        var logRowID = $(this).attr("data-logrowID");
        var relatedRowID = $(this).attr("data-rowID");
        var chkResult = $('input:radio[name="auditResult"]:checked').val();
        //通过前自动保存单据(如果允许保存)，保存成功后进行审批操作
        if ($("#opSave").is(':visible')) {
            //保存后，调用审批方法
            ajaxForm($("form"), function (data) {
                showJsonResult(data, function () {
                    auditPass(logRowID, relatedRowID,chkResult);
                });
            });
        }
        else {
            auditPass(logRowID, relatedRowID, chkResult);
        }
        return false;
    });
    //勾选通过，隐藏驳回列表
    $('input[value="pass"]').change(function () {
        $(".rejectList").hide();
    });
    //勾选驳回，显示驳回列表
    $('input[value="reject"]').change(function () {
        getRejectList();
    });
});

//财务审核控制
$(document).ready(function () {

    //获取审批的阶段
    var val = $("#printTag").val();
    //info(val);
    if (val == "财务") {
        //财务审批，根据财务审批的控制规则，选择提醒，还是禁止
        var financeCtl = $("#financeCtl").val();
        var financeMsg = $("#financeCtl").attr("data-msg");
        if (financeMsg != "" && financeCtl == "提醒") {
            showError(financeMsg);
        }
        if (financeMsg != "" && financeCtl == "禁止") {
            //不给编辑
            $("#opSave").hide();
            $("#container .showData input").attr("readonly", "readonly")

            //不准审批通过，默认选中驳回和显示驳回列表
            $("#pass").hide();
            $('input[value="reject"]').attr("checked", "true");
            getRejectList();
            showError(financeMsg);
        }
    }
    else {
        //不是财务的时候，只能审批，不能修改，如果有超额问题，则提醒
        $("#opSave").hide();
        $("#container .showData input").attr("readonly", "readonly")

        var financeCtl = $("#financeCtl").val();
        var financeMsg = $("#financeCtl").attr("data-msg");
        if (isNull(financeMsg)==false) {
            showError(financeMsg);
        }
    }
});