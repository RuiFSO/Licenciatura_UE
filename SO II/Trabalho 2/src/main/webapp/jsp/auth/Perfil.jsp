
<%@page import="alergia.beans.PontoID"%>
<%@page import="alergia.beans.PontoAlergico"%>
<%@page import="alergia.beans.Alergenico"%>
<%@page import="java.util.LinkedList"%>
<jsp:useBean id="dataManager" scope="application" class="alergia.model.DataManager" />
<%
String base = (String)application.getAttribute("base");
  String username = (String)session.getAttribute("username");
%>
<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Mapa de Alergias</title>
         <link rel="stylesheet" type="text/css" href="css/alergia.css">
    </head>
    <body>
        <jsp:include page="../TopMenu.jsp" flush="true" />
          <jsp:include page="../LeftMenu.jsp" flush="true" />
          <% if(username != null) { %>
        <table>    
        <td>
            <div align="left">
                <form method="post" action="<%=base%>?action=perfil">
                <h1>Alergias:</h1>
                <%
                    LinkedList<Alergenico> listaAls = dataManager.getAlergenicos();
                    if (request.getParameter("atualizaAlergias") != null) {
                        LinkedList<Alergenico> listaAlsUser = new LinkedList<>();
                        
                        for(Alergenico al: listaAls) {
                            if (request.getParameter(al.getTipo()) != null)
                                listaAlsUser.add(new Alergenico(al.getTipo()));
                        }
                        
                        dataManager.editUserAlergias(username, listaAlsUser);
                    }
                %><ul><%
                    LinkedList<Alergenico> listaAlsUser = dataManager.getAlergiasUser(username);
                    for (Alergenico al: listaAlsUser) {
                        out.println("<li>" + al.getTipo() + "</li>");
                    }
                %></ul>
                <h3>Editar:</h3>
                    
<%
                    for (Alergenico al: listaAls) {
                        if (listaAlsUser.contains(al)) {
                            out.println("<input type=\"checkbox\" name=" + al.getTipo()
                                + " value=" + al.getTipo() 
                                + " checked=\"checked\"> " + al.getTipo() 
                                + " <br>");
                        } else {                         
                            out.println("<input type=\"checkbox\" name=" + al.getTipo()
                                    + " value=" + al.getTipo() 
                                    + "> " + al.getTipo() 
                                    + " <br>"); 
                        }
            }%>
            <input type="hidden" name="atualizaAlergias"/>
            <input type="submit" value="Editar" />
            </form>
            </div>

    <table border="1">
        <br> <h1>Entradas: </h1>
        <tr>
            <th>Codigo de Submissão</th>
            <th>Latitude</th>
            <th>Longitude</th>
            <th>Alergenio</th>
            <th>Remover</th>
        </tr>
        
        <%    
            LinkedList<PontoID> listaEntradas = dataManager.getUserEntradas(username);
            
            for(PontoID pa: listaEntradas) {
                if (request.getParameter(Double.toString(pa.getId())) == null){ %>
                
                <tr>
                    <td><%=pa.getId()%></td>
                    <td><%=pa.getLatitude()%></td>
                    <td><%=pa.getLongitude()%></td>
                    <td><%=pa.getPolinico()%></td>
                    <td>
                        <form method="post" action="<%=base%>?action=perfil">
                            <input type="hidden" name="<%=pa.getId()%>"> 
                            <input  type="submit" value="Remover"/>
                        </form>
                    </td>
                </tr>
              <% 
                
            } else {
                    dataManager.removeUserEntrada(pa.getId());
                } 
            }
        %>
    </table>
        <% }else {
                %><p>NECESSITA DE LOGIN</p>
                <%}%>
    </body>
</html>