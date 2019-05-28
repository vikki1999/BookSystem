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
</head>
  
  <body>
 <div id="main" style="margin:2px;">
</div>
<script>
$(document).ready(function(){
    myForm('products','main','商品分类信息',0,0,465,400,'close;min;max;');
    myComboField('prname','products','商品类别：',68,10,30,23,158,'','','');
    myTextareaField('datalist','products','',0,40,10,320,370,'','');
	myTextField('amount','products','销售额：',68,369,40,23,108,'','');
	myTextField('quantity','products','销售量：',68,402,40,23,108,'','');
   
    var xsql="select productid,productid+' '+productname as prname from products where isparentflag=1";
   	var source=myRunSelectSql('',xsql);
   	console.log(source);
   	
   	$("#prname").combobox({
			panelHeight: 120,
			data:source,
			valueField: 'prname',
			textField: 'prname'
		});	
	//myGetComboxData('prname',xsql);
	
	$("#prname").combobox({
		onSelect:function(r){
			var x=r.productid;
			xsql="select productid,productid+productname as datalist from products where parentNodeId="+x;
			//console.log(xsql);
			source=myRunSelectSql('',xsql);
			//count=source.length;
           // console.log(count);
            //for(var i=1;i<=count;i++){
            	//var str='<ul class="easyui-datalist" >';
   				//str+='<li value='+i+'>'+source[i-1].datalist+'</li>';
   				//str+='</ul>';
   				//$("#datalist").append($(str));
           // }; 
			//console.log(str);
			$("#datalist").datalist({
				checkbox:true,
				data:source,
				valueField: 'datalist',
				textField: 'datalist',
				onSelect:function(index,r){
					xsql="select sum(amount) as amount,SUM(quantity) as qty from orderitems where productid='"+r.productid+"'";
				   	source=myRunSelectSql('',xsql);
				   	console.log(source);
				   	$("#quantity").textbox('setValue',source[0].qty);
					$("#amount").textbox('setValue',source[0].amount);
				}
			});
		}
	});
	$("#prname").combobox('select',source[0].prname);
});

 </script>
  </body>
</html>
