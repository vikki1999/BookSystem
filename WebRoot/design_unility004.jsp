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
    <div id="main" style="margin:2px;"></div>

  <script>
  	$(document).ready(function(){
        myForm('ordercount','main','商品销售额统计',0,0,365,325,'close;min;max;');
        myTextField('proid','ordercount','商品编码:',68,10,10,23,100,'102','');
        myButton('cmdselect','ordercount','...',10,200,23,45,'','');
        myTextField('prname','ordercount','商品名称:',68,43,10,23,220,'汇源桃汁果肉果汁','');
        myComboField('pyear','ordercount','输入年份:',68,76,10,23,100,'2010;2011;2012;2013;2014;2015','2012','');
        myTextareaField('kuang','ordercount','',0,109,10,220,280,'','');
        
        $("#cmdselect").on('click',function(){
            var prid=$("#proid").textbox('getValue');
            var date=$("#pyear").combobox('getValue');
            //var x=document.getElementById("kuang").value;
            xsql="select productid from products where productid="+prid;
   		 	data=myRunSelectSql(xsql);
   		 	if(data==''){
   		 		alert('该编号不存在');
   		 	}
            
            var xsql="select '"+date+"年'+cast(month(a.orderdate) as varchar(5))+'月'+'  '+cast(SUM(a.amount) as varchar(10))as kuang from orders a"
				+" join orderitems b on a.orderid=b.orderid"+
				" where productid="+prid+" and year(a.orderdate)="+date+" group by MONTH(a.orderdate)";
				console.log(xsql);
            var data=myRunSelectSql('',xsql);
             //console.log(data);
            count=data.length;
            //console.log(count);
            
            for(var i=1;i<=count;i++){
   				$("#kuang").append(data[i-1].kuang + "\t\n");
   				
            };
            $("#kuang").append('-----------------------\t\n');
            //商品名称
            xsql="select productname from products where productid="+prid;
   		 	data=myRunSelectSql('',xsql);
   		 	console.log(data);
   		 	$("#prname").textbox('setValue',data[0].productname);
   		 	//商品编码
   		 	
   		 
   		 });
    });   
		
 </script>
  </body>
</html>
