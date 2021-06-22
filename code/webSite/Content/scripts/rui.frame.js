//后台框架页面引用
//首页框架用到的相关js代码
//主框架内的弹窗按钮 - 不刷新 - 修改密码用的
function openDialog(title, url, pwin, max) {
    var navWidth = $(pwin).width();
    var navHeight = $(pwin).height();
    var width = 1000;
    var height = 500;

    //如果没有则添加
    if ($("#divDialog").length == 0) {
        var dialog = $("<div id='divDialog' style='text - align: right;'></div>")
        $("body").append(dialog);
    }
    $("#divDialog").window({
        title: title,
        content: "<iframe id=\"iframeDialog\" data-opentype='dialog' name=\"iframeDialog\" frameborder=\"0\"  width=\"100%\" height=\"100%\" src=\"" + url + "\"></iframe>",
        width: width,
        height: height,
        top: (navHeight - height) / 2,
        left: (navWidth - width) / 2,
        maximizable: true,
        minimizable: false,
        collapsible: false,
        modal: true,
        onClose: function () {

        }
    });
    if (isNull(max) == false)
        $("#divDialog").window("maximize");
}


//关闭对话框,在弹窗页面内通过调用window.parent.closeDialog()来关闭对话框
function closeDialog() {
    $("#divDialog").window('close');
}


//通过title和url来创建一个新的tab页面
//refleshtype:type1-不刷新;type2-局部刷新;type3-整页刷新
function addTab(title, url, refleshtype) {
    //获取父元素的title
    var ptitle = $('#tabs').tabs('getSelected').panel('options').title;

    if ($('#tabs').tabs('exists', title)) {
        $('#tabs').tabs('select', title);
        $('#tabs').tabs('getSelected').children("iframe").attr("src", url);
    }
    else {
        $('#tabs').tabs('add', {
            title: title,
            content: "<iframe id=\"iframeTab\" data-opentype='tab' data-ptitle='" + ptitle + "' data-refleshtype='" + refleshtype + "' name=\"mainTab\" frameborder=\"0\" width=\"100%\" height=\"100%\" src=\"" + url + "\"></iframe>",
            closable: true,
            tools: [{
                iconCls: 'icon-mini-refresh',
                handler: function () {
                    var url = $('#tabs').tabs('getSelected').children("iframe").attr("src");
                    $('#tabs').tabs('getSelected').children("iframe").attr("src", url);
                }
            }]
        });
    }
}

//关闭当前Tab
//Tab页面内通过调用window.parent.closeTab()来关闭对话框
function closeTab() {
    //关闭当前
    var tab = $('#tabs').tabs('getSelected');
    var index = $('#tabs').tabs('getTabIndex', tab);
    $('#tabs').tabs('close', index);
}

//通过title 局部刷新页面
function refleshTab(refleshTitle) {
    if ($('#tabs').tabs('exists', refleshTitle)) {
        $iframe = $('#tabs').tabs('getTab', refleshTitle).children("iframe").get(0);
        $iframe.contentWindow.refleshData(true);
    }
}

//通过title 整体刷新页面
function refleshTabR(refleshTitle) {
    if ($('#tabs').tabs('exists', refleshTitle)) {
        var url = $('#tabs').tabs('getTab', refleshTitle).children("iframe").attr("src");
        $('#tabs').tabs('getTab', refleshTitle).children("iframe").attr("src", url);
    }
}

//tabsMenu关闭Tab的代码
//type=close 关闭自己，other 关闭其他，all 关闭所有
function closeMenuTab(menu, type) {
    console.info(type);
    var curTabTitle = $(menu).data("tabTitle");
    var tabs = $("#tabs");
    if (type === "close" && curTabTitle != "我的首页") {
        tabs.tabs("close", curTabTitle);
        return;
    }
    var allTabs = tabs.tabs("tabs");
    var refleshTabsTitle = [];
    $.each(allTabs, function () {
        var opt = $(this).panel("options");
        if (opt.closable && opt.title != curTabTitle && type === "other") {
            refleshTabsTitle.push(opt.title);
        } else if (opt.closable && type === "all") {
            refleshTabsTitle.push(opt.title);
        }
    });
    for (var i = 0; i < refleshTabsTitle.length; i++) {
        tabs.tabs("close", refleshTabsTitle[i]);
    }
    if (type == "other") {
        $('#tabs').tabs("select", curTabTitle);
        console.info(curTabTitle);
    }
}

