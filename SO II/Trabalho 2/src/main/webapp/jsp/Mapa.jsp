
<%@page import="alergia.beans.PontoAlergico"%>
<%@page import="alergia.beans.Ponto"%>
<%@page import="java.util.LinkedList"%>
<%@page import="alergia.beans.Alergenico"%>
<jsp:useBean id="dataManager" scope="application" class="alergia.model.DataManager" />
<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<% 
    String base = (String)application.getAttribute("base");
    LinkedList<PontoAlergico> Pontos = new LinkedList<>(); 
%>

<table>
    <td>
        <div id="mapid" style="width: 600px; height: 400px;"></div></td>
    
    
    <td>
        <form method="post" action="<%=base%>?action=home">
        <%
            LinkedList<Alergenico> listaAls = dataManager.getAlergenicos();
            for (Alergenico al: listaAls) {
                if (request.getParameter(al.getTipo()) == null)
                {
                out.println("<input type=\"checkbox\" name=" + al.getTipo()
                        + " value=" + al.getTipo() 
                        + "> " + al.getTipo() 
                        + " <br>"); 
                } else {
                out.println("<input type=\"checkbox\" name=" + al.getTipo()
                    + " value=" + al.getTipo() 
                    + " checked=\"checked\"> " + al.getTipo() 
                    + " <br>");
                }
                if (request.getParameter(al.getTipo()) != null) {
                    LinkedList<Ponto> listaPs = dataManager.getLocaisPolen(al);
                    for (Ponto p: listaPs) {
                        Pontos.add(new PontoAlergico(p, al));
                    }
                }
            }%>
            <br>
            <input type="submit" name="atualiza_mapa" value="Atualizar">
        </form>
    </td>
</table>
<script>

    var mymap = L.map('mapid').setView([38.568, -7.91], 14.5);

    L.tileLayer('https://api.tiles.mapbox.com/v4/{id}/{z}/{x}/{y}.png?access_token=pk.eyJ1IjoibWFwYm94IiwiYSI6ImNpejY4NXVycTA2emYycXBndHRqcmZ3N3gifQ.rJcFIG214AriISLbB6B5aw', {
        maxZoom: 18,
        attribution: 'Map data &copy; <a href="https://www.openstreetmap.org/">OpenStreetMap</a> contributors, ' +
            '<a href="https://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, ' +
            'Imagery © <a href="https://www.mapbox.com/">Mapbox</a>',
        id: 'mapbox.streets'
    }).addTo(mymap);

    <%
        for (PontoAlergico pa: Pontos) {%>
            var m = L.marker([<%=pa.getLatitude()%>, <%=pa.getLongitude()%>]).addTo(mymap);
            m.bindPopup("Presença de <b><%=pa.getPolinico()%></b>").openPopup();
            
        <%} %>
    
    
    
    
    var popup = L.popup();

        function onMapClick(e) {
            popup
                .setLatLng(e.latlng)
                .setContent("Coordenadas " + e.latlng.toString())
                .openOn(mymap);
        }

        mymap.on('click', onMapClick);
       
</script>