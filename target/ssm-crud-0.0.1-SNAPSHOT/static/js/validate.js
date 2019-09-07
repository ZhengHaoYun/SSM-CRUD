$(function() {
	var n, e;
	
	$("#emp_save_btn")
			.click(
					function() {
						if (true) {
							$
									.ajax({
										url : "emp",
										type : "POST",
										data : $("#empAddModal form")
												.serialize(),
										success : function(result) {
											console.log(result);
											if (result.code == 100) {
												alert("添加成功！");
												$('#empAddModal').modal('hide');
												to_page(totalRecord);
											} else {
												if (undefined != result.extend.errors.email) {
													// 显示邮箱的错误信息
													show_validate_msg(
															"#email_add_input",
															"error",
															result.extend.errors.email);
												}
												if (undefined != result.extend.errors.empName) {
													// 显示邮箱的错误信息
													show_validate_msg(
															"#empName_add_input",
															"error",
															result.extend.errors.empName);
												}
											}

										}
									});
						} else {
							alert("请检查您输入的信息！");
							return false;
						}
					});

	// 检验用户名是否规范
	$("#empName_add_input")
			.blur(
					function() {
						var empName = $("#empName_add_input").val();
						var regName = /(^[a-zA-Z0-9_-]{4,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
						if (!regName.test(empName)) {
							show_validate_msg("#empName_add_input", "error",
									"用户名为2-5中文或4-16英文数字组合！");
							n = false;
						} else {
							checkEmpNameIsUsed(empName);
						}
					});

	function checkEmpNameIsUsed(empName) {
		$
				.ajax({
					url : "checkName",
					type : "POST",
					data : "empName=" + empName,
					success : function(result) {
						if (result.code == 100) {
							show_validate_msg("#empName_add_input", "success",
									"用户名可用。");
							n = true;
						} else {
							show_validate_msg("#empName_add_input", "error",
									"用户名已存在！");
							n = false;
						}
					}
				});
	}

	// 检验邮箱是否规范
	$("#email_add_input").blur(function() {
		var empEmail = $("#email_add_input").val();
		var regEmail = /^([a-zA-Z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/
		if (!regEmail.test(empEmail)) {
			// alert("邮箱格式错误");
			show_validate_msg("#email_add_input", "error", "邮箱格式错误！");
			e = false;
		} else {
			show_validate_msg("#email_add_input", "success", "该邮箱可用。");
			e = true;
		}
	});

	// 显示校验提示
	function show_validate_msg(ele, status, msg) {
		// 首先清空当前元素
		$(ele).parent().removeClass("has-success has-error");
		$(ele).next("span").text("");
		if ("success" == status) {
			$(ele).parent().addClass("has-success");
			$(ele).next("span").text(msg);
		} else if ("error" == status) {
			$(ele).parent().addClass("has-error");
			$(ele).next("span").text(msg);
		}
	}

});
