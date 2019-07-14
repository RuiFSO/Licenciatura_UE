
<%@page import="alergia.beans.Utilizador"%>
<%@page import="alergia.beans.PontoAlergico"%>
<%@page import="alergia.beans.Alergenico"%>
<jsp:useBean id="dataManager" scope="application" class="alergia.model.DataManager" />
<%@page import="alergia.beans.Ponto"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Mapa de Alergias</title>
        <link rel="stylesheet" href="https://unpkg.com/leaflet@1.5.1/dist/leaflet.css"
        integrity="sha512-xwE/Az9zrjBIphAcBb3F6JVqxf46+CDLwfLMHloNu6KEQCAWi6HcDUbeOfBIptF7tcCzusKFjFw2yuvEpDL9wQ=="
        crossorigin="" />
    <script src="https://unpkg.com/leaflet@1.5.1/dist/leaflet.js"
        integrity="sha512-GffPMF3RvMeYyc1LWMHtK8EbPv0iNZ8/oTtHPx9/cc2ILxQ+u905qIwdpULaqDkyBKgOaB57QTMg7ztg8Jm2Og=="
        crossorigin=""></script>         
    <link rel="stylesheet" type="text/css" href="css/alergia.css">

    </head>
    <body>
        <jsp:include page="../TopMenu.jsp" flush="true" />
        <jsp:include page="../LeftMenu.jsp" flush="true" />
        <jsp:include page="../Mapa.jsp" flush="true" />
    </body>
    
    <%
        Ponto p = new Ponto(Float.parseFloat(request.getParameter("latitude")), Float.parseFloat(request.getParameter("longitude")));
        Alergenico a = new Alergenico((String)request.getParameter("alergenico"));
        PontoAlergico pa = new PontoAlergico(p, a);
        Utilizador u = new Utilizador((String)session.getAttribute("username"));
        
        long cod_sub = dataManager.setLocalPolen(pa, u);
    %>
    
    <p>Ponto submetido com sucesso: #<%=cod_sub%>.</p>
</html>
