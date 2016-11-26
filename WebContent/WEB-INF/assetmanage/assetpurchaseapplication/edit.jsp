<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../common/taglibs.jsp" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="content-type" content="text/html;charset=utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" ></meta>
    <meta name="robots" content="none" />
    <title>资产购置申请信息编辑</title>    
	<link href="${path}/resources/ligerUI/skins/Gray/css/ligerui-all.css" rel="stylesheet" type="text/css"> 
	<link href="${path}/resources/css/main2.css" rel="stylesheet" type="text/css" />
    <link href="${path}/resources/css/ui.css" rel="stylesheet" type="text/css" />
    <link href="${path}/resources/css/base.css" rel="stylesheet" type="text/css" />
    
    <script src="${path}/resources/My97DatePicker/WdatePicker.js"  type="text/javascript"></script>
    <script src="${path}/resources/js/jquery-1.7.2.min.js" type="text/javascript"></script>
    <script src="${path}/resources/ligerUI/js/ligerui.all.js" type="text/javascript"></script>
    <script type="text/javascript">
	    $(document).ready(function(){
			var oldParams=$("#sub_form").serialize();
			$("#btnSaveNext").bind("click",function(){
				var flag=checkUser();
				if(!flag){
					var url="${path}/assetmanage/assetpurchaseapplication/save";
					var params=$("#sub_form").serialize();
					parent.Public.ajaxPost(url,params,saveNext);
				}
			});
			$("#btnSave").bind("click",function(){
				var flag=checkUser();
				if(!flag){
					var url="${path}/assetmanage/assetpurchaseapplication/save";
					var params=$("#sub_form").serialize();
					parent.Public.ajaxPost(url,params,save);
				}
			});
			$("#btnClose").bind("click",function(){
				var params=$("#sub_form").serialize();
				if(oldParams!=params){
					$.ligerDialog.confirm('您有信息未保存，是否关闭？', function (yes) { 
						if(yes) parent.tab.removeSelectedTabItem();
					});
				}else{
					parent.tab.removeSelectedTabItem();					
				}
			});
		});
		function saveNext(data){
			data=eval(data);
			if(data.state){
				parent.Public.reloadTab(parent.SYSTEM.dwlb);
				parent.Public.tips({type: 0, content : data.message});
				window.location.reload();
			}else{
				parent.Public.tips({type: 1, content : data.message});
			}
		}
		function save(data){
			data=eval(data);
			if(data.state){
				parent.Public.reloadTab(parent.SYSTEM.dwlb);
				parent.Public.tips({type: 0, content : data.message});
				var tabId=parent.tab.getSelectedTabItemID();
				parent.Public.addTab("dwxx"+data.param,"资产购置申请详细","${path}/assetmanage/assetpurchaseapplication/detail?id="+data.param);
				parent.Public.pageTabClose(tabId);
			}else{
				parent.Public.tips({type: 1, content : data.message});
			}
		}
		
		//检查当前资产购置申请用户编号
		function checkUser(){
			var name=$("#userId").val();
			var flag=true;
			$.ajax({
				type:"post",
				async:false,
				url:"${path}/assetmanage/assetpurchaseapplication/checkAssetpurchaseapplication",
				data:{name:name,id:"${model.purchaseapplicationId }"},
	    		dataType:'json',
	    		contentType:"application/x-www-form-urlencoded; charset=utf-8",	
	    		success:function(data){
	    			if(data){
	    				parent.Public.tips({type: 2, content : '资产购置申请用户编号已存在！'});
	    				flag=true;
	    			}else{
						flag=false;
	    			}
	    		},
	    		error:function(){
	    			flag=true;
	    		}
			});
			return flag;
		}
    </script>
