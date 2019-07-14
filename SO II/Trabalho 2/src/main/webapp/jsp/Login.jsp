<%@page language="java" contentType="text/html" %>
<!DOCTYPE html>
<%
  String base = (String)application.getAttribute("base");
%>

    <form method="POST" action="<%=base%>?action=home" >
            <table border="0" cellspacing="5">
                <tr>
                    <th align="right">Username:</th>
                    <td align="left"><input type="text" name="user_name"></td>
                </tr>
                <tr>
                    <th align="right">Password:</th>
                    <td align="left"><input type="password" name="user_password"></td>
                </tr>
                <tr>
                    <td align="right"><input type="submit" value="Log In"></td>
                    <td align="left"><input type="reset"></td>
                    
                </tr>
            </table>
    </form>
