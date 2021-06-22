$(function () {
    var isMouseDown = false;
    var currentTh = null;
    $("body").on("mousedown", "table th", function (e) {
        var $th = $(this);
        var left = $th.offset().left; //元素距左
        var rightPos = left + $th.outerWidth();
        if (rightPos - 4 <= e.pageX && e.pageX <= rightPos) {
            isMouseDown = true;
            currentTh = $th;
            $('table th').css('cursor', 'ew-resize');

            //创建遮罩层，防止mouseup事件被其它元素阻止冒泡，导致mouseup事件无法被body捕获，导致拖动不能停止
            var bodyWidth = $('body').width();
            var bodyHeight = $('body').height();
            $('body').append('<div id="mask" style="opacity:0;top:0px;left:0px;cursor:ew-resize;background-color:green;position:absolute;z-index:9999;width:' + bodyWidth + 'px;height:' + bodyHeight + 'px;"></div>');
        }
    });
    $('body').bind({
        mousemove: function (e) {
            //移动到column右边缘提示
            $('table th').each(function (index, eleDom) {
                var ele = $(eleDom);
                var left = ele.offset().left; //元素距左
                var rightPos = left + ele.outerWidth();
                if (rightPos - 4 <= e.pageX && e.pageX <= rightPos) { //移到列右边缘
                    ele.css('cursor', 'ew-resize');
                } else {
                    if (!isMouseDown) { //不是鼠标按下的时候取消特殊鼠标样式
                        ele.css("cursor", "auto");
                    }
                }
            });

            //改变大小
            if (currentTh != null) {
                if (isMouseDown) { //鼠标按下了，开始移动
                    var left = currentTh.offset().left;
                    var paddingBorderLen = currentTh.outerWidth() - currentTh.width();
                    currentTh.width((e.pageX - left - paddingBorderLen) + 'px');
                }
            }
        },
        mouseup: function (e) {
            isMouseDown = false;
            currentTh = null;
            $('table th').css('cursor', 'auto');
            $('#mask').remove();
        }
    });
});