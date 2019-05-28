<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	//String path=getServletContext().getRealPath("/"); 
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
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
    <script type="text/javascript" src="jqeasyui/fusioncharts/fusioncharts.js"></script>
	<script type="text/javascript" src="system/easyui_functions.js"></script>
</head>
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
<body style="margin:0px 0px 0px 0px;" data-options="fit:true">
<div class="easyui-layout" data-options="fit:true"> 
	<div id='toolbar' class='easyui-panel' data-options="region:'north'" style="overflow:hidden; background-color: #E0ECFF; height:50px; padding: 8px 1px 0px 12px;">
		<div id="tspan1" style="position:absolute; left:0px; top:0px; width:500px; float:left"></div>
		<div id="tspan2" style="position:relative; top:0px; width:550px; float:right"></div>
		<iframe id="mainframe" width="100%" height="100%" src="design_pagehome.jsp" frameborder="no" border="0" style="overflow-y:hidden; margin:0px 0px 0px 0px; padding:0px 0;"></iframe>
	</div>
	<div id="main" class="easyui-panel" data-options="region:'center'" style="position:relative; overflow:auto; width:1200px; margin:1px 1px 1px 1px;">
		<div id="pie1"></div>
		<div id="pie2"></div>
		<div id="chartdiv1" style="text-align:center"></div>
	</div>
