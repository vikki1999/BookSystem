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
			<a href="#" id="btndelete" xtype="button" class="easyui-linkbutton" data-options="iconCls:'deleteIcon',plain:true, onClick:fn_delete" style="">删除</a>
			<a href="#" class="btn-separator"></a>
			<a href="#" id="btnsave" xtype="button" class="easyui-linkbutton" data-options="iconCls:'saveIcon',plain:true, onClick:fn_save" style="">保存</a>
			<a href="#" class="btn-separator"></a>
			<a href="#" id="btnedit" xtype="button" class="easyui-linkbutton" data-options="iconCls:'editIcon',plain:true" style="">修改</a>
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
var categorysource=[{"id":"000","text":"所有分类","categoryid":"000","parentnodeid":"","ancester":"","isparentflag":"1","level":"1",
	"children":[{"id":"A","text":"马列主义毛泽东思想","categoryid":"A","parentnodeid":"000","ancester":"000#","isparentflag":"1","level":"2",
	"children":[{"id":"A1","text":"马、恩著作","categoryid":"A1","parentnodeid":"A","ancester":"000#A#","isparentflag":"0","level":"3"}
	,{"id":"A2","text":"列宁著作","categoryid":"A2","parentnodeid":"A","ancester":"000#A#","isparentflag":"0","level":"3"}
	,{"id":"A3","text":"斯大林著作","categoryid":"A3","parentnodeid":"A","ancester":"000#A#","isparentflag":"0","level":"3"}
	,{"id":"A4","text":"毛泽东著作","categoryid":"A4","parentnodeid":"A","ancester":"000#A#","isparentflag":"0","level":"3"}
	,{"id":"A5","text":"马恩列斯毛著作汇编","categoryid":"A5","parentnodeid":"A","ancester":"000#A#","isparentflag":"0","level":"3"}
	,{"id":"A7","text":"马恩列斯毛生平和传记","categoryid":"A7","parentnodeid":"A","ancester":"000#A#","isparentflag":"0","level":"3"}
	,{"id":"A8","text":"马恩列斯毛思想的学习和研究","categoryid":"A8","parentnodeid":"A","ancester":"000#A#","isparentflag":"0","level":"3"}
	]}
	,{"id":"B","text":"哲学","categoryid":"B","parentnodeid":"000","ancester":"000#","isparentflag":"1","level":"2",
	"children":[{"id":"B0","text":"哲学理论","categoryid":"B0","parentnodeid":"B","ancester":"000#B#","isparentflag":"0","level":"3"}
	,{"id":"B1","text":"世界哲学","categoryid":"B1","parentnodeid":"B","ancester":"000#B#","isparentflag":"0","level":"3"}
	,{"id":"B2","text":"中国哲学","categoryid":"B2","parentnodeid":"B","ancester":"000#B#","isparentflag":"0","level":"3"}
	,{"id":"B3～B7","text":"各洲哲学","categoryid":"B3～B7","parentnodeid":"B","ancester":"000#B#","isparentflag":"0","level":"3"}
	,{"id":"B8","text":"思维科学","categoryid":"B8","parentnodeid":"B","ancester":"000#B#","isparentflag":"0","level":"3"}
	,{"id":"B81","text":"逻辑学","categoryid":"B81","parentnodeid":"B","ancester":"000#B#","isparentflag":"0","level":"3"}
	,{"id":"B82","text":"伦理学","categoryid":"B82","parentnodeid":"B","ancester":"000#B#","isparentflag":"0","level":"3"}
	,{"id":"B83","text":"美学","categoryid":"B83","parentnodeid":"B","ancester":"000#B#","isparentflag":"0","level":"3"}
	,{"id":"B84","text":"心理学","categoryid":"B84","parentnodeid":"B","ancester":"000#B#","isparentflag":"0","level":"3"}
	,{"id":"B9","text":"无神论 宗教","categoryid":"B9","parentnodeid":"B","ancester":"000#B#","isparentflag":"0","level":"3"}
	]}
	,{"id":"C","text":"社会科学总论","categoryid":"C","parentnodeid":"000","ancester":"000#","isparentflag":"1","level":"2",
	"children":[{"id":"C0","text":"社会科学理论与方法论","categoryid":"C0","parentnodeid":"C","ancester":"000#C#","isparentflag":"0","level":"3"}
	,{"id":"C1～C6","text":"社会科学概况","categoryid":"C1～C6","parentnodeid":"C","ancester":"000#C#","isparentflag":"0","level":"3"}
	,{"id":"C8","text":"统计学","categoryid":"C8","parentnodeid":"C","ancester":"000#C#","isparentflag":"0","level":"3"}
	,{"id":"C9","text":"C9","categoryid":"C9","parentnodeid":"C","ancester":"000#","isparentflag":"1","level":"3",
	"children":[{"id":"C92","text":"人口学","categoryid":"C92","parentnodeid":"C9","ancester":"000#C9#","isparentflag":"0","level":"4"}
	]}
	]}
	,{"id":"D","text":"政治、法律","categoryid":"D","parentnodeid":"000","ancester":"000#","isparentflag":"1","level":"2",
	"children":[{"id":"D0","text":"政治理论","categoryid":"D0","parentnodeid":"D","ancester":"000#D#","isparentflag":"0","level":"3"}
	,{"id":"D1/3","text":"共产主义运动、共产党","categoryid":"D1/3","parentnodeid":"D","ancester":"000#D#","isparentflag":"0","level":"3"}
	,{"id":"D4","text":"工、农、青、妇女运动与组织","categoryid":"D4","parentnodeid":"D","ancester":"000#D#","isparentflag":"0","level":"3"}
	,{"id":"D5/7","text":"世界各国政治","categoryid":"D5/7","parentnodeid":"D","ancester":"000#D#","isparentflag":"0","level":"3"}
	,{"id":"D6","text":"中国政治","categoryid":"D6","parentnodeid":"D","ancester":"000#D#","isparentflag":"1","level":"3",
	"children":[{"id":"D60","text":"政策、政论","categoryid":"D60","parentnodeid":"D6","ancester":"000#D#D6#","isparentflag":"0","level":"4"}
	,{"id":"D61","text":"中国革命和建设问题","categoryid":"D61","parentnodeid":"D6","ancester":"000#D#D6#","isparentflag":"0","level":"4"}
	,{"id":"D62","text":"政治制度与国家机构","categoryid":"D62","parentnodeid":"D6","ancester":"000#D#D6#","isparentflag":"0","level":"4"}
	,{"id":"D63","text":"国家行政管理","categoryid":"D63","parentnodeid":"D6","ancester":"000#D#D6#","isparentflag":"0","level":"4"}
	,{"id":"D64","text":"思想政治教育","categoryid":"D64","parentnodeid":"D6","ancester":"000#D#D6#","isparentflag":"0","level":"4"}
	,{"id":"D65","text":"政治运动","categoryid":"D65","parentnodeid":"D6","ancester":"000#D#D6#","isparentflag":"0","level":"4"}
	,{"id":"D66","text":"阶级结构与社会结构","categoryid":"D66","parentnodeid":"D6","ancester":"000#D#D6#","isparentflag":"0","level":"4"}
	,{"id":"D67","text":"地方政治概况","categoryid":"D67","parentnodeid":"D6","ancester":"000#D#D6#","isparentflag":"0","level":"4"}
	,{"id":"D69","text":"政治制度史","categoryid":"D69","parentnodeid":"D6","ancester":"000#D#D6#","isparentflag":"0","level":"4"}
	]}
	,{"id":"D8","text":"外交、国际关系","categoryid":"D8","parentnodeid":"D","ancester":"000#D#","isparentflag":"1","level":"3",
	"children":[{"id":"D82","text":"中国外交","categoryid":"D82","parentnodeid":"D8","ancester":"000#D#D8#","isparentflag":"0","level":"4"}
	]}
	,{"id":"D9","text":"法律","categoryid":"D9","parentnodeid":"D","ancester":"000#D#","isparentflag":"1","level":"3",
	"children":[{"id":"D92","text":"中国法律","categoryid":"D92","parentnodeid":"D9","ancester":"000#D#D9#","isparentflag":"0","level":"4"}
	]}
	]}
	,{"id":"E","text":"军事","categoryid":"E","parentnodeid":"000","ancester":"000#","isparentflag":"1","level":"2",
	"children":[{"id":"E0","text":"军事理论","categoryid":"E0","parentnodeid":"E","ancester":"000#E#","isparentflag":"0","level":"3"}
	,{"id":"E1","text":"世界军事","categoryid":"E1","parentnodeid":"E","ancester":"000#E#","isparentflag":"0","level":"3"}
	,{"id":"E2","text":"中国军事","categoryid":"E2","parentnodeid":"E","ancester":"000#E#","isparentflag":"1","level":"3",
	"children":[{"id":"E20","text":"建军理论","categoryid":"E20","parentnodeid":"E2","ancester":"000#E#E2#","isparentflag":"0","level":"4"}
	,{"id":"E21/25","text":"军事工作","categoryid":"E21/25","parentnodeid":"E2","ancester":"000#E#E2#","isparentflag":"0","level":"4"}
	,{"id":"E26","text":"军事制度","categoryid":"E26","parentnodeid":"E2","ancester":"000#E#E2#","isparentflag":"0","level":"4"}
	,{"id":"E27","text":"各种武装力量","categoryid":"E27","parentnodeid":"E2","ancester":"000#E#E2#","isparentflag":"0","level":"4"}
	,{"id":"E28","text":"民兵","categoryid":"E28","parentnodeid":"E2","ancester":"000#E#E2#","isparentflag":"0","level":"4"}
	]}
	,{"id":"E3/7","text":"各国军事","categoryid":"E3/7","parentnodeid":"E","ancester":"000#E#","isparentflag":"0","level":"3"}
	,{"id":"E9","text":"军事技术","categoryid":"E9","parentnodeid":"E","ancester":"000#E#","isparentflag":"1","level":"3",
	"children":[{"id":"E99","text":"军事地形学、军事地理学","categoryid":"E99","parentnodeid":"E9","ancester":"000#E#E9#","isparentflag":"0","level":"4"}
	]}
	]}
	,{"id":"F","text":"经济","categoryid":"F","parentnodeid":"000","ancester":"000#","isparentflag":"1","level":"2",
	"children":[{"id":"F0","text":"政治经济学","categoryid":"F0","parentnodeid":"F","ancester":"000#F#","isparentflag":"0","level":"3"}
	,{"id":"F1","text":"世界各国经济概况","categoryid":"F1","parentnodeid":"F","ancester":"000#F#","isparentflag":"1","level":"3",
	"children":[{"id":"F12","text":"中国经济","categoryid":"F12","parentnodeid":"F1","ancester":"000#F#F1#","isparentflag":"0","level":"4"}
	]}
	,{"id":"F2","text":"经济计划与管理","categoryid":"F2","parentnodeid":"F","ancester":"000#F#","isparentflag":"1","level":"3",
	"children":[{"id":"F23","text":"会计","categoryid":"F23","parentnodeid":"F2","ancester":"000#F#F2#","isparentflag":"0","level":"4"}
	,{"id":"F27","text":"企业经济","categoryid":"F27","parentnodeid":"F2","ancester":"000#F#F2#","isparentflag":"0","level":"4"}
	]}
	,{"id":"F3","text":"农业经济","categoryid":"F3","parentnodeid":"F","ancester":"000#F#","isparentflag":"1","level":"3",
	"children":[{"id":"F32","text":"中国农业经济","categoryid":"F32","parentnodeid":"F3","ancester":"000#F#F3#","isparentflag":"0","level":"4"}
	]}
	,{"id":"F4","text":"工业经济","categoryid":"F4","parentnodeid":"F","ancester":"000#F#","isparentflag":"1","level":"3",
	"children":[{"id":"F42","text":"中国工业经济","categoryid":"F42","parentnodeid":"F4","ancester":"000#F#F4#","isparentflag":"0","level":"4"}
	]}
	,{"id":"F5","text":"交通运输经济","categoryid":"F5","parentnodeid":"F","ancester":"000#F#","isparentflag":"1","level":"3",
	"children":[{"id":"F59","text":"旅游经济","categoryid":"F59","parentnodeid":"F5","ancester":"000#F#F5#","isparentflag":"0","level":"4"}
	]}
	,{"id":"F6","text":"邮电经济","categoryid":"F6","parentnodeid":"F","ancester":"000#F#","isparentflag":"1","level":"3",
	"children":[{"id":"F60","text":"邮电经济理论","categoryid":"F60","parentnodeid":"F6","ancester":"000#F#F6#","isparentflag":"0","level":"4"}
	,{"id":"F61","text":"邮政","categoryid":"F61","parentnodeid":"F6","ancester":"000#F#F6#","isparentflag":"0","level":"4"}
	,{"id":"F62","text":"电信","categoryid":"F62","parentnodeid":"F6","ancester":"000#F#F6#","isparentflag":"0","level":"4"}
	,{"id":"F63","text":"世界各国邮电事业","categoryid":"F63","parentnodeid":"F6","ancester":"000#F#F6#","isparentflag":"0","level":"4"}
	]}
	,{"id":"F7","text":"贸易经济","categoryid":"F7","parentnodeid":"F","ancester":"000#F#","isparentflag":"1","level":"3",
	"children":[{"id":"F72","text":"中国国内贸易经济","categoryid":"F72","parentnodeid":"F7","ancester":"000#F#F7#","isparentflag":"0","level":"4"}
	]}
	,{"id":"F8","text":"财政、金融","categoryid":"F8","parentnodeid":"F","ancester":"000#F#","isparentflag":"1","level":"3",
	"children":[{"id":"F81","text":"财政、国家财政","categoryid":"F81","parentnodeid":"F8","ancester":"000#F#F8#","isparentflag":"0","level":"4"}
	,{"id":"F83","text":"金融、银行","categoryid":"F83","parentnodeid":"F8","ancester":"000#F#F8#","isparentflag":"0","level":"4"}
	,{"id":"F84","text":"保险","categoryid":"F84","parentnodeid":"F8","ancester":"000#F#F8#","isparentflag":"0","level":"4"}
	]}
	]}
	,{"id":"G","text":"文化、科学、教育、体育","categoryid":"G","parentnodeid":"000","ancester":"000#","isparentflag":"1","level":"2",
	"children":[{"id":"G0","text":"文化理论","categoryid":"G0","parentnodeid":"G","ancester":"000#G#","isparentflag":"1","level":"3",
	"children":[{"id":"G02","text":"文化的哲学基础","categoryid":"G02","parentnodeid":"G0","ancester":"000#G#G0#","isparentflag":"0","level":"4"}
	,{"id":"G03","text":"文化的民族性","categoryid":"G03","parentnodeid":"G0","ancester":"000#G#G0#","isparentflag":"0","level":"4"}
	,{"id":"G07","text":"文化地理学","categoryid":"G07","parentnodeid":"G0","ancester":"000#G#G0#","isparentflag":"0","level":"4"}
	]}
	,{"id":"G1","text":"世界各国文化事业概况","categoryid":"G1","parentnodeid":"G","ancester":"000#G#","isparentflag":"1","level":"3",
	"children":[{"id":"G12","text":"中国文化事业","categoryid":"G12","parentnodeid":"G1","ancester":"000#G#G1#","isparentflag":"0","level":"4"}
	]}
	,{"id":"G2","text":"信息与知识传播","categoryid":"G2","parentnodeid":"G","ancester":"000#G#","isparentflag":"1","level":"3",
	"children":[{"id":"G20","text":"信息与传播理论","categoryid":"G20","parentnodeid":"G2","ancester":"000#G#G2#","isparentflag":"0","level":"4"}
	,{"id":"G21","text":"新闻学、新闻事业","categoryid":"G21","parentnodeid":"G2","ancester":"000#G#G2#","isparentflag":"0","level":"4"}
	,{"id":"G22","text":"广播、电视事业","categoryid":"G22","parentnodeid":"G2","ancester":"000#G#G2#","isparentflag":"0","level":"4"}
	,{"id":"G23","text":"出版事业","categoryid":"G23","parentnodeid":"G2","ancester":"000#G#G2#","isparentflag":"0","level":"4"}
	,{"id":"G25","text":"图书馆学、图书馆事业","categoryid":"G25","parentnodeid":"G2","ancester":"000#G#G2#","isparentflag":"0","level":"4"}
	,{"id":"G26","text":"博物馆学、博物馆事业","categoryid":"G26","parentnodeid":"G2","ancester":"000#G#G2#","isparentflag":"0","level":"4"}
	,{"id":"G27","text":"档案学、档案事业","categoryid":"G27","parentnodeid":"G2","ancester":"000#G#G2#","isparentflag":"0","level":"4"}
	]}
	,{"id":"G3","text":"科学、科学研究","categoryid":"G3","parentnodeid":"G","ancester":"000#G#","isparentflag":"1","level":"3",
	"children":[{"id":"G31","text":"科学研究工作","categoryid":"G31","parentnodeid":"G3","ancester":"000#G#G3#","isparentflag":"0","level":"4"}
	,{"id":"G35","text":"情报学、情报工作","categoryid":"G35","parentnodeid":"G3","ancester":"000#G#G3#","isparentflag":"0","level":"4"}
	]}
	,{"id":"G4","text":"教育","categoryid":"G4","parentnodeid":"G","ancester":"000#G#","isparentflag":"1","level":"3",
	"children":[{"id":"G40","text":"教育学","categoryid":"G40","parentnodeid":"G4","ancester":"000#G#G4#","isparentflag":"0","level":"4"}
	,{"id":"G41","text":"思想政治教育、德育","categoryid":"G41","parentnodeid":"G4","ancester":"000#G#G4#","isparentflag":"0","level":"4"}
	,{"id":"G42","text":"教学理论","categoryid":"G42","parentnodeid":"G4","ancester":"000#G#G4#","isparentflag":"0","level":"4"}
	,{"id":"G43","text":"电化教育","categoryid":"G43","parentnodeid":"G4","ancester":"000#G#G4#","isparentflag":"0","level":"4"}
	,{"id":"G44","text":"教育心理学","categoryid":"G44","parentnodeid":"G4","ancester":"000#G#G4#","isparentflag":"0","level":"4"}
	,{"id":"G45","text":"教师与学生","categoryid":"G45","parentnodeid":"G4","ancester":"000#G#G4#","isparentflag":"0","level":"4"}
	,{"id":"G46","text":"教育行政","categoryid":"G46","parentnodeid":"G4","ancester":"000#G#G4#","isparentflag":"0","level":"4"}
	,{"id":"G47","text":"学校管理","categoryid":"G47","parentnodeid":"G4","ancester":"000#G#G4#","isparentflag":"0","level":"4"}
	]}
	,{"id":"G5","text":"教育事业","categoryid":"G5","parentnodeid":"G","ancester":"000#G#","isparentflag":"1","level":"3",
	"children":[{"id":"G51","text":"世界教育","categoryid":"G51","parentnodeid":"G5","ancester":"000#G#G5#","isparentflag":"0","level":"4"}
	,{"id":"G52","text":"中国教育","categoryid":"G52","parentnodeid":"G5","ancester":"000#G#G5#","isparentflag":"0","level":"4"}
	,{"id":"G53/57","text":"各国教育","categoryid":"G53/57","parentnodeid":"G5","ancester":"000#G#G5#","isparentflag":"0","level":"4"}
	]}
	,{"id":"G6","text":"各级教育","categoryid":"G6","parentnodeid":"G","ancester":"000#G#","isparentflag":"1","level":"3",
	"children":[{"id":"G61","text":"学前教育","categoryid":"G61","parentnodeid":"G6","ancester":"000#G#G6#","isparentflag":"0","level":"4"}
	,{"id":"G62","text":"初等教育","categoryid":"G62","parentnodeid":"G6","ancester":"000#G#G6#","isparentflag":"0","level":"4"}
	,{"id":"G63","text":"中等教育","categoryid":"G63","parentnodeid":"G6","ancester":"000#G#G6#","isparentflag":"0","level":"4"}
	,{"id":"G64","text":"高等教育","categoryid":"G64","parentnodeid":"G6","ancester":"000#G#G6#","isparentflag":"0","level":"4"}
	,{"id":"G65","text":"师范教育","categoryid":"G65","parentnodeid":"G6","ancester":"000#G#G6#","isparentflag":"0","level":"4"}
	]}
	,{"id":"G7","text":"各类教育","categoryid":"G7","parentnodeid":"G","ancester":"000#G#","isparentflag":"1","level":"3",
	"children":[{"id":"G71","text":"职业技术教育","categoryid":"G71","parentnodeid":"G7","ancester":"000#G#G7#","isparentflag":"0","level":"4"}
	,{"id":"G72","text":"成人教育、业余教育","categoryid":"G72","parentnodeid":"G7","ancester":"000#G#G7#","isparentflag":"0","level":"4"}
	,{"id":"G74","text":"华侨教育、侨民教育","categoryid":"G74","parentnodeid":"G7","ancester":"000#G#G7#","isparentflag":"0","level":"4"}
	,{"id":"G75","text":"少数民族教育","categoryid":"G75","parentnodeid":"G7","ancester":"000#G#G7#","isparentflag":"0","level":"4"}
	,{"id":"G76","text":"特殊教育","categoryid":"G76","parentnodeid":"G7","ancester":"000#G#G7#","isparentflag":"0","level":"4"}
	,{"id":"G77","text":"社会教育","categoryid":"G77","parentnodeid":"G7","ancester":"000#G#G7#","isparentflag":"0","level":"4"}
	,{"id":"G78","text":"家庭教育","categoryid":"G78","parentnodeid":"G7","ancester":"000#G#G7#","isparentflag":"0","level":"4"}
	,{"id":"G79","text":"自学","categoryid":"G79","parentnodeid":"G7","ancester":"000#G#G7#","isparentflag":"0","level":"4"}
	]}
	,{"id":"G8","text":"体育","categoryid":"G8","parentnodeid":"G","ancester":"000#G#","isparentflag":"1","level":"3",
	"children":[{"id":"G80","text":"体育理论","categoryid":"G80","parentnodeid":"G8","ancester":"000#G#G8#","isparentflag":"0","level":"4"}
	,{"id":"G81","text":"世界各国体育事业","categoryid":"G81","parentnodeid":"G8","ancester":"000#G#G8#","isparentflag":"0","level":"4"}
	,{"id":"G82","text":"田径运动","categoryid":"G82","parentnodeid":"G8","ancester":"000#G#G8#","isparentflag":"0","level":"4"}
	,{"id":"G83","text":"体操运动","categoryid":"G83","parentnodeid":"G8","ancester":"000#G#G8#","isparentflag":"0","level":"4"}
	,{"id":"G84","text":"球类运动","categoryid":"G84","parentnodeid":"G8","ancester":"000#G#G8#","isparentflag":"0","level":"4"}
	,{"id":"G89","text":"文体活动","categoryid":"G89","parentnodeid":"G8","ancester":"000#G#G8#","isparentflag":"0","level":"4"}
	]}
	]}
	,{"id":"H","text":"语言 文字","categoryid":"H","parentnodeid":"000","ancester":"000#","isparentflag":"1","level":"2",
	"children":[{"id":"H0","text":"语言学","categoryid":"H0","parentnodeid":"H","ancester":"000#H#","isparentflag":"1","level":"3",
	"children":[{"id":"H01","text":"语音学","categoryid":"H01","parentnodeid":"H0","ancester":"000#H#H0#","isparentflag":"0","level":"4"}
	,{"id":"H02","text":"文字学","categoryid":"H02","parentnodeid":"H0","ancester":"000#H#H0#","isparentflag":"0","level":"4"}
	,{"id":"H04","text":"语法学","categoryid":"H04","parentnodeid":"H0","ancester":"000#H#H0#","isparentflag":"0","level":"4"}
	,{"id":"H05","text":"写作学","categoryid":"H05","parentnodeid":"H0","ancester":"000#H#H0#","isparentflag":"0","level":"4"}
	,{"id":"H06","text":"词典学","categoryid":"H06","parentnodeid":"H0","ancester":"000#H#H0#","isparentflag":"0","level":"4"}
	,{"id":"H07","text":"方言学","categoryid":"H07","parentnodeid":"H0","ancester":"000#H#H0#","isparentflag":"0","level":"4"}
	,{"id":"H09","text":"语文教学","categoryid":"H09","parentnodeid":"H0","ancester":"000#H#H0#","isparentflag":"0","level":"4"}
	]}
	,{"id":"H1","text":"汉语","categoryid":"H1","parentnodeid":"H","ancester":"000#H#","isparentflag":"1","level":"3",
	"children":[{"id":"H11","text":"H11","categoryid":"H11","parentnodeid":"H1","ancester":"000#H#H1#","isparentflag":"0","level":"4"}
	,{"id":"H12","text":"H12","categoryid":"H12","parentnodeid":"H1","ancester":"000#H#H1#","isparentflag":"0","level":"4"}
	,{"id":"H14","text":"H14","categoryid":"H14","parentnodeid":"H1","ancester":"000#H#H1#","isparentflag":"0","level":"4"}
	,{"id":"H15","text":"H15","categoryid":"H15","parentnodeid":"H1","ancester":"000#H#H1#","isparentflag":"0","level":"4"}
	,{"id":"H16","text":"H16","categoryid":"H16","parentnodeid":"H1","ancester":"000#H#H1#","isparentflag":"0","level":"4"}
	,{"id":"H17","text":"H17","categoryid":"H17","parentnodeid":"H1","ancester":"000#H#H1#","isparentflag":"0","level":"4"}
	,{"id":"H19","text":"H19","categoryid":"H19","parentnodeid":"H1","ancester":"000#H#H1#","isparentflag":"0","level":"4"}
	]}
	,{"id":"H2","text":"中国少数民族语言","categoryid":"H2","parentnodeid":"H","ancester":"000#H#","isparentflag":"0","level":"3"}
	,{"id":"H3","text":"常用外国语","categoryid":"H3","parentnodeid":"H","ancester":"000#H#","isparentflag":"1","level":"3",
	"children":[{"id":"H31","text":"英语","categoryid":"H31","parentnodeid":"H3","ancester":"000#H#H3#","isparentflag":"0","level":"4"}
	,{"id":"H32","text":"法语","categoryid":"H32","parentnodeid":"H3","ancester":"000#H#H3#","isparentflag":"0","level":"4"}
	,{"id":"H33","text":"德语","categoryid":"H33","parentnodeid":"H3","ancester":"000#H#H3#","isparentflag":"0","level":"4"}
	,{"id":"H36","text":"日语","categoryid":"H36","parentnodeid":"H3","ancester":"000#H#H3#","isparentflag":"0","level":"4"}
	]}
	,{"id":"H4","text":"汉藏语系","categoryid":"H4","parentnodeid":"H","ancester":"000#H#","isparentflag":"0","level":"3"}
	,{"id":"H5/H9","text":"各种语系","categoryid":"H5/H9","parentnodeid":"H","ancester":"000#H#","isparentflag":"0","level":"3"}
	]}
	,{"id":"I","text":"文学","categoryid":"I","parentnodeid":"000","ancester":"000#","isparentflag":"1","level":"2",
	"children":[{"id":"I0","text":"文学理论","categoryid":"I0","parentnodeid":"I","ancester":"000#I#","isparentflag":"1","level":"3",
	"children":[{"id":"I01","text":"文艺美学","categoryid":"I01","parentnodeid":"I0","ancester":"000#I#I0#","isparentflag":"0","level":"4"}
	,{"id":"I02","text":"文学理论的基本问题","categoryid":"I02","parentnodeid":"I0","ancester":"000#I#I0#","isparentflag":"0","level":"4"}
	,{"id":"I03","text":"文艺工作者","categoryid":"I03","parentnodeid":"I0","ancester":"000#I#I0#","isparentflag":"0","level":"4"}
	,{"id":"I04","text":"文学写作学","categoryid":"I04","parentnodeid":"I0","ancester":"000#I#I0#","isparentflag":"0","level":"4"}
	,{"id":"I05","text":"各体文学理论","categoryid":"I05","parentnodeid":"I0","ancester":"000#I#I0#","isparentflag":"0","level":"4"}
	,{"id":"I06","text":"文学评论、文学欣赏","categoryid":"I06","parentnodeid":"I0","ancester":"000#I#I0#","isparentflag":"0","level":"4"}
	]}
	,{"id":"I1","text":"世界文学","categoryid":"I1","parentnodeid":"I","ancester":"000#I#","isparentflag":"1","level":"3",
	"children":[{"id":"I11","text":"世界文学作品集","categoryid":"I11","parentnodeid":"I1","ancester":"000#I#I1#","isparentflag":"0","level":"4"}
	]}
	,{"id":"I2","text":"中国文学","categoryid":"I2","parentnodeid":"I","ancester":"000#I#","isparentflag":"1","level":"3",
	"children":[{"id":"I21","text":"中国文学作品集","categoryid":"I21","parentnodeid":"I2","ancester":"000#I#I2#","isparentflag":"0","level":"4"}
	,{"id":"I22","text":"诗歌、韵文","categoryid":"I22","parentnodeid":"I2","ancester":"000#I#I2#","isparentflag":"0","level":"4"}
	,{"id":"I23","text":"戏剧","categoryid":"I23","parentnodeid":"I2","ancester":"000#I#I2#","isparentflag":"0","level":"4"}
	,{"id":"I24","text":"小说","categoryid":"I24","parentnodeid":"I2","ancester":"000#I#I2#","isparentflag":"0","level":"4"}
	,{"id":"I25","text":"报告文学","categoryid":"I25","parentnodeid":"I2","ancester":"000#I#I2#","isparentflag":"0","level":"4"}
	,{"id":"I26","text":"散文","categoryid":"I26","parentnodeid":"I2","ancester":"000#I#I2#","isparentflag":"0","level":"4"}
	,{"id":"I27","text":"民间文学","categoryid":"I27","parentnodeid":"I2","ancester":"000#I#I2#","isparentflag":"0","level":"4"}
	,{"id":"I28","text":"儿童文学","categoryid":"I28","parentnodeid":"I2","ancester":"000#I#I2#","isparentflag":"0","level":"4"}
	,{"id":"I29","text":"少数民族文学","categoryid":"I29","parentnodeid":"I2","ancester":"000#I#I2#","isparentflag":"0","level":"4"}
	]}
	,{"id":"I3/7","text":"各国文学","categoryid":"I3/7","parentnodeid":"I","ancester":"000#I#","isparentflag":"0","level":"3"}
	]}
	,{"id":"J","text":"艺术","categoryid":"J","parentnodeid":"000","ancester":"000#","isparentflag":"1","level":"2",
	"children":[{"id":"J0","text":"艺术理论","categoryid":"J0","parentnodeid":"J","ancester":"000#J#","isparentflag":"1","level":"3",
	"children":[{"id":"J01","text":"艺术美学","categoryid":"J01","parentnodeid":"J0","ancester":"000#J#J0#","isparentflag":"0","level":"4"}
	,{"id":"J05","text":"艺术评论、欣赏","categoryid":"J05","parentnodeid":"J0","ancester":"000#J#J0#","isparentflag":"0","level":"4"}
	]}
	,{"id":"J1","text":"世界各国艺术概况","categoryid":"J1","parentnodeid":"J","ancester":"000#J#","isparentflag":"1","level":"3",
	"children":[{"id":"J11","text":"世界艺术","categoryid":"J11","parentnodeid":"J1","ancester":"000#J#J1#","isparentflag":"0","level":"4"}
	,{"id":"J12","text":"中国艺术","categoryid":"J12","parentnodeid":"J1","ancester":"000#J#J1#","isparentflag":"0","level":"4"}
	,{"id":"J19","text":"宗教艺术","categoryid":"J19","parentnodeid":"J1","ancester":"000#J#J1#","isparentflag":"0","level":"4"}
	]}
	,{"id":"J2","text":"绘画","categoryid":"J2","parentnodeid":"J","ancester":"000#J#","isparentflag":"1","level":"3",
	"children":[{"id":"J20","text":"绘画理论","categoryid":"J20","parentnodeid":"J2","ancester":"000#J#J2#","isparentflag":"0","level":"4"}
	,{"id":"J21","text":"绘画技法","categoryid":"J21","parentnodeid":"J2","ancester":"000#J#J2#","isparentflag":"0","level":"4"}
	,{"id":"J22","text":"中国绘画","categoryid":"J22","parentnodeid":"J2","ancester":"000#J#J2#","isparentflag":"0","level":"4"}
	,{"id":"J23","text":"各国绘画","categoryid":"J23","parentnodeid":"J2","ancester":"000#J#J2#","isparentflag":"0","level":"4"}
	,{"id":"J29","text":"书法、篆刻","categoryid":"J29","parentnodeid":"J2","ancester":"000#J#J2#","isparentflag":"0","level":"4"}
	]}
	,{"id":"J3","text":"雕塑","categoryid":"J3","parentnodeid":"J","ancester":"000#J#","isparentflag":"1","level":"3",
	"children":[{"id":"J30","text":"雕塑理论","categoryid":"J30","parentnodeid":"J3","ancester":"000#J#J3#","isparentflag":"0","level":"4"}
	,{"id":"J31","text":"雕塑技法","categoryid":"J31","parentnodeid":"J3","ancester":"000#J#J3#","isparentflag":"0","level":"4"}
	,{"id":"J32","text":"中国雕塑","categoryid":"J32","parentnodeid":"J3","ancester":"000#J#J3#","isparentflag":"0","level":"4"}
	]}
	,{"id":"J4","text":"摄影艺术","categoryid":"J4","parentnodeid":"J","ancester":"000#J#","isparentflag":"1","level":"3",
	"children":[{"id":"J40","text":"摄影艺术理论","categoryid":"J40","parentnodeid":"J4","ancester":"000#J#J4#","isparentflag":"0","level":"4"}
	,{"id":"J41","text":"拍摄技术","categoryid":"J41","parentnodeid":"J4","ancester":"000#J#J4#","isparentflag":"0","level":"4"}
	,{"id":"J42","text":"中国摄影艺术","categoryid":"J42","parentnodeid":"J4","ancester":"000#J#J4#","isparentflag":"0","level":"4"}
	]}
	,{"id":"J5","text":"工艺美术","categoryid":"J5","parentnodeid":"J","ancester":"000#J#","isparentflag":"1","level":"3",
	"children":[{"id":"J50","text":"工艺美术理论","categoryid":"J50","parentnodeid":"J5","ancester":"000#J#J5#","isparentflag":"0","level":"4"}
	,{"id":"J52","text":"中国工艺美术","categoryid":"J52","parentnodeid":"J5","ancester":"000#J#J5#","isparentflag":"0","level":"4"}
	]}
	,{"id":"J6","text":"音乐","categoryid":"J6","parentnodeid":"J","ancester":"000#J#","isparentflag":"1","level":"3",
	"children":[{"id":"J60","text":"音乐理论","categoryid":"J60","parentnodeid":"J6","ancester":"000#J#J6#","isparentflag":"0","level":"4"}
	,{"id":"J62","text":"器乐理论与演奏方法","categoryid":"J62","parentnodeid":"J6","ancester":"000#J#J6#","isparentflag":"0","level":"4"}
	,{"id":"J64","text":"中国音乐作品","categoryid":"J64","parentnodeid":"J6","ancester":"000#J#J6#","isparentflag":"0","level":"4"}
	]}
	,{"id":"J7","text":"舞蹈","categoryid":"J7","parentnodeid":"J","ancester":"000#J#","isparentflag":"1","level":"3",
	"children":[{"id":"J70","text":"舞蹈理论","categoryid":"J70","parentnodeid":"J7","ancester":"000#J#J7#","isparentflag":"0","level":"4"}
	,{"id":"J72","text":"中国舞蹈、舞剧","categoryid":"J72","parentnodeid":"J7","ancester":"000#J#J7#","isparentflag":"0","level":"4"}
	]}
	,{"id":"J8","text":"戏剧艺术","categoryid":"J8","parentnodeid":"J","ancester":"000#J#","isparentflag":"1","level":"3",
	"children":[{"id":"J80","text":"戏剧艺术理论","categoryid":"J80","parentnodeid":"J8","ancester":"000#J#J8#","isparentflag":"0","level":"4"}
	,{"id":"J82","text":"中国戏剧艺术","categoryid":"J82","parentnodeid":"J8","ancester":"000#J#J8#","isparentflag":"0","level":"4"}
	,{"id":"J89","text":"戏剧事业","categoryid":"J89","parentnodeid":"J8","ancester":"000#J#J8#","isparentflag":"0","level":"4"}
	]}
	,{"id":"J9","text":"电影、电视艺术","categoryid":"J9","parentnodeid":"J","ancester":"000#J#","isparentflag":"1","level":"3",
	"children":[{"id":"J90","text":"电影、电视艺术理论","categoryid":"J90","parentnodeid":"J9","ancester":"000#J#J9#","isparentflag":"0","level":"4"}
	,{"id":"J94","text":"电影工作组织与管理","categoryid":"J94","parentnodeid":"J9","ancester":"000#J#J9#","isparentflag":"0","level":"4"}
	,{"id":"J99","text":"电影事业","categoryid":"J99","parentnodeid":"J9","ancester":"000#J#J9#","isparentflag":"0","level":"4"}
	]}
	]}
	,{"id":"K","text":"历史、地理","categoryid":"K","parentnodeid":"000","ancester":"000#","isparentflag":"1","level":"2",
	"children":[{"id":"K0","text":"史学理论","categoryid":"K0","parentnodeid":"K","ancester":"000#K#","isparentflag":"1","level":"3",
	"children":[{"id":"K01","text":"史学的哲学基础","categoryid":"K01","parentnodeid":"K0","ancester":"000#K#K0#","isparentflag":"0","level":"4"}
	,{"id":"K02","text":"社会发展理论","categoryid":"K02","parentnodeid":"K0","ancester":"000#K#K0#","isparentflag":"0","level":"4"}
	,{"id":"K06","text":"历史研究","categoryid":"K06","parentnodeid":"K0","ancester":"000#K#K0#","isparentflag":"0","level":"4"}
	,{"id":"K09","text":"史学史","categoryid":"K09","parentnodeid":"K0","ancester":"000#K#K0#","isparentflag":"0","level":"4"}
	]}
	,{"id":"K1","text":"世界史","categoryid":"K1","parentnodeid":"K","ancester":"000#K#","isparentflag":"1","level":"3",
	"children":[{"id":"K10","text":"世界史通史","categoryid":"K10","parentnodeid":"K1","ancester":"000#K#K1#","isparentflag":"0","level":"4"}
	,{"id":"K11","text":"上古史","categoryid":"K11","parentnodeid":"K1","ancester":"000#K#K1#","isparentflag":"0","level":"4"}
	,{"id":"K12","text":"古代史","categoryid":"K12","parentnodeid":"K1","ancester":"000#K#K1#","isparentflag":"0","level":"4"}
	,{"id":"K13","text":"中世纪史","categoryid":"K13","parentnodeid":"K1","ancester":"000#K#K1#","isparentflag":"0","level":"4"}
	,{"id":"K14","text":"近代史","categoryid":"K14","parentnodeid":"K1","ancester":"000#K#K1#","isparentflag":"0","level":"4"}
	,{"id":"K15","text":"现代史","categoryid":"K15","parentnodeid":"K1","ancester":"000#K#K1#","isparentflag":"0","level":"4"}
	,{"id":"K16","text":"世界民族史志","categoryid":"K16","parentnodeid":"K1","ancester":"000#K#K1#","isparentflag":"0","level":"4"}
	]}
	,{"id":"K2","text":"中国史","categoryid":"K2","parentnodeid":"K","ancester":"000#K#","isparentflag":"1","level":"3",
	"children":[{"id":"K20","text":"中国史通史","categoryid":"K20","parentnodeid":"K2","ancester":"000#K#K2#","isparentflag":"0","level":"4"}
	,{"id":"K21","text":"原始社会","categoryid":"K21","parentnodeid":"K2","ancester":"000#K#K2#","isparentflag":"0","level":"4"}
	,{"id":"K22","text":"奴隶社会","categoryid":"K22","parentnodeid":"K2","ancester":"000#K#K2#","isparentflag":"0","level":"4"}
	,{"id":"K23","text":"封建社会","categoryid":"K23","parentnodeid":"K2","ancester":"000#K#K2#","isparentflag":"0","level":"4"}
	,{"id":"K24","text":"半殖民地、半封建社会","categoryid":"K24","parentnodeid":"K2","ancester":"000#K#K2#","isparentflag":"0","level":"4"}
	,{"id":"K25","text":"中华人民共和国","categoryid":"K25","parentnodeid":"K2","ancester":"000#K#K2#","isparentflag":"0","level":"4"}
	,{"id":"K28","text":"中国民族史志","categoryid":"K28","parentnodeid":"K2","ancester":"000#K#K2#","isparentflag":"0","level":"4"}
	,{"id":"K29","text":"地方史志","categoryid":"K29","parentnodeid":"K2","ancester":"000#K#K2#","isparentflag":"0","level":"4"}
	]}
	,{"id":"K3","text":"亚洲史","categoryid":"K3","parentnodeid":"K","ancester":"000#K#","isparentflag":"0","level":"3"}
	,{"id":"K4","text":"非洲史","categoryid":"K4","parentnodeid":"K","ancester":"000#K#","isparentflag":"0","level":"3"}
	,{"id":"K5","text":"欧洲史","categoryid":"K5","parentnodeid":"K","ancester":"000#K#","isparentflag":"0","level":"3"}
	,{"id":"K6","text":"大洋洲史","categoryid":"K6","parentnodeid":"K","ancester":"000#K#","isparentflag":"0","level":"3"}
	,{"id":"K7","text":"美洲史","categoryid":"K7","parentnodeid":"K","ancester":"000#K#","isparentflag":"0","level":"3"}
	,{"id":"K8","text":"K8","categoryid":"K8","parentnodeid":"K","ancester":"000#K#","isparentflag":"1","level":"3",
	"children":[{"id":"K82","text":"中国人物传记","categoryid":"K82","parentnodeid":"K8","ancester":"000#K#K8#","isparentflag":"0","level":"4"}
	,{"id":"K85","text":"文物考古","categoryid":"K85","parentnodeid":"K8","ancester":"000#K#K8#","isparentflag":"0","level":"4"}
	,{"id":"K87","text":"中国文物考古","categoryid":"K87","parentnodeid":"K8","ancester":"000#K#K8#","isparentflag":"0","level":"4"}
	]}
	,{"id":"K9","text":"地理","categoryid":"K9","parentnodeid":"K","ancester":"000#K#","isparentflag":"1","level":"3",
	"children":[{"id":"K90","text":"地理学","categoryid":"K90","parentnodeid":"K9","ancester":"000#K#K9#","isparentflag":"0","level":"4"}
	,{"id":"K91","text":"世界地理","categoryid":"K91","parentnodeid":"K9","ancester":"000#K#K9#","isparentflag":"0","level":"4"}
	,{"id":"K92","text":"中国地理","categoryid":"K92","parentnodeid":"K9","ancester":"000#K#K9#","isparentflag":"0","level":"4"}
	,{"id":"K99","text":"地图","categoryid":"K99","parentnodeid":"K9","ancester":"000#K#K9#","isparentflag":"0","level":"4"}
	]}
	]}
	,{"id":"N","text":"自然科学总论","categoryid":"N","parentnodeid":"000","ancester":"000#","isparentflag":"1","level":"2",
	"children":[{"id":"N0","text":"自然科学理论与方法论","categoryid":"N0","parentnodeid":"N","ancester":"000#N#","isparentflag":"0","level":"3"}
	,{"id":"N4","text":"自然科学教育与普及","categoryid":"N4","parentnodeid":"N","ancester":"000#N#","isparentflag":"0","level":"3"}
	,{"id":"N6","text":"自然科学参考工具书","categoryid":"N6","parentnodeid":"N","ancester":"000#N#","isparentflag":"0","level":"3"}
	,{"id":"N8","text":"自然科学调查、考察","categoryid":"N8","parentnodeid":"N","ancester":"000#N#","isparentflag":"0","level":"3"}
	,{"id":"N9","text":"N9","categoryid":"N9","parentnodeid":"N","ancester":"000#N#","isparentflag":"1","level":"3",
	"children":[{"id":"N91","text":"自然研究、自然历史","categoryid":"N91","parentnodeid":"N9","ancester":"000#N#N9#","isparentflag":"0","level":"4"}
	,{"id":"N94","text":"系统论","categoryid":"N94","parentnodeid":"N9","ancester":"000#N#N9#","isparentflag":"0","level":"4"}
	]}
	]}
	,{"id":"O","text":"数理科学和化学","categoryid":"O","parentnodeid":"000","ancester":"000#","isparentflag":"1","level":"2",
	"children":[{"id":"O1","text":"数学","categoryid":"O1","parentnodeid":"O","ancester":"000#O#","isparentflag":"1","level":"3",
	"children":[{"id":"O12","text":"初等数学","categoryid":"O12","parentnodeid":"O1","ancester":"000#O#O1#","isparentflag":"0","level":"4"}
	,{"id":"O13","text":"高等数学","categoryid":"O13","parentnodeid":"O1","ancester":"000#O#O1#","isparentflag":"0","level":"4"}
	,{"id":"O14","text":"数理逻辑、数学基础","categoryid":"O14","parentnodeid":"O1","ancester":"000#O#O1#","isparentflag":"0","level":"4"}
	,{"id":"O15","text":"代数、数论、组合理论","categoryid":"O15","parentnodeid":"O1","ancester":"000#O#O1#","isparentflag":"0","level":"4"}
	,{"id":"O17","text":"数学分析","categoryid":"O17","parentnodeid":"O1","ancester":"000#O#O1#","isparentflag":"0","level":"4"}
	,{"id":"O18","text":"几何、拓扑","categoryid":"O18","parentnodeid":"O1","ancester":"000#O#O1#","isparentflag":"0","level":"4"}
	,{"id":"O19","text":"整体分析","categoryid":"O19","parentnodeid":"O1","ancester":"000#O#O1#","isparentflag":"0","level":"4"}
	]}
	,{"id":"O2","text":"O2","categoryid":"O2","parentnodeid":"O","ancester":"000#O#","isparentflag":"1","level":"3",
	"children":[{"id":"O21","text":"概率论、数理统计","categoryid":"O21","parentnodeid":"O2","ancester":"000#O#O2#","isparentflag":"0","level":"4"}
	,{"id":"O22","text":"运筹学","categoryid":"O22","parentnodeid":"O2","ancester":"000#O#O2#","isparentflag":"0","level":"4"}
	,{"id":"O23","text":"控制论、信息论","categoryid":"O23","parentnodeid":"O2","ancester":"000#O#O2#","isparentflag":"0","level":"4"}
	,{"id":"O24","text":"计算数学","categoryid":"O24","parentnodeid":"O2","ancester":"000#O#O2#","isparentflag":"0","level":"4"}
	,{"id":"O29","text":"应用数学","categoryid":"O29","parentnodeid":"O2","ancester":"000#O#O2#","isparentflag":"0","level":"4"}
	,{"id":"O31","text":"理论力学","categoryid":"O31","parentnodeid":"O3","ancester":"000#O#O3#","isparentflag":"0","level":"4"}
	]}
	,{"id":"O4","text":"物理学","categoryid":"O4","parentnodeid":"O","ancester":"000#O#","isparentflag":"1","level":"3",
	"children":[{"id":"O41","text":"理论物理学","categoryid":"O41","parentnodeid":"O4","ancester":"000#O#O4#","isparentflag":"0","level":"4"}
	,{"id":"O42","text":"声学","categoryid":"O42","parentnodeid":"O4","ancester":"000#O#O4#","isparentflag":"0","level":"4"}
	,{"id":"O43","text":"光学","categoryid":"O43","parentnodeid":"O4","ancester":"000#O#O4#","isparentflag":"0","level":"4"}
	,{"id":"O44","text":"电磁学、电动力学","categoryid":"O44","parentnodeid":"O4","ancester":"000#O#O4#","isparentflag":"0","level":"4"}
	,{"id":"O45","text":"无线物理学","categoryid":"O45","parentnodeid":"O4","ancester":"000#O#O4#","isparentflag":"0","level":"4"}
	,{"id":"O46","text":"真空电子学","categoryid":"O46","parentnodeid":"O4","ancester":"000#O#O4#","isparentflag":"0","level":"4"}
	,{"id":"O47","text":"半导体物理学","categoryid":"O47","parentnodeid":"O4","ancester":"000#O#O4#","isparentflag":"0","level":"4"}
	]}
	,{"id":"O5","text":"O5","categoryid":"O5","parentnodeid":"O","ancester":"000#O#","isparentflag":"1","level":"3",
	"children":[{"id":"O59","text":"应用物理学","categoryid":"O59","parentnodeid":"O5","ancester":"000#O#O5#","isparentflag":"0","level":"4"}
	]}
	,{"id":"O6","text":"化学","categoryid":"O6","parentnodeid":"O","ancester":"000#O#","isparentflag":"1","level":"3",
	"children":[{"id":"O61","text":"无机化学","categoryid":"O61","parentnodeid":"O6","ancester":"000#O#O6#","isparentflag":"0","level":"4"}
	,{"id":"O62","text":"有机化学","categoryid":"O62","parentnodeid":"O6","ancester":"000#O#O6#","isparentflag":"0","level":"4"}
	,{"id":"O63","text":"高分子化学","categoryid":"O63","parentnodeid":"O6","ancester":"000#O#O6#","isparentflag":"0","level":"4"}
	,{"id":"O64","text":"物理化学","categoryid":"O64","parentnodeid":"O6","ancester":"000#O#O6#","isparentflag":"0","level":"4"}
	,{"id":"O65","text":"分析化学","categoryid":"O65","parentnodeid":"O6","ancester":"000#O#O6#","isparentflag":"0","level":"4"}
	,{"id":"O69","text":"应用化学","categoryid":"O69","parentnodeid":"O6","ancester":"000#O#O6#","isparentflag":"0","level":"4"}
	]}
	,{"id":"O7","text":"晶体学","categoryid":"O7","parentnodeid":"O","ancester":"000#O#","isparentflag":"1","level":"3",
	"children":[{"id":"O71","text":"几何晶体学","categoryid":"O71","parentnodeid":"O7","ancester":"000#O#O7#","isparentflag":"0","level":"4"}
	]}
	]}
	,{"id":"P","text":"天文学、地球科学","categoryid":"P","parentnodeid":"000","ancester":"000#","isparentflag":"1","level":"2",
	"children":[{"id":"P1","text":"天文学","categoryid":"P1","parentnodeid":"P","ancester":"000#P#","isparentflag":"1","level":"3",
	"children":[{"id":"P19","text":"时间、历法","categoryid":"P19","parentnodeid":"P1","ancester":"000#P#P1#","isparentflag":"0","level":"4"}
	]}
	,{"id":"P2","text":"测绘学","categoryid":"P2","parentnodeid":"P","ancester":"000#P#","isparentflag":"1","level":"3",
	"children":[{"id":"P20","text":"测绘学一般性问题","categoryid":"P20","parentnodeid":"P2","ancester":"000#P#P2#","isparentflag":"0","level":"4"}
	,{"id":"P27","text":"地籍学","categoryid":"P27","parentnodeid":"P2","ancester":"000#P#P2#","isparentflag":"0","level":"4"}
	,{"id":"P28","text":"地图学","categoryid":"P28","parentnodeid":"P2","ancester":"000#P#P2#","isparentflag":"0","level":"4"}
	]}
	,{"id":"P3","text":"地球物理学","categoryid":"P3","parentnodeid":"P","ancester":"000#P#","isparentflag":"0","level":"3"}
	,{"id":"P4","text":"气象学","categoryid":"P4","parentnodeid":"P","ancester":"000#P#","isparentflag":"1","level":"3",
	"children":[{"id":"P40","text":"一般理论与方法","categoryid":"P40","parentnodeid":"P4","ancester":"000#P#P4#","isparentflag":"0","level":"4"}
	,{"id":"P41","text":"气象观测","categoryid":"P41","parentnodeid":"P4","ancester":"000#P#P4#","isparentflag":"0","level":"4"}
	,{"id":"P44","text":"天气学","categoryid":"P44","parentnodeid":"P4","ancester":"000#P#P4#","isparentflag":"0","level":"4"}
	,{"id":"P45","text":"天气预报","categoryid":"P45","parentnodeid":"P4","ancester":"000#P#P4#","isparentflag":"0","level":"4"}
	,{"id":"P49","text":"应用气象学","categoryid":"P49","parentnodeid":"P4","ancester":"000#P#P4#","isparentflag":"0","level":"4"}
	]}
	,{"id":"P5","text":"地质学","categoryid":"P5","parentnodeid":"P","ancester":"000#P#","isparentflag":"0","level":"3"}
	,{"id":"P7","text":"海洋学","categoryid":"P7","parentnodeid":"P","ancester":"000#P#","isparentflag":"0","level":"3"}
	,{"id":"P9","text":"自然地理学","categoryid":"P9","parentnodeid":"P","ancester":"000#P#","isparentflag":"0","level":"3"}
	]}
	,{"id":"Q","text":"生物科学","categoryid":"Q","parentnodeid":"000","ancester":"000#","isparentflag":"1","level":"2",
	"children":[{"id":"Q1","text":"普通生物学","categoryid":"Q1","parentnodeid":"Q","ancester":"000#Q#","isparentflag":"1","level":"3",
	"children":[{"id":"Q10","text":"生命的起源","categoryid":"Q10","parentnodeid":"Q1","ancester":"000#Q#Q1#","isparentflag":"0","level":"4"}
	,{"id":"Q11","text":"生物演化与发展","categoryid":"Q11","parentnodeid":"Q1","ancester":"000#Q#Q1#","isparentflag":"0","level":"4"}
	,{"id":"Q13","text":"生物形态学","categoryid":"Q13","parentnodeid":"Q1","ancester":"000#Q#Q1#","isparentflag":"0","level":"4"}
	,{"id":"Q14","text":"生物生态学","categoryid":"Q14","parentnodeid":"Q1","ancester":"000#Q#Q1#","isparentflag":"0","level":"4"}
	]}
	,{"id":"Q2","text":"细胞学","categoryid":"Q2","parentnodeid":"Q","ancester":"000#Q#","isparentflag":"0","level":"3"}
	,{"id":"Q3","text":"遗传学","categoryid":"Q3","parentnodeid":"Q","ancester":"000#Q#","isparentflag":"0","level":"3"}
	,{"id":"Q4","text":"生理学","categoryid":"Q4","parentnodeid":"Q","ancester":"000#Q#","isparentflag":"1","level":"3",
	"children":[{"id":"Q41","text":"普通生理学","categoryid":"Q41","parentnodeid":"Q4","ancester":"000#Q#Q4#","isparentflag":"0","level":"4"}
	]}
	,{"id":"Q5","text":"生物化学","categoryid":"Q5","parentnodeid":"Q","ancester":"000#Q#","isparentflag":"1","level":"3",
	"children":[{"id":"Q50","text":"生物化学一般性问题","categoryid":"Q50","parentnodeid":"Q5","ancester":"000#Q#Q5#","isparentflag":"0","level":"4"}
	]}
	,{"id":"Q6","text":"生物物理学","categoryid":"Q6","parentnodeid":"Q","ancester":"000#Q#","isparentflag":"0","level":"3"}
	,{"id":"Q7","text":"分子生物学","categoryid":"Q7","parentnodeid":"Q","ancester":"000#Q#","isparentflag":"1","level":"3",
	"children":[{"id":"Q78","text":"遗传工程","categoryid":"Q78","parentnodeid":"Q7","ancester":"000#Q#Q7#","isparentflag":"0","level":"4"}
	]}
	,{"id":"Q8","text":"Q8","categoryid":"Q8","parentnodeid":"Q","ancester":"000#Q#","isparentflag":"1","level":"3",
	"children":[{"id":"Q9","text":"Q9","categoryid":"Q9","parentnodeid":"Q","ancester":"000#Q#","isparentflag":"1","level":"3",
	"children":[{"id":"Q91","text":"古生物学","categoryid":"Q91","parentnodeid":"Q9","ancester":"000#Q#Q9#","isparentflag":"0","level":"4"}
	,{"id":"Q93","text":"微生物学","categoryid":"Q93","parentnodeid":"Q9","ancester":"000#Q#Q9#","isparentflag":"0","level":"4"}
	,{"id":"Q94","text":"植物学","categoryid":"Q94","parentnodeid":"Q9","ancester":"000#Q#Q9#","isparentflag":"0","level":"4"}
	,{"id":"Q95","text":"动物学","categoryid":"Q95","parentnodeid":"Q9","ancester":"000#Q#Q9#","isparentflag":"0","level":"4"}
	,{"id":"Q96","text":"昆虫学","categoryid":"Q96","parentnodeid":"Q9","ancester":"000#Q#Q9#","isparentflag":"0","level":"4"}
	,{"id":"Q98","text":"人类学","categoryid":"Q98","parentnodeid":"Q9","ancester":"000#Q#Q9#","isparentflag":"0","level":"4"}
	]}
	]}
	]}
	,{"id":"S","text":"农业科学","categoryid":"S","parentnodeid":"000","ancester":"000#","isparentflag":"1","level":"2",
	"children":[{"id":"S1","text":"农业基础科学","categoryid":"S1","parentnodeid":"S","ancester":"000#S#","isparentflag":"0","level":"3"}
	,{"id":"S2","text":"农业工程","categoryid":"S2","parentnodeid":"S","ancester":"000#S#","isparentflag":"0","level":"3"}
	,{"id":"S3","text":"农学","categoryid":"S3","parentnodeid":"S","ancester":"000#S#","isparentflag":"0","level":"3"}
	,{"id":"S4","text":"植物保护","categoryid":"S4","parentnodeid":"S","ancester":"000#S#","isparentflag":"0","level":"3"}
	,{"id":"S5","text":"农作物","categoryid":"S5","parentnodeid":"S","ancester":"000#S#","isparentflag":"0","level":"3"}
	,{"id":"S6","text":"园艺","categoryid":"S6","parentnodeid":"S","ancester":"000#S#","isparentflag":"0","level":"3"}
	,{"id":"S7","text":"林业","categoryid":"S7","parentnodeid":"S","ancester":"000#S#","isparentflag":"0","level":"3"}
	,{"id":"S8","text":"畜牧、兽医、狩猎、蚕、蜂","categoryid":"S8","parentnodeid":"S","ancester":"000#S#","isparentflag":"0","level":"3"}
	,{"id":"S9","text":"水产、渔业","categoryid":"S9","parentnodeid":"S","ancester":"000#S#","isparentflag":"0","level":"3"}
	]}
	,{"id":"U","text":"交通运输","categoryid":"U","parentnodeid":"000","ancester":"000#","isparentflag":"1","level":"2",
	"children":[{"id":"U1","text":"综合运输","categoryid":"U1","parentnodeid":"U","ancester":"000#U#","isparentflag":"0","level":"3"}
	,{"id":"U2","text":"铁路运输","categoryid":"U2","parentnodeid":"U","ancester":"000#U#","isparentflag":"0","level":"3"}
	,{"id":"U4","text":"公路运输","categoryid":"U4","parentnodeid":"U","ancester":"000#U#","isparentflag":"0","level":"3"}
	,{"id":"U6","text":"水路运输","categoryid":"U6","parentnodeid":"U","ancester":"000#U#","isparentflag":"0","level":"3"}
	]}
	,{"id":"V","text":"航空、航天","categoryid":"V","parentnodeid":"000","ancester":"000#","isparentflag":"1","level":"2",
	"children":[{"id":"V1","text":"航空、航天技术的研究与探索","categoryid":"V1","parentnodeid":"V","ancester":"000#V#","isparentflag":"0","level":"3"}
	,{"id":"V2","text":"航空","categoryid":"V2","parentnodeid":"V","ancester":"000#V#","isparentflag":"0","level":"3"}
	,{"id":"V4","text":"航天（宇宙航行）","categoryid":"V4","parentnodeid":"V","ancester":"000#V#","isparentflag":"0","level":"3"}
	]}
	]}];
	var now = new Date();
	today = now.getFullYear()+'-'+(now.getMonth()+1)+'-'+now.getDate();
	$(document).ready(function(){
	var pmyGrid1={};
		pmyGrid1.id='myGrid1';
		pmyGrid1.parent='grid';
		pmyGrid1.staticsql="select bookID,title,author,b.pubname,pubdate,unitprice from books a";
		pmyGrid1.staticsql+="join pubs b on a.pubid=b.pubid ";
		pmyGrid1.gridfields="[@c%c#280]图书名称/title;[@c%c#180,2]作者/author;[@c%c#140]出版社/pubname;"+
		"[%d#110@c]出版时间/pubdate;[@c%d#110]单价/unitprice";	
		pmyGrid1.fixedfields='[@l%c#90]图书编号/bookID';
		pmyGrid1.title='';
		pmyGrid1.menu='myMenu1';
		pmyGrid1.checkbox='single';
		pmyGrid1.pagesize=10;
		pmyGrid1.keyfield='bookid';
		pmyGrid1.rownumbers=true;
		pmyGrid1.collapsible=true;
		pmyGrid1.height=310;
		pmyGrid1.width=0;
		pmyGrid1.rowindex=0;
		//定义grid
		myGrid(pmyGrid1);
		
		var jqsql={};  //sql语句中不能有双引号
		jqsql.catename="select categoryname as 'text',categoryID,ParentNodeID,Ancester,IsParentFlag,Level from "
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
		/*$("#myTree1").tree({
			checkbox: false,
			lines:true,
		});
		$.ajax({
			url: "system/easyui_getAllTreeNodes.jsp",
			data: { database: sysdatabasestring, selectsql: jqsql.catename, keyfield:'categoryid', sortfield:'' }, 
			async: false, method: 'post',    
			success: function(data) {
				console.log(data);
				var source=eval(data);
				$('#myTree1').tree({ data: source });
				console.log(source);
			},     
			error: function(err) {     
				console.log(err);     
			}     
		});*/
		
		
			$("#myTree1").tree({
				checkbox: false,
				lines:true,
				xtype:'tree',
				data: categorysource
			});
		//树的点击效果，显示对应的datagrid表格
		$('#myTree1').tree({  
			onSelect: function(node){
				if (node.isparentflag==0){
					pmyGrid1.activesql="select bookID,title,author,b.pubname ,pubdate ,unitprice from books a join pubs b on a.pubid=b.pubid where a.categoryid like '"+node.categoryid+"%'";
					console.log(pmyGrid1.activesql);
					myLoadGridData(pmyGrid1,1);	
				}
				else {
					pmyGrid1.activesql="select bookID,title,author,b.pubname ,pubdate ,unitprice from books a ";
					pmyGrid1.activesql+=" join pubs b on a.PubID=b.pubid ";
					pmyGrid1.activesql+=" join (select categoryname ,categoryID,'000' as ParentNodeID,'000#' as ancester,IsParentFlag,Level+1 as level from zz";
					pmyGrid1.activesql+=" where Level=1 ";
					pmyGrid1.activesql+=" union all ";
					pmyGrid1.activesql+=" select categoryname ,categoryID,ParentNodeID,'000#'+Ancester as ancester,IsParentFlag,Level+1 as level from zz";
					pmyGrid1.activesql+=" where Level>1 ";
					pmyGrid1.activesql+=" union all ";
					pmyGrid1.activesql+=" select '所有分类' ,'000' ,'','','1','1') p on a.categoryid=p.categoryid where p.ancester like '%"+node.categoryid+"%' ";
					console.log(pmyGrid1.activesql);
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
		myTextField('areaid','myWin1','地区编码：',70,33*0+14,18,0,232,'','');
		myTextField('areaname','myWin1','地区名称：',70,33*1+14,18,0,232,'','');
		myMenu('myMenu1','新增结点/mnaddnode/addIcon;新增子结点/mnaddsubnode/addIcon;修改结点/mneditnode/editIcon;-;删除结点/mndeletenode/deleteIcon','');
		myForm('myForm1','mform','编辑图书信息',0,20,290,720,'close;collapse;min;max');
		myFieldset('myFieldset1','myForm1','基本信息',010,10,280,355);
		myFieldset('myFieldset2','myForm1','通信信息',010,320,280,295);
		myTextField('bookid','myFieldset1','图书编码：',95,33*0+20,12,0,120,'1234567');
		myTextField('title','myFieldset1','图书名称：',95,33*1+20,12,0,160,'');
		myTextField('categoryid','myFieldset1','所属类别：',95,33*2+20,12,0,120,'');
		myTextField('categoryname','myFieldset1','类别名称：',95,33*3+20,12,0,160,'');
		myTextField('author','myFieldset1','作者：',95,33*4+20,12,0,160,'');
		myComboField('pubname','myFieldset1','出版社：',95,33*5+20,12,0,160,'','');
		myDateField('pubdate','myFieldset1','出版日期：',95,33*6+20,12,0,90,'');
		//myComboField('','myFieldset1','出版社：',95,33*6+20,210,0,60,'','');
		myTextField('unitprice','myFieldset1','单价：',95,33*7+20,12,0,90,'');
		//myTextAreaField('');
		var sql1="select pubid,pubname from pubs ";
   		var source1=myRunSelectSql('',sql1);
   		//console.log(source);
   	
   		$("#pubname").combobox({
			panelHeight: 120,
			data:source1,
			valueField: 'pubname',
			textField: 'pubname'
		});
		
		$('#myTree1').tree({  
			onContextMenu: function (e, title) {
				e.preventDefault();
				$("#myMenu1").menu('show', {
					left: e.pageX,
					top: e.pageY
				});
			}
		});
		//菜单结构和实现：新增结点、新增子节点、删除结点、修改结点
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

		$("#myWin1CancelBtn").bind('click', function(e){
			$("#myWin1").window('close');
		});//菜单结束
		$("#myTree1").tree('collapseAll');
		node=$("#myTree1").tree('getRoot');
		$("#myTree1").tree('select',node.target);
		
	});
function fn_delete(){
		
	}
	function fn_save(){
		
	}
	
	function fn_add(){
		
		}
	function fn_refresh(){
		
	}
	function myGridEvents(id,event){
		//alert(event);
		e=event.toLowerCase();
		
		if(e=='onclickcell'||e=='onselect'){
			var row=$("#myGrid1").datagrid("getSelected");
			console.log(row.bookid);
			var sql="select a.bookID,a.title,a.author,b.pubname ,a.pubdate ,a.unitprice,a.pubid,"
			+"c.categoryid,c.categoryname ,a.notes from books a join pubs b on a.pubid=b.pubid "
			+"join categories c on a.categoryid=c.categoryid where a.bookid='"+row.bookid+"'";
			//x=substring('123456789',0,4);
			//console.log(x);
			var source=[];
			
			source=myRunSelectSql('',sql);
			//console.log(source);
			$.each(source[0], function(id, value) {  //将json数据复制到表单
				var input = $("#"+id);
				//console.log(input);
				var type=input.attr('type');
				if (input!=undefined){
					if (type=='text'){ 
						input.textbox('setValue',value);
					}else if (type=='combobox'){ 
						input.combobox('setValue',value);
					}/*else if (type=='checkbox'){
						var s1=input.attr('xtext'); //子项标题
						if ((';'+value+';').indexOf(';'+s1+';')>=0) input.prop("checked", true);
						else input.prop("checked", false);*/
					else{
						input.val(value);			
					}
				}//if	
			});//each
		}
			/*onSelect:function(index,row){
				console.log(row.class);
			//*用each循环改一下
				$("#stuid").textbox('setValue',row.studentid);
				$("#stuname").textbox('setValue',row.name);
				$("#pycode").textbox('setValue',row.pycode);
				//$("#adress").textbox('setValue',x.province+x.city);
				//$("#mobile").textbox('setValue',row.mobile);
				$("#class").textbox('setValue',row.class);
				$("#gender").combobox('setValue',row.gender);
				$("#birthdate").textbox('setValue',row.birthdate);
				//$("#city").combobox('setValue',row.city);
				$("#email").textbox('setValue','');
				$("#qq").textbox('setValue','');
				$("#weixin").textbox('setValue','');
				
			}*/
			
	}
	
</script>
</body>
</html>