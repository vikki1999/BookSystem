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
<body>
<div style="margin:0 auto;width:1200px;">
	<div class="easyui-panel" style="width:1200px;height:800px;">
		<header>
			<a href="javascript:void(0)" data-options="plain:true,iconCls:'addIcon'" class="easyui-linkbutton" id="add">新增</a>
			<a href="javascript:void(0)" data-options="plain:true,iconCls:'editIcon'" class="easyui-linkbutton" id="edit">修改</a>
			<a href="javascript:void(0)" data-options="plain:true,iconCls:'saveIcon'" class="easyui-linkbutton" id="save">保存</a>
			<a href="javascript:void(0)" data-options="plain:true,iconCls:'deleteIcon'" class="easyui-linkbutton" id="delete">删除</a>
			<a href="javascript:void(0)" data-options="plain:true,iconCls:'refreshIcon'" class="easyui-linkbutton" id="refresh">刷新</a>
		</header>
		<div class="easyui-layout" data-options="fit:true">
			<div data-options="region:'west',split:true" style="width:260px;">
				<div id="tree" class="easyui-tree">
					
				</div>
			</div>
			<div data-options="region:'center',split:true,fit:true">
				<div id="main" class="easyui-panel" style="height:420px;">
					
				</div>
				<div id="detail" title="编辑学生信息" class="easyui-panel" style="height:360px;">
					<fieldset style="float:left;margin:15px;width:350px;height:260px">
						<legend>基本信息</legend>
						<div style="margin:15px">学生学号:<input id="studentid" type="text" class="easyui-textbox input" /></div>
						<div style="margin:15px">学生姓名:<input id="name" type="text" class="easyui-textbox input" /></div>
						<div style="margin:15px">姓名拼音:<input id="pycode" type="text" readonly="true" class="easyui-textbox input" /></div>
						<div style="margin:15px">性别:　　<input id="gender" type="text" class="easyui-combobox input" /></div>
						<div style="margin:15px">出生日期:<input id="birthdate" type="text" class="easyui-datebox input" /></div>
						<div style="margin:15px">籍贯:　　<input id="province" type="text" style="width:85px" class="easyui-combobox input" /> 省 <input type="text" id="city"  style="width:85px" class="easyui-combobox input" /> 市 </div>
					</fieldset>
					<fieldset style="margin:15px;width:450px;height:260px;">
						<legend>通信信息</legend>
						<div style="margin:10px">家庭地址:<input id="address" readonly="true" type="text" class="easyui-textbox input" /></div>
						<div style="margin:10px">手机号码:<input id="phone" type="text" class="easyui-textbox input" /></div>
						<div style="margin:10px">家庭电话:<input id="homephone" type="text" class="easyui-textbox input" /></div>
						<div style="margin:10px">Email:　 <input id="email" type="text" class="easyui-textbox input" /></div>
						<div style="margin:10px">QQ号:　　<input id="qq" type="text" class="easyui-textbox input" /></div>
						<div style="margin:10px">微信号:　<input id="weixin" type="text" class="easyui-textbox input" /></div>
						<div style="margin:10px">个人主页:<input id="page" type="text" class="easyui-textbox input" /></div>
					</fieldset>
				</div>
			</div>
		</div>
	</div>
