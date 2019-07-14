
<%@page import="java.util.LinkedList"%>
<%@page import="alergia.beans.Alergenico"%>
<%
  String base = (String)application.getAttribute("base");
  String username = (String)session.getAttribute("username");
%>

<jsp:useBean id="dataManager" scope="application" class="alergia.model.DataManager" />
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Mapa Alergias</title>
        <link rel="shortcut icon" type="image/x-icon" href="docs/images/favicon.ico" />

    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.5.1/dist/leaflet.css"
        integrity="sha512-xwE/Az9zrjBIphAcBb3F6JVqxf46+CDLwfLMHloNu6KEQCAWi6HcDUbeOfBIptF7tcCzusKFjFw2yuvEpDL9wQ=="
        crossorigin="" />
    <script src="https://unpkg.com/leaflet@1.5.1/dist/leaflet.js"
        integrity="sha512-GffPMF3RvMeYyc1LWMHtK8EbPv0iNZ8/oTtHPx9/cc2ILxQ+u905qIwdpULaqDkyBKgOaB57QTMg7ztg8Jm2Og=="
        crossorigin=""></script>
    <link rel="stylesheet" type="text/css" href="css/alergia.css">

    </head>
    </head>
    <body>
        <jsp:include page="../TopMenu.jsp" flush="true" />
        <jsp:include page="../LeftMenu.jsp" flush="true" />
        <jsp:include page="../Mapa.jsp" flush="true" />
        <% if (username != null) { %>
            
        <form method="post" action="<%=base%>?action=pontomarcado">
        <table>
            <tr>
                <th align="right">Latitude:</th>
                <td align="left"><input type="number" step="any" name="latitude" ></td>
            </tr>
            <tr>
                <th align="right">Longitude:</th>
                <td align="left"><input type="number" step="any" name="longitude"></td>
            </tr>
            <tr>
                <th align="right">Alergenico:</th>
                <td align="left">
                <select name="alergenico">
                    <%
                        LinkedList<Alergenico> listaAls = dataManager.getAlergenicos();
                        for (Alergenico al: listaAls) {
                            out.println("<option value= " + al.getTipo() + " name=\"alergenico\"> " + al.getTipo() + "</option>");
                        }
                        %>
               </select>
                </td>
            </tr>
            <tr>
                <td align="right"><input type="submit" value="Ok"></td>

            </tr>
        </table>
        </form>
              <% } else { %>
              <p>NECESSITA DE LOGIN</p>
              <%}%>
    </body>
</html>
