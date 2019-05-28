<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!doctype html>
<html lang="en">
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
</head>
<body id="main" style="margin: 2px 2px 2px 2px;">
</body>
    
<script>
$(document).ready(function(){
	var str='<div style="float:right; margin:60px 20px 0px 0px;" >'+
	'<div class="easyui-window" id="myForm1" title="<div style=\'margin:0px 0px 0px 5px; \'>用户注册</div>" style="position:relative; width:375px; height:490px; background:#FFF8DC;'+
	'padding:2px 2px 2px 2px;">'+
	'</div></div>';
	$("#main").append($(str));
	$("#myForm1").window({iconCls:"panelIcon", closable:false, collapsible:false, maximizable:false, minimizable:false, sortable:false, headerCls:'xpanel-header',bodyCls:'xpanel-body'});
	myTextField('stuid','myForm1','用户账号：',65,50*0+20,28,0,200,'');
	myTextField('name','myForm1','用户名：',65,50*1+20,28,0,200,'');
	myComboField('gender','myForm1','性别：',65,50*2+20,28,0,100,'男;女','');
	myTextField('password','myForm1','登录密码：',65,50*3+20,28,0,200,'');
	myTextField('repassword','myForm1','密码确认：',65,50*4+20,28,0,200,'');
	myTextField('email','myForm1','常用邮箱：',65,50*5+20,28,0,180,'');
	myButton('submit','myForm1','注册',50*6+20,28,35,120);
	myButton('clear','myForm1','清空',50*6+20,198,35,120);
	//$("#submit").linkbutton({'plain':true});
//	$("#clear").linkbutton({'plain':true});
	$("#email").textbox({validType:'email'});
	$("#submit").click(function(e){
		submitForm();
	});
	$("#clear").click(function(e){
		clearForm();
	});
});
    function submitForm(){
    	var gender=$("#gender").combobox('getValue');
    	if(gender=='男')gender='M';
    	gender='F';
    	var errormsg=[];  //存放数据验证发现的错误信息
    	var s1=$("#stuid").textbox('getValue');
    	var s2=$("#password").textbox('getValue');
    	var s3=$("#repassword").textbox('getValue');
    	if (s1.length==0) errormsg.push('用户账号不能为空！');
		if (s2.length==0) errormsg.push('登录密码不能为空！');
		if (s3.length==0) errormsg.push('密码确认不能为空！');
    	var sql="select studentid from students where studentid='"+s1+"'\n";
		//sql+=" and checkedstatus=1\n";
		console.log(sql);
		var result=myRunSelectSql(sysdatabasestring, sql);
		if (result.length>0){
			errormsg.push('用户账号['+s1+']已存在！');
		}else if(s2!=s3){
			errormsg.push('密码确认与登录密码不符！');
		}if (!$("#email").textbox('isValid')) errormsg.push('emai格式输入错误！'); 
		//数据验证结束
		if (errormsg.length==0){
			var sql="insert into students (studentid,name,gender,password,email) values(";
			sql+="'"+$("#stuid").textbox('getValue')+"',";
			sql+="'"+$("#name").textbox('getValue')+"',";
			sql+="'"+gender+"',";
			sql+="'"+$("#password").textbox('getValue')+"',";
			sql+="'"+$("#email").textbox('getValue')+"',";
			sql+=")";
			var result=myRunUpdateSql(sysdatabasestring,sql);
   			if (result.error==''){
   				window.top.location.href='design_login.jsp';
   			}
		}else{	
			myMessage('数据验证发现下列错误，提交失败！@n'+errormsg);
			return(0);
		}
    }
    function clearForm(){
        $('#myForm1').form('clear');  //jquery语句
    }
</script>

</html>