/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package alergia.beans;

public class Utilizador {
    String username;
    
    public Utilizador(String username){
        this.username=username;
    }
    
    public String getUtilizador(){
        return this.username;
    }
    
    public void setUtilizador(String username){
        this.username=username;
    }
}