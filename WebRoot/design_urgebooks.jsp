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
	<div id='toolbar' class='easyui-panel' data-options="region:'north'" style="overflow:hidden; background-color: #E0ECFF; height:33px; padding: 1px 1px 1px 10px;"></div>
	<div id='main' class='easyui-panel' data-options="region:'center'" style="padding: 1px 1px 1px 1px;"></div>
<script>
	$(function() {
		var pmyGrid1={};
		pmyGrid1.id='myGrid1';
		pmyGrid1.parent='main';
		pmyGrid1.staticsql="select a.lendid,a.isbn,b.title,b.counts,a.lenddate,dateadd(month,1,a.lenddate) as diedate,datediff(day,dateadd(month,1,lenddate),GetDate()) as forfeit from lends a";
		pmyGrid1.staticsql+=" join books b on a.isbn=b.isbn ";
		//pmyGrid1.activesql=pmyGrid1.staticsql;
		pmyGrid1.gridfields='[@c%c#180,2]图书编码/isbn;[%d#240@c]图书名称/title;[%d#40@c]库存/counts;[@c#130]借书日期/lenddate;[@c#130]截止日期/lenddate;[@d#130]延期天数/forfeit;';
		pmyGrid1.fixedfields='[@l%c#90]借阅号/lendid';
		pmyGrid1.title='借阅列表';
		pmyGrid1.menu='myMenu1';
		pmyGrid1.checkbox='single';
		pmyGrid1.pagesize=10;
		pmyGrid1.keyfield='lendid';
		pmyGrid1.rownumbers=true;
		pmyGrid1.collapsible=true;
		pmyGrid1.height=540;
		pmyGrid1.width=0;
		pmyGrid1.rowindex=0;
		//定义grid
		myGrid(pmyGrid1);
		//初始化，显示第一页记录
		pmyGrid1.activesql=pmyGrid1.staticsql+" join bm_users c on c.userid=a.userid where forfeit>0 ";
		myLoadGridData(pmyGrid1,1);			
		//myGrid1定义结束
		//定义关键字下拉框和查询文本输入框
		var tmp='';  ////从网格中提取列标题作为下拉框选项
		for (var i=0;i<pmyGrid1.columns.length;i++){
			if (tmp!='') tmp+=';';
			tmp+=pmyGrid1.columns[i].title;
		}
		myComboField('searchfield','toolbar','选择关键字:',75,4,10,0,260,tmp,'','checkbox');
		myTextField('searchtext','toolbar','快速过滤：',65,4,380,0,200,'','');
		myTextField('locatetext','toolbar','',0,4,644,0,24,'','');
		//过滤记录
		$('#searchtext').textbox({
			buttonIcon:'icon-filter',
			onClickButton: function(e){
				wheresql=fnGenWhereSql('filter');
				if (wheresql!='') pmyGrid1.activesql='select * from ('+pmyGrid1.staticsql+') as p where '+wheresql;
				else pmyGrid1.activesql=pmyGrid1.staticsql;
				//console.log(pmyGrid1.activesql);
				var opts =$("#myGrid1").datagrid('getPager').data("pagination").options; 
				opts.pageNumber=1;
				pmyGrid1.rowindex=0;
				myLoadGridData(pmyGrid1,1);            	
			}
		});
		//定位记录
		$('#locatetext').textbox({
			buttonIcon:'locateIcon',
			onClickButton: function(e){
				wheresql=fnGenWhereSql();
				if (wheresql!=''){
					sql="select top 1 "+pmyGrid1.keyfield+" from ("+pmyGrid1.activesql+") as p where "+wheresql;
					console.log(sql);
					var results=myRunSelectSql(sysdatabasestring, sql);
					if (results.length>0){
						var keyvalue=eval('results[0].'+pmyGrid1.keyfield);
						sql='select count(*)+1 as rowno from ('+pmyGrid1.activesql+') as p where '+pmyGrid1.keyfield+"<'"+keyvalue+"'";
						console.log(sql);
						var sources=myRunSelectSql(sysdatabasestring, sql);
						var rowno=sources[0].rowno;
						var opts =$("#myGrid1").datagrid('getPager').data("pagination").options; 
						var pageno=parseInt((rowno-1)/opts.pageSize)+1;
						pmyGrid1.rowindex=rowno-(pageno-1)*opts.pageSize-1;
						myLoadGridData(pmyGrid1,pageno);
					}else{
						$.messager.alert('系统提示','没有找到满足条件的记录！','info');
					}
				}	
			}
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