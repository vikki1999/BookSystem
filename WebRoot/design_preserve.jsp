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
<body style="margin: 2px 2px 2px 2px;width:1000px;">
<div id="main" class="easyui-layout" data-options="fit:true" style="margin:2px 2px 2px 2px;">
</div>
<script>
	$(document).ready(function(){
		var sql="select isbn,title,author,b.pubname ,pubdate ,unitprice from books a join pubs b on a.pubid=b.pubid where"; 
		var pmyGrid1={};
		pmyGrid1.id='myGrid1';
		pmyGrid1.parent='grid';
		pmyGrid1.staticsql="select isbn,title,author,b.pubname,pubdate,unitprice from books a";
		pmyGrid1.staticsql+="join pubs b on a.pubid=b.pubid ";
		pmyGrid1.gridfields="[@c%c#250]图书名称/title;[@c%c#150,2]作者/author;[@c%c#130]出版社/pubname;"+
		"[%d#110@c]出版时间/pubdate;[@c%d#100]单价/unitprice";	
		pmyGrid1.fixedfields='[@l%c#130]图书编号/isbn';
		pmyGrid1.title='';
		pmyGrid1.menu='myMenu2';
		pmyGrid1.checkbox='single';
		pmyGrid1.pagesize=10;
		pmyGrid1.keyfield='isbn';
		pmyGrid1.rownumbers=true;
		pmyGrid1.collapsible=true;
		pmyGrid1.height=360;
		pmyGrid1.width=0;
		pmyGrid1.rowindex=0;
		//定义grid
		myGrid(pmyGrid1);
		//myForm('myForm1','torbar','数据库连接与数据检索',0,0,'100%','100%','');
		//myTextareaField('sqlstmt','myForm1','查询语句：',0,10,8,100,675,'','');
		//myTextareaField('result','myForm1','查询结果：',0,115,8,155,575,'','');
		myButton('cmdquery','myForm1','运行SQL',150,430,25,75,'','');
		myButton('cmdreset','myForm1','清空',150,506,25,70,'','');
		$("#sqlstmt").val(sql);
		//按钮点击事件
		$("#cmdreset").on('click', function() {
			$("#sqlstmt").val(sql);	
			pmyGrid1.activesql="select isbn,title,author,b.pubname ,pubdate ,unitprice from books a join pubs b on a.pubid=b.pubid where a.categoryid='0'";
			myLoadGridData(pmyGrid1,1);	
			//$("#result").val('');	
		});

		$("#cmdquery").on('click', function() {
			//var xsql=$("#sqlstmt").val();
			pmyGrid1.activesql=$("#sqlstmt").val();
			myLoadGridData(pmyGrid1,1);
		});
	});	
	function myGridEvents(id,event){
		
	}
     
    </script>
</body>
</html>