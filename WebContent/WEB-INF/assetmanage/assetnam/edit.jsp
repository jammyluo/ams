<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../common/taglibs.jsp" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="content-type" content="text/html;charset=utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" ></meta>
    <meta name="robots" content="none" />
    <title>资产名称信息编辑</title>    
	<link href="${path}/resources/ligerUI/skins/Gray/css/ligerui-all.css" rel="stylesheet" type="text/css"> 
	<link href="${path}/resources/css/main2.css" rel="stylesheet" type="text/css" />
    <link href="${path}/resources/css/ui.css" rel="stylesheet" type="text/css" />
    <link href="${path}/resources/css/base.css" rel="stylesheet" type="text/css" />
    
    <script src="${path}/resources/js/jquery-1.7.2.min.js" type="text/javascript"></script>
    <script src="${path}/resources/ligerUI/js/ligerui.all.js" type="text/javascript"></script>
    <script type="text/javascript">
	    $(document).ready(function(){
			var oldParams=$("#sub_form").serialize();
			$("#btnSaveNext").bind("click",function(){
				var flag=checkUser();
				if(!flag){
					var url="${path}/assetmanage/assetnam/save";
					var params=$("#sub_form").serialize();
					parent.Public.ajaxPost(url,params,saveNext);
				}
			});
			$("#btnSave").bind("click",function(){
				var flag=checkUser();
				if(!flag){
					var url="${path}/assetmanage/assetnam/save";
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
				parent.Public.addTab("zcmcxx"+data.param,"资产名称详细","${path}/assetmanage/assetnam/detail?id="+data.param);
				parent.Public.pageTabClose(tabId);
			}else{
				parent.Public.tips({type: 1, content : data.message});
			}
		}
		
		//检查当前资产名
		function checkUser(){
			var name=$("#assetName").val();
			var flag=true;
			$.ajax({
				type:"post",
				async:false,
				url:"${path}/assetmanage/assetnam/checkAssetnam",
				data:{name:name,id:"${model.assetnameId}"},
	    		dataType:'json',
	    		contentType:"application/x-www-form-urlencoded; charset=utf-8",	
	    		success:function(data){
	    			if(data){
	    				parent.Public.tips({type: 2, content : '资产名称已存在！'});
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
            <form id="sub_form" action="${path }/assetmanage/assetnam/save" method="post">
            <table class="op_tb">
            	<caption style="text-align: center;">
            		<c:choose>
            			<c:when test="${empty model.assetnameId}">资产名称信息录入</c:when>
            			<c:otherwise>
            				资产名称信息修改
            				<input type="hidden" name="assetnameId" value="${model.assetnameId }" />
            			</c:otherwise>
            		</c:choose>
            	</caption>
                <tbody>
                   <%--  <tr>
                        <td class="label">
                            	资产名称编号：
                        </td>
                        <td>
                            <input type="text" name="assetnameId" id="assetnameId" value="${model.assetnameId }"/>
                        </td>
                    </tr> --%>
					<tr>
                        <td class="label">
                            	资产名称：
                        </td>
                        <td>
                            <input type="text" name="assetName" id="assetName" value="${model.assetName }"/>*
                        </td>
                    </tr>
                    <tr>
                        <td class="label">
                            	关联资产类别编号及名称：
                        </td>
                        <td>
                            <select name="assetType">
									<c:forEach items="${assetclaList }" var="item">
										<option
											<c:if test="${ item.assettypeid eq model.assetType }">selected</c:if>
											value="${item.assettypeid }">${item.assettypeid }-${item.assettypename }</option>
									</c:forEach>
							</select>* 
                            <%-- <input type="text" name="assetType" id="assetType" value="${model.assetType }"/> --%>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" class="toolbottom" align="center">
	                        <c:if test="${empty model.assetnameId }">
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