</div>
<script>
$(document).ready(function(){
	
	function tab(){
		//姓名判断
		var name=$("#name").textbox("getValue");
		if(name==''){
			$.messager.show({
				title:"系统提示",
				msg:"姓名不能为空",
			});
		}
		//通过正则表达式判断是否输入的为汉字
		for(var i=0;i<name.length;i++){
			if(/[\u4E00-\u9FA5]/g.test(name[i])){
				flag=1;
			}else{
				flag=0;
				$.messager.show({
					title:"系统提示",
					msg:"请输入只含有汉字的姓名",
				});
				break;
			}
		}
		
		//如果全部是汉字，则自动转化为拼音
		if(flag){
			var xsql="select dbo.sys_GenPycode('"+$("#name").textbox("getValue")+"') as pycode";
			$.ajax({
				url: "system/easyui_execSelect.jsp",
				data: { database: sysdatabasestring, selectsql:xsql }, 
				async: false,    
				success: function(data) {
					eval("var result="+data);
					$("#pycode").textbox("setValue",result[0].pycode); 
				},     
				error: function(err) {     
					console.log(err);     
				}     
			});
		}
		
		//在不为空的时候，判断手机号码是否是11位
		phone=$("#phone").textbox("getValue");
		if(phone!='' && phone.length!=11){
			$.messager.show({
				title:"系统提示",
				msg:"请输入11位的手机号码",
			});
		}
		
		//判断输入的11位字符是否全是数字
		if(phone!='' && isNaN(phone)){
			$.messager.show({
				title:"系统提示",
				msg:"请输入只含有数字的手机号码",
			});
		}
		
		//判断家庭电话是否有区号
		homephone=$("#homephone").textbox("getValue");
		if(homephone!=''){
			if(homephone.substring(4,5)!='-'){
				$.messager.show({
					title:"系统提示",
					msg:"请输入4位数的区号按照格式为0000-11111111的格式",
				});
			}else{
				a=homephone.split('-');
				if(a[0].length!=4 || isNaN(a[0])){
					$.messager.show({
						title:"系统提示",
						msg:"请输入4位数字的区号",
					});
				}
				else if(a[1].length!=8 || isNaN(a[1])){
					$.messager.show({
						title:"系统提示",
						msg:"请输入8位数字的电话号码",
					});
				}
			}
		}
		//邮箱验证
		email=$("#email").textbox("getValue");
		if(email!=''){
			a=email.indexOf('@');
			b=email.indexOf('.');
			if(a>=b){
				$.messager.show({
					title:"系统提示",
					msg:"请输入正确的电子邮箱",
				});
			}
		}
		
		//QQ号码验证
		qq=$("#qq").textbox("getValue");
		if(isNaN(qq) && qq!=''){
			$.messager.show({
				title:"系统提示",
				msg:"只含有数字的qq号码",
			});
		}
	}
	
	
	var jqsql={};  
	jqsql.area="select deptname as 'text',* from departments ";
	
	//获取左边树的开始
	$.ajax({
		url: "system/easyui_getAllTreeNodes.jsp",
		data: { database: sysdatabasestring, selectsql: jqsql.area, keyfield:'deptid', sortfield:'' }, 
		async: false, method: 'post',    
		success: function(data) {
			var source=eval(data);
			$('#tree').tree({ 
					data: source,
					lines:true,
				});
		}  
	});
	//获取左边树的结束
	
	
	var pmyGrid1={};
	pmyGrid1.id='myGrid1';
	pmyGrid1.parent='main';
	pmyGrid1.gridfields='[@l%c#90]姓名/name;[@c%c#110,2]拼音/pycode;[%d#90@c]出生日期/birthdate;[@c#100]所属城市/hometown;[@c#100]所属专业/deptname;';
	pmyGrid1.gridfields+='[110]联系电话/mobile;[110]家庭电话/homephone;[140]Email/email;[130]微信号/weixin;[100]QQ号/qq';
	pmyGrid1.fixedfields='[@l%c#90]学号/studentid';
	pmyGrid1.title='学生列表';
	pmyGrid1.menu='myMenu1';
	pmyGrid1.checkbox='single';
	pmyGrid1.pagesize=10;
	pmyGrid1.keyfield='studentid';
	pmyGrid1.rownumbers=true;
	pmyGrid1.collapsible=true;
	pmyGrid1.height=420;
	pmyGrid1.width=940;
	pmyGrid1.rowindex=0;
	
	//树的选择事件
	$("#tree").tree({
		onSelect:function(e){
			var node=$("#tree").tree('getSelected');
			pmyGrid1.staticsql="select StudentID,Name,pycode,case when Gender='f' then '女' else '男' end as gender,";
			pmyGrid1.staticsql+="birthdate,province,city,province+' '+city as hometown,mobile,homephone,email,qq,weixin,'' as personpage,deptname from students";
			pmyGrid1.staticsql+=" a join departments b on a.DeptID=b.deptid where deptname='"+node.text+"'";
			pmyGrid1.staticsql+=" or ancester like '%"+node.id+"#%'";
			pmyGrid1.activesql=pmyGrid1.staticsql;
			$("#studentid").textbox({
				editable:false,
			});
			//通过each方法将值放入下面的fieldset的开始 
			var sc=new Array();   //面向一个对象
			$("#myGrid1").datagrid({
				onBeforeCheck:function(index,row){   //事件
					var i=0;
					
					for(var key in row){		//将json转换为数组
						sc[i]=row[key];
						i++;
					}
					i=1;
					$('.input').each(function(){
						$(this).textbox('setValue',sc[i]);   //通过each方法赋值
						i++;
					});
				}				
			});
			//通过each方法将值放入下面的fieldset的结束
				
			
			myGrid(pmyGrid1);	

			myLoadGridData(pmyGrid1,1);
		}
	});
	//删除按钮
	$("#delete").bind({
		click:function(){
			$.messager.confirm({
				title:"系统提示",
				msg:"<br/><div style='text-align:center'>你确定要删除吗？这会直接删除数据库中的内容</div>",
				fn:function(r){
					var rows=$("#myGrid1").datagrid("getRows");
					if(rows.length>=1){
						node=$("#myGrid1").datagrid("getSelected");
						//console.log(node);
						$("#myGrid1").datagrid('deleteRow', pmyGrid1.rowindex);
						console.log(pmyGrid1.rowindex);
						if(pmyGrid1.rowindex==rows.length)
							$("#myGrid1").datagrid('selectRow', pmyGrid1.rowindex-1);
						else
							$("#myGrid1").datagrid('selectRow', pmyGrid1.rowindex);
						sql="delete from students where studentid="+node.studentid;
						source=myRunUpdateSql('',sql);
					}else{
						$.messager.alert({
							title:"系统提示",
							msg:"<br/><br/><div style='text-align:center;'>该页没有可以删除的内容</div>",
						});
					}
				}
			});
		}
	});
	//修改按钮
	$("#edit").bind({
		click:function(){
			//为了防止主键冲突，这里不允许修改学号 
			//学号判断
			/*var studentid=$("#studentid").textbox("getValue");
			if(isNaN(studentid) || studentid.length!=11){//isNaN是is not a number的缩写，是一个函数
				$.messager.show({
					title:"系统提示",
					msg:"请输入含有10位数字的学号",
				});
			}*/
			
			tab();
			gender=$("#gender").combobox("getValue");
			if(gender=='男'){
				gender='M';
			}else{
				gender='F';
			}
			
			sql="update students set  name='"+$("#name").textbox("getValue")+"',";
			sql+="pycode='"+$("#pycode").textbox("getValue")+"',";
			sql+="gender='"+gender+"',";
			sql+="birthdate='"+$("#birthdate").textbox("getValue")+"',";
			sql+="province='"+$("#province").textbox("getValue")+"',";
			sql+="city='"+$("#city").textbox("getValue")+"',";
			sql+="mobile='"+$("#phone").textbox("getValue")+"',";
			sql+="homephone='"+$("#homephone").textbox("getValue")+"',";
			sql+="weixin='"+$("#weixin").textbox("getValue")+"',";
			sql+="qq='"+$("#qq").textbox("getValue")+"'";
			sql+=" where studentid='"+$("#studentid").textbox("getValue")+"'";
			myRunUpdateSql('',sql);
			$.messager.show({
				title:"系统提示",
				msg:"修改成功,点击刷新按钮就可以查看",
			});
		}
	});
	
	//刷新按钮
	$("#refresh").bind({
		click:function(){
			window.location.reload();
		}
	});
	
	//新增按钮
	$("#add").bind({
		click:function(){
			$("#myGrid1").datagrid('insertRow',{
				index: 0,
				row: {
					name:'',
				}
			});
			$("#myGrid1").datagrid("selectRow",0);
			$("#studentid").textbox("textbox").removeAttr("readonly");//设置为只读
			$("#studentid").css({"readonly":"false"});
			$("#save").bind({
				click:function(){
					//学号判断
					
					$("#studentid").textbox({
						editable:true,
					});
					
					studentid=$("#studentid").textbox("getValue");
					if(isNaN(studentid) || studentid.length!=11){//isNaN是is not a number的缩写，是一个函数
						$.messager.show({
							title:"系统提示",
							msg:"请输入含有11位数字的学号",
						});
					}else{
						sql="select * from students where studentid='"+$("#studentid").textbox("getValue")+"'";
						source=myRunSelectSql('',sql);
						if(source.length){
							$.messager.show({
								title:"系统提示",
								msg:"该学号已经存在",
							});
						}else{
							tab();
							$.messager.show({
								title:"系统提示",
								msg:"新增成功,此处没有新增入数据库"
							});
						}
					}
				}
			});
			
		}
	});
	
	//树的初始化选择
	//var node1=$("#tree").tree('find','A');
	var node1=$("#tree").tree('getRoot');
	$("#tree").tree('select',node1.target);
	
	
	//filedset内容初始化
	//性别选项
	var genderSource=[{"gender":"男"},{"gender":"女"}];
	$("#gender").combobox({
		data:genderSource,
		panelHeight:"auto",
		valueField:"gender",
		editable:false,
		textField:"gender"
	});
	$("#gender").combobox("select",genderSource[0].gender);
	//地区选项  联动
	var sql="select AreaID,AreaName from areas where level=1";
	source=myRunSelectSql('',sql);
	$("#province").combobox({
		data:source,
		panelHeight:500,
		valueField:"areaname",
		editable:false,
		textField:"areaname",
		onSelect:function(row){
			sql="select areaname from Areas where Ancester='"+row.areaid+"#'";
			source=myRunSelectSql('',sql);
			$("#city").combobox({
				data:source,
				valueField:'areaname',
				textField:'areaname',
				editable:false,
			});
			$("#city").combobox("select",source[0].areaname);
		}
	});
	$("#province").combobox("select",source[0].areaname);
	$("#birthdate").datebox({
		editable:false
	});
	
	$("#studentid").textbox({
		editable:false,
	});
	
	$("#birthdate").datebox("setValue","1");
	$("#address").textbox("setValue",$("#province").combobox("getValue")+' '+$("#city").combobox("getValue"));
});
function myGridEvents(){
		
}
</script>
</body>
</html>
