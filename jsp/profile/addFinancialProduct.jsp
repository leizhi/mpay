<!DOCTYPE HTML>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="/jsp/incl/static.inc"%>
<fmt:bundle basename="MessageBundle">
<html>
<head>
<title><fmt:message key="Product"/></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<link id="skinCss" href="jsp/public/ISCSSobjects_style5.css" type="text/css" rel="stylesheet"/>   
<script type="text/javascript" src="jsp/public/skin.js"></script>
<script type="text/javascript" src="jsp/js/calendar.js"></script>
<script type="text/javascript" src="jsp/js/pop-lookup.js"></script>
<script type="text/javascript" src="jsp/js/util.js"></script>
</head>

<body>
<form method="post">
<div id="gtop">
	<jsp:include page="../incl/action.jsp">
		<jsp:param name="type" value="save"/>
		<jsp:param name="key" value="Edit"/>
		<jsp:param name="action" value="FinancialProduct.do"/>
		<jsp:param name="method" value="processAdd"/>
	</jsp:include>
	<jsp:include page="../incl/action.jsp">
		<jsp:param name="type" value="cancel"/>
		<jsp:param name="key" value="Cancel"/>
		<jsp:param name="action" value="FinancialProduct.do"/>
		<jsp:param name="method" value="list"/>
	</jsp:include>
</div>

<div id="container">
<%@ include file="../incl/b_message.jsp" %>

<div>
<table  class="twrap">
<tr>
<td>

<table class="modify">
<caption><fmt:message key="Add"/> <fmt:message key="FinancialProduct"/></caption>

<tbody>

<tr>
<td class="tl"><fmt:message key="Name"/></td>
<td><input type="text" name="financialProduct.financialName" size="10" maxlength="10"/><font class="fm">*</font></td>
</tr>

<tr>
<td class="tl"><fmt:message key="CycleTotal"/></td>
<td><input type="text" name="financialProduct.cycleTotal" size="10" maxlength="10"/><input type="text" name="financialProduct.cycleUnit" size="2" maxlength="2" value="月"/><font class="fm">*</font></td>
</tr>

<tr>
<td class="tl"><fmt:message key="NaturalRate"/></td>
<td><input type="text" name="financialProduct.naturalRate" size="10" maxlength="10"/><font class="fm">*</font></td>
</tr>

<tr>
<td class="tl"><fmt:message key="VouchRate"/></td>
<td><input type="text" name="financialProduct.vouchRate" size="10" maxlength="10"/><font class="fm">*</font></td>
</tr>

<tr>
<td class="tl"><fmt:message key="ChargeRate"/></td>
<td><input type="text" name="financialProduct.chargeRate" size="10" maxlength="10"/><font class="fm">*</font></td>
</tr>


<tr>
<td class="tl"><fmt:message key="FinancialMax"/></td>
<td><input type="text" name="financialProduct.financialMax" size="10" maxlength="10"/><font class="fm">*</font></td>
</tr>

<tr>
<td class="tl"><fmt:message key="FinancialMin"/></td>
<td><input type="text" name="financialProduct.financialMin" size="10" maxlength="10"/><font class="fm">*</font></td>
</tr>

<tr>
<td class="tl"><fmt:message key="MinPayPercent"/></td>
<td><input type="text" name="financialProduct.minPayPercent" size="10" maxlength="10"/><font class="fm">*</font></td>
</tr>

	
<tr>
	<td class="tl"><fmt:message key="Product" /></td>
	<td>
	<ul>
		<c:forEach var="product" items="${products}" varStatus="s">
			<li><input type="checkbox" name="productId" value="${product.id }">${product.productName }</li>
		</c:forEach>
	</ul>
</tr>

</table>
</td>
</tr>

</table>
</div>

<jsp:include page="../incl/g_footer.jsp" />
</div>
</form>
</body>
</html>
</fmt:bundle>