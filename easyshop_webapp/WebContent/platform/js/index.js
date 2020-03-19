$(function () {
    //执行代码块
    var Owidth = $(window).width();
    if (Owidth < 900) {
        if ($(".basic-left").css("left") >= "0px") {
            $(".basic-left").css("left", "-250px");
            $(".main-iframebox").css("left", 0);
            $(".base-menu").children("img").attr("src", "../../platform/themes/images/menu_ico2.png");
            $(".base-menu").removeClass("active");
        }
        $(".blackbg").click(function () {
            $(".basic-left").animate({
                left: "-250px"
            });
            $(".main-iframebox").animate({
                left: "0"
            });
            $(".base-menu").removeClass("active");
            $(".base-menu").children("img").attr("src", "../../platform/themes/images/menu_ico2.png");
            $(".blackbg").hide();
            $(".moremenu").hide();
        });

        $(".base-menu").click(function () {
            if ($(this).is(".active")) {
                $(".basic-left").animate({
                    left: "-250px"
                });
                $(".main-iframebox").animate({
                    left: "0"
                });
                $(this).removeClass("active");
                $(this).children("img").attr("src", "../../platform/themes/images/menu_ico2.png");
                $(".blackbg").hide();
                $(".moremenu").hide();
            } else {
                $(".basic-left").animate({
                    left: "0"
                });
                $(".main-iframebox").animate({
                    left: "250px"
                });
                $(this).addClass("active");
                $(this).children("img").attr("src", "../../platform/themes/images/menu_ico1.png");
                $(".blackbg").show();
                $(".moremenu").hide();
            }
        });
    } else {
        $(".base-menu").click(function () {
            if ($(this).is(".active")) {
                $(".basic-left").animate({
                    left: "-250px"
                });
                $(".main-iframebox").animate({
                    left: "0"
                });
                $(this).removeClass("active");
                $(this).children("img").attr("src", "../../platform/themes/images/menu_ico2.png");
                $(".blackbg").hide();
                $(".moremenu").hide();
            } else {
                $(".basic-left").animate({
                    left: "0"
                });
                $(".main-iframebox").animate({
                    left: "250px"
                });
                $(this).addClass("active");
                $(this).children("img").attr("src", "../../platform/themes/images/menu_ico1.png");
                $(".blackbg").hide();
                $(".moremenu").hide();
            }
        });

        $(".blackbg").click(function () {
            $(".moremenu").hide();
            $(this).hide();
        });
    }

    //切换用户
    $(".switchbtn").click(function () {
        $(".switch-cons").css("display", "inline-block");
        $(this).hide();
    });

    $(".cancel").click(function () {
        $(".switch-cons").css("display", "none");
        $(".switchbtn").show();
    });

    $(".basic-left-menu").on("click", "dd", function () {
        var node = index.getNodeById($(this).attr("id"), appindex.userpermissionlist);
        index.menuclick(node);
        if (!finedo.fn.isnon(node.children)) {
            if ($(this).is(".active")) {
                $(this).children(".downico").attr("src", "../../platform/themes/images/square.png");
                $(this).removeClass("active");
            } else {
                $(this).children(".downico").attr("src", "../../platform/themes/images/squareico2.png");
                $(this).addClass("active");

            }
        }
        $(".moremenu").hide();
        if ($(window).width() >= 900) {
            $(".blackbg").hide();
        }
        $(this).children("ul").slideToggle();
    });

    $(".basic-left-menu").on("click", "dd li", function () {
        var node = index.getNodeById($(this).attr("id"), appindex.userpermissionlist);
        if (!finedo.fn.isnon(node.children)) {
            index.initMoreMenu(node);
        } else {
            $(".moremenu").hide();
            $(".blackbg").hide();
        }
        index.menuclick(node);
        if (!finedo.fn.isnon(node.permissionentry)) {
            $(".basic-left-menu li").removeClass("active");
            $(this).addClass("active");
        }
        return false;
    });

    $("#moremenulist").on("click", "ul li", function () {
        var node = index.getNodeById($(this).attr("id"), appindex.userpermissionlist);
        if (!finedo.fn.isnon(node.children)) {
            index.initMoreMenu(node);
        } else {
            var currentNode = node;
            var parentNode = index.getNodeById(currentNode.pid, appindex.userpermissionlist);
            while (parentNode.pid != "0") {
                currentNode = parentNode;
                parentNode = index.getNodeById(parentNode.pid, appindex.userpermissionlist);
            }
            $(".basic-left-menu li").removeClass("active");
            $("#" + currentNode.id).addClass("active");
        }
        index.menuclick(node);
    });

    $("#moremenu-tits").on("click", "img", function () {
        var node = index.getNodeById($("#moremenu-title").attr("value"), appindex.userpermissionlist);
        node = index.getNodeById(node.pid, appindex.userpermissionlist);
        if (node.pid != "0") {
            index.initMoreMenu(node);
        } else {
            $(".moremenu").hide();
            if ($(window).width() >= 900) {
                $(".blackbg").hide();
            }
        }
    })
});
var index = {
    initMenu: function () {
        var leftmenuhtml = "";
        for (var i = 0; i < appindex.userpermissionlist.length; i++) {
            var item = appindex.userpermissionlist[i];
            leftmenuhtml += '<dd id="' + item.nodeid + '"><a href="#"></a>';
            leftmenuhtml += item.name;
            if (finedo.fn.isnon(item.permissionentry)) {
                leftmenuhtml += '<img src="../../platform/themes/images/square.png" class="downico">';
            }
            leftmenuhtml += '<ul>';
            for (var j = 0; j < item.children.length; j++) {
                var childNode = item.children[j];
                leftmenuhtml += '<li id="' + childNode.nodeid + '">' + childNode.name + '</li>';
            }
            leftmenuhtml += '</ul></dd>';
        }
        $("#leftmenu").html(leftmenuhtml);
    },
    initMoreMenu: function (node) {
        if ($("#moremenu-title").attr("value") == node.id) {
            $(".moremenu").toggle();
            if ($(window).width() < 900) {
                $(".blackbg").show();
            } else {
                $(".blackbg").toggle();
            }
            return;
        }
        $("#moremenu-title").html(node.name);
        $("#moremenu-title").attr("value", node.id);
        var moreMenuHtml = "<ul>";
        for (var i = 0; i < node.children.length; i++) {
            var child = node.children[i];
            moreMenuHtml += "<li id='" + child.id + "'>" + child.name + "</li>";
        }
        moreMenuHtml += "</ul>";
        $("#moremenulist").html(moreMenuHtml);
        $(".moremenu").show();
        $(".blackbg").show();
    },
    menuclick: function (node) {
        if (finedo.fn.isnon(node.permissionentry)) {
            return;
        }
        $(".moremenu").hide();
        $(".blackbg").hide();
        if ($(window).width() < 900) {
            $(".basic-left").animate({
                left: "-250px"
            });
            $(".main-iframebox").animate({
                left: "0"
            });
            $(".base-menu").removeClass("active");
            $(".base-menu").children("img").attr("src", "../../platform/themes/images/menu_ico2.png");
        }
        $('#mainFrame').attr('src', "../.." + node.permissionentry);
    },
    switchLogin: function () {
        var account = $.trim($("#accountuser").val());
        if (finedo.fn.isnon(account)) {
            finedo.message.tip("请输入要切换的账号");
            return;
        }
        finedo.action.ajax({
            url: "../../finedo/auth/developerlogin",
            data: {account: account},
            callback: function (ret) {
                if (ret.fail) {
                    finedo.message.error(ret.resultdesc);
                    return;
                }
                $.cookie("account", account, {httponly: true});
                window.top.location.href = "../.." + ret.object;
            }
        });
    },
    formatData: function (data) {
        var formatdata = [];
        for (var i = 0; i < data.length; i++) {
            if (data[i].pid != '0') {
                continue;
            }
            formatdata.push(data[i]);
            index.parseChildren(data, data[i]);
        }
        return formatdata;
    },
    parseChildren: function (data, node) {
        for (var i = 0; i < data.length; i++) {
            if (data[i].pid != node.id) {
                continue;
            }
            if (finedo.fn.isNon(node.children)) {
                node.children = [];
            }
            node.children.push(data[i]);
            index.parseChildren(data, data[i]);
        }
    },
    getNodeById: function (id, data) {
        for (var i = 0; i < data.length; i++) {
            if (data[i].nodeid == id) {
                return data[i];
            }
            if (finedo.fn.isnon(data[i].children)) {
                continue;
            }
            var node = index.getNodeById(id, data[i].children);
            if (!finedo.fn.isnon(node)) {
                return node;
            }
        }
    }
};