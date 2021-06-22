$(document).ready(function () {

    //保存数据
    $(".opSave").addClass("btn").prepend("<i class='fa fa-floppy-o'></i>&nbsp;");

    //普通按钮
    $(".opBtn").addClass("btn").prepend("<i class='fa fa-asterisk'></i>&nbsp;");

    //关闭按钮
    $(".opClose").addClass("btn").prepend("<i class='fa fa-close'></i>&nbsp;");

    //搜索类按钮
    $(".opSearch").addClass("btn").prepend("<i class='fa fa-search'></i>&nbsp;");

    //打印按钮 
    $(".opPrint").addClass("btn").prepend("<i class='fa fa-print'></i>&nbsp;");

    //确认按钮
    $(".opConfirm").addClass("btn").prepend("<i class='fa fa-check-circle'></i>&nbsp;");

    //选择按钮 
    $(".opSelect").addClass("btn").prepend("<i class='fa fa-filter'></i>&nbsp;");

    //新增按钮
    $(".opInsert").addClass("btn").prepend("<i class='fa fa-plus'></i>&nbsp;");
    $(".opUpdate").addClass("btn").prepend("<i class='fa fa-edit'></i>&nbsp;");

    //外库导入
    $(".opImport").addClass("btn").prepend("<i class='fa fa-reply'></i>&nbsp;");
    $(".opExlImport").addClass("btn").prepend("<i class='fa fa-file-excel-o'></i>&nbsp;");

    //Excel导出数据
    $(".opExlExport").addClass("btn").prepend("<i class='fa fa-file-excel-o'></i>&nbsp;");

    //批量删除
    $(".opBatchDelete").addClass("btn").prepend("<i class='fa fa-floppy-o'></i>&nbsp;");

    //显示
    $(".opShow").addClass("btn").prepend("<i class='fa fa-arrow-down'></i>&nbsp;");

    //隐藏
    $(".opHide").addClass("btn").prepend("<i class='fa fa-arrow-up'></i>&nbsp;");

    //上传按钮
    $(".opUpload").addClass("btn").prepend("<i class='fa fa-paperclip'></i>&nbsp;");

    //下载按钮
    $(".opDownload").addClass("btn").prepend("<i class='fa fa-download'></i>&nbsp;");

    //定制
    $(".opPage").addClass("btn").prepend("<i class='fa fa-wrench'></i>&nbsp;");

    //打开查看
    $(".opSee").addClass("btn").prepend("<i class='fa fa-file-word-o'></i>&nbsp;");

});