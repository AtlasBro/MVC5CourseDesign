//常用工具方法 - 自己编写方法的最顶层

//info输出消息
function info(msg) {
    console.info(msg);
}

function log(msg) {
    console.log(msg);
}

//判断当前地址是否包含某个参数,若包含，则返回参数值
function getValFromUrl(paramName) {
    var url = window.location.href;
    if (url.indexOf(paramName) > 0) {
        var str = url.substr(url.indexOf("?") + 1) + "&";
        var strs = str.split("&");
        for (var i = 0; i < strs.length - 1; i++) {
            var key = strs[i].substring(0, strs[i].indexOf("="));
            if (key == paramName) {
                var val = strs[i].substring(strs[i].indexOf("=") + 1);
                return val;
                break;
            }
        }
    }
}

function objToStr(obj) {
    var keyValue = "";
    // 处理好的json字符串
    var jsonStr = "";
    for (var key in obj) {
        console.info(obj[key])
        keyValue += key + ":" + (typeof (obj[key]) == "string" ? "'" + obj[key] + "'," : obj[key] + ",");
    }
    // 去除最后一个逗号
    keyValue = keyValue.substring(0, keyValue.length - 1);
    jsonStr = "{" + keyValue + "}";
    return jsonStr;
}

//页面权限控制
function privCtl() {
    //无权限的操作移除
    $("[data-show=False]").remove();
}

//判断是否空 undined, null, ''
function isNull(val) {
    if (typeof (val) == undefined)
        return true;
    if (val == null)
        return true;
    if (val == "")
        return true;
    return false;
}

//是否非空
function isNotNull(val) {
    return !isNull(val);
}

//检查文件类型
function checkFileType(filePath, fileType) {
    var extStart = filePath.lastIndexOf(".");
    var ext = filePath.substring(extStart, filePath.length).toUpperCase();
    if (fileType.toUpperCase().indexOf(ext) == -1) {
        showError("文件类型不符合，只能是 " + fileType);
        return false;
    }
    return true;
}

//异步上传文件的方法input标记要提供name属性
function fileUpload(url, fileID, success) {
    $.ajaxFileUpload({
        url: url, //用于文件上传的服务器端请求地址
        secureuri: false, //一般设置为false
        fileElementId: fileID, //文件上传控件的id属性  
        dataType: 'json', //返回值类型 一般设置为json
        success: success,
        error: function (data, status, e)//服务器响应失败处理函数
        {
            alert(status);
        }
    });
    return false;
}

//网址拼接,把参数拼接到网址上
function joinUrl(url, param) {
    if (isNull(param) == false) {
        if (url.indexOf('?') == -1)
            url = url + "?" + param;
        else
            url = url + "&" + param;
    }
    return url;
}


//-------------------------ajax请求与消息显示------------------------
//此方法用来异步提交，返回值类型为json
function ajaxPost(url, data, successCallback) {
    $.ajax({
        type: "post",
        dataType: "json",
        url: url,
        data: data,
        success: successCallback,
        error: function (data) {
            alert("ajax请求出错" + data);
        }
    });
}

//此方法用来异步加载页面内容，返回值类型为html
function ajaxHtml(url, data, successCallback) {
    $.ajax({
        type: "get",
        dataType: "html",
        url: url,
        data: data,
        success: successCallback,
        error: function (data) {
            alert("ajax请求出错" + data);
        }
    });
}

//此方法用来异步提交form，返回值类型为json
function ajaxForm(form, successCallback) {
    if (isNull(form.attr("action")))
        showError("form未设定action");
    ajaxFormUrl(form, form.attr("action"), successCallback);
}

//获取被禁用的select,radio,checkbox的值(禁用后不被提交)
function getDisabledValue(form) {
    var obj = {};
    $(form).find("select[disabled=disabled]").each(function () {
        obj[$(this).attr("name")] = $(this).val();
    });
    $(form).find("input[type='radio'][disabled=disabled][checked='checked']").each(function () {
        obj[$(this).attr("name")] = $(this).val();
    });
    $(form).find("input[type='checkbox'][disabled=disabled][checked='checked']").each(function () {
        obj[$(this).attr("name")] = $(this).val();
    });
    return obj;
}

//个性化数据提交方法 此方法用来异步提交form，返回值类型为json
function ajaxFormUrl(form, url, successCallback) {
    //通过jform提交表单
    $(form).ajaxSubmit({
        url: url,
        dataType: "json",
        data: getDisabledValue(form),
        type: "post",
        error: function (data) {
            alert("ajax请求出错" + data);
        },
        success: function (data) {
            if (successCallback != undefined)
                successCallback(data);
        }
    });
}

//-------------------------消息显示处理------------------------
//显示消息的方法(成功和失败都显示)
//以wait:开头的内容，显示长时间，需要手工关闭消息框
//以no:开头的内容，不显示消息
function showJsonResult(data, successFunc) {
    var message = data.message;
    //成功后所调用的方法
    if (data.result == "True") {
        if (successFunc != undefined) {
            successFunc(data);
        }
        if (message.indexOf("wait:") == 0) {
            //成功后，长时间显示消息
            showError(message.substr(5));
        }
        else if (message.indexOf("no:") == -1) {
            //成功后，不显示消息
            showInfo(message);
        }
    } else {
        showError(message);
    }
}

//显示错误信息所调用的统一方法（不自动隐藏，需要手工关闭）
function showError(error) {
    if (error == "登陆状态失效")
        top.location.href = "/login/loginAdmin";
    if (isNotNull(error)) {
        layui.use('layer', function () {
            var layer = layui.layer;
            layer.ready(function () {
                layer.alert(error, { title: "请注意", area: ['500px', '400px'] });
            });
        });
    }
    return;
}

