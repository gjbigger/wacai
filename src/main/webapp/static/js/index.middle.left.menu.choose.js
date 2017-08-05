/**
 * Created by GJ on 2017/4/13 0013.
 */
/**
 * 菜单选择执行的方法
 */

//主菜单///////////////////////////////////////////


function overview() {
    chooseMenu("overview");
    window.location.href="index/toOverviewJsp";
}

function record() {
    chooseMenu("record");
    window.location.href="index/toRecordJsp";
}

function detail() {
    chooseMenu("detail");
    window.location.href="index/toDetailJsp";
}

function report() {
    chooseMenu("report");
    window.location.href="index/toReportJsp";
}

function account() {
    chooseMenu("account");
    window.location.href="index/toAccountListJsp";
}

function budget() {
    chooseMenu("budget");
    window.location.href="index/toBudgetListJsp";
}

function set() {
    chooseMenu("set");
}






//子菜单///////////////////////////////////////////
function set_personCenter() {
    chooseMenu("personCenter");
    window.location.href="index/toSetPersonCenterJsp";
}

function set_notification() {
    chooseMenu("notification");
    window.location.href="index/toSetNotificationJsp";
}

function set_importExport() {
    chooseMenu("importExport");
    window.location.href = "index/toSetImportExportJsp";
}

function set_baseDataSetting() {
    chooseMenu("baseDataSetting");
    window.location.href = "index/toSetBaseDataSettingJsp";
    
}

function set_rssSetting() {
    chooseMenu("rssSetting");
}

function set_personSetting() {
    chooseMenu("personSetting");
    window.location.href="index/toSetPersonSettingJsp";
}

function set_toolKit() {
    chooseMenu("toolKit");
}







//辅助方法///////////////////////////////////////////
function chooseMenu(menuId) {
    if (menuId === 'set') {
        $("#set_detail").toggle("fast", "linear");
        var $jianTou = $($("#set").children("span").get(1));
        if ($jianTou.attr("class") === "glyphicon glyphicon-menu-down") {
            $jianTou.removeClass("glyphicon glyphicon-menu-down");
            $jianTou.addClass("glyphicon glyphicon-menu-up");
        } else {
            $jianTou.removeClass("glyphicon glyphicon-menu-up");
            $jianTou.addClass("glyphicon glyphicon-menu-down");
        }
    } else {
        $('#middle_left .current').removeClass('current');
        $('#' + menuId).addClass('current');
    }
}