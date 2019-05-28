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
	<style>
	</style>
</head>
<body id="main" style="margin: 2px 2px 2px 2px;">
</body>
<script >
	$(document).ready(function(){
		/*
		var browser=fnCheckBrowser();
		if (browser!='chrome'){
			var str='<div style="margin:20px"><a href="javascript:fndownload(\'谷歌游览器Chrome.exe\')">下载谷歌游览器</a></div>';
			str+='<div style="margin:20px"><a href="javascript:fndownload(\'搜狗游览器sogou_explorer.exe\')">下载搜狗游览器</a></div>';
			$("#main").append($(str));
			return;
		}
		*/
		document.onkeypress=myBanBackSpace;
		document.onkeydown=myBanBackSpace;
		var colorset=['#FAF4FF','#FFF8D7','#FFE66F','#CCFF80','#EFFFD7','#F3F3FA','#FFDEAD','#F0F0F0'];		
		var btnwidth=220;   //#FFF8D7  #F4F4F4
		var str='<div style="float:right; margin:60px 20px 0px 0px;" >'+
		'<div class="easyui-window" id="myForm1" title="<div style=\'margin:0px 0px 0px 5px; \'>用户登录</div>" style="position:relative; width:305px; height:420px; background:#FFF3EE;'+
		'padding:2px 2px 2px 2px;">'+
		'</div></div>';
		$("#main").append($(str));
		$("#myForm1").window({iconCls:"panelIcon", closable:false, collapsible:false, maximizable:false, minimizable:false, sortable:false, headerCls:'xpanel-header',bodyCls:'xpanel-body'});
		str='<div style="position:absolute; width:220px; height:35px; top:35px; left:38px;"><input class="easyui-textbox" type="text" id="account" data-options="prompt:\'用户账号\',iconCls:\'icon-man\',iconWidth:38" style="font-size:13px; height:100%; width:100%; padding:0px 8px 0px 10px;" ></div>';
		str+='<div style="position:absolute; width:220px; height:35px; top:105px; left:38px;"><input class="easyui-validatebox easyui-textbox" type="password" id="password" data-options="prompt:\'登录密码\',iconCls:\'icon-lock\',iconWidth:38" style=" font-size:13px; height:100%; width:100%; padding:0px 8px 0px 10px;" ></div>';
		str+='<div style="position:absolute; top:170px; left:45px;"><a id="getpassword" href="getPassword.jsp" target="">忘记密码？</a></div>\n';		
		str+='<div style="position:absolute; top:170px; left:195px;"><a id="register" href="register.jsp" target="">免费注册</a></div>';		
		$("#myForm1").append($(str));
		$("#account").textbox();
		$("#password").textbox();
		$("#account").textbox('setValue',sys.userid);
		$("#password").textbox('setValue',myFromXcode(sys.userpassword));
		//$("#account").textbox('setValue','20000554');
		//$("#password").textbox('setValue','zxywolf0554');
		myButton('cmdok1','myForm1','账号登录',210,38,35,220);
		myButton('cmdok2','myForm1','游客登录',265,38,35,220);
		myImageField('logo_melab','myForm1','',0,330,16,28,264,'system/images/logo_melab.png');		
		$("#cmdok1").css({ background:'#99BBE8' });  //'orange'
		$("#cmdok2").css({background:'#99BBE8' });
		$("#cmdok1").linkbutton({'plain':true});
		$("#cmdok2").linkbutton({'plain':true});
		myKeyDownEvent('account;password');		
 		mySelectOnFocus();
		myFocus('account');
		//$("#account").textbox("setValue","zxywolf@163.com");
		//$("#password").textbox("setValue","zxy");
		//确定登录
		$('#password').textbox('textbox').bind('keydown',function(e){
			if (e.which==13) $("#cmdok1").focus();	
		});
		
		
		$("#cmdok1").click(function(e){
			var s1=$("#account").textbox('getValue');
			var s2=$("#password").textbox('getValue');
			s2=myToXcode(s2);
			if (s1!=''){
				var sql="select studentid as userid,name as username,password,account,email,mobile,qq,weixin,1 from students where (studentid='"+s1+"' or account='"+s1+"')\n";
				//sql+=" and checkedstatus=1\n";
				console.log(sql);
				var result=myRunSelectSql(sysdatabasestring, sql);
				if (result.length==0){
					myMessage('@n用户账号['+s1+']不存在！','error',0,'fn1');
				}else if(result[0].password!=s2){
					//$.messager.alert('title','msg','info',fn1);
					myMessage('@n用户登录密码输入错误！','warn',280,'fn2');			
				//}else if(result[0].usertype!=1 ){
					//$.messager.alert('title','msg','info',fn1);
					//myMessage('@n用户没有经过后台审核！','warn',280,'fn2');			
				}else{  
							window.top.location.href='design_index.jsp';
					
				}
				//alert(myLocalTime(''));
			}
		});
		//游客登录
		$("#cmdok2").click(function(e){
			
					window.top.location.href='index.jsp';
				    
			});
		
		
	//****************************end of jquery**************************//		
	});

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
	</html>