//显示提示消息所调用的统一方法(自动消失)
function showInfo(message, option) {
    var options = $.extend(true, {}, { time: 1500, maxWidth: 200 }, option);
    layui.use('layer', function () {
        var layer = layui.layer;
        layer.ready(function () {
            layer.msg(message);
        });
    });
    return;
}

//显示确认框
function showConfirm(message, okFunction) {
    layui.use('layer', function () {
        var layer = layui.layer;
        layer.ready(function () {
            layer.confirm(message, { btn: ['确认', '取消'] }, function (index) {
                layer.close(index);
                okFunction();
            });
        });
    });
}

//显示tip提示
function showTip(message, target, option) {
    var tipIndex;
    var options = $.extend(true, {}, { tips: [2, 'red'], time: 4000, tipsMore: true }, option);
    layui.use('layer', function () {
        var layer = layui.layer;
        layer.ready(function () {
            tipIndex = layer.tips(message, target, options);
        });
    });
    return tipIndex;
}

//关闭tip提示
function closeTip(index) {
    layui.use('layer', function () {
        var layer = layui.layer;
        layer.close(index);
    });
}

//-------------------------字符串处理------------------------
//获取数组中包含的内容，返回格式:a,b,c
function getFromArray(array) {
    var result = "";
    for (var i = 0; i < array.length; i++)
        result += array[i] + ",";
    return result;
}

//获取选中元素的数量
function getLength(str, splitTag) {
    var arr = String(str).split(splitTag);
    arr = arrayRemove(arr, '');
    return arr.length;
}

//从数组中移除某个值,返回数组
function arrayRemove(arr, val) {
    for (var i = 0; i < arr.length; i++) {
        if (arr[i] == val) {
            arr.splice(i, 1);
            break;
        }
    }
    return arr;
}

//字符串分割，去除空格，返回数组
function stringSplit(str, splitTag) {
    var arr = String(str).split(splitTag);
    return arrayRemove(arr, '');
}

//将str1和str2的内容进行合并,去重，并返回，格式是：a,b,c,
function stringMerge(str1, str2) {
    var arr1 = stringSplit(str1, ',');
    var arr2 = stringSplit(str2, ',');
    for (var i = 0; i < arr2.length; i++)
        if (arr1.indexOf(arr2[i]) == -1)
            arr1.push(arr2[i]);
    return getFromArray(arr1);
}

//从str1中删除str2中包含的内容，并返回，格式是：a,b,c,
function stringRemove(str1, str2) {
    var arr1 = stringSplit(str1, ',');
    var arr2 = stringSplit(str2, ',');
    for (var i = 0; i < arr2.length; i++) {
        if (arr1.indexOf(arr2[i]) > -1)
            arrayRemove(arr1, arr2[i]);
    }
    return getFromArray(arr1);
}

//获取浏览器视口的大小（显示文档的部分）
function getViewPortSize() {
    // 除IE8及更早的版本以外的浏览器
    if (window.innerWidth != null) {
        return {
            w: window.innerWidth,
            h: window.innerHeight
        }
    }
    // 标准模式下的IE
    if (document.compatMode == "css1Compat") {
        return {
            w: document.documentElement.clientWidth,
            h: document.documentElement.clientHeight
        }
    }
    // 怪异模式下的浏览器
    return {
        w: document.body.clientWidth,
        h: document.body.clientHeight
    }
}

//获取窗口滚动条的位置（x和y的位置）
function getScrollOffset() {
    // 除IE8及更早版本
    if (window.pageXOffset != null) {
        return {
            x: window.pageXOffset,
            y: window.pageYOffset
        }
    }
    // 标准模式下的IE
    if (document.compatMode == "css1Compat") {
        return {
            x: document.documentElement.scrollLeft,
            y: document.documentElement.scrollTop
        }
    }
    // 怪异模式下的浏览器
    return {
        x: document.body.scrollLeft,
        y: document.body.scrollTop
    }
}

//跳转到单据的修改界面
function redirectUpdate(rowID, url) {
    //如果跳转的修改界面不是/Update?rowID=xxx，则新增Action需要返回url，否则就通过新增的URL计算出修改的URL
    if (isNull(url) == false)
        window.location.href = url + "?rowID=" + rowID;
    else {
        var url = window.location.href;
        url = url.substring(0, url.lastIndexOf("/") + 1);
        window.location.href = url + "Update?rowID=" + rowID;
    }
}

//json解析
function parseJSON(val) {
    if (isNull(val) == false) {
        return $.parseJSON(val);
    }
    return "";
}

function getOptionValue(selector, option) {
    var attrValue = $(selector).attr("data-option");
    if (isNull(attrValue))
        return "";
    attrValue = eval("(" + attrValue + ")");
    if (isNull(attrValue[option]))
        return "";
    return attrValue[option];
}

//检查某表单输入的信息是否满足要求
//检查的类型Date,Number
//不满足，则提示，并返回FALSE, 否则返回TRUE
function checkInput(colTag, dataType) {
    $(colTag).each(function () {
        //正整数
        if (dataType == "正整数") {
            if (/^\d+(\.\d+)?$/.test($(this).val())) {
                return true;
            }
            else {
                showInfo("输入的数据类型应为：" + dataType);
                return false;
            }
        }
        //非负数
        if (dataType == "金额") {
            if (/^([1-9][\d]{0,7}|0)(\.[\d]{1,2})?$/.test($(this).val())) {
                return true;
            }
            else {
                showInfo("输入的数据类型不应为：" + dataType);
                return false;
            }
        }
    });
}

function htmlEncode(value) {
    var result = $('<div />').text(value).html();
    return result;
}


function htmlDecode(value) {
    var result = $('<div />').html(value).text();
    return result;
}





