<%@page language="java" contentType="text/html"%>
<jsp:useBean id="dataManager" scope="application" class="alergia.model.DataManager" />
<% String base = (String)application.getAttribute("base");
    String username = (String)session.getAttribute("username");
%>
<nav>
    
<% 
    
    if (username == null) { %>
    <jsp:include page="Login.jsp" flush="true"/>
    <form method="post" action="<%=base%>?action=register">
        <input type="submit" value="Registar" />
        
        <% 
            
    %>
    </form>
  
  
<% } else { %>
<p>User: <%=username%></p>
<ul>
    <li><a href="<%=base%>?action=assinalar"> Assinalar</a></li>
    <li><a href="<%=base%>?action=passeio"> Meu Passeio</a></li>
    <li><a href="<%=base%>?action=perfil"> Meu Perfil</a></li>
</ul>
    
    <form method="post" action="?action=home">
        <input type="hidden" name="logout"/> 
        <input type="submit" name="" value="Log Out" />
    </form>
<% }%>

</nav>