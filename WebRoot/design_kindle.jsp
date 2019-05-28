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
	<script type="text/javascript" src="system/easyui_html5media.js"></script>
</head>
<body >
<div id='main' class="easyui-layout" data-options="fit:true" style="margin: 1px 1px 1px 1px;">
	<div id='top' class='easyui-panel' data-options="region:'north'" style="overflow:hidden; background-color: #E0ECFF; height:30px; padding: 1px 1px 1px 10px;">
		<a href="#" class="btn-separator"></a>
		<a href="#" id="btnadd" xtype="button" class="easyui-linkbutton" data-options="iconCls:'addIcon', plain:true, onClick:fn_add" style="">新增</a>
		<a href="#" id="btndelete" xtype="button" class="easyui-linkbutton" data-options="iconCls:'deleteIcon',plain:true, onClick:fn_delete" style="">删除</a>
		<a href="#" class="btn-separator"></a>
	</div>	
	<div id='bottom' class='easyui-panel' data-options="region:'south'" style="height:35px; overflow:auto; padding:8px 0px 0px 20px;">
	</div>
	<div id='left' class='easyui-panel' data-options="region:'west', split:true" style="overflow:auto; width:250px;">
		<div id="accor" class="easyui-accordion" data-options="fit:true, border:false">
			<div id='book1' title="三体"  data-options="selected:true"></div>
			
		</div>
	</div>
	<div id='middle' class='easyui-panel' data-options="region:'center', split:true" style="overflow:auto;">
		<object data="mybase/book289.pdf" type="application/pdf" width="100%" height="100%" ></object>
	</div>
</div>
<script>
	var count=1;
	$(document).ready(function() {
		//myWindow('myWin1','图书阅读',10,400,600,520,'','close');
		//myComboField('category','myWin1','图书类别：',70,20,32,0,230,'','');
		//myFieldset('datalist','myWin1','',63,18,375,445,'');
		//myButton('read','myWin1','在线阅读',470,200,24,70,'','');
		//var str='<div id="data" class="easyui-datalist" style="position:absolute;top:0px;left:16px;"></div>';
		//console.log(str);
		//$("#datalist").append($(str));
		//var xsql="select categoryname as category,categoryid from categories where level=1";
		//source=myRunSelectSql('',xsql);
		//console.log(source);
		/*$("#category").combobox({
			data:source,
			textfield:category,
			valuefield:category,
			panelHeight:200,
			onSelect:function(r){
				var pv=r.categoryid;
				//console.log(pv);
				xsql="select title as data ,* from books where categoryid like'"+pv+"%'";
				//console.log(xsql);
				var source1=myRunSelectSql('',xsql);
				//console.log(source1);
				$("#data").datalist({
					checkbox:true,
					height:380,
					data:source1,
					textField:'data',
					valueField:'data'
				});
			}
		});
		$('#category').combobox('select',source[0].category);*/
		var data='';
		/*$("#read").click(function(e) {
			var dd=$("#data").datalist('getSelected');
			$('#accor').accordion('add', {
				title: dd.data,
				content: ' ',
				selected: false
			});
			$("#myWin1").window('close');
		});*/
		//实时显示系统当前时间
		setInterval(function() {
		    var now = (new Date()).toLocaleString();
		    $('#bottom').text("系统当前时间："+now);
		},1000);
		//添加文字
		$("#accor").accordion({
			onSelect:function(title,index){
				var id=$("#accor").accordion('getSelected');
				id.panel('clear');
				var sql="select notes,sysid from mybooks where title='"+id.panel('options').title+"'";
				source=myRunSelectSql('',sql);
				//console.log(id.panel('options'));
				id.append(source[0].notes);
				//console.log(id);
				data="mybase/book"+source[0].sysid+".pdf";
				//在右上角区域显示pdf文件
				$('#middle').panel('clear');
				var str='<object data="'+data+'" type="application/pdf" width="100%" height="100%" >\n';
				str+='</object>';
				//swf ,,application/x-shockwave-flash, x-mplayer2
				$('#middle').append($(str));
			}
		
		});
		var id=$("#accor").accordion('getSelected');
		var sql="select notes from books where title='"+id.panel('options').title+"'";
		source=myRunSelectSql('',sql);
		id.append(source[0].notes);
	});
/*function fn_add(){
	$("#myWin1").window('open');
}
function fn_delete(){
	var id=$("#accor").accordion('getSelected');
	$('#accor').accordion('remove',id.panel('options').title );
}*/
</script>
</body>
</html>