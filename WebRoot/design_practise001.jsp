

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<style type="text/css">
	a:link {  text-decoration: none}
	a:hover { text-decoration: underline}	
</style>
<head>
	<title>移动互联网实验室</title>
	<meta charset="utf-8">
	<link rel="stylesheet" type="text/css" href="jqeasyui1.4.5/themes/default/easyui.me.css">
	<link rel="stylesheet" type="text/css" href="jqeasyui1.4.5/themes/icon.css">
    <link rel="stylesheet" type="text/css" href="system/css/icon.css">
    <script type="text/javascript" src="jqeasyui1.4.5/jquery214.min.js"></script>
    <script type="text/javascript" src="jqeasyui1.4.5/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="jqeasyui1.4.5/easyui-lang-zh_CN.js"></script>	
	<script type="text/javascript" src="javascript/easyui_functions.js"></script>
	<script type="text/javascript" src="javascript/index.min.js"></script>
</head>
<body style="margin:1px 1px 1px 1px; padding:0px 0px 0px 0px; ">
<div id='main' class="easyui-layout" data-options="fit:true" style="margin:0px 0px 0px 0px;">
	<div id="toolbar" class="easyui-panel" data-options="region:'north'" style="overflow:hidden; background-color:#D2E9FF; height:40px; padding:7px 1px 0px 2px;">
		<div id="lefttoolbar" style="margin:-2px 0px 0px 6px; position:relative; top:0px; float:left">
			<img src="system/images/logo.png" style="height:30px; width:32px;" />
			<img src="system/images/logo_melab.png" style="height:30px;" />
		</div>
		<div id="righttoolbar" style="position:relative; top:0px; float:right"></div>
	</div>
	<div id="center" data-options="region:'center'" style="overflow:hidden; margin:0px 0px 0px 0px; padding: 0px 0px 0px 0px;">
		<iframe id="mainframe" width="100%" height="100%" src="" frameborder="no" border="0" style="overflow-y:hidden; margin:0px 0px 0px 0px; padding:0px 0;">	
		</iframe>
	</div>
	<div id="bottom" data-options="region:'south'" style="height:25px; padding: 2px 0px 0px 2px;">
	</div>
</div>   
<script>
	var basepath='http://melab.zstu.edu.cn:80/melab/';
	sys.userid='2015333504006';
	sys.useraccount='';
	sys.username='刘佳';
	sys.userlogindate='2017-02-03 15:24:56';
	sys.usertype='1';
	sys.userpassword='100054100051100057100055100057100065';
	sys.action='1';
	sys.flag='1';
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
				var sql="select checkedstatus,teacherid as userid,name as username,password,account,email,mobile,qq,weixin,usertype from teachers where (teacherid='"+s1+"' or account='"+s1+"')\n";
				//sql+=" and checkedstatus=1\n";
				sql+="union all \n";
				sql+="select checkedstatus,studentid as userid,name as username,password,account,email,mobile,qq,weixin,1 from students where (studentid='"+s1+"' or account='"+s1+"')\n";
				//sql+=" and checkedstatus=1\n";
				console.log(sql);
				var result=myRunSelectSql(sysdatabasestring, sql);
				if (result.length==0){
					myMessage('@n用户账号['+s1+']不存在！','error',0,'fn1');
				}else if(result[0].password!=s2){
					//$.messager.alert('title','msg','info',fn1);
					myMessage('@n用户登录密码输入错误！','warn',280,'fn2');			
				}else if(result[0].usertype!=1 && result[0].checkedstatus==0 ){
					//$.messager.alert('title','msg','info',fn1);
					myMessage('@n用户没有经过后台审核！','warn',280,'fn2');			
				}else{
					$.ajax({     
						type: "Post",     
						url: "system/easyui_loginServer.jsp",     
						//contentType: "application/json; charset=utf-8",     
						//dataType: "json", 
						data:{
							userid: result[0].userid, 
							useraccount: result[0].account, 
							username: result[0].username, 
							userpassword: result[0].password, 
							usertype: result[0].usertype, 
							userlogindate: myLocalTime('datetime'),
							action: 'login',
							flag:'1', 
							notes: ''
						},					
						async: false, method: 'post',   
						success: function(data){   
							window.top.location.href='index.jsp';
						}     
					});
				}
				//alert(myLocalTime(''));
			}
		});
		//游客登录
		$("#cmdok2").click(function(e){
			$.ajax({     
				type: "Post",     
				url: "system/easyui_loginServer.jsp",     
				//contentType: "application/json; charset=utf-8",     
				//dataType: "json", 
				data: {
					userid:'', 
					useraccount:'', 
					username:'', 
					userpassword:'', 
					usertype:'0', 
					userlogindate: myLocalTime(''),
					action:'login', 
					notes:''
				},					
				async: false, method: 'post',   
				success: function(data){   
					//alert(9);  
					window.top.location.href='index.jsp';
				}     
			});
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
</body>
</html>
