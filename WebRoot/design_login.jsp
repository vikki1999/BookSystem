<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<html>
<style type="text/css">
</style>
<head>
	<meta charset="utf-8">
	<link rel="stylesheet" type="text/css" href="jqeasyui/themes/default/easyui.me.css">
	<link rel="stylesheet" type="text/css" href="jqeasyui/themes/icon.css">
	<link rel="stylesheet" type="text/css" href="system/css/icon.css">
    <script type="text/javascript" src="jqeasyui/jquery.min.js"></script>
    <script type="text/javascript" src="jqeasyui/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="jqeasyui/easyui-lang-zh_CN.js"></script>	
	<script type="text/javascript" src="system/easyui_functions.js"></script>
	<title>登录图书管理系统</title>
</head>
<body style="margin: 2px 2px 2px 2px;">
<div id="main" style="margin:2px 2px 2px 2px;height:auto;weith:auto;">
	<div id="login" style="width:360px;height:360px;margin-left:460px;margin-top:100px;border:#FFD700 solid;outline:#FFA500 dotted thick;">
		<div id="top" style="height:30px;background-color:#FFF8DC;">
			<div class="panel-header panel-header-noborder window-header xpanel-header" style="">
				<div class="panel-title panel-with-icon">
					<div style="margin:0px 0px 0px 5px; ">用户登录</div>
				</div>
				<div class="panel-icon panelIcon"></div>
				<div class="panel-tool"></div>
			</div>	
		</div>
		<div id="bottom" style="background-color:#FFF8DC; width:auto; height:260px;">
			<div style="padding-left:70px;padding-top:30px;margin-bottom:20px;"> 
				<span class="textbox easyui-fluid" style="width: 218px; height: 33px;">
					<span class="textbox-addon textbox-addon-right" style="right: 0px;">
						<a href="javascript:void(0)" class="textbox-icon icon-man textbox-icon-disabled" icon-index="0" tabindex="-1" style="width: 38px; height: 33px;">
						</a>
					</span>
					<input class="easyui-textbox" type="text" id="account" data-options="prompt:'用户账号',iconCls:'icon-man',iconWidth:38" style="font-size:13px; height:100%; width:100%; padding:0px 8px 0px 10px;" >
				</span>
			</div>
			<div style="padding-left:70px;margin-bottom:20px;">
				<span class="textbox easyui-fluid" style="width: 218px; height: 33px;">
					<span class="textbox-addon textbox-addon-right" style="right: 0px;">
						<a href="javascript:void(0)" class="textbox-icon icon-lock textbox-icon-disabled" icon-index="0" tabindex="-1" style="width: 38px; height: 33px;">
						</a>
					</span>
					<input class="easyui-validatebox easyui-textbox" type="password" id="password" data-options="prompt:'登录密码',iconCls:'icon-lock',iconWidth:38" style=" font-size:13px; height:100%; width:100%; padding:0px 8px 0px 10px;" >
				</span>
			</div>
			<div style="padding-left:70px;margin-bottom:25px;">
				<input type="checkbox" style=""/>
				<a href="#" style="font-size:14px;text-decoration:none;color:black;">记住密码</a>
				<a href="design_register.jsp" style="padding-left:80px;font-size:14px;text-decoration:none;color:black;">>>立即注册</a>
			</div>
			<div id="load" style="width:180px;margin-left:100px;">
				 <a id="cmdok1" href="#" class="easyui-linkbutton" style="width:160px;height:30px;margin-bottom:20px;margin-top:20px;" onclick="">账号登录</a>
				
			</div>
		</div>
		<div id="footer" style="padding-top:20px;text-align:center">Welcome To Books Management System!</div>
	</div>
</div>
<script>
$(document).ready(function(){
	document.onkeypress=myBanBackSpace;
	document.onkeydown=myBanBackSpace;

	$("#account").textbox();
	$("#password").textbox();
	$("#account").textbox('setValue',sys.userid);
	$("#password").textbox('setValue',myFromXcode(sys.userpassword));
	//myButton('cmdok1','myForm1','账号登录',210,38,35,220);
	//myButton('cmdok2','myForm1','游客登录',265,38,35,220);
	myKeyDownEvent('account;password');		
	mySelectOnFocus();
	myFocus('account');
	$("#cmdok1").click(function(e){
		var s1=$("#account").textbox('getValue');
		var s2=$("#password").textbox('getValue');
		s2=myToXcode(s2);
		if (s1!=''){
			var sql="select userid,username,password,account,email,mobile,usertype from bm_users where userid='"+s1+"'\n";
			sql+="union all \n";
			sql+="select userid,username,password,account,email,mobile,usertype from bm_mans where userid='"+s1+"'\n";
			//sql+=" and checkedstatus=1\n";
			console.log(sql);
			var result=myRunSelectSql(sysdatabasestring, sql);
			if (result.length==0){
				myMessage('@n用户账号['+s1+']不存在！','error',0,'fn1');
			}else if(result[0].password!==s2){
				//$.messager.alert('title','msg','info',fn1);
				myMessage('@n用户登录密码输入错误！','warn',280,'fn2');			
			//}else if(result[0].usertype!=1 ){
				//$.messager.alert('title','msg','info',fn1);
				//myMessage('@n用户没有经过后台审核！','warn',280,'fn2');			
			}else{  
				//console.log(result[0].usertype);
				if(result[0].usertype==1){
					var sql="update bm_mans set logindate='"+mySysDateTime('datetime')+"' where userid='"+s1+"'\n";
					sql+="update bm_mans set leavedate='' where userid='"+s1+"'";
				}else if(result[0].usertype==0){
					var sql="update bm_users set logindate='"+mySysDateTime('datetime')+"'where userid='"+s1+"'\n";
					sql+="update bm_users set leavedate='' where userid='"+s1+"'";
				}
				//console.log(sql);
				myRunUpdateSql(sysdatabasestring,sql);
				window.top.location.href='design_index.jsp';
				
			}
			//alert(myLocalTime(''));
		}
	});

});
function fn_login(){
	var s1=$("#user").textbox('getValue');
	var s2=$("#password").textbox('getValue');
	var sql="select studentid as user,right(studentid,6) as password from students where studentid='"+s1+"'";
	var result=[];
	result=myRunSelectSql('',sql);
	if(result.length==0) myMessage('系统提示','用户名不存在！');
	else if(result[0].user==s1 && result[0].password==s2) window.location.href='design_index.jsp';
	else myMessage('系统提示','密码错误！');
}

function fn1(){
	myFocus('account');
}
function fn2(){
	myFocus('password');
}

function fndownload(url){
	var target=url;
	window.location.href='system//easyui_fileDownLoad.jsp?source='+url+'&target='+target;

}

function fnCheckBrowser(){
	//返回当前正在使用的游览器的类型
	var type=navigator.userAgent.toLowerCase();
	var browser=navigator.userAgent;
	if (type.indexOf('msie')>=0 && type.indexOf('opera')<0) {
		browser='ie';
	}else if (type.indexOf('firefox')>=0) {
		browser='firefox';
	}else if (type.indexOf('opera')>=0) {
		browser='opera';
	}else if (type.indexOf('chrome')>=0) {
		browser='chrome';
	}else if (type.indexOf('safari')>=0) {
		browser='safari';
	}
	//console.log(browser);
	return (browser);	 	
}
</script>
</body>
</html>