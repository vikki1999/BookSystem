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
<div class="easyui-layout" data-options="fit:true" style="margin:0px 0px 0px 0px;">
 	<div id='toolbar' class='easyui-panel' data-options="region:'north'" style="overflow:hidden; background-color: #E0ECFF; height:33px; padding: 1px 1px 1px 10px;"></div>
 	<div id='main' class='easyui-panel' data-options="region:'center'" style="padding: 1px 1px 1px 1px;"></div>	
</div>    
<script>
	$(document).ready(function() {
		sql_products="select distinct cast(MONTH(lenddate) as nchar(2))+'月' as text ,'1' as isparentflag,'' as parentnodeid,'' as ancester,'1' as level,'' as title,cast(month(lenddate) as int) as lendid,'' as isbn,'' as lenddate,'' as returndate,'' as userid,'' as forfeit from lends"
			+" union all"
			+" select cast(lenddate as nchar(20)) as text,'0' as isparentflag,cast(MONTH(lenddate) as nchar(2)) as parentnodid,CAST(MONTH(lenddate) as NCHAR(2))+'#' as ancester,'2' as level ,b.title,a.* from lends a "
			+"join books b on a.isbn=b.ISBN";
		var xcolumns=[[
			{ title: '借阅编码', field:'lendid', width: 120, halign:'center', align: 'center' },
			{ title: '用户名', field: 'userid', width: 75, halign:'center', align: 'right'	},
			{ title: '图书名称', field:'title', width: 260, halign:'center', align: 'center' },
			{ title: 'ISBN', field:'isbn', width: 180, halign:'center', align: 'center' },
			{ title: '借阅日期', field:'lenddate', width: 120, halign:'center', align: 'center' },
			{ title: '还书日期', field:'returndate', width: 120, halign:'center', align: 'center' },
			{ title: '逾期缴款', field: 'forfeit', width: 75, halign:'center', align: 'right'	}
		]];
		var str='<table id="myTreeGrid1" class="easyui-treegrid" style="overflow:auto"></table>';
		$("#main").append($(str));
		trGrid=$("#myTreeGrid1");
		myMenu('myMenu1','新增节点/mnadd/addIcon;新增子节点/mnaddsub/addIcon;修改节点/mnedit/editIcon;-;删除/mndelete/deleteIcon;-;刷新/mnrefresh/refreshIcon','');
		trGrid.treegrid({
			title: '&nbsp;商品分类列表',
			iconCls: "panelIcon",
			width:'100%',
            height:'100%', //282, //'100%',
            collapsible: false,
            singleSelect:true,
            rownumbers: true,
			treeField: 'text',
            idField: 'id',
			frozenColumns:[[{ title: '借阅时间', field:'text', width: 160, halign:'center', align: 'left' }]],
			columns: xcolumns,
			onContextMenu: function(e, row){  //定义右键
				e.preventDefault();
				trGrid.treegrid("select", row.id); //根据索引选中该行
				$("#myMenu1").menu('show', {
					left: e.pageX,
					top: e.pageY
				});
			}				
		});	
		//console.log(xcolumns.length);
		var pmyGrid1=trGrid.treegrid('options'); 
		console.log(pmyGrid1);
		var tmp='';  ////从网格中提取列标题作为下拉框选项
		for (var i=0;i<pmyGrid1.columns[0].length;i++){
			if (tmp!='') tmp+=';';
			tmp+=pmyGrid1.columns[0][i].title;
		}
		myComboField('searchfield','toolbar','选择关键字:',75,4,10,0,260,tmp,'','checkbox');
		myTextField('searchtext','toolbar','快速过滤：',65,4,380,0,200,'','');
		myTextField('locatetext','toolbar','',0,4,644,0,24,'','');
		
		myHiddenFields("addoredit;level;parentnodeid;ancester");  //隐藏用作变量		
		 //调用通用函数，实现聚焦时全选文本框
		 mySelectOnFocus();
		////调用通用函数，下列各列实现键盘光标上下移动聚焦
		//myKeyDownEvent('productid;productname;englishname;quantityperunit;unit;unitprice');		
		//提取TreeGrid1第一层节点
		var sqlx="select * from ("+sql_products+") as p where parentnodeid=''";  //第一层
		reload(sqlx);
		//定义myTreeGrid1父节点 点击展开事件
		trGrid.treegrid({
			onBeforeExpand: function (node){  //点击展开事件
				var pid=node.id;
			//console.log(pid);
				//var sql=trGrid.attr('xsql');
				var sql=sql_products;
				var sqlx="select * from ("+sql+") as p where parentnodeid='"+pid+"'";
				var child_node = trGrid.treegrid('getChildren', pid);
				if (child_node.length==1 && child_node[0].id=='_'+pid){ //生成子节点
					$.ajax({
						url: "system/easyui_getChildNodes.jsp",
						data: { database: sysdatabasestring, selectsql: sqlx, keyfield:'lendid', sortfield:'' }, 
						async: false, method: 'post',    
						success: function(data) {
							var source=eval(data);
							trGrid.treegrid('remove', child_node[0].id); //删除虚拟子节点
							trGrid.treegrid('append', {  //增加数据作为子节点
								parent: pid, //这里不能用node.target,
								data: source 
							});
						}     
					});
				}
			},
			//双击展开或收缩结点事件	
			onDblClickRow: function(row){
				if (row.state=='closed') $(this).treegrid('expand', row.id);
				else $(this).treegrid('collapse', row.id);
			}
		});
		
		$('#searchtext').textbox({
			buttonIcon:'icon-filter',
			onClickButton: function(e){
				wheresql=fnGenWhereSql();
				sql_products=sql_products+" where "+wheresql;
				//console.log(sql_products);
				pmyGrid1.rowindex=0;
				trGrid.treegrid('reload');          	
			}
		});
		//定位记录
		$('#locatetext').textbox({
			buttonIcon:'locateIcon',
			onClickButton: function(e){
				wheresql=fnGenWhereSql();
				console.log(wheresql);
				if (wheresql!=''){
					sql="select * from ("+sql_products+") as p where "+wheresql;
					console.log(sql);
					var id=myRunSelectSql('',sql);
					//console.log(id[0].lendid);
					trGrid.treegrid('expand',id[0].parentnodeid);
					trGrid.treegrid('select',id[0].lendid);
				}else{
						$.messager.alert('系统提示','没有找到满足条件的记录！','info');
					}
				}	
			
		});


		function fnGenWhereSql(action){
			var xtext=$('#searchtext').textbox("getValue");
			var xfields=';'+$('#searchfield').combobox("getText")+';';
			var wheresql='';
			for (var i=0;i<pmyGrid1.columns[0].length;i++){
				if (xfields.indexOf(';'+pmyGrid1.columns[0][i].title+';')>=0){
					if (wheresql!='') wheresql+=' or ';
					wheresql+=pmyGrid1.columns[0][i].field+" like '%"+xtext+"%'";
				}
			}
			return wheresql;
		}	
			
	//---------------------endofjquery
	});
	function reload(sqlx){
		$.ajax({
			url: "system/easyui_getChildNodes.jsp",
			data: { database: sysdatabasestring, selectsql: sqlx, keyfield:'lendid', sortfield:''}, 
			async: false, method: 'post',    
			success: function(data) {
				//console.log(data);     
				var source=eval(data);
				trGrid.treegrid({ data: source });  //加载json数据到树
			}    
		});
	}
	
</script>
</body>
</html>