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
	<style>
	</style>
</head>
<body style="margin: 2px 2px 2px 2px;">
	<div id="main" class="easyui-layout" data-options="fit:true" style="margin:2px 2px 2px 2px;">
		<div id="torbar" class="easyui-panel" data-options="region:'north'" style="height:30px;">
			<a href="#" class="btn-separator"></a>
			<a href="#" id="btnadd" xtype="button" class="easyui-linkbutton" data-options="iconCls:'addIcon', plain:true, onClick:fn_add" style="">新增</a>
			<a href="#" class="btn-separator"></a>
			<a href="#" id="btnsave" xtype="button" class="easyui-linkbutton" data-options="iconCls:'saveIcon',plain:true, onClick:fn_save" style="">保存</a>
			<a href="#" class="btn-separator"></a>
			<a href="#" id="btndelete" xtype="button" class="easyui-linkbutton" data-options="iconCls:'deleteIcon',plain:true, onClick:fn_delete" style="">删除</a>
			<a href="#" class="btn-separator"></a>
			<a href="#" id="btnedit" xtype="button" class="easyui-linkbutton" data-options="iconCls:'editIcon',plain:true,onClick:fn_edit" style="">修改</a>
			<a href="#" class="btn-separator"></a>
			<a href="#" id="btnrefresh" xtype="button" class="easyui-linkbutton" data-options="iconCls:'refreshIcon',plain:true, onClick:fn_refresh" style="">刷新</a>
		</div>
		<div id="lefttree" class="easyui-panel" data-options="region:'west',split:true" style="width:260px;"></div>
		<div id="rightgrid" class="easyui-panel" data-options="region:'center',split:true" style="">
			<div id="right" class="easyui-layout" data-options="fit:true" style="margin:2px 2px 2px 2px;">
				<div id="grid" class="easyui-panel" data-options="region:'north',split:true" style="height:325px;"></div>
				<div id="mform" class="easyui-panel" data-options="region:'center',split:true" style=""></div>
			</div>
		</div>
	</div>
