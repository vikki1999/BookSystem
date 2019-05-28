<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<html>
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

<div class="panel window" style="display: block; width: 293px; left: 529px; top: 88px; z-index: 9003; position: absolute;">
	
	<div class="panel-header panel-header-noborder window-header xpanel-header" style="width: 293px;">
		<div class="panel-title panel-with-icon">
			<div style="margin:0px 0px 0px 5px; ">用户登录</div>
		</div>
		<div class="panel-icon panelIcon"></div>
		<div class="panel-tool"></div>
	</div>
	<div class="easyui-window panel-body panel-body-noborder window-body xpanel-body" id="myForm1" title="" style="position: relative; background: rgb(255, 243, 238); padding: 2px; width: 290px; height: 380px;">
		<div style="position:absolute; width:220px; height:35px; top:35px; left:38px;">
		
			<span class="textbox easyui-fluid" style="width: 218px; height: 33px;">
				<span class="textbox-addon textbox-addon-right" style="right: 0px;">
					<a href="javascript:void(0)" class="textbox-icon icon-man textbox-icon-disabled" icon-index="0" tabindex="-1" style="width: 38px; height: 33px;">
					</a>
				</span>
				<input type="text" class="textbox-text validatebox-text" autocomplete="off" placeholder="用户账号" style="padding: 0px 8px 0px 10px; margin-left: 0px; margin-right: 38px; height: 33px; line-height: 33px; width: 162px;">
			</span>
		</div>
		<div style="position:absolute; width:220px; height:35px; top:105px; left:38px;">
			
			<span class="textbox easyui-fluid" style="width: 218px; height: 33px;">
				<span class="textbox-addon textbox-addon-right" style="right: 0px;">
					<a href="javascript:void(0)" class="textbox-icon icon-lock textbox-icon-disabled" icon-index="0" tabindex="-1" style="width: 38px; height: 33px;">
					</a>
				</span>
				<input type="password" class="textbox-text validatebox-text" autocomplete="off" placeholder="登录密码" style="padding: 0px 8px 0px 10px; margin-left: 0px; margin-right: 38px; height: 33px; line-height: 33px; width: 162px;">
				
			</span>
		</div>
		
		<div style="position:absolute; top:170px; left:45px;">
			<a id="getpassword" href="getPassword.jsp" target="">忘记密码？</a>
		</div>
		<div style="position:absolute; top:170px; left:195px;">
			<a id="register" href="register.jsp" target="">免费注册</a>
		</div>
		<a href="javascript:void(0)" id="cmdok1" class="easyui-linkbutton l-btn l-btn-small l-btn-plain" style="padding: 0px 2px 0px 4px; margin: 0px; position: absolute; top: 210px; left: 38px; width: 214px; height: 35px; z-index: 2; background: rgb(153, 187, 232);" xparent="myForm1" xid="cmdok1" xtype="linkbutton" group="">
			<span class="l-btn-left" style="margin-top: 5px;">
				<span class="l-btn-text">账号登录</span>
			</span>
		</a>
		<a href="javascript:void(0)" id="cmdok2" class="easyui-linkbutton l-btn l-btn-small l-btn-plain" style="padding: 0px 2px 0px 4px; margin: 0px; position: absolute; top: 265px; left: 38px; width: 214px; height: 35px; z-index: 2; background: rgb(153, 187, 232);" xparent="myForm1" xid="cmdok2" xtype="linkbutton" group="">
			<span class="l-btn-left" style="margin-top: 5px;">
				<span class="l-btn-text">游客登录</span>
			</span>
		</a>
		<img src="system/images/logo_melab.png" id="logo_melab" style="position: absolute; top: 330px; left: 16px; width: 253.556px; height: 28px; padding: 0px 2px 0px 4px; z-index: 2;" xparent="myForm1" xlabel="" xtype="image" type="image" xid="logo_melab" xwidth="253.55555555555557" xheight="28">
	</div>
</div>

</body>
</html>