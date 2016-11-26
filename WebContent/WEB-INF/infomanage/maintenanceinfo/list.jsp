<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../common/taglibs.jsp" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" ></meta>
    <meta name="robots" content="none" />
	<title>维护公司信息列表</title>
	<link href="${path}/resources/ligerUI/skins/Gray/css/ligerui-all.css" rel="stylesheet" type="text/css" />	
    <link href="${path}/resources/ligerUI/skins/ligerui-icons.css" rel="stylesheet" type="text/css"/>
    <link href="${path}/resources/css/ui.css" rel="stylesheet" type="text/css" />
    <link href="${path}/resources/css/main.css" rel="stylesheet" type="text/css" />
    <link href="${path}/resources/css/main2.css" rel="stylesheet" type="text/css" />
    <link href="${path}/resources/css/base.css" rel="stylesheet" type="text/css" />
    <script src="${path}/resources/js/jquery-1.7.2.min.js" type="text/javascript"></script>
    <script src="${path}/resources/ligerUI/js/ligerui.all.js" type="text/javascript"></script>
    <script src="${path}/resources/js/config.js" type="text/javascript" ></script>
    <script src="${path}/resources/js/commonFN.js" type="text/javascript"></script>
    <script type="text/javascript">
    
	    var grid = null;
		$(document).ready(function(){
			grid = $("#maingrid").ligerGrid({
				toolbar: { items: [
					{ text: '新增', click: add, icon:'add'},               	
					{ line: true },
					{ text: '刷新', click: refresh, icon:'refresh'},
				]},
				columns: [
				{ display: '维护公司名称', name: 'maintenanceName', width: "250" },
				{ display: '维护公司联系人', name: 'maintenanceContacts', width: "150" },
				{ display: '维护公司联系人电话', name: 'maintenanceContactsPhone', width: "200" },
				{ display: '操作',width: "140", render: function (rowdata, rowindex, value){
					var h="";
					h += "<a href='${path}/infomanage/maintenanceinfo/detail?id="+rowdata.maintenanceId+"' rel='pageTab' data-tabid='dwxx"+rowdata.maintenanceId+"' data-tabTxt='维护公司详细' data-parentOpen='true' style='color:teal'>详细</a>&nbsp;|&nbsp;";
					h += "<a href='javascript:beginEdit(\"" + rowdata.maintenanceId + "\")' style='color:teal'>编辑</a>&nbsp;|&nbsp;";
					h += "<a href='javascript:itemDel(\""+rowdata.maintenanceId+"\")' style='color:teal' >删除</a> ";
					return h;
				}}],
				usePager:true,
				delayLoad:true,//延迟加载
				root:'rows',
				record:'total',
	            url:"${path}/infomanage/maintenanceinfo/list",
				fixedCellHeight: false,
				rownumbers:true,
				clickToEdit:false,
				width: '100%',height:'99%'
			});
			search();
			Public.pageTab();//启用链接打开tab页
		});
		function add(){
			parent.Public.addTab("","新建维护公司信息","${path}/infomanage/maintenanceinfo/add");
		}
		function refresh(){
			window.location.reload();
		}
		function search(){
			grid.changePage("first");
			var params=$("#searchForm").serialize();
			grid.set("url","${path}/infomanage/maintenanceinfo/list?"+params);
			grid.reload();
			return false;
		}
		function beginEdit(maintenanceId) { 
			parent.Public.addTab("dwbj"+maintenanceId,"维护公司信息编辑","${path}/infomanage/maintenanceinfo/edit?id="+maintenanceId);
	    }
		//删除
	    function itemDel(maintenanceId){
	    	$.ligerDialog.confirm('请不要随意删除，如要删除，请联系管理员？', function (yes) {
	    		if(yes){
		        	parent.Public.ajaxPost("${path}/infomanage/maintenanceinfo/delete?id="+maintenanceId,"",function(data){
		        		data=eval(data);
		        		if(data){
		        			parent.Public.tips({type: 0, content : data.message});
		        			grid.reload();
		        		}else{
		        			parent.Public.tips({type: 0, content : data.message});
		        		}
		        	});
	    		}
	    	});
	    }
	</script>
</head>
<body>
	<div class="search-wrap">
		<form id="searchForm" onsubmit="return search();" method="post">
		<dl>
			<dd>
				<label class="b-label" for="txt_kw">维护公司名称：</label>
				<span class="ui-search"><input type="text" name="maintenanceName" value="${model.maintenanceName }" class="ui-input"></span>
				<label class="b-label" for="txt_kw">维护公司联系人：</label>
				<span class="ui-search"><input type="text" name="maintenanceContacts" value="${model.maintenanceContacts }" class="ui-input"></span>
			    <input id="btnOK" type="submit" value="搜 索" class="ui-btn">
			    <input type="reset" value="重置" class="ui-btn" >
			</dd>
		</dl>
		</form>		
	</div>
	<div class="clear ht_10"></div>
    <div id="maingrid" style="margin:0; padding:0"></div>
</body>
</html>