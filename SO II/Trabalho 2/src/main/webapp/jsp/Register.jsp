<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<% String base = (String) application.getAttribute("base"); %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Mapa de Alergias</title>             
        <link rel="stylesheet" type="text/css" href="css/alergia.css">

    </head>
    <body>
        <jsp:include page="TopMenu.jsp" flush="true" />
        <h2>Registar utilizador!</h2>
        <form method="POST" action="<%=base%>?action=home" >
            <table border="0" cellspacing="5">
                <tr>
                    <th align="right">Insira username:</th>
                    <td align="left"><input type="text" name="reg_username"></td>
                </tr>
                <tr>
                    <th align="right">Insira password:</th>
                    <td align="left"><input type="password" name="reg_password"></td>
                </tr>
                <tr>
                    <td align="right"><input type="submit" value="Registar"></td>
                    <td align="left"><input type="reset"></td>
                    
                </tr>
            </table>
    </form>
    </body>
</html>