</head>
    <body>
       <div class="man_zone">
            <form id="sub_form" action="${path }/assetmanage/assetpurchaseapplication/save" method="post">
            <table class="op_tb">
            	<caption style="text-align: center;">
            		<c:choose>
            			<c:when test="${empty model.purchaseapplicationId }">资产购置申请</c:when>
            			<c:otherwise>
            				资产购置申请信息修改
            				<input type="hidden" name="purchaseapplicationId" value="${model.purchaseapplicationId  }" />
            			</c:otherwise>
            		</c:choose>
            	</caption>
                <tbody>
                    <tr>
                        <td class="label">
                            	经办人：
                        </td>
                        <td>
                        <select name="userId">
									<c:forEach items="${userList }" var="item">
										<option
											<c:if test="${ item.userId eq model.userId }">selected</c:if>
											value="${item.userId }">${item.userId }-${item.userName }</option>
									</c:forEach>
						</select>*
                        <%-- <select name="userId">
									<c:forEach items="${userList }" var="item">
										<option
											<c:if test="${ item.userId eq model.userId }">selected</c:if>
											value="${item.userId }">${item.userId }-${item.userName }</option>
									</c:forEach>
						</select> --%>
                            <%-- <input type="text" name="userId" id="userId" value="${model.userId }"/> --%>
                        </td>
                    </tr>
                    <tr>
                        <td class="label">
                            	请购部门：
                        </td>
                        <td>
                            <select name="purchaseDepartment">
                        		
                        		<option <c:if test='${ "综合办" eq model.purchaseDepartment }'>selected</c:if> value="综合办" >综合办</option>
                        		<option <c:if test='${ "总工办" eq model.purchaseDepartment }'>selected</c:if> value="总工办" >总工办</option>
                        		<option <c:if test='${ "财务室" eq model.purchaseDepartment }'>selected</c:if> value="财务室" >财务室</option>
                        		<option <c:if test='${ "信息开发科" eq model.purchaseDepartment }'>selected</c:if> value="信息开发科" >信息开发科</option>
                        		<option <c:if test='${ "通信管理科" eq model.purchaseDepartment }'>selected</c:if> value="通信管理科" >通信管理科</option>
                        		<option <c:if test='${ "网络事业科" eq model.purchaseDepartment }'>selected</c:if> value="网络事业科" >网络事业科</option>
                        		<option <c:if test='${ "工程部" eq model.purchaseDepartment }'>selected</c:if> value="工程部" >工程部</option>
                        		<option <c:if test='${ "政务处理中心" eq model.purchaseDepartment }'>selected</c:if> value="政务处理中心" >政务处理中心</option>
                        		<option <c:if test='${ "项目部" eq model.purchaseDepartment }'>selected</c:if> value="项目部" >项目部</option>
                        	</select>*
                            <%-- <input type="text" name="purchaseDepartment" id="purchaseDepartment" value="${model.purchaseDepartment }"/> --%>
                        </td>
                    </tr>
                    <tr>
                        <td class="label">
                            	申请人编号：
                        </td>
                        <td>
                        <select name="applicant">
									<c:forEach items="${applicantList }" var="item">
										<option
											<c:if test="${ item.applicant eq model.applicant }">selected</c:if>
											value="${item.applicant }">${item.applicant }</option>
									</c:forEach>
						</select>*
                            <%-- <input type="text" name="applicant" id="applicant" value="${model.applicant}" /> --%>
                        </td>
                    </tr>
                    
                    <tr>
                        <td class="label">
                            	申请时间：
                        </td>
                        <td>
                            <%-- <input type="text" name="applicationTime" id="applicationTime" value="${model.applicationTime }"/> --%>
                         <input type="text" name="applicationTime" class="Wdate" style="300px" value="${model.applicationTime }" 
                            onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"
                            datatype="/^\s*$|^\d{4}\-\d{1,2}\-\d{1,2}\s{1}(\d{1,2}:){2}\d{1,2}$/"
                            errormsg="请选择正确的日期" />*
                        </td>
                    </tr>
                    <tr>
                        <td class="label">
                            	资产名称编号及名称：
                        </td>
                        <td>
                        <select name="assetnameId">
									<c:forEach items="${assetnameList }" var="item">
										<option
											<c:if test="${ item.assetnameId eq model.assetnameId }">selected</c:if>
											value="${item.assetnameId }">${item.assetnameId }-${item.assetName }</option>
									</c:forEach>
						</select>*
                            <%-- <input type="text" name="assetnameId" id="assetnameId" value="${model.assetnameId }"/> --%>
                        </td>
                    </tr>
                    <tr>
                        <td class="label">
                            	规格型号：
                        </td>
                        <td>
                            <input type="text" name="specificationModel" id="specificationModel" value="${model.specificationModel}" />*
                        </td>
                    </tr>
                    
                    <tr>
                        <td class="label">
                            	申购数量：
                        </td>
                        <td>
                            <input type="text" name="purchaseQuantity" id="purchaseQuantity" value="${model.purchaseQuantity }"/>*
                        </td>
                    </tr>
                    <tr>
                        <td class="label">
                            	预算资金：
                        </td>
                        <td>
                            <input type="text" name="budgetFunds" id="budgetFunds" value="${model.budgetFunds }"/>*
                        </td>
                    </tr>
                    <tr>
                        <td class="label">
                            	请购理由及用途：
                        </td>
                        <td>
                            <input type="text" name="purchaseReason" id="purchaseReason" value="${model.purchaseReason}" />*
                        </td>
                    </tr>
                    
                    <tr>
                        <td class="label">
                            	 备注：
                        </td>
                        <td>
                            <input type="text" name="remark" id="remark" value="${model.remark }"/>
                        </td>
                    </tr>
                    <tr>
                        <td class="label">
                            	审批意见：
                        </td>
                        <td>
                            <input type="text" name="approveOpinion" id="approveOpinion" value="${model.approveOpinion }"/>
                        </td>
                    </tr>
                    <tr>
                        <td class="label">
                            	审批人：
                        </td>
                        <td>
                            <input type="text" name="approver" id="approver" value="${model.approver}" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" class="toolbottom" align="center">
	                        <c:if test="${empty model.purchaseapplicationId}">
								<input type="button" class="ui-btn ui-btn-sp" id="btnSaveNext" value="保存并新建" />&nbsp;&nbsp;
							</c:if>
							<input type="button" class="ui-btn ui-btn-sp" id="btnSave" value="保存" />&nbsp;&nbsp;
						    <input type="button" class="ui-btn-rad button blue" id="btnClose" value="关闭" />
                        </td>
                    </tr>
                </tbody>
            </table>   
            </form>
        </div>
    </body>
</html>