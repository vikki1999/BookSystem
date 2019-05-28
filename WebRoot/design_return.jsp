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
<body class="easyui-layout" fit="true" style="margin: 2px 2px 2px 2px;">
	<div id='right' class='easyui-panel' data-options="region:'east'" style="overflow:hidden; background-color: #E0ECFF; width:143px; padding: 1px 1px 1px 10px;"></div>
	<div id='main' class='easyui-panel' data-options="region:'center'" style="padding: 1px 1px 1px 1px;"></div>
<script>
	$(function() {
		var pmyGrid1={};
		pmyGrid1.id='myGrid1';
		pmyGrid1.parent='main';
		pmyGrid1.staticsql="select a.lendid,a.isbn,b.title,a.lenddate,dateadd(month,1,a.lenddate) as diedate,a.forfeit from lends a";
		pmyGrid1.staticsql+=" join books b on a.isbn=b.isbn ";
		//pmyGrid1.activesql=pmyGrid1.staticsql;
		pmyGrid1.gridfields='[@c%c#180,2]图书编码/isbn;[%d#240@c]图书名称/title;[@c#130]借书日期/lenddate;[@c#130]截止日期/lenddate;[@d#130]欠费/forfeit;';
		pmyGrid1.fixedfields='[@l%c#90]借阅号/lendid';
		pmyGrid1.title='借阅列表';
		pmyGrid1.menu='myMenu1';
		pmyGrid1.checkbox='single';
		pmyGrid1.pagesize=10;
		pmyGrid1.keyfield='lendid';
		pmyGrid1.rownumbers=true;
		pmyGrid1.collapsible=true;
		pmyGrid1.height=580;
		pmyGrid1.width=0;
		pmyGrid1.rowindex=0;
		//定义grid
		myGrid(pmyGrid1);
		//初始化，显示第一页记录
		pmyGrid1.activesql=pmyGrid1.staticsql+" join bm_users c on c.userid=a.userid where c.leavedate='' and a.returndate=''";
		myLoadGridData(pmyGrid1,1);			
		//myGrid1定义结束
		myButton('return','right','归还图书',45*0+25,8,35,130);
		myButton('delay','right','图书续借',45*1+25,8,35,130);
		$("#return").click(function(e){
			var id=$('#myGrid1').datagrid('getSelected');
			var rows=$("#myGrid1").datagrid('getRows');
			//console.log(id.lendid);
			var sql="update lends set returndate='"+mySysDateTime('date')+"' where lendid='"+id.lendid+"'";
			sql="\n update books set counts=counts+1 where isbn=(select isbn from lends  where lendid='"+id.lendid+"')";
			myRunUpdateSql('',sql);
			$('#myGrid1').datagrid('deleteRow', pmyGrid1.rowindex);
			if (pmyGrid1.rowindex>rows.length-1 && rows.length>0){
				pmyGrid1.rowindex--;  //选中上一行，否则自动选下一行
			}
			$("#myGrid1").datagrid('selectRow', pmyGrid1.rowindex);//选中下一行
		});
		$("#delay").click(function(e){
			var id=$('#myGrid1').datagrid('getSelected');
			var rows=$("#myGrid1").datagrid('getRows');
			//console.log(id.lendid);
			var sql="update lends set lenddate='"+mySysDateTime('date')+"' where lendid='"+id.lendid+"'";
			myRunUpdateSql('',sql);
			myLoadGridData(pmyGrid1,1);	
		});
		function fnGenWhereSql(action){
			var xtext=$('#searchtext').textbox("getValue");
			var xfields=';'+$('#searchfield').combobox("getText")+';';
			var wheresql='';
			for (var i=0;i<pmyGrid1.columns.length;i++){
				if (xfields.indexOf(';'+pmyGrid1.columns[i].title+';')>=0){
					if (wheresql!='') wheresql+=' or ';
					wheresql+=pmyGrid1.columns[i].field+" like '%"+xtext+"%'";
				}
			}
			return wheresql;
		}
	//---------------------
	});  //endofjquery

	function myGridEvents(){
		
		
	}
</script>
</body>
</html>