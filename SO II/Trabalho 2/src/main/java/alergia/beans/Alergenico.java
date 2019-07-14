/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package alergia.beans;


public class Alergenico {
    private String tipo;
    
    public Alergenico(String t) {
        tipo = t;
    }
    
    public String getTipo() {
        return tipo;
    }
    
    public void setTipo(String t) {
        tipo = t;
    }
}