function closeAllTab() {
    var tabs = $("#tabs");
    var allTabs = tabs.tabs("tabs");
    var refleshTabsTitle = [];
    $.each(allTabs, function () {
        var opt = $(this).panel("options");
        if (opt.closable) {
            refleshTabsTitle.push(opt.title);
        }
    });
    for (var i = 0; i < refleshTabsTitle.length; i++) {
        tabs.tabs("close", refleshTabsTitle[i]);
    }
}


//处理Tab页的刷新事件
function handleTabReflesh($iframe) {
   
    //关闭前 - 获取关闭页面的父Tab标题和刷新类型
    var ptitle = $($iframe).attr("data-ptitle");
    var refleshtype = $($iframe).attr("data-refleshtype");
    console.info(refleshtype);
    //局部刷新 - 调框架页面的局部刷新方法
    if (refleshtype == "type2") {
        console.info("closing");
        window.parent.refleshTab(ptitle);
    }
    //整页刷新 - 调框架页面的整页刷新方法
    if (refleshtype == "type3") {
        window.parent.refleshTabR(ptitle);
    }
}


//处理Tab页的手动关闭前事件
function handleTabCloseing($iframe) {
    //关闭前 - 处理本页面未保存的单据(废弃)
    var $checkSave = $("#checkSave", $iframe.contentWindow.document);
    if ($checkSave.length == 1) {
        if ($($checkSave).attr("data-isSave") != "是") {
            var keyCode = $($checkSave).val();
            var url = $($checkSave).attr("data-url");
            //如果没保存，则删除该单据
            ajaxPost(url, { keyCode: keyCode }, function (data) {
                //如果未保存，保存后刷新
                handleTabReflesh($iframe);
            });
        } else {
            //如果已保存，直接刷新
            handleTabReflesh($iframe);
        }
    }
    else {
        //如果不检测未保存，直接刷新
        handleTabReflesh($iframe);
    }
}

//获取当前时间
function currentTime() {
    var d = new Date(), str = '';
    str += d.getFullYear() + '年';
    str += d.getMonth() + 1 + '月';
    str += d.getDate() + '日';
    return str;
}

$(document).ready(function () {
    //初始化tab，设置相关属性，并设定tab的自定义Menu
    $("#tabs").tabs({
        border: false,
        fit: true,
        onContextMenu: function (e, title, index) {
            e.preventDefault();
            $('#tabsMenu').menu('show', {
                left: e.pageX,
                top: e.pageY
            }).data("tabTitle", title);
        },
        onBeforeClose: function (title, index) {
            //获取关闭Tab所拥有的iframe对象
            var $iframe = $('#tabs').tabs('getSelected').children("iframe").get(0);
            handleTabCloseing($iframe, title);
        }
    });

    //单击class="addTab"的超链接元素时，创建一个Tab
    $("body").on("click",".addTab", function (e) {
        var url = $(this).attr("href");
        var title = $(this).text();
        addTab(title, url, "type1");
        return false;
    });

    //Menu的菜单项点击后执行的代码，调用菜单项关Tab方法
    $("#tabsMenu").menu({
        onClick: function (item) {
            closeMenuTab(this, item.name);
        }
    });

    //初始化accordion,设置相关属性
    $('#accordion').accordion({
        animate: true,
        fit: true,
        border: false
    });

    //定义accordion的鼠标样式
    $("#accordion a").mouseover(function () {
        $(this).css("color", "blue");
        $(this).css("font-weight", "bolder");
    });

    $("#accordion a").mouseout(function () {
        $(this).css("color", "black");
        $(this).css("font-weight", "normal");
    });

    //显示当前日期
    $('#time').html(currentTime());
});