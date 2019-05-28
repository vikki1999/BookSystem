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
<body style="margin: 2px 2px 2px 2px;">
<div id='main' style="margin:0px 0px 0px 0px;">
	
</div>    
<script>
	$(document).ready(function() {
		$("input:text").focus(function() { $(this).select(); } );		
		var jqsql={};  //sql语句中不能有双引号
		jqsql.party="select Pycode as id,description as party from dictionary where Type='党派'";
		jqsql.title="select Pycode as id,description as title from dictionary where Type='学历'";
		jqsql.province="select AreaID as provinceid,AreaName as province from Areas where level=1";
		jqsql.city="select AreaID as cityid,AreaName as city, parentnodeid as provinceid from Areas ";
		jqsql.degree="select Pycode as id,description as degree from dictionary where Type='学历'";
		myForm('myForm1','main','教师信息编辑',0,0,495,348,'close;drag');
		myFieldset('myFieldset1','myForm1','',58,16,400,305);
		myComboField('category','myForm1','商品类别：',70,20,16,0,220,'','');
		myTextField('qty','myFieldset1','销售数量：',70,310,16,0,180,'');
		myTextField('amt','myFieldset1','销售金额：',70,340,16,0,180,'');


		str="<div id='datalist1' class='easyui-datalist' style='position:\"absolute\";top:\"0px\"; left:\"16px\"; width:300px;height:280px;'></div>";
		console.log(str);
		$("#myFieldset1").append($(str));
		$("#datalist1").datalist({
			valueField: 'product',
			textField: 'product',
			checkbox:true,
			onSelect:function(index,r){
				sql="select sum(quantity) as qty,sum(amount) as amt from orderitems where productid='"+r.productid+"'";
				console.log(sql);
				data2=myRunSelectSql('',sql);
				$("#qty").textbox('setValue',data2[0].qty);
				$("#amt").textbox('setValue',data2[0].amt);
			
			}
			
			
		});
		
		var sql="select *,productid+' '+productname as category from products where isparentflag=1";
		var data1=myRunSelectSql('',sql);
		$("#category").combobox({
			panelHeight: 'auto',
			valueField: 'category',
			textField: 'category',
			data:data1,
			onSelect:function(r){
				s1=r.ancester;
				s2=r.productid+'#';   //701
				s3=s1+s2+'%';
				sql="select *,productid+' '+productname as product from products where ancester like '"+s3+"' ";
				sql+=" and isparentflag=0";
				source=myRunSelectSql('',sql);
				$("#datalist1").datalist({
					data: source
				});		   
			}
			
		});
		$("#category").combobox('select',data1[0].category);
			
		 
		
		
		
	}); 
    
    </script>
</body>
</html>