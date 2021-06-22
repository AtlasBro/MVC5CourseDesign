
//母版页引用的
$(document).ready(function () {

    //在子页面内单击class="addTab"的元素时，以Tab的方式显示页面，通过data-title设置tab标题
    $("body").on("click", ".addTab", function (event) {
        $(this).trigger("mouseout");
        var title = $(this).attr("data-title");
        if (isNull(title))
            title = $(this).text();
        window.parent.addTab(title, event.currentTarget.href, "type1");
        return false;
    });

    //在子页面内单击class="addTabR"的元素时，以Tab的方式显示页面，通过data-title设置tab标题
    $("body").on("click", ".addTabR", function (event) {
        $(this).trigger("mouseout");
        var title = $(this).attr("data-title");
        if (isNull(title))
            title = $(this).text();
        window.parent.addTab(title, event.currentTarget.href, "type2");
        return false;
    });

    //在子页面内单击class="addTabR"的元素时，以Tab的方式显示页面，通过data-title设置tab标题
    $("body").on("click", ".addTabRR", function (event) {
        window.parent.addTab($(this).attr("data-title"), event.currentTarget.href, "type3");
        return false;
    });

    //页面权限控制 - rui.tool.js
    privCtl();

    //ajax请求开始显示loading
    $(document).ajaxStart(function (option) {
        console.info(option);
        $("#loading").css("height", $(document).height());
        $("#loading").show();
    });

    //ajax请求结束隐藏loading
    $(document).ajaxStop(function (option) {
        console.info(option);
        $("#loading").hide();
    });
});