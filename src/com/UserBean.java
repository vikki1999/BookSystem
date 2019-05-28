package com;

import java.sql.Date;

public class UserBean {
	private int userID;//readonly
	private String account;
	private String username;
	private String password;
	private String unittitle;
	private String unitno;
	private String notes;
	private String userright;
	private String hostname;
	private String sqlpassword;
	private String logindate;
	private String database;
	private String action;
	private String message;  //临时变量
	public UserBean(){
		
	}
	public UserBean(int userID, String account, String username, String password, String unittitle,String unitno, 
			String notes, String userright, String hostname, String sqlpassword, String logindate, 
			String database, String action, String message){
		this.userID = userID;
		this.account = account;
		this.username = username;
		this.password = password;
		this.unittitle = unittitle;
		this.unitno = unitno;
		this.notes = notes;
		this.userright = userright;
		this.hostname = hostname;
		this.sqlpassword = sqlpassword;
		this.logindate = logindate;
		this.database = database;
		this.action = action;
		this.message = message;
	}
	public String getAccount() {
		return account;
	}
	public void setAccount(String account) {
		this.account = account;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getUnitTitle() {
		return unittitle;
	}
	public void setUnitTitle(String unittitle) {
		this.unittitle = unittitle;
	}
	public String getUnitNo() {
		return unitno;
	}
	public void setUnitNo(String unitno) {
		this.unitno = unitno;
	}
	public String getNotes() {
		return notes;
	}
	public void setNotes(String notes) {
		this.notes = notes;
	}
	public String getUserRight() {
		return userright;
	}
	public void setUserRight(String userright) {
		this.userright = userright;
	}
	public int getUserID() {
		return userID;
	}
	public String getHostName() {
		return hostname;
	}
	public void setHostName(String hostname) {
		this.hostname = hostname;
	}
	public String getSqlPassword() {
		return sqlpassword;
	}
	public void setSqlPassword(String sqlpassword) {
		this.sqlpassword = sqlpassword;
	}
	public String getLoginDate() {
		return logindate;
	}
	public void setLoginDate(String logindate) {
		this.logindate = logindate;
	}
	public String getDatabase() {
		return database;
	}
	public void setDatabase(String database) {
		this.database = database;
	}
	public String getAction() {
		return action;
	}
	public void setAction(String action) {
		this.action = action;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
}