<script>
	var now = new Date();
	today = now.getFullYear()+'-'+(now.getMonth()+1)+'-'+now.getDate();
	console.log(today);
	var pmyGrid1={};
	var form='isbn;title;author;pubname ;pubdate ;unitprice;pubid;categoryid;categoryname ;notes';
	$(document).ready(function(){
	//var pmyGrid1={};
		pmyGrid1.id='myGrid1';
		pmyGrid1.parent='grid';
		pmyGrid1.staticsql="select isbn,title,author,b.pubname,pubdate,unitprice from books a";
		pmyGrid1.staticsql+="join pubs b on a.pubid=b.pubid ";
		pmyGrid1.gridfields="[@c%c#280]图书名称/title;[@c%c#180,2]作者/author;[@c%c#140]出版社/pubname;"+
		"[%d#110@c]出版时间/pubdate;[@c%d#110]单价/unitprice";	
		pmyGrid1.fixedfields='[@l%c#130]图书编号/isbn';
		pmyGrid1.title='';
		pmyGrid1.menu='myMenu2';
		pmyGrid1.checkbox='single';
		pmyGrid1.pagesize=10;
		pmyGrid1.keyfield='isbn';
		pmyGrid1.rownumbers=true;
		pmyGrid1.collapsible=true;
		pmyGrid1.height=310;
		pmyGrid1.width=0;
		pmyGrid1.rowindex=0;
		//定义grid
		myGrid(pmyGrid1);
		
		var jqsql={};  //sql语句中不能有双引号
		jqsql.catename="select categoryid+categoryname as 'text',categoryID,ParentNodeID,Ancester,IsParentFlag,Level from "
		+" (select categoryname ,categoryID,'000' as ParentNodeID,'000#' as ancester,IsParentFlag,Level+1 as level from zz"	
		+" where level=1"
		+" union all"
		+" select categoryname ,categoryID,ParentNodeID,'000#'+Ancester as ancester,IsParentFlag,Level+1 as level from zz"
		+" where level>1"
		+" union all"
		+" select '所有分类','000' ,'','','1','1') as p";
		console.log(jqsql.catename);
		//定义树控件
		//myDBTree( 'myTree1', 'lefttree', '图书分类',0,0,0,0,jqsql.catename,'categoryid',' ',' full');
		var str='<div id="myTree1" class="easyui-tree" style="fit:auto; border: false; padding:5px;"></div>';
		$("#lefttree").append($(str));
		$("#myTree1").tree({
			checkbox: false,
			lines:true,
		});
		$.ajax({
			url: "system/easyui_getAllTreeNodes.jsp",
			data: { database: sysdatabasestring, selectsql: jqsql.catename, keyfield:'categoryid', sortfield:'' }, 
			async: false, method: 'post',    
			success: function(data) {
				var source=eval(data);
				$('#myTree1').tree({ data: source });
				//console.log(source);
			},     
			error: function(err) {     
				console.log(err);     
			}     
		});
		//树的点击效果，显示对应的datagrid表格
		$('#myTree1').tree({  
			onSelect: function(node){
				if (node.isparentflag==0){
					pmyGrid1.activesql="select isbn,title,author,b.pubname ,pubdate ,unitprice from books a join pubs b on a.pubid=b.pubid where a.categoryid like '"+node.categoryid+"%'";
					myLoadGridData(pmyGrid1,1);	
				}
				else {
					pmyGrid1.activesql="select isbn,title,author,b.pubname ,pubdate ,unitprice from books a ";
					pmyGrid1.activesql+="join pubs b on a.PubID=b.pubid ";
					pmyGrid1.activesql+=" join (select categoryname ,categoryID,'000' as ParentNodeID,'000#' as ancester,IsParentFlag,Level+1 as level from zz";
					pmyGrid1.activesql+=" where Level=1 ";
					pmyGrid1.activesql+=" union all ";
					pmyGrid1.activesql+=" select categoryname ,categoryID,ParentNodeID,'000#'+Ancester as ancester,IsParentFlag,Level+1 as level from zz";
					pmyGrid1.activesql+=" where Level>1 ";
					pmyGrid1.activesql+=" union all ";
					pmyGrid1.activesql+=" select '所有分类' ,'000' ,'','','1','1') as p on a.categoryid=p.categoryid where p.ancester like '%"+node.categoryid+"%' ";
					myLoadGridData(pmyGrid1,1);	
				}
			
			}
		});
		$('#myTree1').tree({  //双击展开或收缩结点
			onDblClick: function(node){
				if (node.state=='closed') $(this).tree('expand', node.target);
				else $(this).tree('collapse', node.target);
			}
		});
		
		//表单定义
		myWindow('myWin1','编辑节点',0,0,170,355,'save;cancel','close;drag;modal');
		myTextField('areaid','myWin1','图书编码：',70,33*0+14,18,0,232,'','');
		myTextField('areaname','myWin1','图书名称：',70,33*1+14,18,0,232,'','');
		myMenu('myMenu1','新增结点/mnaddnode/addIcon;新增子结点/mnaddsubnode/addIcon;修改结点/mneditnode/editIcon;-;删除结点/mndeletenode/deleteIcon','');
		myMenu('myMenu2','新增节点/mnadd/addIcon;修改节点/mnedit/editIcon;-;删除/mndelete/deleteIcon;-;刷新/mnrefresh/refreshIcon','');
		myForm('myForm1','mform','编辑图书信息',0,20,290,700,'close;collapse;min;max');
		myFieldset('myFieldset1','myForm1','图书信息',010,10,295,310);
		myFieldset('myFieldset2','myForm1','图书简介',010,330,295,305);
		myTextField('isbn','myFieldset1','图书编码：',95,33*0+20,12,0,120,'');
		myTextField('title','myFieldset1','图书名称：',95,33*1+20,12,0,160,'');
		myTextField('categoryid','myFieldset1','所属类别：',95,33*2+20,12,0,120,'');
		myTextField('categoryname','myFieldset1','类别名称：',95,33*3+20,12,0,160,'');
		myTextField('author','myFieldset1','作者：',95,33*4+20,12,0,160,'');
		myComboField('pubname','myFieldset1','出版社：',95,33*5+20,12,0,160,'','');
		myDateField('pubdate','myFieldset1','出版日期：',95,33*6+20,12,0,90,'');
		myTextField('unitprice','myFieldset1','单价：',95,33*7+20,12,0,90,'');
		myMemoField('notes','myFieldset2','',0,33*0+20,12,260,273,'');
		myHiddenFields('addoredit');
		//出版社下拉框
		var xsql="select pubid,pubname from pubs ";
   		var source=myRunSelectSql('',xsql);
   		//console.log(source);
   		$("#pubname").combobox({
			panelHeight: 120,
			data:source,
			valueField: 'pubname',
			textField: 'pubname'
		});
   		//定义图书类别按钮
 		$("#categoryid").textbox({
 			buttonIcon:'helpIcon',
            onClickButton: function(e){
				var xsql="select categoryname from zz where categoryid='"+$("#categoryid").textbox("getValue")+"'";
				$.ajax({
					url: "system/easyui_execSelect.jsp",
					data: { database: sysdatabasestring, selectsql:xsql }, 
					async: false,    
					success: function(data) {
						eval("var result="+data);
						$("#categoryname").textbox("setValue",result[0].categoryname); 
					},     
					error: function(err) {     
						console.log(err);     
					}     
				});
			}
 		});
 		mySetReadonly(form,true);
		//右键菜单
 		$('#myTree1').tree({  
			onContextMenu: function (e, title) {
				e.preventDefault();
				$("#myMenu1").menu('show', {
					left: e.pageX,
					top: e.pageY
				});
			}
		});
		//网格菜单结构和实现：新增、插入、删除、重置、保存
		$("#mnadd").bind('click', function(e){
			fn_add();
		});
		$("#mnedit").bind('click', function(e){
			fn_edit();
		});
		$("#mndelete").bind('click', function(e){
			fn_delete();
		});
		$("#mnrefresh").bind('click', function(e){
			fn_refresh();
		});
		//树菜单结构和实现：新增结点、新增子节点、删除结点、修改结点
		$("#mnaddnode").bind('click', function(e){ //新增兄弟节点;
			$("#areaid").textbox('setValue','');
			$("#areaname").textbox('setValue','');
			$("#myWin1").window({title: '新增节点'});
			$("#myWin1").window('open');
		});
		$("#mnaddsubnode").bind('click', function(e){ //新增子节点;
			//获取树中当前节点
			$("#areaid").textbox('setValue','');
			$("#areaname").textbox('setValue','');
			$("#myWin1").window({title: '新增子节点'});
			$("#myWin1").window('open');
		});
		
		$("#mneditnode").bind('click', function(e){ //修改节点;
			//获取树中当前节点
			var node=$("#myTree1").tree('getSelected');
			if (node!=null){
				$("#areaid").textbox('setValue',node.id);
				$("#areaname").textbox('setValue',node.text);
				$("#myWin1").window({title: '修改节点'});
				$("#myWin1").window('open');
			}
		});

		$("#myWin1SaveBtn").bind('click', function(e){ //点击窗体中的保存按钮
			var options=$("#myWin1").window('options');
			var action=options.title;
			var xid=$("#areaid").textbox('getValue');
			var xname=$("#areaname").textbox('getValue');
			var node=$("#myTree1").tree('getSelected');
			if (action=='修改节点'){
				node.id=xid;
				node.text=xname;
				$("#myTree1").tree('update',node);  //刷新树结点
			}else if (action=='新增节点'){
					var node=$("#myTree1").tree('getSelected'); //获取树中当前节点
					var pnode=$("#myTree1").tree('getParent', node.target); //求节点的父节点
					$("#myTree1").tree('append',{
						parent:pnode.target,
						data:{ id:xid, text:xname }
					});	
			}else if (action=='新增子节点'){
				var pnode=$("#myTree1").tree('getSelected'); //获取树中当前节点
				$("#myTree1").tree('append',{
					parent:pnode.target,
					data:{ id:xid, text:xname }
				});
			}
			$("#myWin1").window('close');
		});
		
		$("#mndeletenode").bind('click', function(e){ //删除节点;
			//获取树中当前节点
			var node=$("#myTree1").tree('getSelected');
			if (node!=null){
				var pnode=$("#myTree1").tree('getParent');
				var cnodes=$("#myTree1").tree('getChildren');
				alert(cnodes.length);  //cnodes[n]
				$("#myTree1").tree('remove',node.target);
			}
		});
		//取消按钮
		$("#myWin1CancelBtn").bind('click', function(e){
			$("#myWin1").window('close');
		});//菜单结束
		$("#myTree1").tree('collapseAll');
		node=$("#myTree1").tree('getRoot');
		$("#myTree1").tree('select',node.target);
		//数据验证开始
		$("#isbn").textbox({
			validType:"integer"	//自定义验证规则名，下同	
		});
		$("#pubdate").datebox({
			validType:"date"		
		});
		$("#title").textbox({
			validType:"CHS"		
		});		
		
	});
    function fnonSelectCombo(id,record){
    	//console.log(record);
    }
	$.extend($.fn.validatebox.defaults.rules, {
		date: {
			validator: function(value, param){
				var now = new Date();
				var d1 = new Date('1949-10-01');
				var d2 = new Date(now.getFullYear(), now.getMonth(), now.getDate());
				var today = now.getFullYear()+'-'+now.getMonth()+'-'+now.getDate();
				return d1<=new Date(value) && new Date(value)<=d2;
				//var d1 = $.fn.datebox.defaults.parser(param[0]);
                   //var d2 = $.fn.datebox.defaults.parser(value);
                   //return d2<=d1;
               },
               message: '出版日期必须在1949-10-01与'+today+'之间！'
           },
		/*CHS:{  //验证汉字
			validator:function(value){
				return /^[\u0391-\uFFE5]+$/.test(value);
			},
			message:"图书名称只能输入汉字！"
		},*/
		integer : {// 验证整数 
			validator : function(value) { 
				return /^[+]?[1-9]+\d*$/i.test(value) || '-'; 
			}, 
			message : '图书编码只能输入数字！' 
		}, 	             
	});
	//数据验证结束
	function fn_delete(){
			//快速连续点击删除时，会有错误提示，原因是删除后选中行的问题
			var rows=$("#myGrid1").datagrid('getRows');
			var keyvalue=$("#myGrid1").datagrid('getSelected').isbn;
			//console.log(row);
			if (rows.length>0){ 
				$.messager.confirm('系统提示','删除图书编码'+keyvalue+"<br>是否确定？",function(r){
					if (r){
			            $('#myGrid1').datagrid('deleteRow', pmyGrid1.rowindex);
						if (pmyGrid1.rowindex>rows.length-1 && rows.length>0){
							pmyGrid1.rowindex--;  //选中上一行，否则自动选下一行
						}
						$("#myGrid1").datagrid('selectRow', pmyGrid1.rowindex);//选中下一行
						}
				});
			}else{
				myMessagebox('系统提示','记录已经全部被删除！');
			}
		}
	function fn_add(){
		mySetFormValues(form,null);
  		mySetReadonly('',false);
		$("#myGrid1").datagrid('insertRow', { //插入一行到最前行
			index: 0,
			row: {rownumber:"-1"}
		});
		pmyGrid1.rowindex = 0;	
		$("#addoredit").val('add');  //新增记录
		//$("#myGrid1").datagrid('beginEdit', 0);
		//$("#myGrid1").datagrid('selectRow', 0);	
	}
	function fn_edit(){
		mySetReadonly(form,false);
  		$("#isbn").textbox('readonly',true);  //新增记录
  		$("#addoredit").val('edit');  //修改记录
	}
	function fn_save(){  //保存记录
		var addoredit=$("#addoredit").val();
    	var flag=fnValidation(addoredit);
    	mySetReadonly(form,true);
    	var a=[];
    	var asql="select pubid from pubs where pubname='"+$("#pubname").combobox('getValue')+"'";
    	a=myRunSelectSql('',asql);
		//var result=myRunSelectSql(sysdatabasestring,sql);
    	console.log(a);
    	if (flag==1){
    		if (addoredit=='edit'){
    			
    			var sql="update books set ";
    			sql+="isbn='"+$("#isbn").textbox('getValue')+"',";
    			sql+="title='"+$("#title").textbox('getValue')+"',";
    			sql+="categoryid='"+$("#categoryid").textbox('getValue')+"',";
    			sql+="author='"+$("#author").textbox('getValue')+"',";
    			sql+="pubid='"+a[0].pubid+"',";
    			sql+="pubdate='"+$("#pubdate").datebox('getValue')+"',";
    			sql+="unitprice="+$("#unitprice").textbox('getValue')+",";
    			sql+="notes='"+$("#notes").val()+"'";
    			sql+=" where isbn='"+$("#isbn").textbox('getValue')+"'";
    		}else{  //add new record
    			var sql="insert into books (isbn,title,categoryid,author,pubid,pubdate,unitprice,notes) values(";
    			sql+="'"+$("#isbn").textbox('getValue')+"',";
    			sql+="'"+$("#title").textbox('getValue')+"',";
    			sql+="'"+$("#categoryid").textbox('getValue')+"',";
    			sql+="'"+$("#author").textbox('getValue')+"',";
    			sql+="'"+a[0].pubid+"',";
    			sql+="'"+$("#pubdate").datebox('getValue')+"',";
    			sql+="'"+$("#unitprice").textbox('getValue')+"',";
    			sql+="'"+$("#notes").val()+"'";
    			sql+=")";
    		}
  			var result=myRunUpdateSql(sysdatabasestring,sql);
   			if (result.error==''){
   				fnRefresh();
   				$("#addoredit").val('edit');
   			}
    	}
    }
	//点击新增记录
	
	function fn_refresh(){
		$("#myTree1").tree('update',node); 
		$("#myTree1").tree('collapseAll');
		node=$("#myTree1").tree('getRoot');
		$("#myTree1").tree('select',node.target);
		$("#myGrid1").datagrid('selectRow', 0);
	}
	
	function fnValidation(addoredit){
		var errormsg=[];  //存放数据验证发现的错误信息
		//先判断各个控件是否符合格式要求
		if (!$("#isbn").textbox('isValid')) errormsg.push('图书编码输入错误！');
		//判断其他逻辑
		var s1=$("#isbn").textbox('getValue');
		var s2=$("#categoryid").textbox('getValue');
		var s3=$("#pubname").combobox('getText');
		//var s4=$("#city").combobox('getText');
		if (s1.length==0) errormsg.push('图书编码不能为空！');
		if (s2.length==0) errormsg.push('图书类别不能为空！');
		if (addoredit=='add'){
			//新增记录才需要验证编码是否重复 
			var sql="select * from books where isbn='"+s1+"'";
			var result=myRunSelectSql(sysdatabasestring,sql);
			if (result.length>0){
				errormsg.push('图书编码重复！');
			}
		}
		//验证图书类别和出版社是否存在
		var sql1="select categoryid from categories where categoryid='"+s2+"'";  
		var result1=myRunSelectSql(sysdatabasestring,sql1);
		if (result1.length==0){
			errormsg.push('图书类别输入错误！');
		}else{
			var sql2="select 1 as n from pubs where pubname='"+s3+"'";  
			var result2=myRunSelectSql(sysdatabasestring,sql2);
			if (result2.length==0){
				errormsg.push('出版社名称输入错误！');
			}
		}
		//数据验证结束
		if (errormsg.length==0){
			return(1);
		}else{	
			myMessage('数据验证发现下列错误，提交失败！@n'+errormsg);
			return(0);
		}
	}  //fn	
	
	function myGridEvents(id,event){
		//alert(event);
		e=event.toLowerCase();
		if(e=='onclickcell'||e=='onselect'){
			var row=$("#myGrid1").datagrid("getSelected");
			var sql="select a.isbn,a.title,a.author,b.pubname ,a.pubdate ,a.unitprice,a.pubid,"
			+"c.categoryid,c.categoryname ,a.notes from books a join pubs b on a.pubid=b.pubid "
			+"join zz c on a.categoryid=c.categoryid where a.isbn='"+row.isbn+"'";
			var source=[];
			source=myRunSelectSql('',sql);
			console.log(source);
			$.each(source[0], function(id, value) {  //将json数据复制到表单
				var input = $("#"+id);
				var type=input.attr('type');
				if (input!=undefined){
					if (type=='text'){ 
						input.textbox('setValue',value);
					}else if (type=='combobox'){ 
						input.combobox('setValue',value);
					}else{
						input.val(value);			
					}
				}//if	
			});//each
		}
			
	}
</script>
</body>
</html>