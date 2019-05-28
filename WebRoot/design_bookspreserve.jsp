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
	<div id="torbar" class="easyui-panel" data-options="region:'north'" style="height:220px;"></div>
	<div id="grid" class="easyui-panel" data-options="region:'center',split:true" style=""></div>
</div>
<script>
	var form='isbn;title;author;pubname ;pubdate ;unitprice;pubid;categoryid;categoryname ;notes';
	var pmyGrid1={};
	$(document).ready(function(){
		var sql="select isbn,title,author,b.pubname ,pubdate ,unitprice from books a join pubs b on a.pubid=b.pubid where"; 
	//	var pmyGrid1={};
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
		myForm('myForm1','torbar','数据库连接与数据检索',0,0,'100%','100%','');
		myTextareaField('sqlstmt','myForm1','查询语句：',0,10,8,100,675,'','');
		//myTextareaField('result','myForm1','查询结果：',0,115,8,155,575,'','');
		myButton('cmdquery','myForm1','运行SQL',150,430,25,75,'','');
		myButton('cmdreset','myForm1','清空',150,506,25,70,'','');
		myMenu('myMenu2','新增节点/mnadd/addIcon;修改节点/mnedit/editIcon;-;删除/mndelete/deleteIcon;-;刷新/mnrefresh/refreshIcon','');
		//myWindow('myWin1','编辑节点',0,0,170,355,'save;cancel','close;drag;modal');
		myWindow('myWin1','编辑图书信息',0,0,490,700,'save;cancel','close;drag;modal');
		myFieldset('myFieldset1','myWin1','图书信息',010,10,295,310);
		myFieldset('myFieldset2','myWin1','图书简介',010,330,295,305);
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
		$("#myWin1SaveBtn").bind('click', function(e){ 
			fn_save();
		});
		//取消按钮
		$("#myWin1CancelBtn").bind('click', function(e){
			$("#myWin1").window('close');
		});//菜单结束
		$("#sqlstmt").val(sql);
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
		//
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
	function fn_add(){
		$("#myWin1").window('open');
		mySetFormValues(form,null);
  		mySetReadonly('',false);
		$("#myGrid1").datagrid('insertRow', { //插入一行到最前行
			index: 0,
			row: {rownumber:"-1"}
		});
		pmyGrid1.rowindex = 0;	
		$("#addoredit").val('add');  //新增记录
		//
	}
	function fn_edit(){
		$("#myWin1").window('open');
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
    	$("#myWin1").window('close');
    }
	//点击新增记录
	
	function fn_refresh(){
		myLoadGridData(pmyGrid1,1);
		$("#myGrid1").datagrid('selectRow', 0);
	}
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