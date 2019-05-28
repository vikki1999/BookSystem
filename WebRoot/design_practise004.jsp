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
	<script type="text/javascript" src="jqeasyui/datagrid-detailview.js"></script>
    <script type="text/javascript" src="jqeasyui/easyui-lang-zh_CN.js"></script>	
	<script type="text/javascript" src="system/easyui_functions.js"></script>
</head>
<body style="margin: 2px 2px 2px 2px;">
<div id='main' class="easyui-layout" data-options="fit:'true'" style="margin:0px 0px 0px 0px;">
 	
</div>    
<script>
$(document).ready(function() {
	var pmyGrid1={};
	pmyGrid1.id='myGrid1';
	pmyGrid1.parent='main';
	pmyGrid1.staticsql=" select b.title,a.lendid,a.isbn,a.lenddate,dateadd(month,1,a.lenddate) as diedate,a.userid,datediff(day,dateadd(month,1,lenddate),GetDate()) as forfeit from lends a "
		+"join books b on a.isbn=b.ISBN where a.forfeit>0";
	//console.log(pmyGrid1.staticsql);
	pmyGrid1.activesql=pmyGrid1.staticsql;
	pmyGrid1.summeryfields="title='<center>* 全部催还合计 *</center>',lendid=count(lendid)";
	pmyGrid1.keyfield='lendid';
	pmyGrid1.pagesize=10;
	pmyGrid1.rowindex=-1;
	var xcolumns=[[
	   			
	   			{ title: '用户名', field: 'userid', width: 75, halign:'center', align: 'right'	},
	   			{ title: '图书名称', field:'title', width: 260, halign:'center', align: 'center' },
	   			{ title: 'ISBN', field:'isbn', width: 180, halign:'center', align: 'center' },
	   			{ title: '借阅日期', field:'lenddate', width: 120, halign:'center', align: 'center' },
	   			{ title: '截止日期', field:'diedate', width: 120, halign:'center', align: 'center' },
	   			{ title: '逾期', field: 'forfeit', width: 75, halign:'center', align: 'right'	}
	   		]];
	var xfixedcolumns=[[{ title: '借阅编码', field:'lendid', width: 120, halign:'center', align: 'center' }
	]];
	//定义grid及其工具栏
	var myToolbar1 = ['-',{
		text:'输出',
		iconCls:'excelIcon',
		handler: fn_toExcel
	},'-',{
		text:'刷新',
		iconCls:'refreshIcon',
		handler: fn_refresh
	}];	
	var str='<div id="myGrid1" class="easyui-datagrid"></div>';
	$("#main").append($(str));
	$("#myGrid1").datagrid({
		title: '&nbsp;图书催还报表',
		iconCls: "panelIcon",
		width:'100%',
		height:'100%',
		nowrap: true,
		pagePosition: 'bottom',  //top,both
		autoRowHeight: false,
		rownumbers: true,
		toolbar: myToolbar1,
		pagination: true,
		pageSize: pmyGrid1.pagesize,
		pageNumber:1,
		striped: true,
		collapsible: false,
		singleSelect: true,
		idField: 'lendid',
		frozenColumns: xfixedcolumns,
		columns: xcolumns,
		showFooter: true
	});
	//定义分页栏模式
	myGridPaging(pmyGrid1);
	var opts = $("#myGrid1").datagrid('options');
	myLoadGridData(pmyGrid1,1);
	//数值型数据格式对其
	function fnSetNumberFormat(value){
		if (value==undefined || value==0) value='';
		else value=(1.0*value).toFixed(this.decimal);
		return '<div align="right">' + value+'</div>';
	}
	//输出到excel
	function fn_toExcel(){
		//调用函数的实现方法，适用于头体尾三层的报表
		var pmyReport1={};
		pmyReport1.sql=pmyGrid1.staticsql+" union all ";
		pmyReport1.sql+="\n select '* 全部催还合计 *',count(lendid),'','','','','' from (";
		pmyReport1.sql+="\n "+pmyGrid1.staticsql+") as p";
		pmyReport1.sql+="\n order by lendid";
		pmyReport1.targetfilename="图书催还总报表.xls";
		pmyReport1.template="TUrgeBooks.xls";
		/*
		pmyReport1.headerrange='<1-4>'; //标题为第1行到第4行，每页重复
		pmyReport1.headercells="<1,1>商品销售情况月报表;<2,1>2012年12月份";
		//页脚最多只能是左中右三个值
		pmyReport1.footercells="<l>制单人：诸葛亮;<c>第pageno页/共pagecount页";
		pmyReport1.fields="productid;productname;quantityperunit;unit;unitprice;qty1;amount1;qty2;amount2";
		var r=myExportExcelReport(sysdatabasestring,pmyReport1);
		*/
		//后台程序写死的方法，只适用于这个报表模板
		var filename="";
		$.ajax({
			url:"design_toExcelFile.jsp",
			data:{ database:sysdatabasestring, 
				template:pmyReport1.template, 
				selectsql:pmyReport1.sql
			},									
			//method: 'POST',
			async:false, method: 'post',
	   		success:function(data){
	   			eval("var result="+data);
	    		filename=result[0].filename;
			}	
		});
		var xsourcefilename=filename;
		var url='system//easyui_fileDownLoad.jsp?source='+filename+'&target='+pmyReport1.targetfilename;
		window.location.href=url;		
	}

	function fn_refresh(){
		
	}
//---------------------endofjquery----------------
});

function myGridEvents(id,e){
	
}
</script>
</body>
</html>