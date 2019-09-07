package com.zhy.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zhy.bean.Employee;
import com.zhy.bean.EmployeeExample;
import com.zhy.bean.EmployeeExample.Criteria;
import com.zhy.dao.EmployeeMapper;

@Service
public class EmployeeService {
	
	@Autowired
	EmployeeMapper employeeMapper;
	
	/**
	 * 查询所有员工信息附带部门信息
	 * @return
	 */
	public List<Employee> getAll() {
		return employeeMapper.selectByExampleWithDept(null);
	}

	public void save(Employee employee) {
		employeeMapper.insertSelective(employee);
	}
	
	public boolean checkNameIsUserd(String empName) {
		EmployeeExample employeeExample = new EmployeeExample();
		Criteria criteria = employeeExample.createCriteria();
		criteria.andEmpNameEqualTo(empName);
		long countByExample = employeeMapper.countByExample(employeeExample);
		if(countByExample > 0) {
			return true;
		}
		return false;
		
	}

	public Employee getEmpById(Integer id) {
		Employee employee = employeeMapper.selectByPrimaryKey(id);
		return employee;
	}

	public void update(Employee employee) {
		employeeMapper.updateByPrimaryKeySelective(employee);
	}

	public void delete(Integer empId) {
		employeeMapper.deleteByPrimaryKey(empId);
	}

	public void deleteBatch(List<Integer> idList) {
		EmployeeExample employeeExample = new EmployeeExample();
		Criteria criteria = employeeExample.createCriteria();
		criteria.andEmpIdIn(idList);
		employeeMapper.deleteByExample(employeeExample);
	}

}
