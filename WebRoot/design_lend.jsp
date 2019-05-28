<%@ page language="java" import="java.util.*" contentType="text/html;charset=utf-8"  language="java"  pageEncoding="UTF-8" %>
<!doctype html>
<html>
<style type="text/css">
</style>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<link rel="stylesheet" type="text/css" href="jqeasyui/themes/default/easyui.me.css">
	<link rel="stylesheet" type="text/css" href="jqeasyui/themes/icon.css">
    <link rel="stylesheet" type="text/css" href="system/css/icon.css">
    <script type="text/javascript" src="jqeasyui/jquery.min.js"></script>
    <script type="text/javascript" src="jqeasyui/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="jqeasyui/easyui-lang-zh_CN.js"></script>	
	<script type="text/javascript" src="system/easyui_functions.js"></script>
	<script type="text/javascript" src="system/easyui_html5media.js"></script>
</head>
<body>

<div id="main" style="width:1024px;height:500px;">
	<div id="layout" class="easyui-layout" data-options="fit:true" style="margin: 1px 1px 1px 1px;">
        <div id='left' data-options="region:'west',split:true" style="width:500px;height:400px;">
        	
        </div>
        <div id="right" data-options="region:'center'" style="">
            <div id="tab" class="easyui-tabs"  style="overflow: auto; width:480px; height:480px;">
            	<div id="myForm2" title="图书信息" style="position:relative; overflow:auto;"></div>
            	<div id="myForm3" title="借阅信息" style="position:relative; overflow:auto;"></div>
            </div>
        </div>
    </div> 	
 	    
</div>  
<script>
	$(document).ready(function(){
		var date1=mySysDateTime('date');
		var date2=dateadd(mySysDateTime('date'),30);
		//myForm('myForm1','main','学生信息编辑',0,0,540,1024,'min;max;close;');
		//myForm('myForm2','tab','基本信息',0,0,340,600,'');
		//myForm('myForm3','tab','学生简介',0,0,340,600,'');
		myFieldset('myFieldset1','myForm2','',10,10,400,405);
		myFieldset('myFieldset2','myForm3','',10,10,400,405);
		//myTextareaField('','left','',0,63,8,375,445,'','');
		myFieldset('datalist','left','',63,18,375,445,'');
		//myTextareaField('introduction','myForm3','',0,20,8,375,475,'','');
		myTextField('isbn','myFieldset1','图书编码：',95,33*0+20,12,0,120,'');
		myTextField('title','myFieldset1','图书名称：',95,33*1+20,12,0,260,'');
		myTextField('categoryid','myFieldset1','所属类别：',95,33*2+20,12,0,120,'');
		myTextField('categoryname','myFieldset1','类别名称：',95,33*3+20,12,0,230,'');
		myTextField('author','myFieldset1','作者：',95,33*4+20,12,0,160,'');
		myComboField('pubname','myFieldset1','出版社：',95,33*5+20,12,0,160,'','');
		myDateField('pubdate','myFieldset1','出版日期：',95,33*6+20,12,0,90,'');
		//myTextField('unitprice','myFieldset1','单价：',95,33*7+20,12,0,90,'');
		myMemoField('notes','myFieldset1','图书简介',0,33*7+20,12,100,330,'');
		myTextField('counts','myFieldset2','库存：',95,33*0+20,42,0,120,'');
		myDateField('lenddate','myFieldset2','借阅日期：',95,33*1+20,42,0,120,date1);
		myDateField('diedate','myFieldset2','截止日期：',95,33*2+20,42,0,120,date2);
		myTextField('userid','myFieldset2','用户编码：',95,33*3+20,42,0,120,'');
		myTextField('password','myFieldset2','服务密码：',95,33*4+20,42,0,120,'');
		myButton('lend','myFieldset2','借阅',33*6+20,58,35,120);
		myComboField('category','left','图书类别：',70,20,32,0,230,'','');
		var str='<div id="data" class="easyui-datalist" style="position:absolute;top:0px;left:16px;"></div>';
		console.log(str);
		$("#datalist").append($(str));
		
		var xsql="select categoryname as category,categoryid from categories where level=1";
		source=myRunSelectSql('',xsql);
		//console.log(source);
		$("#category").combobox({
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
					data:source1,
					textField:'data',
					valueField:'data'
				});
			}
		});
		$('#category').combobox('select',source[0].category);
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
		$("#data").datalist({
			checkbox:true,
			height:380,
			onSelect:function(index,x){
				var sql="select a.isbn,a.title,a.author,b.pubname ,a.pubdate ,a.unitprice,a.pubid,"
				+" c.categoryid,c.categoryname ,a.notes, a.counts from books a join pubs b on a.pubid=b.pubid "
				+" join zz c on a.categoryid=c.categoryid " 
				+" where a.title='"+x.title+"'";
				//console.log(sql);
				var source=[];
				source=myRunSelectSql('',sql);
				//console.log(source);
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
				//$("#stuid").textbox('setValue',x.studentid);
			
			}
		});
		$("#lend").click(function(e){
			var s1=$("#userid").textbox('getValue');
			var s2=$("#password").textbox('getValue');
			s2=myToXcode(s2);
			if (s1!=''){
				var sql="select userid,username,password,account,email,mobile,usertype from bm_users where userid='"+s1+"'\n";
				sql+="union all \n";
				sql+="select userid,username,password,account,email,mobile,usertype from bm_mans where userid='"+s1+"'\n";
				console.log(sql);
				var result=myRunSelectSql(sysdatabasestring, sql);
				if (result.length==0){
					myMessage('@n用户账号['+s1+']不存在！','error',0,'');
				}else if(result[0].password!==s2){
					//$.messager.alert('title','msg','info',fn1);
					myMessage('@n用户登录密码输入错误！','warn',280,'');			
				}else{ 
					var sql="insert into lends (isbn,counts,lenddate,returndate,userid) values(";
	    			sql+="'"+$("#isbn").textbox('getValue')+"',";
	    			sql+=""+$("#counts").textbox('getValue')+"-1,";
	    			sql+="'"+$("#lenddate").datebox('getValue')+"',";
	    			sql+="'',";
	    			sql+="'"+$("#userid").textbox('getValue')+"')";
					console.log(sql);
					myRunUpdateSql(sysdatabasestring,sql);
					alert('图书借阅成功！<br>请取书');
				}
			}else{
					myMessage('请输入用户、密码','error',0,'');
				}
					
		});
	
	});



</script>  
</body>
</html>