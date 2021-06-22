//批量文本框录入支持鼠标移动位置
//使用方法如下
//$(document).ready(function () {
//    第一个参数是控件的ID，第二个参数是控件类型
//    new tabTableInput("ctl00_ContentPlaceHolder1_GridView质检数据", "text");
//});

var tabTableInput = function (tableId, inputType) {
    var rowInputs = [];
    var trs = $("#" + tableId).find("tr");
    var inputRowIndex = 0;
    $.each(trs, function (i, obj) {
        if ($(obj).find("th").length > 0) { //跳过表头
            return true;
        }
        var rowArray = [];
        var thisRowInputs;
        if (!inputType) { //所有的input
            thisRowInputs = $(obj).find("input:not(:disabled):not(:hidden):not([readonly])");
        } else {
            thisRowInputs = $(obj).find("input:not(:disabled):not(:hidden):not([readonly])[type=" + inputType + "]");
        }
        if (thisRowInputs.length == 0)
            return true;

        thisRowInputs.each(function (j) {
            //alert("xx");
            $(this).attr("_r_", inputRowIndex).attr("_c_", j);
            rowArray.push({ "c": j, "input": this });

            $(this).keydown(function (evt) {
                var r = $(this).attr("_r_");
                var c = $(this).attr("_c_");

                var tRow
                if (evt.which == 38) { //上
                    if (r == 0)
                        return;

                    r--; //向上一行

                    tRow = rowInputs[r];
                    if (c > tRow.length - 1) {
                        c = tRow.length - 1;
                    }
                } else if (evt.which == 40) { //下
                    if (r == rowInputs.length - 1) { //已经是最后一行
                        return;
                    }

                    r++;
                    tRow = rowInputs[r];
                    if (c > tRow.length - 1) {
                        c = tRow.length - 1;
                    }
                } else if (evt.which == 37) { //左
                    if (r == 0 && c == 0) { //第一行第一个,则不执行操作
                        return;
                    }
                    if (c == 0) { //某行的第一个,则要跳到上一行的最后一个,此处保证了r大于0
                        r--;
                        tRow = rowInputs[r];
                        c = tRow.length - 1;
                    } else { //否则只需向左走一个
                        c--;
                    }
                } else if (evt.which == 39) { //右
                    tRow = rowInputs[r];
                    if (r == rowInputs.length - 1 && c == tRow.length - 1) { //最后一个不执行操作
                        return;
                    }

                    if (c == tRow.length - 1) { //当前行的最后一个,跳入下一行的第一个
                        r++;
                        c = 0;
                    } else {
                        c++;
                    }
                }
                $(rowInputs[r].data[c].input).focus();
            });
        });

        rowInputs.push({ "length": thisRowInputs.length, "rowindex": inputRowIndex, "data": rowArray });
        inputRowIndex++;

    });
}