package com.zhy.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zhy.bean.Department;
import com.zhy.bean.Msg;
import com.zhy.service.DepartmentService;

@Controller
public class DepartmentController {
	
	@Autowired
	DepartmentService departmentService;
	
	@ResponseBody
	@RequestMapping("/depts")
	public Msg depts() {
		List<Department> depts = departmentService.getAll();
		return Msg.success().add("depts", depts);
	}
}
