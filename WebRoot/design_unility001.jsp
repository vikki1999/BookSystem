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
	<div id="layout" class="easyui-layout" data-options="fit:true" style="margin: 1px 1px 1px 1px;">
        <div id='left' data-options="region:'west',split:true" style="width:500px;height:400px;">
        	
        </div>
        <div id="right" data-options="region:'center'" style="">
            <div id="tab" class="easyui-tabs"  style="overflow: auto; width:520px; height:500px;">
            	<div id="myForm2" title="基本信息" style="position:relative; overflow:auto;"></div>
            	<div id="myForm3" title="学生简介" style="position:relative; overflow:auto;"></div>
            </div>
        </div>
    </div> 	
 	    
</div>  
<script>
	$(document).ready(function(){
		//myForm('myForm1','main','学生信息编辑',0,0,540,1024,'min;max;close;');
		//myForm('myForm2','tab','基本信息',0,0,340,600,'');
		//myForm('myForm3','tab','学生简介',0,0,340,600,'');
		myFieldset('myFieldset1','myForm2','',10,10,430,455);
		//myFieldset('myFieldset2','myForm3','',10,10,230,355);
		//myTextareaField('','left','',0,63,8,375,445,'','');
		myFieldset('datalist','left','',63,8,375,445,'');
		myTextareaField('introduction','myForm3','',0,20,8,375,475,'','');
		myTextField('stuid','myFieldset1','学号：',70,33*0+20,12,0,120,'');
		myTextField('stuname','myFieldset1','姓名：',70,33*1+20,12,0,160,'');
		myTextField('pycode','myFieldset1','拼音：',70,33*2+20,12,0,300,'');
		myComboField('gender','myFieldset1','性别：',70,33*3+20,12,0,120,'男;女','');
		myComboField('birth','myFieldset1','出生日期：',70,33*4+20,12,0,160,'','');
		myComboField('city','myFieldset1','所属县市：',70,33*5+20,12,0,160,'','');
		myTextField('adress','myFieldset1','家庭地址：',70,33*6+20,12,0,300,'');
		myTextField('mobile','myFieldset1','联系电话：',70,33*7+20,12,0,200,'');
		myTextField('email','myFieldset1','Email：',70,33*8+20,12,0,300,'');
		myComboField('province','left','省份：',70,20,32,0,160,'','');
		var str='<div id="data" class="easyui-datalist" style="position:absolute;top:0px;left:16px;"></div>';
		console.log(str);
		$("#datalist").append($(str));
		
		var xsql="select areaname as province from areas where level=1";
		source=myRunSelectSql('',xsql);
		$("#province").combobox({
			data:source,
			textfield:province,
			valuefield:province,
			panelHeight:200,
			onSelect:function(r){
				var pv=r.province;
				//console.log(pv);
				xsql="select studentid+name as data ,* from students where province='"+pv+"'";
				//console.log(xsql);
				var source1=myRunSelectSql('',xsql);
				/*for(var i=0;i<source.length;i++){
					if(source[i].gender=='F')
						{var xy='女';}
					else {xy='男';}
				}*/
				console.log(source1);
				
				$("#data").datalist({
					data:source1,
					textField:'data',
					valueField:'data'
					
				});
			}
		});
		$("#data").datalist({
			
			checkbox:true,
			onselect:function(index,x){
				//if(x.gender=='F'){x.gender='女'}else{x.gender='男'}
				//console.log(x.gender);
				$("#stuid").textbox('setValue',x.studentid);
				$("#stuname").textbox('setValue',x.name);
				$("#pycode").textbox('setValue',x.pycode);
				$("#adress").textbox('setValue',x.province+x.city);
				$("#mobile").textbox('setValue',x.mobile);
				$("#email").textbox('setValue',x.email);
				$("#gender").combobox('setValue',x.gender);
				$("#birth").combobox('setValue',x.bithdate);
				$("#city").combobox('setValue',x.city);
			}
		});
	
	});



</script>  
</body>
</html>