</div>    
<script>
$(document).ready(function(){
	$("#pie1").css(myTextCss('main',40,2,300,490));
	$("#pie2").css(myTextCss('main',40,500,300,490));
	$("#chartdiv1").css(myTextCss('main',340,5,400,600));
	myComboField('rank1','main','选择图书库存前:',115,10,145,0,60,'10;20;30;40;50','','');	
	myComboField('rank2','main','选择借阅量排名前:',115,10,635,0,60,'10;20;30;40;50','','');	
	myLabel('rankx1','main','位客户',10+4,332);	
	myLabel('rankx2','main','位客户',10+4,822);	
	myWindow('myGridWin1','钻取图书借阅情况',220,200,470,366,'','close;drag');
	myWindow('myGridWin2','钻取图书分部情况',0,0,595,455,'','close;drag');
	//myWindow('myChartWin1','利润率（％）',320,640,285,280,'','drag;close');
	fnGenTwoPieChart2();  //打开页面就作图
	//fnDrillDownColumnLineChart('');  //第一个图的钻取
	myhref("btnexample","tspan1",'',8,10,0,0,'#','blank');
		myhref("btncode","tspan2",'源码下载',0,255,0,0,'#','');
		myhref("btnaol","tspan2",'用户登录',0,340,0,0,'design_login.jsp','');
		myhref("btnhome","tspan2",'主页',0,425,0,0,'design_pagehome.jsp','');
		myhref("btnprog","bspan1",'',8,100,0,0,'#','blank');
		//myTextField('searchtext','bspan2','站内搜索：',70,3,0,0,300,'','');
		
 		$('#searchtext').textbox({
			buttonIcon:'locateIcon',
            onClickButton: function(e){
            	fn_search();
			}
		});		
		
 		$('#btncode').click(function(e){
 			fnDownLoad(); 		
 		});  
	$("#cmdok").bind('click',function(e){
		$("#myGridWin1").window("close");
		$("#myGridWin2").window("close");
		fnGenTwoPieChart2;  //文件名区分大小写');
	});
	
	function fnGenTwoPieChart2(){
		//取日期区间
		var date1=myDateboxValue('datefrom','');
		var date2=myDateboxValue('dateto','');
		//计算销售额和利润额
		var sql="select top "+$("#rank1").textbox("getValue")+" COUNT(b.isbn) as coun1,left(a.categoryid,1) as categoryid from categories a join books b on a.categoryid=b.categoryid ";
		//sql+="\n where orderdate between '"+$("#datefrom").textbox("getValue")+"' and ";
		//sql+=" '"+$("#dateto").textbox("getValue")+"'";
		sql+="\n group by left(a.categoryid,1)";
		sql+="\n order by coun1 desc ";
		var source1=myRunSelectSql(sysdatabasestring, sql);  //将销售额和利润额的数据保存到数组变量
		var pmyChart1={};
		pmyChart1.title="图书库存最大的前"+$("#rank1").textbox("getValue")+"类图书";
		pmyChart1.xAxisName="类别";  //x轴坐标名称
		pmyChart1.yAxisName='库存';  //Y轴坐标名称
		pmyChart1.labelfield='categoryid';  //label标签对应的列名
		pmyChart1.valuefield='coun1';    //value标签对应的列名
		pmyChart1.data=source1;       //图表数据源
		pmyChart1.type='single';       //圆饼图为单序列图表
		pmyChart1.sliced=true;	     //圆饼图展开
		pmyChart1.height=300;     //圆饼图高度
		pmyChart1.width=490;         //圆饼图宽度
		pmyChart1.drilldown='fnDrillDownColumnLineChart(categoryid)';   //向下钻取时调用的js函数名称及参数
		pmyChart1=myGetChartXML(pmyChart1);     //生成圆饼图的xml语句
		myShowFusionChart(pmyChart1,'Doughnut3D','pie1');     //显示圆饼图
		//画圆饼图，先计算每个客户的销售额和利润额
		var sql="select top "+$("#rank2").textbox("getValue")+"  COUNT(a.lendid) as coun2,a.isbn from lends a join books b on b.ISBN=a.isbn  ";
		//sql+="\n join products c on a.productid=c.productid ";
		//sql+="\n where orderdate between '"+$("#datefrom").textbox("getValue")+"' and ";
		//sql+=" '"+$("#dateto").textbox("getValue")+"'";
		sql+="\n group by a.isbn";
		sql+="\n order by coun2 desc ";
		var source2=myRunSelectSql(sysdatabasestring, sql);//将查询结果保存到数组变量source2
		var pmyChart2={};
		pmyChart2.colorset=''; //8EBB07;02BEBE;048F8F;D74B4B904990;5C882B;B5AD0A;018ED6;9E0B10';  //F6C11F';
		pmyChart2.title="\n借阅量最大的前"+$("#rank2").textbox("getValue")+"本书";
		pmyChart2.xAxisName="书";
		pmyChart2.yAxisName='借阅量';
		pmyChart2.labelfield='isbn';
		pmyChart2.valuefield='coun2';
		pmyChart2.data=source2;
		pmyChart2.sliced=true;	
		pmyChart2.height=300;
		pmyChart2.width=490;
		pmyChart2.type='single';
		pmyChart2.drilldown='fnDrillDownCustomerGrid(isbn)'; //钻取时使用的函数和传递的参数
		pmyChart2=myGetChartXML(pmyChart2);
		myShowFusionChart(pmyChart2,'Pie3D','pie2');
	}	
	
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
	function fnDrillDownColumnLineChart(cid){  //向下钻取圆柱折线图
		//一级钻取，客户每月销售额+利润额图
		//var date1=myDateboxValue('datefrom','');
		//var date2=myDateboxValue('dateto','');
		//计算钻取客户每个月的销售额和利润额
		var sql="select COUNT(b.isbn) as coun4,a.categoryname from categories a join books b on a.categoryid=b.categoryid ";
			sql+="\n where ancester like '"+cid+"%'";
			//sql+=" '"+$("#dateto").textbox("getValue")+"'";
			sql+="\n group by a.categoryname";
			sql+="\n order by coun4 desc ";
			var source3=myRunSelectSql(sysdatabasestring, sql);  //将结果集保存到一个数组变量
		var pmyChart3={};
		pmyChart3.title="图书分部图";
		if (cid!=''){  //根据客户编码提取客户名称
			sql="select categoryid,categoryname from categories where categoryid='"+cid+"'";
			var customer=myRunSelectSql(sysdatabasestring, sql);
			pmyChart3.title+="\n"+customer[0].categoryid+customer[0].categoryname;
		}else{
			pmyChart3.title+="\n全部图书";
		}
		pmyChart3.xAxisName="名称";
		pmyChart3.labelfield='categoryname';
		pmyChart3.yAxisName='本';  
		pmyChart3.valuefield='coun4'; //两个序列的列名
		pmyChart3.data=source3;
		pmyChart3.type='multiple';
		pmyChart3.height=0;
		pmyChart3.width=800;
		//pmyChart3.drilldown='fnGenProductGrid(month,"'+cid+'")';  //进行而二级钻取时将月份和客户编码传递给函数
		pmyChart3=myGetChartXML(pmyChart3);
		myShowFusionChart(pmyChart3,'MSColumn3DLineDY','chartdiv1');
		//钻取开始后，关闭三个无关的子窗口
		$("#myGridWin1").window("close");
		$("#myGridWin2").window("close");
		$("#myChartWin1").window("close");
	}
	//钻取报表
	function fnDrillDownCustomerGrid(cid){
		//显示钻取的报表，客户每月销售额+利润额
		//var date1=myDateboxValue('datefrom','');
		//var date2=myDateboxValue('dateto','');
		var sql="select  COUNT(a.lendid) as coun3,b.title from lends a join books b on b.ISBN=a.isbn  ";
		sql+="\n group by b.title";
		//sql+="\n order by coun3 desc ";
		var pmyGrid1={};
		pmyGrid1.id='myGrid1';
		pmyGrid1.parent='myGridWin1';
		pmyGrid1.staticsql=sql;
		pmyGrid1.activesql=pmyGrid1.staticsql;
		pmyGrid1.gridfields='[@c#230]Title/title;[%n90]借阅量/coun3';
		pmyGrid1.fixedfields='';
		pmyGrid1.title=''; //不显示标题
		pmyGrid1.checkbox=''; //'single';
		pmyGrid1.pagesize=20;
		pmyGrid1.keyfield='title';
		pmyGrid1.sortfield='';
		pmyGrid1.rownumbers=true;
		pmyGrid1.collapsible=false;
		pmyGrid1.height=400;
		pmyGrid1.width=400;
		pmyGrid1.top=32;
		pmyGrid1.left=3;
		pmyGrid1.rowindex=0;
		$("#myGridWin1").empty();
		//var sql="select isbn,title from books where isbn='"+cid+"'";
		//var book=myRunSelectSql(sysdatabasestring, sql);
		myLabel('xcustomer1','myGridWin1','图书借阅量',8,8);
		//体用函数定义myGrid1
		myGrid(pmyGrid1);
		myLoadGridData(pmyGrid1,1); //显示grid数据
		$("#myGridWin1").window("open");
	//计算客户利润率，画仪表盘
	}


	String.prototype.getWidth = function(fontSize){  
	    var span = document.getElementById("__getwidth");  
	    if (span == null) {  
	        span = document.createElement("span");  
	        span.id = "__getwidth";  
	        document.body.appendChild(span);  
	        span.style.visibility = "hidden";  
	        span.style.whiteSpace = "nowrap";  
	    }  
	    span.innerText = this;  
	    span.style.fontSize = fontSize + "px";  
	    return span.offsetWidth;  
	}  
	
</script>
</body>
</html>