<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head><title>Simple jsp page</title></head>
<body>
<h1>Tires in the system</h1>
<table>
    <tr>
        <th>Id</th>
        <th>Navn</th>
    </tr>
    <c:forEach items="${tires}" var="tire">
        <tr>
        	<td><c:out value="${tire.id}"></c:out></td>
            <td><c:out value="${tire.name}"></c:out></td>
        </tr>
    </c:forEach>
</table>
</body>
</html>