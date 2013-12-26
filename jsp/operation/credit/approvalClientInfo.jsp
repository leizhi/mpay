<!DOCTYPE HTML>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="/jsp/incl/static.inc"%>
<fmt:bundle basename="MessageBundle">
	<html>
<head>
<title><fmt:message key="ClientInfo" /></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script type="text/javascript" src="jsp/public/skin.js"></script>
<script type="text/javascript" src="jsp/js/calendar.js"></script>
<script type="text/javascript" src="jsp/js/pop-lookup.js"></script>
<script type="text/javascript" src="jsp/js/jquery-1.9.0.js"></script>
<script type="text/javascript" src="jsp/js/myhy.js"></script>
<script type="text/javascript" src="jsp/js/util.js"></script>
<script type="text/javascript">

function fun(){
	//alert("12");
	$.ajax({
		type:"post",
		url:"ClientInfo.do",//需要用来处理ajax请求的action,excuteAjax为处理的方法名，JsonAction为action名
		data:{//设置数据源
			method:"handleCheckResult",
			jobCheckid:$('#chekOne').val()		
		},
		dataType:"json",//设置需要返回的数据类型
		success:function(data){
			//var d = eval("("+data+")");//将数据转换成json类型，可以把data用alert()输出出来看看到底是什么样的结构
			//得到的d是一个形如{"key":"value","key1":"value1"}的数据类型，然后取值出来
			//alert(data.financialProduct[0]);
			$("#canp").empty();
			//var i=0;
			for(i=0;i<data.size;i++){
			$("#canp").append("<option value='"+data.results[i].id+"'>"+data.results[i].checkName+"</option>");
			}
			},
		error:function(){
			//alert("ciuo");
			//window.location.href="companycome.jsp";
		}//这里不要加","
	});
}
function sut(){

	//alert('123');
	$.ajax({
		type:"post",
		url:"ClientInfo.do",//需要用来处理ajax请求的action,excuteAjax为处理的方法名，JsonAction为action名
		data:{//设置数据源
			method:"processAddCheck",
			jobCheckId:'2',
			id:'1',
			checkRemark:'d的'
		},
		dataType:"json",//设置需要返回的数据类型
		success:function(data){
			//var d = eval("("+data+")");//将数据转换成json类型，可以把data用alert()输出出来看看到底是什么样的结构
			//得到的d是一个形如{"key":"value","key1":"value1"}的数据类型，然后取值出来
			//alert(data.financialProduct[0]);
			//$("#canp").empty();
			//var i=0;
			 var chekOne=$("#chekOne").find("option:selected").text();  //获取Select选择的Text
			 var capp=$("#canp").find("option:selected").text(); 
			 var now= new Date();  

		        var year=now.getYear()+1900;  

		        var month=now.getMonth()+1;  

		        var day=now.getDate();  

		        var hour=now.getHours();  

		        var minute=now.getMinutes();  

		        var second=now.getSeconds();  

		        var nowTime=year+"-"+month+"-"+day+" "+hour+":"+minute+":"+second;    
			if(data.reslut==1){
				$("#pp").append('<tr><td  width="100px" align="center"  class="td_css"><strong>记录</strong></td><td align="center"  class="td_css"></td><td align="center"  class="td_css">'+chekOne+'</td><td align="center"  class="td_css">'+capp+'</td><td align="left"  class="td_css" style="padding-left:4px;">'+$('#remake').val()+'</td><td align="left"  class="td_css" style="padding-left:4px;">'+nowTime+'</td></tr>');

			}else{
					alert("失败！");
				}
			},
		error:function(){
			//alert("ciuo");
			//window.location.href="companycome.jsp";
		}//这里不要加","
	});

	
}
</script>

<style>
	td{
		line-height:24px;
	}
	* {margin:0;padding:0;}
#imglist {list-style:none; width:500px; margin:50px auto;}
#imglist li {float:left; margin-top:10px;}

body,table{
 font-size:12px;
}
table{
 table-layout:fixed;
 empty-cells:show; 
 border-collapse: collapse;
 margin:0 auto;
}

h1,h2,h3{
 font-size:12px;
 margin:0;
 padding:0;
}
 
