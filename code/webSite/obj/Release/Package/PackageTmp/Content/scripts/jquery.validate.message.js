jQuery.extend(jQuery.validator.messages, {
    required: "必填",
    remote: "请修正该字段",
    email: "邮件",
    url: "网址",
    date: "日期",
    dateISO: "日期 (ISO).",
    number: "数字",
    digits: "整数",
    creditcard: "信用卡号",
    equalTo: "请再次输入相同的值",
    accept: "请输入拥有合法后缀名的字符串",
    maxlength: jQuery.validator.format("最多是{0}的字符串"),
    minlength: jQuery.validator.format("最少是{0}的字符串"),
    rangelength: jQuery.validator.format("长度介于{0}和{1}之间的字符串"),
    range: jQuery.validator.format("介于{0}和{1}之间的值"),
    max: jQuery.validator.format("最大为{0}的值"),
    min: jQuery.validator.format("最小为{0}的值")
});