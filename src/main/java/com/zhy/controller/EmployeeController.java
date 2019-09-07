package com.zhy.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.zhy.bean.Employee;
import com.zhy.bean.Msg;
import com.zhy.service.EmployeeService;

@Controller
public class EmployeeController {

	@Autowired
	EmployeeService employeeService;

	@ResponseBody
	@RequestMapping(value = "/emps", method = RequestMethod.GET)
	public Msg getEmps(@RequestParam(defaultValue = "1", value = "pn") Integer pn, Model model) {
		PageHelper.startPage(pn, 10);
		List<Employee> list = employeeService.getAll();
		PageInfo<Employee> pageInfo = new PageInfo<Employee>(list, 5);
		return Msg.success().add("pageInfo", pageInfo);
	}

	@ResponseBody
	@RequestMapping(value = "/checkName")
	public Msg checkName(@RequestParam("empName") String empName) {
		boolean flag = employeeService.checkNameIsUserd(empName);
		if (flag == true) {
			return Msg.fail();
		} else {
			return Msg.success();
		}
	}

	@ResponseBody
	@RequestMapping(value = "/emp", method = RequestMethod.POST)
	public Msg saveEmp(@Valid Employee employee, BindingResult bindingResult) {
		HashMap<String, String> errors = new HashMap<String, String>();
		if (bindingResult.hasErrors()) {
			List<FieldError> fieldErrors = bindingResult.getFieldErrors();
			for (FieldError fieldError : fieldErrors) {
				errors.put(fieldError.getField(), fieldError.getDefaultMessage());
			}
			return Msg.fail().add("errors", errors);
		} else {
			employeeService.save(employee);
			return Msg.success();
		}

	}

	@ResponseBody
	@RequestMapping(value = "/emp/{id}", method = RequestMethod.GET)
	public Msg getEmp(@PathVariable("id") Integer id) {
		Employee employee = employeeService.getEmpById(id);
		return Msg.success().add("emp", employee);
	}

	@ResponseBody
	@RequestMapping(value = "/emp/{empId}", method = RequestMethod.PUT)
	public Msg updateEmp(Employee employee) {
		System.out.println(employee);
		employeeService.update(employee);
		return Msg.success();
	}

	@ResponseBody
	@RequestMapping(value = "/emp/{ids}", method = RequestMethod.DELETE)
	public Msg deleteEmp(@PathVariable("ids") String ids) {
		if (ids.contains("-")) {
			List<Integer> idList = new ArrayList<Integer>();
			for (String id : Arrays.asList(ids.split("-"))) {
				idList.add(Integer.parseInt(id));
			}
			employeeService.deleteBatch(idList);
		} else {
			Integer id = Integer.parseInt(ids);
			employeeService.delete(id);

		}
		return Msg.success();

	}

}
