<%@ page language="java" import="java.util.*" contentType="text/html;charset=utf-8"  language="java"  pageEncoding="UTF-8" %>
<!doctype html>
<html>
<style type="text/css">
</style>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<link rel="stylesheet" type="text/css" href="jqeasyui/themes/default/easyui.me.css">
	<link rel="stylesheet" type="text/css" href="jqeasyui/themes/icon.css">
    <link rel="stylesheet" type="text/css" href="system/css/icon.css">
    <script type="text/javascript" src="jqeasyui/jquery.min.js"></script>
    <script type="text/javascript" src="jqeasyui/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="jqeasyui/easyui-lang-zh_CN.js"></script>	
	<script type="text/javascript" src="system/easyui_functions.js"></script>
	<script type="text/javascript" src="system/easyui_html5media.js"></script>
</head>
<body>
<div id="main" style="width:1024px;height:540px;">
	   
</div>  
<script>
	$(document).ready(function(){
		$.messager.confirm('系统提示','您确定要关闭本页吗？',function(r){
		    if (r){
		    	var sql="select * from bm_users where leavedate=''\n";
		    	sql+="union all\n";
		    	sql+="select * from bm_mans where leavedate=''";
		    	var result=[];
		    	result=myRunSelectSql('',sql);
				if(result[0].usertype==1){
					var sql="update bm_mans set leavedate='"+mySysDateTime('datetime')+"' where userid='"+result[0].userid+"'";
				}else if(result[0].usertype==0){
					var sql="update bm_users set leavedate='"+mySysDateTime('datetime')+"' where userid='"+result[0].userid+"'";
				}
				myRunUpdateSql('',sql);
				//console.log(sql);
		    	window.top.location.href='design_pagehome.jsp';
		    }
		});
		
	});



</script>  
</body>
</html>