finedo.choose = {
	/**
	 * 组织机构单选
	 */
	singleOrg:function(ccallback){
		finedo.dialog.show({'selecttype':'single',
			width:300,
			'title':'双击选择',
			'loadtype':'iframe',
			'url':ctx+'/fsdp/org/choose.jsp?selecttype=single',
			callback:function(data){
				if($.isFunction(ccallback))
					ccallback(data);
			}
		});
	}
	
	/**
	 * 组织机构多选
	 */
	,multiOrg:function(ccallback){
		finedo.dialog.show({'selecttype':'multi',
			width:300,
			'title':'组织机构选择',
			'loadtype':'iframe',
			'url':ctx+'/fsdp/org/choose.jsp?selecttype=multi',
			callback:function(data){
				if($.isFunction(ccallback))
					ccallback(data);
			}
		});
	}
	
	/**
	 * 单选角色
	 */
	,singleRole:function(ccallback){
		finedo.dialog.show({'selecttype':'single',
			width:1000,height:600,
			'title':'选择岗位角色（双击表格行）',
			'loadtype':'iframe',
			'url':ctx+'/fsdp/role/choose.jsp?selecttype=single',
			callback:function(data){
				if($.isFunction(ccallback))
					ccallback(data);
			}
		});
	}
	
	/**
	 * 多选角色
	 */
	,multiRole:function(ccallback){
		finedo.dialog.show({'selecttype':'multi',
			width:1000,height:600,
			'title':'选择角色',
			'loadtype':'iframe',
			'url':ctx+'/fsdp/role/choose.jsp?selecttype=multi',
			callback:function(data){
				if($.isFunction(ccallback))
					ccallback(data);
			}
		});
	}

	/**
	 * 单选用户
	 */
	,singleUser:function(ccallback){
		finedo.dialog.show({'selecttype':'single',
			width:900,height:600,
			'title':'选择用户（双击表格行）',
			'loadtype':'iframe',
			'url':ctx+'/fsdp/user/choose.jsp?selecttype=single',
			callback:function(data){
				if($.isFunction(ccallback))
					ccallback(data);
			}
		});
	}

	/**
	 * 多选用户
	 */
	,multiUser:function(ccallback){
		finedo.dialog.show({'selecttype':'multi',
			width:1000,height:600,
			'title':'选择用户',
			'loadtype':'iframe',
			'url':ctx+'/fsdp/user/choose.jsp?selecttype=multi',
			callback:function(data){
				if($.isFunction(ccallback))
					ccallback(data);
			}
		});
	}

		
	/**
	 * 单选用户表
	 */
	,singleEasyshopuser:function(ccallback){
		finedo.dialog.show({'selecttype':'single',
			width:900,height:600,
			'title':'选择用户表（双击表格行）',
			'loadtype':'iframe',
			'url':ctx+'/easyshop/easyshopuser/choose.jsp?selecttype=single',
			callback:function(data){
				if($.isFunction(ccallback))
					ccallback(data);
			}
		});
	}
	
	/**
	 * 多选用户表
	 */
	,multiEasyshopuser:function(ccallback){
		finedo.dialog.show({'selecttype':'multi',
			width:1000,height:600,
			'title':'选择用户表',
			'loadtype':'iframe',
			'url':ctx+'/easyshop/easyshopuser/choose.jsp?selecttype=multi',
			callback:function(data){
				if($.isFunction(ccallback))
					ccallback(data);
			}
		});
	}
	
	
	/**
	 * 单选订单表
	 */
	,singleEasyshoporder:function(ccallback){
		finedo.dialog.show({'selecttype':'single',
			width:900,height:600,
			'title':'选择订单表（双击表格行）',
			'loadtype':'iframe',
			'url':ctx+'/easyshop/easyshoporder/choose.jsp?selecttype=single',
			callback:function(data){
				if($.isFunction(ccallback))
					ccallback(data);
			}
		});
	}
	
	/**
	 * 多选订单表
	 */
	,multiEasyshoporder:function(ccallback){
		finedo.dialog.show({'selecttype':'multi',
			width:1000,height:600,
			'title':'选择订单表',
			'loadtype':'iframe',
			'url':ctx+'/easyshop/easyshoporder/choose.jsp?selecttype=multi',
			callback:function(data){
				if($.isFunction(ccallback))
					ccallback(data);
			}
		});
	}
	
	
	/**
	 * 单选商品表
	 */
	,singleEasyshopgoods:function(ccallback){
		finedo.dialog.show({'selecttype':'single',
			width:900,height:600,
			'title':'选择商品表（双击表格行）',
			'loadtype':'iframe',
			'url':ctx+'/easyshop/easyshopgoods/choose.jsp?selecttype=single',
			callback:function(data){
				if($.isFunction(ccallback))
					ccallback(data);
			}
		});
	}
	
	/**
	 * 多选商品表
	 */
	,multiEasyshopgoods:function(ccallback){
		finedo.dialog.show({'selecttype':'multi',
			width:1000,height:600,
			'title':'选择商品表',
			'loadtype':'iframe',
			'url':ctx+'/easyshop/easyshopgoods/choose.jsp?selecttype=multi',
			callback:function(data){
				if($.isFunction(ccallback))
					ccallback(data);
			}
		});
	}
	
	
	/**
	 * 单选订单物品关联表
	 */
	,singleEasyshopordergoods:function(ccallback){
		finedo.dialog.show({'selecttype':'single',
			width:900,height:600,
			'title':'选择订单物品关联表（双击表格行）',
			'loadtype':'iframe',
			'url':ctx+'/easyshop/easyshopordergoods/choose.jsp?selecttype=single',
			callback:function(data){
				if($.isFunction(ccallback))
					ccallback(data);
			}
		});
	}
	
	/**
	 * 多选订单物品关联表
	 */
	,multiEasyshopordergoods:function(ccallback){
		finedo.dialog.show({'selecttype':'multi',
			width:1000,height:600,
			'title':'选择订单物品关联表',
			'loadtype':'iframe',
			'url':ctx+'/easyshop/easyshopordergoods/choose.jsp?selecttype=multi',
			callback:function(data){
				if($.isFunction(ccallback))
					ccallback(data);
			}
		});
	}
	
	
	/**
	 * 单选商品类型
	 */
	,singleEasyshopgoodstype:function(ccallback){
		finedo.dialog.show({'selecttype':'single',
			width:900,height:600,
			'title':'选择商品类型（双击表格行）',
			'loadtype':'iframe',
			'url':ctx+'/easyshop/easyshopgoodstype/choose.jsp?selecttype=single',
			callback:function(data){
				if($.isFunction(ccallback))
					ccallback(data);
			}
		});
	}
	
	/**
	 * 多选商品类型
	 */
	,multiEasyshopgoodstype:function(ccallback){
		finedo.dialog.show({'selecttype':'multi',
			width:1000,height:600,
			'title':'选择商品类型',
			'loadtype':'iframe',
			'url':ctx+'/easyshop/easyshopgoodstype/choose.jsp?selecttype=multi',
			callback:function(data){
				if($.isFunction(ccallback))
					ccallback(data);
			}
		});
	}
	
	
	/**
	 * 单选咨询表
	 */
	,singleEasyshopconsult:function(ccallback){
		finedo.dialog.show({'selecttype':'single',
			width:900,height:600,
			'title':'选择咨询表（双击表格行）',
			'loadtype':'iframe',
			'url':ctx+'/easyshop/easyshopconsult/choose.jsp?selecttype=single',
			callback:function(data){
				if($.isFunction(ccallback))
					ccallback(data);
			}
		});
	}
	
	/**
	 * 多选咨询表
	 */
	,multiEasyshopconsult:function(ccallback){
		finedo.dialog.show({'selecttype':'multi',
			width:1000,height:600,
			'title':'选择咨询表',
			'loadtype':'iframe',
			'url':ctx+'/easyshop/easyshopconsult/choose.jsp?selecttype=multi',
			callback:function(data){
				if($.isFunction(ccallback))
					ccallback(data);
			}
		});
	}
	
	
	/**
	 * 单选广告表
	 */
	,singleEasyshopnews:function(ccallback){
		finedo.dialog.show({'selecttype':'single',
			width:900,height:600,
			'title':'选择广告表（双击表格行）',
			'loadtype':'iframe',
			'url':ctx+'/easyshop/easyshopnews/choose.jsp?selecttype=single',
			callback:function(data){
				if($.isFunction(ccallback))
					ccallback(data);
			}
		});
	}
	
	/**
	 * 多选广告表
	 */
	,multiEasyshopnews:function(ccallback){
		finedo.dialog.show({'selecttype':'multi',
			width:1000,height:600,
			'title':'选择广告表',
			'loadtype':'iframe',
			'url':ctx+'/easyshop/easyshopnews/choose.jsp?selecttype=multi',
			callback:function(data){
				if($.isFunction(ccallback))
					ccallback(data);
			}
		});
	}
	
	
	/**
	 * 单选物流表
	 */
	,singleEasyshopexpress:function(ccallback){
		finedo.dialog.show({'selecttype':'single',
			width:900,height:600,
			'title':'选择物流表（双击表格行）',
			'loadtype':'iframe',
			'url':ctx+'/easyshop/easyshopexpress/choose.jsp?selecttype=single',
			callback:function(data){
				if($.isFunction(ccallback))
					ccallback(data);
			}
		});
	}
	
	/**
	 * 多选物流表
	 */
	,multiEasyshopexpress:function(ccallback){
		finedo.dialog.show({'selecttype':'multi',
			width:1000,height:600,
			'title':'选择物流表',
			'loadtype':'iframe',
			'url':ctx+'/easyshop/easyshopexpress/choose.jsp?selecttype=multi',
			callback:function(data){
				if($.isFunction(ccallback))
					ccallback(data);
			}
		});
	}
	
	
};
