<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../common/taglibs.jsp" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" ></meta>
    <meta name="robots" content="none" />
	<title>资产购置申请信息列表</title>
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
				{ display: '申请编号', name: 'purchaseapplicationId', width: "100" },
				{ display: '用户名称', name: 'userId', width: "100" },
				{ display: '请购部门', name: 'purchaseDepartment', width: "100" },
				{ display: '申请人编号', name: 'applicant', width: "100" },
				{ display: '申请时间', name: 'applicationTime', width: "100" },
				{ display: '资产类型称', name: 'assettypeId', width: "100" },
				{ display: '规格型号', name: 'specificationModel', width: "100" },
				{ display: '申购数量', name: 'purchaseQuantity', width: "100" },
				{ display: '预算资金', name: 'budgetFunds', width: "100" },
				{ display: '请购理由及用途', name: 'purchaseReason', width: "100" },
				{ display: '备注', name: 'remark', width: "100" },
				{ display: '审批意见', name: 'approveOpinion', width: "100" },
				{ display: '审批人', name: 'approver', width: "100" },
				{ display: '操作',width: "140", render: function (rowdata, rowindex, value){
					var h="";
					h += "<a href='${path}/assetmanage/assetpurchaseapplication/detail?id="+rowdata.purchaseapplicationId+"' rel='pageTab' data-tabid='dwxx"+rowdata.purchaseapplicationId +"' data-tabTxt='资产购置申请详细' data-parentOpen='true' style='color:teal'>详细</a>&nbsp;|&nbsp;";
					h += "<a href='javascript:beginEdit(\"" + rowdata.purchaseapplicationId  + "\")' style='color:teal'>编辑</a>&nbsp;|&nbsp;";
					h += "<a href='javascript:itemDel(\""+rowdata.purchaseapplicationId +"\")' style='color:teal' >删除</a> ";
					return h;
				}}],
				usePager:true,
				delayLoad:true,//延迟加载
				root:'rows',
				record:'total',
	            url:"${path}/assetmanage/assetpurchaseapplication/list",
				fixedCellHeight: false,
				rownumbers:true,
				clickToEdit:false,
				width: '100%',height:'99%'
			});
			search();
			Public.pageTab();//启用链接打开tab页
		});
		function add(){
			parent.Public.addTab("","新建资产购置申请","${path}/assetmanage/assetpurchaseapplication/add");
		}
		function refresh(){
			window.location.reload();
		}
		function search(){
			grid.changePage("first");
			var params=$("#searchForm").serialize();
			grid.set("url","${path}/assetmanage/assetpurchaseapplication/list?"+params);
			grid.reload();
			return false;
		}
		function beginEdit(purchaseapplicationId ) { 
			parent.Public.addTab("dwbj"+purchaseapplicationId ,"资产购置申请编辑","${path}/assetmanage/assetpurchaseapplication/edit?id="+purchaseapplicationId );
	    }
		//删除
	    function itemDel(purchaseapplicationId ){
	    	$.ligerDialog.confirm('请不要随意删除，如要删除，请联系管理员？', function (yes) {
	    		if(yes){
		        	parent.Public.ajaxPost("${path}/assetmanage/assetpurchaseapplication/delete?id="+purchaseapplicationId ,"",function(data){
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
				<label class="b-label" for="txt_kw">用户名称：</label>
				<span class="ui-search"><input type="text" name="userId" value="${model.userId }" class="ui-input"></span>
				<label class="b-label" for="txt_kw">请购部门：</label>
				<span class="ui-search"><input type="text" name="purchaseDepartment" value="${model.purchaseDepartment }" class="ui-input"></span>
				<label class="b-label" for="txt_kw">资产类型：</label>
				<span class="ui-search"><input type="text" name="assettypeId" value="${model.assettypeId }" class="ui-input"></span>
				<label class="b-label" for="txt_kw">审批意见：</label>
				<span class="ui-search"><input type="text" name="approveOpinion" value="${model.approveOpinion }" class="ui-input"></span>
				<label class="b-label" for="txt_kw">申请人：</label>
				<span class="ui-search"><input type="text" name="approver" value="${model.approver }" class="ui-input"></span>
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