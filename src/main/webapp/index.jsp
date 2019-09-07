<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>

<head>
<title>员工列表</title>
<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<script type="text/javascript"
	src="${APP_PATH}/static/js/jquery-3.4.1.js"></script>
<link
	href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${APP_PATH}/static/js/validate.js"></script>
</head>

<body>
	<%--    搭建显示页面--%>
	<div class="container">
		<%--        标题--%>
		<div class="row">
			<div class="clo-md-12">
				<h1>SSM-CRUD</h1>
			</div>
		</div>
		<%--        新加删除按钮--%>
		<div class="row">
			<div class="col-md-4">
				<button class="btn btn-primary " id="emp_add_modal_btn">新增</button>
				<button class="btn btn-danger" id="emp_delete_all_btn">删除</button>
				<br> <br>
			</div>
		</div>

		<%--        显示表格内容--%>
		<div class="row">
			<div class="col-md-12">
				<table class="table table-hover" id="emps_table">
					<thead>
						<tr>
							<th><input type="checkbox" id="check_all"></th>
							<th>#</th>
							<th>empName</th>
							<th>gender</th>
							<th>email</th>
							<th>deptName</th>
							<th>操作</th>
						</tr>

					</thead>
					<tbody>
					</tbody>
				</table>
			</div>
		</div>
		<%--        显示分页信息--%>
		<div class="row">
			<%--            分页文字信息--%>
			<div class="col-md-6" id="page_info_area"></div>
			<%--            分页条信息--%>
			<div class="col-md-6">
				<nav aria-label="Page navigation" id="page_nav_area">
					<ul class="pagination">

					</ul>
				</nav>
			</div>
		</div>
	</div>

	<!-- 员工增加Modal -->
	<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">新增员工</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal">
						<div class="form-group">
							<label for="empName_add_input" class="col-sm-2 control-label">empName</label>
							<div class="col-sm-10">

								<input type="text" class="form-control" name="empName"
									id="empName_add_input" placeholder="empName"> <span
									class="help-block"></span>
							</div>
						</div>
						<div class="form-group">
							<label for="email_add_input" class="col-sm-2 control-label">email</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" name="email"
									id="email_add_input" placeholder="请输入正确的邮箱地址"> <span
									class="help-block"></span>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">gender</label>
							<div class="col-sm-10">
								<label class="radio-inline"> <input type="radio"
									name="gender" id="gender1_add_input" value="M"
									checked="checked"> 男
								</label> <label class="radio-inline"> <input type="radio"
									name="gender" id="gender2_add_input" value="W"> 女
								</label>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">deptName</label>
							<div class="col-sm-4">
								<select class="form-control" name="dId" id="dept_add_select">

								</select>
							</div>
						</div>


					</form>

				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
				</div>
			</div>
		</div>
	</div>

	<!-- 员工修改Modal -->
	<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">修改员工</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal">
						<input type="hidden" name="_method" value="PUT">
						<div class="form-group">
							<label for="empName_edit_input" class="col-sm-2 control-label">empName</label>
							<div class="col-sm-10">

								<p class="form-control-static" id="empName_edit_static">email@example.com</p>
							</div>
						</div>
						<div class="form-group">
							<label for="email_add_input" class="col-sm-2 control-label">email</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" name="email"
									id="email_edit_input" placeholder="请输入正确的邮箱地址"> <span
									class="help-block"></span>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">gender</label>
							<div class="col-sm-10">
								<label class="radio-inline"> <input type="radio"
									name="gender" id="gender1_edit_input" value="M"
									checked="checked"> 男
								</label> <label class="radio-inline"> <input type="radio"
									name="gender" id="gender2_edit_input" value="W"> 女
								</label>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">deptName</label>
							<div class="col-sm-4">
								<select class="form-control" name="dId" id="dept_edit_select">

								</select>
							</div>
						</div>


					</form>

				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="emp_update_btn">更新</button>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		var totalRecord, currentPage;

		$(function() {
			to_page(1);

		});

		//去第几页
		function to_page(pn) {
			$.ajax({
				url : "${APP_PATH}/emps",
				data : "pn=" + pn,
				type : "GET",
				success : function(result) {
					$("#check_all").prop("checked",false);
					// console.log(result);
					//1、解析并显示员工信息
					build_emps_table(result);
					//2、解析并显示分页信息
					build_page_info(result);
					//3、解析显示分页条
					build_page_nav(result);
				}
			});
		}

		//解析并显示员工信息
		function build_emps_table(result) {
			$("#emps_table tbody").empty();
			var emps = result.extend.pageInfo.list;

			$.each(emps, function(index, item) {
				var checkboxTd = $("<td></td>").append(
						"<input type='checkbox' class='check_item'>")
				var empIdTd = $("<td></td>").append(item.empId);
				var empNameTd = $("<td></td>").append(item.empName);
				var genderTd = $("<td></td>").append(
						item.gender == "M" ? "男" : "女");
				var emailTd = $("<td></td>").append(item.email);
				var deptNameTd = $("<td></td>")
						.append(item.department.deptName);
				var editBtn = $("<button></button>").addClass(
						"btn btn-primary btn-sm editBtn").append(
						$("<span></span>").addClass(
								"glyphicon glyphicon-pencil").append("编辑"));
				editBtn.attr("edit_id", item.empId);
				var deleteBtn = $("<button></button>").addClass(
						"btn btn-danger btn-sm deleteBtn").append(
						$("<span></span>")
								.addClass("glyphicon glyphicon-trash").append(
										"删除"));
				deleteBtn.attr("del_id", item.empId);
				var optionTd = $("<td></td>").append(editBtn).append(" ")
						.append(deleteBtn);
				$("<tr></tr>").append(checkboxTd).append(empIdTd).append(
						empNameTd).append(genderTd).append(emailTd).append(
						deptNameTd).append(optionTd).appendTo(
						"#emps_table tbody");

			});
		}

		//解析并显示分页信息
		function build_page_info(result) {
			$("#page_info_area").empty();
			totalRecord = result.extend.pageInfo.total;
			currentPage = result.extend.pageInfo.pageNum;
			$("#page_info_area").append(
					"当前" + result.extend.pageInfo.pageNum + "页，总"
							+ result.extend.pageInfo.pages + "页，共"
							+ result.extend.pageInfo.total + "条记录");
		}

		//解析并显示分页条
		function build_page_nav(result) {
			//page_nav_area
			$("#page_nav_area").empty();
			var ul = $("<ul></ul>").addClass("pagination");

			//构建元素
			var firstPageLi = $("<li></li>").append(
					$("<a></a>").append("首页").attr("href", ""));
			var prePageLi = $("<li></li>").append(
					$("<a></a>").append("&laquo;").attr("href", ""));
			if (result.extend.pageInfo.hasPreviousPage == false) {
				firstPageLi.addClass("disabled");
				prePageLi.addClass("disabled");
			} else {
				//为元素添加翻页事件
				firstPageLi.click(function() {
					to_page(1);
					return false;
				});
				prePageLi.click(function() {
					to_page(result.extend.pageInfo.pageNum - 1);
					return false;
				});
			}

			var nextPageLi = $("<li></li>").append(
					$("<a></a>").append("&raquo;").attr("href", ""));
			var lastPageLi = $("<li></li>").append(
					$("<a></a>").append("末页").attr("href", ""));
			if (result.extend.pageInfo.hasNextPage == false) {
				nextPageLi.addClass("disabled");
				lastPageLi.addClass("disabled");
			} else {
				nextPageLi.click(function() {
					to_page(result.extend.pageInfo.pageNum + 1);
					return false;
				});
				lastPageLi.click(function() {
					to_page(result.extend.pageInfo.pages);
					return false;
				});
			}

			//页码1，2，3，4
			ul.append(firstPageLi).append(prePageLi);
			$.each(result.extend.pageInfo.navigatepageNums, function(index,
					item) {
				var numLi = $("<li></li>").append(
						$("<a></a>").append(item).attr("href", ""));
				if (result.extend.pageInfo.pageNum == item) {
					numLi.addClass("active");
				}
				numLi.click(function() {
					to_page(item);
					return false;
				});
				ul.append(numLi);
			});

			ul.append(nextPageLi).append(lastPageLi);

			//把ul加入到nav
			var navEle = $("<nav></nav>").append(ul);
			navEle.appendTo("#page_nav_area");

		}

		function reset_form(ele) {
			$(ele)[0].reset();
			$(ele).find("*").removeClass("has-error has-success");
			$(ele).find(".help-block").text("");
		}

		//新增按钮点击时弹出模态框
		$("#emp_add_modal_btn").click(function() {
			reset_form("#empAddModal form");
			getDepts($("#empAddModal select"));
			$('#empAddModal').modal({
				backdrop : "static"
			});
		});

		//获取部门信息
		function getDepts(ele) {
			$(ele).empty();
			$.ajax({
				url : "${APP_PATH}/depts",
				type : "GET",
				success : function(result) {
					$.each(result.extend.depts, function() {
						var optionEle = $("<option></option>").append(
								this.deptName).attr("value", this.deptId);
						optionEle.appendTo(ele);
					});
				}
			});

		}

		function getEmp(id) {
			$.ajax({
				url : "${APP_PATH}/emp/" + id,
				type : "GET",
				success : function(result) {
					var empData = result.extend.emp;
					$("#empName_edit_static").text(empData.empName);
					$("#email_edit_input").val(empData.email);
					$("#empUpdateModal input[name=gender]").val(
							[ empData.gender ]);
					$("#empUpdateModal select").val([ empData.dId ]);
				}
			});
		}

		//当点击编辑按钮时
		$(document).on("click", ".editBtn", function() {
			//1、查出部门信息，显示部门列表
			getDepts("#empUpdateModal select");
			//2、查出员工信息，显示员工信息
			getEmp($(this).attr("edit_id"));
			//3、把员工的id传递给模态框的更新按钮
			$("#emp_update_btn").attr("edit_id", $(this).attr("edit_id"));
			$("#empUpdateModal").modal({
				backdrop : "static"
			});
		});

		//当点击删除按钮时
		$(document).on("click", ".deleteBtn", function() {
			//1、弹出确认删除对话框
			var empName = $(this).parents("tr").find("td:eq(2)").text();
			var empId = $(this).attr("del_id");
			if (confirm("确认删除【" + empName + "】吗？")) {
				//发送ajax请求删除
				$.ajax({
					url : "${APP_PATH}/emp/" + empId,
					type : "DELETE",
					success : function(result) {
						alert(result.msg);
						//回到本页
						to_page(currentPage);
					}
				});
			}
		});

		//点击更新，更新员工信息
		$("#emp_update_btn").click(function() {
			//验证邮箱是否合法
			//1、校验邮箱信息
			var empEmail = $("#email_edit_input").val();
			var regEmail = /^([a-zA-Z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/
			if (!regEmail.test(empEmail)) {
				show_validate_msg("#email_edit_input", "error", "邮箱格式错误");
				return false;
			} else {
				show_validate_msg("#email_edit_input", "success", "");
			}

			//2、发送ajax请求，保存更新员工信息
			$.ajax({
				url : "${APP_PATH}/emp/" + $(this).attr("edit_id"),
				type : "POST",
				data : $("#empUpdateModal form").serialize(),
				success : function() {
					alert("修改成功！");
					$("#empUpdateModal").modal("hide");
					to_page(currentPage);
				}
			});
		});

		$("#check_all").click(function() {
			$(".check_item").prop("checked", $(this).prop("checked"));
		});

		$(document)
				.on(
						"click",
						".check_item",
						function() {
							var flag = $(".check_item:checked").length == $(".check_item").length;
							$("#check_all").prop("checked", flag);
						});

		$("#emp_delete_all_btn").click(
				function() {
					var empNames = "";
					var del_idstr = "";
					$.each($(".check_item:checked"), function() {
						//组装员工字符串
						empNames += $(this).parents("tr").find("td:eq(2)")
								.text()
								+ ",";
						//组织员工id字符串
						del_idstr += $(this).parents("tr").find("td:eq(1)")
								.text()
								+ "-";
					});

					//去除empnames多月的","
					empNames = empNames.substring(0, empNames.length - 1);
					//去除员工删除id多余的-
					del_idstr = del_idstr.substring(0, del_idstr.length - 1);
					if (confirm("您确定删除【" + empNames + "】的信息吗？")) {
						$.ajax({
							url : "${APP_PATH}/emp/" + del_idstr,
							type : "DELETE",
							success : function(result) {
								alert(result.msg);
								//回到本页
								to_page(currentPage);
							}
						});
					} else {
						return false;
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
	</script>

</body>

</html>