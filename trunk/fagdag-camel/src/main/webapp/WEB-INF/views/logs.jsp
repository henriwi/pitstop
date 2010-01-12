<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head><title>Simple jsp page</title></head>
<body>
<h1>Fagdag Logs</h1>
<%--@elvariable id="logs" type="java.util.List<no.bekk.domain.FagdagLog>"--%>
<table>
    <td>
        <th>Code</th>
        <th>Message</th>
    </td>
    <c:forEach items="${logs}" var="log">
        <tr>
            <td>${log.code}</td>
            <td>${log.message}</td>
        </tr>

    </c:forEach>
</table>

</body>
</html>