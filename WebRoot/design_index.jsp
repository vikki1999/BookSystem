<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	//String path=getServletContext().getRealPath("/"); 
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!doctype html>
<html lang="en">
<style type="text/css">
	.bg { background-color:red }
</style>
<head>
	<title>图书管理系统</title>
	<meta charset="utf-8">
	<link rel="stylesheet" type="text/css" href="jqeasyui/themes/default/easyui.me.css">
	<link rel="stylesheet" type="text/css" href="jqeasyui/themes/icon.css">
    <link rel="stylesheet" type="text/css" href="system/css/icon.css">
    <script type="text/javascript" src="jqeasyui/jquery.min.js"></script>
    <script type="text/javascript" src="jqeasyui/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="jqeasyui/easyui-lang-zh_CN.js"></script>	
	<script type="text/javascript" src="system/easyui_functions.js"></script>
</head>
<body style="margin:1px 1px 1px 1px; padding:0px 0px 0px 0px; ">
<div id='main' class="easyui-layout" data-options="fit:true" style="margin:0px 0px 0px 0px;">
	<div id='toolbar' class='easyui-panel' data-options="region:'north'" style="overflow:hidden; background-color: #E0ECFF; height:30px; padding: 8px 1px 0px 12px;">
		<div id="tspan1" style="position:absolute; left:0px; top:0px; width:500px; float:left"></div>
		<div id="tspan2" style="position:relative; top:0px; width:550px; float:right"></div>
	
	</div>
	<div id='left' data-options="region:'west',split:true, title:'tree'" style="width:190px;"></div>
	<div id='right' data-options="region:'center'" style="overflow:hidden; margin:0px 0px 0px 0px; padding: 0px 0px 0px 0px; ">
		<iframe id="mainframe" width="100%" height="100%" src="design_manage.jsp" frameborder="no" border="0" style="overflow-y:hidden; margin:0px 0px 0px 0px; padding:0px 0;"></iframe>
	</div>
	
</div>    
<script>
	pmyTree1={};
	var basepath='<%=basePath %>';
	$(document).ready(function(){
		rowheight=systext.rowheight+4;
		curnode=null;  //记录新增的临时结点
		keyfield='id';
		keyvalue='';
		keyspec='图书馆理系统';
		tablename='homepage';
		nodefields="id;title";
		pmyTree1.id='myTree1';
		pmyTree1.parent='left';
		pmyTree1.keyfield='id';
		pmyTree1.sql="select title as text,RIGHT(str(100+id,3),2) as id,url,0 as isparentflag,2 as level,"+
		"cast(chapter as varchar(2)) as parentnodeid,"+
		"cast(chapter as varchar(2))+'#' as ancester from homepage "+
		"union all "+
		"select distinct '第'+CAST(chapter as varchar(2))+'章' as text,cast(chapter as varchar(2)),'',1,1,'','' from homepage";
		//console.log(pmyTree1.sql);
		//alert(9);
		pmyTree1.title='8787979';
		pmyTree1.sortfield='';
		pmyTree1.editable=false;
		pmyTree1.style='full';
		pmyTree1.line=true;
		pmyTree1.width=0;
		pmyTree1.height=0;
		pmyTree1=myDBTree(pmyTree1);		
		$("#left").panel({ title:'图书管理系统'});
		myhref("btnexample","tspan1",'',8,10,0,0,'#','blank');
		myhref("btncode","tspan2",'源码下载',0,255,0,0,'#','');
		myhref("btnaol","tspan2",'用户登录',0,340,0,0,'design_login.jsp','blank');
		myhref("btnhome","tspan2",'主页',0,425,0,0,'design_pagehome.jsp','');
		
		
		//myLabel("btnprogx","bspan1",'正在运行程序：',8,10,0,0);
		//myhref("btnprog","bspan1",'',8,100,0,0,'#','blank');
		//myTextField('searchtext','bspan2','站内搜索：',70,3,0,0,300,'','');
		
 		/*$('#searchtext').textbox({
			buttonIcon:'locateIcon',
            onClickButton: function(e){
            	fn_search();
			}
		});		
		*/
 		$('#btncode').click(function(e){
 			fnDownLoad(); 		
 		});
 		var item = $('#myTree1').tree('getRoot');
		var cnodes=$('#myTree1').tree('getChildren',item.target);
		//console.log(cnodes);
		//console.log(cnodes);
		$("#myTree1").tree('select', cnodes[0].target);
		//---------------------end of jquery------------------------
	});
	function fnDownLoad(){
		//var url=$("#progname").textbox("getValue");  //$("#btnexample").attr("href");
		var url=$("#mainframe").attr('src');
		//alert(url);
		var targetfile=url+'.txt';
		window.location.href='system//easyui_fileDownLoad.jsp?source='+url+'&target='+targetfile;
	}
	function fn_search(){
		
	}
	
	function myTreeEvents(id,e,node){
		if (e=='onselect'){
			if (node){
				//判断登录是用户，取消管理功能
				var url=node.url;
				var sql="select * from bm_users where leavedate=''";
				var result=[];
				result=myRunSelectSql('',sql);
				
				if(result.length>0){
					if(node.id==3 || node.id==1 || node.id==6 || node.id==7 || node.id==13){
						url=node.url;		
					}else{
						$.messager.alert('系统提示','您没有这个权限','error');
						url='';
					}
				}
				//console.log(dateadd(mySysDateTime('datetime'),-1));
				
				if (url!=''){
					$("#mainframe").attr('src', url);
					//定义程序超链接
					$("#btnexample").text(node.text);
					$("#btnprog").text(node.url);
					$("#btnprog").attr("href",basepath+node.url); 
				} 
			}
		}
	}
</script>
</body>
</html>