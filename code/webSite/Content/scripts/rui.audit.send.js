//单据送审页面需要应用 -- 列表界面

//单据送审方法
function sendAudit(relatedRowID, auditType) {
    //调用单据送审方法，根据count决定是否弹窗选择审批流
    ajaxPost("/admin/afAuditCenter/doSendAudit", { type: auditType, relatedRowID: relatedRowID }, function (data) {
        if (data.result == "True") {
            if (data.count == 1) {
                //送审成功后，刷新界面，并显示消息
                refleshData(false);
                showInfo(data.message);
            } else {
                //打开审批流选择界面，选择可用的审批流
                OpenDialog("选择审批流", "/admin/afAuditCenter/selectAuditFlow?rowID=" + relatedRowID + "&type=" + auditType);
            }
        } else {
            showError(data.message);
        }
    });
}
//通过AJAX请求服务器查看是否有一个审批流，如果有一个，则执行送审操作
//如果有多个，则弹出审批流选择窗口（将送审单据类型和编号），选择完毕后进行单据送审，并刷新父窗口
$(document).ready(function () {
    $("body").on("click",".opSendAudit", function () {
        if (confirm("确认送审？")) {
            var relatedRowID = $(this).attr("data-rowid");
            var auditType = $(this).attr("data-type");
            //调用上方的函数
            sendAudit(relatedRowID, auditType);
        }
        return false;
    });
});

