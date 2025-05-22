	package com.lunettes.model;
	
	public class User {
		private int id;
	    private String firstName;
	    private String middleName;
	    private String lastName;
	    private String username;
	    private String dob;
	    private String gender;
	    private String email;
	    private String countryCode;
	    private String contactNumber;
	    private String address;
	    private String password;
	    private String role;
	    


	    private String avatarPath;
	
	    // Constructors
	    public User() {}
	
	    public User(String firstName, String middleName, String lastName, String username,
	                String dob, String gender, String email, String countryCode, String contactNumber,
	                String address, String password, String avatarPath) {
	        this.firstName = firstName;
	        this.middleName = middleName;
	        this.lastName = lastName;
	        this.username = username;
	        this.dob = dob;
	        this.gender = gender;
	        this.email = email;
	        this.countryCode = countryCode;
	        this.contactNumber = contactNumber;
	        this.address = address;
	        this.password = password;
	        this.avatarPath = avatarPath;
	    }
	    
	    public User(int id,String firstName, String middleName, String lastName, String username,
	            String dob, String gender, String email, String countryCode, String contactNumber,
	            String address, String password, String avatarPath) {
	    this.id = id;
	    this.firstName = firstName;
	    this.middleName = middleName;
	    this.lastName = lastName;
	    this.username = username;
	    this.dob = dob;
	    this.gender = gender;
	    this.email = email;
	    this.countryCode = countryCode;
	    this.contactNumber = contactNumber;
	    this.address = address;
	    this.password = password;
	    this.avatarPath = avatarPath;
	}
	
	    public int getId() {
	    	return this.id;
	    }
	    public void setId(int id) {
	    	this.id = id;
	    }
	    public String getRole() { return role; }
	    public void setRole(String role) { this.role = role; }
	    public String getFirstName() { return firstName; }
	    public void setFirstName(String firstName) { this.firstName = firstName; }
	
	    public String getMiddleName() { return middleName; }
	    public void setMiddleName(String middleName) { this.middleName = middleName; }
	
	    public String getLastName() { return lastName; }
	    public void setLastName(String lastName) { this.lastName = lastName; }
	
	    public String getUsername() { return username; }
	    public void setUsername(String username) { this.username = username; }
	
	    public String getDob() { return dob; }
	    public void setDob(String dob) { this.dob = dob; }
	
	    public String getGender() { return gender; }
	    public void setGender(String gender) { this.gender = gender; }
	
	    public String getEmail() { return email; }
	    public void setEmail(String email) { this.email = email; }
	
	    public String getCountryCode() { return countryCode; }
	    public void setCountryCode(String countryCode) { this.countryCode = countryCode; }
	
	    public String getContactNumber() { return contactNumber; }
	    public void setContactNumber(String contactNumber) { this.contactNumber = contactNumber; }
	
	    public String getAddress() { return address; }
	    public void setAddress(String address) { this.address = address; }
	
	    public String getPassword() { return password; }
	    public void setPassword(String password) { this.password = password; }
	
	    public String getAvatarPath() { return avatarPath; }
	    public void setAvatarPath(String avatarPath) { this.avatarPath = avatarPath; }
	}
	
