package com.dev.drakestore.dto;

public class Employee {

	/** The id. */
	private int id;

	/** The name. */
	private String name;

	/** The gender. */
	private int gender;

	/** The address. */
	private String address;

	/** The salary. */
	private float salary;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getGender() {
		return gender;
	}

	public void setGender(int gender) {
		this.gender = gender;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public float getSalary() {
		return salary;
	}

	public void setSalary(float salary) {
		this.salary = salary;
	}

	public Employee(int id, String name, int gender, String address, float salary) {
		// super();
		this.id = id;
		this.name = name;
		this.gender = gender;
		this.address = address;
		this.salary = salary;
	}

}
