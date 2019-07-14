/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package alergia;

import alergia.model.DataManager;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class AlergiaServlet extends HttpServlet {
    
    
    public AlergiaServlet() {
        super();
    }
    
    @Override
    public void init(ServletConfig config) throws ServletException {
        try {
            super.init(config);
            System.out.println("*** initializing controller servlet."); // para logs
            System.out.println("Aplicacao - CONTEXT Path: " + getServletContext().getContextPath());
            
            ServletContext context = config.getServletContext();
            // 2 atributos com recebidas de web.xml
            context.setAttribute("base", config.getInitParameter("base"));
            context.setAttribute("imageURL", config.getInitParameter("imageURL"));
            
            // Configuracoes de Postgres no web.xml
            context.setAttribute("PG_host", config.getInitParameter("PG_host"));
            context.setAttribute("PG_dbname", config.getInitParameter("PG_dbname"));
            context.setAttribute("PG_dbuser", config.getInitParameter("PG_dbuser"));
            context.setAttribute("PG_dbpwd", config.getInitParameter("PG_dbpwd"));
            
            
            DataManager dataManager = new DataManager(context);
            
            // atributo com o objeto que gera aceso a bd (partilhado por componentes web)
            context.setAttribute("dataManager", dataManager);
        } catch (Exception ex) {
            Logger.getLogger(AlergiaServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    @Override
    public void destroy() {
        ServletContext context = this.getServletContext();
        DataManager dataManager = (DataManager) context.getAttribute("dataManager");
        if (dataManager != null) {
            try {
                // terminar ligacao
                dataManager.finish();
            }
            catch (Exception e) {
                System.err.println("PROBLEMA AO FINALIZAR: " + e.getMessage());
            }
        }
    }
    
    
    
    

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String base = "/jsp/";
        String url = base + "index.jsp";
        String action = request.getParameter("action");
        if (action != null) {
            if (action.equals("register")) {
                url = base + "Register.jsp";
            } else if (action.equals("entradas")) {
                url = base + "auth/Entradas.jsp";
            } else if (action.equals("perfil")) {
                url = base + "auth/Perfil.jsp";
            } else if (action.equals("passeio")) {
                url = base + "auth/Passeio.jsp";
            } else if (action.equals("assinalar")) {
                url = base + "auth/Assinalar.jsp";
            } else if (action.equals("pontomarcado")) {
                url = base + "auth/PontoMarcado.jsp";
            } else if (action.equals("home")) {
                if (request.getParameter("reg_username") != null) { // registar utilizador
                    ServletContext context = this.getServletContext();
                    DataManager dataManager = (DataManager) context.getAttribute("dataManager");
                    dataManager.addUser(request.getParameter("reg_username"), request.getParameter("reg_password"));
                }
                
                if (request.getParameter("user_name") != null) {     // fazer login
                    ServletContext context = this.getServletContext();
                    DataManager dataManager = (DataManager) context.getAttribute("dataManager");
                    if (dataManager.loginUser(request.getParameter("user_name"), request.getParameter("user_password"))) {
                        HttpSession session = request.getSession();
                        session.setAttribute("username", request.getParameter("user_name"));
                    }
                }
                
                if (request.getParameter("logout") != null) {
                    HttpSession session = request.getSession();
                    session.invalidate();
                }
                url = base + "index.jsp";
            } else if (action.equals("registofeito")) {
                url = base + "RegistoFeito.jsp";
            }
        }
        
       // encaminhar o processamento para o Componente Web adequado
        RequestDispatcher requestDispatcher
                = getServletContext().getRequestDispatcher(url);
        requestDispatcher.forward(request, response);
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
