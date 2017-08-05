$(function() {
	var $recordCurrentTab = "#pay_out_add";
	$recordCurrentTab = recordTabListChange($recordCurrentTab);

});

function recordTabListChange($recordCurrentTab) {
	$("#record-tablist a").click(function() {
		if ($recordCurrentTab !== '') {
			$($recordCurrentTab + "_form").get(0).reset();
		}
		$recordCurrentTab = $(this).attr("href");
	});
	return $recordCurrentTab;
}