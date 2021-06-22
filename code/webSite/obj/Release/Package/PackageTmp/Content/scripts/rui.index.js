//后台框架页面引用
$(document).ready(function () {
    $(".changePW").click(function () {
        openDialog("修改密码", $(this).attr("href"), window);
        return false;
    });

    //加载我的首页
    $('#tabs').tabs('add', {
        title: '我的首页',
        content: "<iframe id=\"mainTab\" name=\"mainTab\" frameborder=\"0\" width=\"100%\" height=\"100%\" src=\"desktop\"></iframe>",
        closable: false,
        tools: [{
            iconCls: 'icon-mini-refresh',
            handler: function () {
                var url = $('#tabs').tabs('getSelected').children("iframe").attr("src");
                $('#tabs').tabs('getSelected').children("iframe").attr("src", url);
            }
        }]
    });

    //左侧功能导航
    $(".f_left .ul_module").eq(0).addClass("active").siblings(".ul_module").removeClass("active");
    $(".f_left .ul_module .ul_resource").hide();
    $(".f_left .ul_module .ul_resource").eq(0).show();
    $(".f_left .ul_module > div").click(function () {
        setModuleHeight();
        var index = $(".f_left .ul_module > div").index($(this));
        if ($(".f_left .ul_module").eq(index).hasClass("active")) {
            $(".f_left .ul_module").eq(index).removeClass("active");
            $(".f_left .ul_module .ul_resource").eq(index).hide();
        }
        else {
            $(".f_left .ul_module").eq(index).addClass("active").siblings(".ul_module").removeClass("active");
            $(".f_left .ul_module .ul_resource").hide();
            $(".f_left .ul_module .ul_resource").eq(index).show();
        }
    });

    //最下边的线条
    $(".f_left .ul_module > div").last().css({
        "border-bottom-style": "dotted",
        "border-bottom-color": "#02F2F2",
        "border-bottom-width": "1pt"
    });
});

//设置模块的最大高度
function setModuleHeight() {
    console.info("setModuleHeight");
    var hLeft = $(".f_left").height();
    console.info(hLeft);
    var mCount = $(".ul_module").length;;
    var rHeight = hLeft - 30 * mCount;
    $(".ul_resource").css("max-height", rHeight);
}