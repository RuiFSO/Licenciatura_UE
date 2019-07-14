<jsp:useBean id="dataManager" scope="application" class="alergia.model.DataManager" />

<% String base = (String)application.getAttribute("base"); %>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Mapa de Alergias</title>
        <link rel="stylesheet" href="css/alergia.css" type="text/css" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link rel="shortcut icon" type="image/x-icon" href="docs/images/favicon.ico" />

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
        <td>
    </td>

        
    </body>
</html>