.title { background: #FFF; border: 1px solid #9DB3C5; padding: 1px; width:90%;margin:20px auto; }
 .title h1 { line-height: 31px; text-align:center;  background: #2F589C url(th_bg2.gif); background-repeat: repeat-x; background-position: 0 0; color: #FFF; }
  .title th, .title td { border: 1px solid #CAD9EA; padding: 5px; }
 
//样式一
table.tab_css_1{
 border:1px solid #cad9ea;
 color:#666;
 margin:0;
}

table.tab_css_1 td,table.tab_css_1 th{
 border:1px solid #cad9ea;
 padding:0 1em 0;
}
table.tab_css_1 td.td_css{
 background-color:#f5fafe;
}
</style>
</head>

<body>
<c:url value="/ClientInfo.do" var="defURL">
	<c:param name="method">promptApproval</c:param>
</c:url>

			<form method="post"  action="${defURL }">
			<input type="hidden" name="id" value="${clientJob.id }">
			
		<div id="gtop">
			<jsp:include page="../../incl/action.jsp">
			<jsp:param name="type" value="cancel" />
			<jsp:param name="key" value="Cancel" />
			<jsp:param name="action" value="ClientInfo.do" />
			<jsp:param name="method" value="list" />
			</jsp:include>
		</div>
		
		<%@ include file="../../incl/b_message.jsp"%>
		
				<table class="tab_css_1" width="98%" >
            		<tr>
		
                <td width="100px" align="center"  class="td_css"><strong>
                  销售顾问备注:
                </strong></td>
                <td width="88%">
                  <table class="tab_css_1" width="100%" border="1" cellpadding="0" cellspacing="0">
                        <tbody>
                            <tr>
                              <td align="left" colspan="11"> <c:out value="${clientJob.saleRemark }"/></td>
            
                            </tr>
                        </tbody>
                    </table>
                </td>
				</tr>
            </table>
		<table class="tab_css_1" width="98%" border="0" cellpadding="0" cellspacing="0" >
				<tbody>
				
					<tr height="10px">
						<td width="170px">
			  			<c:out value="身份证号在下列合同中出现："/>
			  			</td>
			  			<td>
			  			<c:forEach var="selfIdNoList" items="${selfIdNoList}" varStatus="s">
								<a href='/mpay/ClientInfo.do?method=promptApproval&id=${selfIdNoList.clientJob.id }' target="_blank" ><c:out value="${selfIdNoList.clientJob.jobNo }"/>&nbsp;</a>
						</c:forEach>	
						<c:forEach var="spuseIdNoList" items="${spuseIdNoList}" varStatus="s">
								<a href='/mpay/ClientInfo.do?method=promptApproval&id=${spuseIdNoList.clientJob.id }' target="_blank"><c:out value="${spuseIdNoList.clientJob.jobNo }"/></a>
						</c:forEach>	
						</td>			
					</tr>

					<tr height="10px">
						<td>
						<c:out value="手机号在下列合同中出现："/>
						</td>
						<td>
			  			<c:forEach var="selfPhoneList" items="${selfPhoneList}" varStatus="s">
								<a href="/mpay/ClientInfo.do?method=promptApproval&id=${selfPhoneList.clientJob.id }" target="_blank"><c:out value="${selfPhoneList.clientJob.jobNo }"/>&nbsp;</a>
						</c:forEach>
						<c:forEach var="spusePhoneNoList" items="${spusePhoneNoList}" varStatus="s">
								<a href="/mpay/ClientInfo.do?method=promptApproval&id=${spusePhoneNoList.clientJob.id }" target="_blank"><c:out value="${spusePhoneNoList.clientJob.jobNo }"/>&nbsp;</a>
						</c:forEach>
						</td>
					</tr>
					<tr height="10px">
					<td>
						<c:out value="座机号在下列合同中出现："/>
					</td>
					<td>
			  			<c:forEach var="homePhoneNoList" items="${homePhoneNoList}" varStatus="s">
								<a href='/mpay/ClientInfo.do?method=promptApproval&id=${homePhoneNoList.clientJob.id }' target="_blank"><c:out value="${homePhoneNoList.clientJob.jobNo }"/></a>
						</c:forEach>
					</td>
					</tr>
		</table>
		<table class="tab_css_1" width="98%" border="0" cellpadding="0" cellspacing="0" >
					<tr height="10px">
		
						<td height="28" colspan="2" align="right">
							销售顾问代码:
						</td>
					  <td width="17%">&nbsp;<c:out value="${UserName}"/></td>
					  <td align="right"  >内部代码</td>
					  <td>
			             <c:out  value="${clientJob.privateKey}"/>
			          </td>
			          <td >&nbsp;</td>
					</tr>

		
		<tr>
			<td colspan="6" align="center" bgcolor="#D6D6D6" style="background-color:#eafef3; line-height: 28px">
				<h2><strong>客户基本信息</strong></h2>
			</td>
		</tr>
		<tr>
		
		</tr>		
				
			</tbody>
		</table>

		<table class="tab_css_1" width="98%" border="1" cellpadding="0" cellspacing="0" >
			<tbody>
				<tr>
                	<td rowspan="5" class="td_css" width="100px"><strong>
					  客户资料
					</strong></td>
					<td colspan="6" align="right"  class="td_css">
					客户照片:
					</td>
				<td align="left" colspan="2">
				<div id="outerdiv" style="position:fixed;top:0;left:0;background:rgba(0,0,0,0.7);z-index:2;width:100%;height:100%;display:none;"><div id="innerdiv" style="position:absolute;"><img id="bigimg" style="border:5px solid #fff;" src="" /></div></div>
					<c:if test="${!empty  client.photoPath}">
						<img src='${client.photoPath} 'class="pimg" width="120" height="120">
					</c:if>
				</td>
		      </tr>
			<tr>
				<td align="right" id="guest_infoA"  class="td_css">
					姓名:
				</td>
				<td align="left" id="guest_infoB" style="padding-left:4px;">
					<c:out  value="${client.clientName}"/></td>
				<td align="right" id="guest_infoC" style="padding-left:4px;" class="td_css">
					SSI号码/学生号码:
		                            </td>
				<td align="left" id="guest_infoD" style="padding-left:4px;"><c:out   value="${ client.otherNo}"/></td>
				<td align="right" id="guest_infoE" class="td_css">
					性别:
		                            </td>
				<td align="left" id="guest_infoF" style="padding-left:4px;"><c:out   value="${ client.sex}"/></td>
				<td align="right" id="guest_infoG" class="td_css">
					申请人年龄:
				</td>
				<td align="left" id="guest_infoK" style="padding-left:4px;"><c:out   value="${ client.age}"/></td>
		
		  </tr>
			<tr>
				<td align="right"  class="td_css">
					身份证号码:
				</td>
				<td align="left" id="guest_infoB"   ><c:out   value="${client.idNo}"/></td>
		
				<td align="right" class="td_css" >
					住宅电话登记人
				</td>
				<td align="left"  style="padding-left:4px;"><c:out  value="${ client.homePhoneName}" /></td>
				<td align="right"  class="td_css">
					身份证截止日期:
				</td>
				<td align="left" i style="padding-left:4px;"><fmt:formatDate value="${client.idEndDate}" type="date" pattern="yyyy-MM-dd"/></td>
				<td align="right" class="td_css">
					发证机关:
				</td>
				<td align="left"  style="padding-left:4px;"><c:out  value="${ client.idAuthority}" /></td> 
		  </tr>
			<tr>
		
				<td align="right" class="td_css">
					住房:
				</td>
				<td align="left"  style="padding-left:4px;"><c:out  value="${ client.housing}" /></td>
				<td align="right" class="td_css">
					教育程度:
				</td>
				<td align="left" style="padding-left:4px;"><c:out  value="${client.educationId }"/></td>
				<td align="right" class="td_css">
					婚姻状况:
				</td>
				<td align="left"  style="padding-left:4px;"><c:out value="${client.marry }" /></td>
				<td align="right" class="td_css">
					子女数目:
				</td>
				<td align="left" id="guest_infoK" style="padding-left:4px;"><c:out  value="${client.childs }"/></td>
		
		  </tr>
			<tr>
		
				<td align="right" class="td_css" >
					配偶姓名:
				</td>
				<td align="left" id="guest_infoB" style="padding-left:4px;"><c:out  value="${client.spuseName}"/></td>
				<td align="right" class="td_css">
					身份证号码:
				</td>
				<td align="left"  style="padding-left:4px;"><c:out value="${client.idSpuse}"/></td>
				<td align="right" class="td_css">
					电子邮箱:
				</td>
				<td align="left" id="guest_infoF" style="padding-left:4px;"><c:out  value="${client.homePhone}"/></td>
		
		
							<td align="right" id="guest_infoG"></td>
							<td align="left" id="guest_infoK"></td>
					  </tr>
					</tbody>
				</table>
                
                <table class="tab_css_1" width="98%" >
					<tbody>
						<tr>
                        <td align="center" class="td_css" width="100px">
                        <strong>户籍地址</strong>
                        </td>
							<td >

												<c:out 
													  value="${censusAddressBook.province }" />
		          	 		</td>
							<td >
								
												<c:out 
													  value="${censusAddressBook.city }" />	
		           			</td>
							<td >
						  
												<c:out  value="${censusAddressBook.county }" />				
		           			</td>
							<td >
								
												<c:out 
													  value="${censusAddressBook.town}" 
										  />				
		        			</td>
							<td>
									<c:out 
										  value="${censusAddressBook.street}"  />
                             </td>
							<td>
									<c:out
										  value="${censusAddressBook.community}" 
										 />							</td>
							
							<td>
									<c:out 
										 value="${censusAddressBook.houseNo}" 
										 />
		        				</td>
		
								<td>
									<c:out 
										 value="${censusAddressBook.other}" />
								</td>
		
				<td align="right"  class="td_css">
					邮编:
				</td>
				<td>
									<c:out 
										  value="${censusAddressBook.zipCode}" />
				</td>
						</tr>
					</tbody>
				</table>
                <table class="tab_css_1" width="98%" >
					<tbody>
						<tr>
							<td align="center"  width="100px" class="td_css"><strong>
			 				 现居住地址
						</strong></td>
											<td>
												<c:out 
													  value="${livingAddressBook.province}" 
										 />
								</td>
							
				
								<td>
									<c:out 
										  value="${livingAddressBook.city}"   />
								</td>
							
								<td>
									<c:out 
										  value="${livingAddressBook.county}"   />
								</td>
							
								<td>
									<c:out 
										 value="${livingAddressBook.town}" 
										/>
								</td>
							
                            
								<td>
									<c:out
										 value="${livingAddressBook.street}" />
								</td>
							
                            
								<td>
									<c:out
										
										 value="${livingAddressBook.community}" />
								</td>
							
                            
								<td>
									<c:out 
										 value="${livingAddressBook.houseNo}"
									/>
								</td>
							
		
				<td  class="td_css" align="center">
					居住(月):<c:out 	value="${contract.nowMonth}" />
				</td>
				<td align="right" class="td_css">
					邮编:
				</td>
				
								<td>
									<c:out value="${livingAddressBook.zipCode}"  />
											</td>
						</tr>
					</tbody>
				</table>
                
                <table class="tab_css_1" width="98%" >
					<tbody>
						<tr>
							<td align="center" width="100px"  class="td_css"><strong> 公司地址</strong></td>
											<td>
												<c:out
													value="${officeAddressBook.province}" 
										/>
								</td>
							
								<td>
									<c:out 
										value="${officeAddressBook.city}" />
								</td>
							
								<td>
									<c:out 
										value="${officeAddressBook.county}" 
										/>
								</td>
							
								<td>
									<c:out 
										value="${officeAddressBook.town}" 
										/>
								</td>
							
								<td>
									<c:out 
										value="${officeAddressBook.street}"   />
								</td>
							
								<td>
									<c:out
										
										value="${officeAddressBook.community}" 
										
										/>
								</td>
							
								<td>
									<c:out 
										 value="${officeAddressBook.houseNo}" 
										
										/>
								</td>
							
								<td>
									<c:out 
										value="${officeAddressBook.other}" 
										/>
								</td>
				<td align="right"  class="td_css">
					邮编:
				</td>
							<td>
									<c:out
										value="${officeAddressBook.zipCode}" 
												/>
											</td>
						</tr>
					</tbody>
				</table>
                
                <table class="tab_css_1" width="98%">
					<tbody>
						<tr>
							<td align="center" width="100px"  class="td_css" ><strong>家庭成员地址</strong></td>
											<td>
												<c:out 
													value="${homeAddressBook.province}" />
								</td>
							
								<td>
									<c:out value="${homeAddressBook.city}" />
										
								</td>
								<td>
									<c:out value="${homeAddressBook.county}" />
								</td>
							
								<td>
									<c:out  value="${homeAddressBook.town}" />
								</td>
						
								<td>
									<c:out  value="${homeAddressBook.street}" />
								</td>
							
								<td>
									<c:out
										
										  value="${homeAddressBook.community}" />
								</td>
							
								<td>
									<c:out  value="${homeAddressBook.houseNo}" />
								</td>
							
								<td>
									<c:out value="${homeAddressBook.other}"/>
								</td>
							
				<td align="right"  class="td_css">
					邮编:
				</td>
				
								<td>
									<c:out value="${homeAddressBook.zipCode}" 
													/>
											</td>
						</tr>
					</tbody>
				</table>
                
                <table class="tab_css_1" width="98%" >
					<tbody>
						<tr>
                        	<td rowspan="2" width="100px" class="td_css" ><strong>联系人信息</strong></td>
                            
							<td  align="right"  class="td_css">
								家庭成员名称:
							</td>
						  <td  >
								 <c:out  value="${client.homeName}"/>
			 				 </td>
                            <td  align="right" class="td_css" >
                                家庭成员类型:
                            </td>
                          <td style="padding-left:4px;">
                                <c:out  value="${client.homeType}" />
                          </td>
                            <td  align="right" class="td_css" >
                                家庭成员电话号:
                            </td>
                            <td >
                                <c:out  value="${client.homeTelephone}" />
                          </td>
			</tr>
			<tr>
            	<td align="right"  class="td_css">
					联系人姓名:
				</td>
				<td   style="padding-left:4px;">
				  <c:out  value="${client.otherContacts}" />
				</td>
				<td align="right"  class="td_css">
					与申请人关系:
				</td>
			  <td  style="padding-left:4px;">
				  <c:out  value="${client.otherNexus}" />
			  </td>
				<td align="right"  class="td_css">
					联系电话:
				</td>
				<td id="guest_info66" style="padding-left:4px;">
					<c:out  value="${client.otherPhone}" />
				</td>
						</tr>
					</tbody>
				</table>
                
          <table class="tab_css_1" width="98%" >
					<tbody>
						<tr>
                        	<td rowspan="3" width="100px" class="td_css" ><strong>电话</strong></td>	
						  <td align="right"  class="td_css">
								本人手机号&nbsp;:			  </td>
			  <td align="left" id="guest_infoB" style="padding-left:4px;">							
			  	<c:out    value="${client.mobilePhone }"/>
			</td>
				<td align="right"  class="td_css">
					手机号码归属地:
				</td>
				<td align="left" id="guest_infoD" style="padding-left:4px;"><c:out   value="${client.mobileAddress }"/></td>
				<td align="right"  class="td_css">
					住宅电话登记人:
				</td>
				<td align="left"   style="padding-left:4px;"><c:out   value="${client.homePhoneName }"
		  /></td>
							<td align="right" class="td_css">
								住宅/宿舍电话:
							</td>
							<td align="left" id="guest_infoK" style="padding-left:4px;"><c:out value="${client.homePhone }"/></td>
		
		
			</tr>
			<tr>
			  <td align="right"  class="td_css">
					办公电话&nbsp;
			  </td>
			  <td align="left" id="guest_infoB" style="padding-left:4px;"><c:out   value="${client.onOfficePhone }"/></td>
							<td align="right"  class="td_css">
								办公电话分机:
							</td>
							<td align="left" id="guest_infoD" style="padding-left:4px;"><c:out value="${client.onExtPhone }"/></td>
				<td align="right" id="guest_infoE">家庭成员电话号</td>
				<td align="left" id="guest_infoF"><c:out value="${ client.homeTelephone}"/></td>
				<td align="right" id="guest_infoG"></td>
				<td align="left" id="guest_infoK"></td>
			</tr>
			<tr>
			  <td align="right"  class="td_css">
					配偶移动电话:
			  </td>
			  <td align="left" id="guest_infoB" style="padding-left:4px;"><c:out  value="${client.spuseMobile }"/></td>
				<td align="right"  class="td_css">
					配偶办公电话:
				</td>
				<td align="left" id="guest_infoD" style="padding-left:4px;"><c:out  value="${client.spuseOfficePhone }"/></td>
				<td align="right"  class="td_css">
					配偶办公电话分机:
				</td>
				<td align="left" id="guest_infoF" style="padding-left:4px;"><c:out   value="${client.spuseExtPhone }"/></td>
				<td align="right"  class="td_css">
					配偶雇主:
				</td>
				<td align="left" id="guest_infoF" style="padding-left:4px;"><c:out   value="${client.spuseHirer }"
		  /></td>
		
						</tr>
					</tbody>
				</table>
                
            <table class="tab_css_1" width="98%" >
					<tbody>
						<tr>
                        	<td width="100px"  rowspan="2" class="td_css"><strong>所在单位信息</strong></td>	
							<td width="125px" align="right" class="td_css">
								单位名称或大学名称:
							</td >
							<td width="127px">
												<c:out  value="${client.onShortName }"/>
								</td>
							
				<td width="125px" align="right"  class="td_css">
					单位/学校/个体全称:
				</td>
				
								<td width="11%">
									<c:out value="${client.onFullName }"
										   />
								</td>

				<td width="11%" align="right" class="td_css">
					单位性质:
				</td>
				
								<td width="12%">
									<c:out  value="${client.onFeature }"
										   />
								</td>
			
				<td width="10%" align="right" class="td_css">
					任职部门或班级:
				</td>
				
				      <td width="12%"><c:out  value="${client.onDivision }"
										   /></td>
			       
			</tr>
			<tr>
				<td align="right" class="td_css">
					行业类别:
				</td>
				
								<td>
								<c:out  value="${client.onSector }"
										  />
								</td>
						
		
				<td align="right"  class="td_css">
					职位:
				</td>
				
								<td>
									 <c:out  value="${client.onOffice }"
										  />
								</td>
							
				<td align="right" class="td_css">
					<p>
						总共工作经脸/总共大学学习时间:
					</p>
				</td>
								<td>
									<c:out  value="${client.onWorkTime }"
													  />
											</td>
										
							<td align="right" class="td_css" >
								现工作时间/大学开始时间(年):
							</td>
							
											<td>
												<label id="verifyForm_contract_xxStartTime"
													   >
													<c:out value="${client.nowWorkingTime }"/>
												</label>
											</td>
						</tr>
					</tbody>
				</table>    
                
                <table class="tab_css_1" width="98%">
					<tbody>
						<tr>
                        <td align="center" width="100px" class="td_css" ><strong> 收入资料</strong></td>
							<td align="right"  class="td_css">
								月收入总额(元):
							</td>
							<td align="left" id="guest_infoB" style="padding-left:4px;">
                                <c:out value="${client.masterInMonth }"  />
                          </td>
                            <td align="right"  class="td_css">
                                其他收入(元/月):
                            </td>
                            <td align="left" id="guest_infoD" style="padding-left:4px;">
                                <c:out  value="${client.otherInMonth }"/>
						  </td>
							<td align="right" class="td_css">
								其他收入来源:
							</td>
							<td align="left" id="guest_infoF" style="padding-left:4px;">
					<c:out value="${client.otherIncome }"/>
						  </td>
							<td align="right" class="td_css">
								家庭月收入(元):
							</td>
							<td align="left" id="guest_infoK" style="padding-left:4px;">
					<c:out  value="${client.homeInMonth }"/>
						  </td>
					  </tr>
					</tbody>
				</table>
             
             <table class="tab_css_1" width="98%" >
					<tbody>
						<tr>
						<td align="center">
                        	<c:forEach var="clientDoc" items="${docs}" varStatus="s">
								<c:out value="${clientDoc.docType}"></c:out>
							</c:forEach>
						</td>
						</tr>
					</tbody>
				</table>   
            <table class="tab_css_1" width="98%" border="1" cellpadding="0" cellspacing="0" >    
                <tr>
			<td width="100px" align="center"  class="td_css"><strong>
			  上传的图片
			</strong></td>
			<td width="88%" colspan="7">
			  <table class="tab_css_1" id="uploadfile">
		
					<tbody>
						<tr>
						<c:forEach var="clientDoc" items="${clientDocs}" varStatus="s">
							<td>
							<a href="${clientDoc.filepath}">附件${s.index }</a>
							</td>
							</c:forEach>
						</tr>
					</tbody>
				</table>
			</td>
		</tr>
        </table>
        <table class="tab_css_1" width="98%" >
        
        					<c:forEach var="sale" items="${sales}" varStatus="s">
								<tr  >
									<th colspan="6" align="left" class="tr8"><strong>商品 ${s.index }</strong></th>
								</tr>
								<tr>
			
									<td align="right"  ><b style="color:red">*</b> 商品 ${s.index }</td>
									<td align="left"><c:out value="${sale.saleName}"/></td>
									<td align="right"  >商品类型</td>
							        <td align="left"></td>
								    <td align="right"  >价格（元）</td>
									<td align="left"><c:out value="${sale.salePrice}"/></td>
								</tr>
								
								<tr>

									<td align="right"  >品牌</td>
									<td align="left"><c:out value="${sale.brand}"/></td>
									<td align="right"  >型号</td>
							        <td align="left"><c:out value="${sale.modelNo}"/></td>
								    <td align="right"  ></td>
									<td></td>
								</tr>
							</c:forEach>
				</table>
        	
            
        	<table class="tab_css_1" width="98%" >
					<tbody>
						<tr>
                        	<td rowspan="2" width="100px" class="td_css"><strong> 信用信息 </strong></td>
							<td align="right"  class="td_css">
								产品:
							</td>
							<td align="left" id="guest_info52" style="padding-left:4px;"><c:out value="${financialProduct.financialName }"/></td>
						<td align="right"  class="td_css">
							商品总价:
						</td>
					  <td align="left" id="guest_info54" style="padding-left:4px;"><c:out    value="${clientJob.totalPrice }"  /></td>
						<td align="right" class="td_css">
							贷款用途:
						</td>
					  <td align="left" id="guest_info56" style="padding-left:4px;"><c:out   value="${clientJob.byUse }"/></td>
						<td align="right"  class="td_css">
							自付金额(元):
						</td>
					  <td align="left" id="guest_info58" style="padding-left:4px;"><c:out   value="${clientJob.selfAmount }"/></td>
						<td align="right"  class="td_css">
							分期期数:
						</td>
					  <td align="left" id="guest_info60" style="padding-left:4px;"><c:out value="${financialProduct.cycleTotal }"/> </td>
		  </tr>
		  <tr>
				
				<td align="right"  class="td_css">
					每月还款额(元):
				</td>
			  <td align="left" id="guest_info52" style="padding-left:4px;"><c:out value="${clientJob.monthOfPay }"  /></td>
				<td align="right"  class="td_css">
					贷款本金(元):
				</td>
				
			  <td align="left" id="guest_info56" style="padding-left:4px;"><c:out value="${clientJob.totalPrice-clientJob.selfAmount } "/></td>
				<td align="right"  class="td_css">
					每月还款日:
				</td>
			  <td align="left" id="guest_info58" style="padding-left:4px;"><fmt:formatDate value="${clientJob.monthOfDate}" type="date" pattern="yyyy-MM-dd"/></td>
		
				<td align="right"  class="td_css">
					<label for="contract.crAgentPay-1"
										class="checkboxLabel">
										银行代扣还款
									</label>
				</td>
				<td align="left" id="guest_info60" style="padding-left:4px;" > 
		                                      					<input type="checkbox" name="contract.crAgentPay"
										value="银行代扣还款" id="contract.crAgentPay-1"
										checked="checked" disabled="disabled" size="10">
		        </td>
		        <td></td><td></td>
		  </tr>
								</tbody>
							</table>
		<table class="tab_css_1"  width="98%">
		<tr>
			<td  colspan="6" width="100px" class="td_css"><strong> 银行卡信息 </strong></td>
			</tr>
				<c:forEach var="bank" items="${banks}" varStatus="s">
				<tr>
								<td align="right"   class="td_css">
					客户银行卡号/账号:
				</td>
			  <td align="left" id="guest_info52" style="padding-left:4px;"><c:out   value="${bank.debitCard }" /></td>
							<td align="right" class="td_css">
								客户开户银行:
							</td>
						  <td align="left" id="guest_info54" style="padding-left:4px;"><c:out   value="${bank.bankName }"
	 /></td>
							<td align="right" class="td_css">
								月花费(元/月):
							</td>
						  <td align="left" id="guest_info56" style="padding-left:4px;"><c:out   value="${bank.monthPay }"/></td>
					</tr>	
				</c:forEach>
							
		</table>

		  <table class="tab_css_1"  width="98%" >
		<tbody>
					<tr>
					  <td rowspan="700" width="100px" align="center"  class="td_css">
				    <strong>征信注记 </strong></td>
						<td align="center"  class="td_css">
							编号
					  </td>
						<td align="center"  class="td_css">
							审查步骤
						</td>
						<td align="center"  class="td_css">
							结果
						</td>
						<td align="left"  class="td_css" style="padding-left:4px;">
			备注
		</td>
		<td align="left"  class="td_css" style="padding-left:4px;">
				审查时间
			</td>
			</tr>
		
				<c:forEach var="item" items="${jobChecks }"  varStatus="status">
				<tr>
					<td><c:out value="${status.index }"/> </td>
					<td><c:out value="${item.jobCheck.checkType }"/></td>
					<td><c:out value="${item.jobCheck.checkName }"/></td>
					<td><c:out value="${item.clientJobCheck.checkRemark }"/></td>
					<td><fmt:formatDate value="${item.clientJobCheck.checkTime }" type="both" /></td>
				 </tr>
				</c:forEach>
			</tbody>
		</table>
		<table class="tab_css_1"  width="98%" id="pp">
		
		</table>
		<table class="tab_css_1" width="98%" border="1" cellpadding="0" cellspacing="0"
			id="tab2">
			<tbody>
				<tr>
				  <td width="100px"  rowspan="3" align="center"  class="td_css">
		      <strong>添加新注记 </strong></td>
				  <td width="6%"  align="right" class="td_css">审查步骤:</td>
					<td width="36%" align="left">
									<select name="checkType" id="chekOne" onChange="fun()" >
										<c:forEach var="items" items="${checkTypes}" varStatus="s">
											<option value="${items.id}"
									
											<c:if test="${items.checkType==param.checkType}">
												selected="selected"
											</c:if>
												>
											${items.checkType}
											</option>
										--</c:forEach>
									</select>
						</td>
					
		<td width="15%" align="right" class="td_css" >结果：</td>
		<td width="27%"  align="left" >
		      					<select name="clientJobCheck.jobCheckId" id="canp">
										<c:forEach var="items" items="${checkNames}" varStatus="s">
											<option value="${items.id}"
									
											<c:if test="${items.id==clientJobCheck.jobCheckId}">
												selected="selected"
											</c:if>
												>
											${items.checkName}
											</option>
										--</c:forEach>
									</select>
			        
			        </td>

			<td width="8%"  id="guest_info75"></td>
		</tr>
		<tr>
			<td align="right"  class="td_css">
				备注
			:</td>
			<td  colspan="3">
				<input type="text" name="clientJobCheck.checkRemark" size="120" value="${clientJobCheck.checkRemark}" id="remake" />
		  </td>
		
		 <td id="guest_info75" >
				30汉字/60字符
		  </td>
		 </tr>
		<tr>
			<td height="25px" colspan="7"
				align="center"  >
				<input type="button" onclick="sut()" value="添加"/>
					</td>
		
				</tr>
			</tbody>
		</table>
		 <table width="98%" class="tab_css_1">
          <tr>
            <td  align="right"></td>
            <td class="td_css" align="left" colspan="2">CC<input type="text" name="clientJob.cc" maxlength="2" value="" size="6"> &nbsp;&nbsp;&nbsp;&nbsp;OC<input type="text" name="clientJob.oc" maxlength="2" size="6" value=""> &nbsp;</td>
            <td>
            </td>
          </tr>
          <tr>
            <td class="td_css" align="right">初审结果</td>
            <td width="600px">
				 <select name="clientJobTrack.jobTypeId" >
							<c:forEach var="jobType" items="${jobTypes}" varStatus="s">
								<option value="${jobType.id}"
						
								<c:if test="${jobType.id==param.clientJobTrack.jobTypeId}">
									selected="selected"
								</c:if>
									>
								${jobType.jobKey}
								</option>
							--</c:forEach>
						</select>&nbsp;
				<input type="text" name="clientJobTrack.nbf"  size="6" maxlength="2" value=""> 
                <input type="text" name="clientJobTrack.nbs"  size="6" maxlength="2" value=""> 
                <input type="text" name="clientJobTrack.nbc"  size="6" maxlength="2" value=""> 
			</td>
            <td class="td_css" align="right">原因：</td>
            <td>
				<input type="text" name="clientJobTrack.jobRemark" size="30" value=""> 
			</td>
          </tr>
          <tr>
            <td class="td_css" align="right">复审结果</td>
            <td>
				<select name="clientJobTrack.jobTypeId"  >
							<c:forEach var="jobType" items="${jobTypes}" varStatus="s">
								<option value="${jobType.id}"
						
								<c:if test="${jobType.id==param.clientJobTrack.jobTypeId}">
									selected="selected" 
								</c:if>
									>
								${jobType.jobKey}
								</option>
							</c:forEach>
						</select>&nbsp;
				<input type="text" name="codeOne" size="6" maxlength="2" value=""> 
                <input type="text" name="codeOne" size="6" maxlength="2" value=""> 
                <input type="text" name="codeOne" size="6" maxlength="2" value=""> 
			</td>
            <td class="td_css" align="right">原因：</td>
            <td>
				 <input type="text" name="codeOne" size="30" value=""> 
			</td>
          </tr>
        </table>
		<table class="tab_css_1" width="100%" cellpadding="0" cellspacing="0"
			style="display: none;">
		
		<tbody>
			<tr>
				<td colspan="2">
					<table class="tab_css_1">
						<tbody>
							<tr>
								<td>
									<textarea name="newContractState" cols="" rows=""
										id="newContractState" style="display: none;"></textarea>
									</td>
								</tr>
		
							</tbody>
						</table>
					</td>
				</tr>
			</tbody>
		</table>
		
		<table class="tab_css_1" width="98%" >
            		<tr>
		
                <td width="100px" align="center"  class="td_css"><strong>
                  销售顾问备注:
                </strong></td>
                <td width="88%">
                  <table class="tab_css_1" width="100%" border="1" cellpadding="0" cellspacing="0">
                        <tbody>
                            <tr>
                              <td align="left" colspan="11">
									<c:out value="${clientJob.saleRemark }"/>
							</td>
            
                            </tr>
                        </tbody>
                    </table>
                </td>
				</tr>
            </table>
				<tbody>
					<tr> 
							<td> <center><strong><h2>审批日志</h2></strong></center></td>
					</tr>
				</tbody>
			</table>
		<table class="tab_css_1" width="98%">
            <tbody>
            <tr>	<td  class="textr"><fmt:message key="ID"/></td>
					<td  class="textr"><fmt:message key="UserName"/></td>
					<td  class="textr"><fmt:message key="State"/></td>
					<td  class="textr"><fmt:message key="JobType"/></td>
					<td  class="textr"><fmt:message key="JobRemark"/></td>
					<td  class="textr"><fmt:message key="JobDate"/></td>
					
				</tr>
				<c:forEach var="clientJobTracks" items="${clientJobTracks}" varStatus="status">
				<tr <c:if test="${status.index%2==0 }">bgcolor="#ffffff"</c:if>  onMouseOver="trMouseOver(this);" onMouseOut="trMouseOut(this);">
				<td><c:out value="${clientJobTracks.clientJobTrack.id }"/></td>
				<td><c:out value="${clientJobTracks.user.name }"/></td>
				<td><c:out value="${clientJobTracks.jobType.nextState }"/></td>
				<td><c:out value="${clientJobTracks.jobType.jobKey }"/></td>
				<td><c:out value="${clientJobTracks.clientJobTrack.jobRemark }"/></td>
				<td><fmt:formatDate value="${clientJobTracks.clientJobTrack.jobDate }" type="both" /></td>
				</tr>
				</c:forEach>
				</tbody>
		</table>
		<table class="tab_css_1" width="98%" border="0" cellpadding="0" cellspacing="0"
			id="tab2">
			<tbody>
				<tr>
					<td width="52%" style="height: 22px;" >
					<center>
						<jsp:include page="../../incl/actionb.jsp" >
							<jsp:param name="key" value="Confirm" />
							<jsp:param name="action" value="ClientInfo.do" />
							<jsp:param name="method" value="processApproval" />
						</jsp:include>
					</center>
					</td>
			</tr>
		</tbody>
					</table>
				</form>
</body>
	</html>
</fmt:bundle>
