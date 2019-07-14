/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package alergia.model;

import alergia.beans.Alergenico;
import alergia.beans.Ponto;
import alergia.beans.PontoAlergico;
import alergia.beans.PontoID;
import alergia.beans.Utilizador;

import java.util.LinkedList;
import javax.servlet.ServletContext;

/**
 *
 * @author sfmelo
 */
public class DataManager implements BusinessLogic {
    
    private static PostgreSQLDM dbManager;
    
    public DataManager() {
        
    }
    
    public DataManager(ServletContext context) throws Exception {
        dbManager = new PostgreSQLDM(
                (String) context.getAttribute("PG_host"),
                (String) context.getAttribute("PG_dbname"),
                (String) context.getAttribute("PG_dbuser"),
                (String) context.getAttribute("PG_dbpwd")
        );
        
        dbManager.connect();
    }

    @Override
    public LinkedList<Ponto> getLocaisPolen(Alergenico tipoPolen) {
        return dbManager.getLocaisPolen(tipoPolen);
    }

    @Override
    public long setLocalPolen(PontoAlergico pa, Utilizador user) {
        return dbManager.setLocalPolen(pa, user);
    }

    @Override
    public LinkedList<PontoID> getUserEntradas(String user) {
        return dbManager.getUserEntradas(user);
    }

    @Override
    public void removeUserEntrada(long cod_id) {
        dbManager.removeUserEntrada(cod_id);
    }

    @Override
    public void editUserAlergias(String user, LinkedList<Alergenico> alergias) {
        dbManager.editUserAlergias(user, alergias);
    }
    
    @Override
    public LinkedList<Alergenico> getAlergenicos() {
        return dbManager.getAlergenicos();
    }
    
     @Override
    public void addUser(String user, String pwd) {
        dbManager.addUser(user, pwd);
    }

    @Override
    public boolean loginUser(String user, String pwd) {
        return dbManager.loginUser(user, pwd);
    }
    
    @Override
    public void finish() {
        dbManager.finish();
    }

    @Override
    public LinkedList<Alergenico> getAlergiasUser(String user) {
        return dbManager.getAlergiasUser(user);
    }

    

   

    
    
}
