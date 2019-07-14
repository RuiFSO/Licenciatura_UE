/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package alergia.model;

import alergia.beans.Ponto;
import alergia.beans.PontoAlergico;
import alergia.beans.Alergenico;
import alergia.beans.PontoID;
import alergia.beans.Utilizador;

import java.util.LinkedList;


public interface BusinessLogic {
    
    // Obter uma lista de locais com um certo tipo de polen presente
    public abstract LinkedList<Ponto> getLocaisPolen(Alergenico tipoPolen);
    
    
    // Assinalar novo ponto alergénico
    public abstract long setLocalPolen(PontoAlergico pa, Utilizador user);
    
    // Obter lista de entradas efetuadas pelo utilizador
    public abstract LinkedList<PontoID> getUserEntradas(String user);
    
    // Remover uma entrada de um utilizador de acordo com um id
    public abstract void removeUserEntrada(long cod_id);
    
    // Receber lista de alergénicos
    public abstract LinkedList<Alergenico> getAlergenicos();
    
    
    // Recebe alergias do utilizador
    public abstract LinkedList<Alergenico> getAlergiasUser(String user);
    
    // Registar um utilizador 
    public abstract void addUser(String user, String pwd);
    
    // Login, true se existe
    public abstract boolean loginUser(String user, String pwd);
    
    // Editar preferencias de um utilizador
    public abstract void editUserAlergias(String user, LinkedList<Alergenico> alergias);

    public void finish();
    
}
