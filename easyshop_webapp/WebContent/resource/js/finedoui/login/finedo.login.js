$(document).ready(function() {
	finedo.action.ajax({
		url:ctx+"/finedo/auth/developerlogin",
		iswait:false,
		callback:function(jsondata){
			if(jsondata.success){
				window.location.href = ctx+jsondata.object;
			}
		}
	});
});