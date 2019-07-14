/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package alergia.beans;


public class PontoAlergico {
    
    private double latitude;
    private double longitude;
    private String polinico;
    
    public PontoAlergico(Ponto p, Alergenico pol) {
        latitude = p.getLatitude();
        longitude = p.getLongitude();
        polinico = pol.getTipo();
    }
    
    public double getLatitude() {
        return latitude;
    }
    
    public double getLongitude() {
        return longitude;
    }
    
    public String getPolinico() {
        return polinico;
    }
    
    public void setLatitude(double lat) {
        latitude = lat;
    }
    
    public void setLongitude(double longi) {
        longitude = longi;
    }
    
    public void setPolinico(String pol) {
        polinico = pol;
    }
    
    public String toString() {
        return " #LOCAL [" + getLatitude() + ", " + getLongitude() + "] - " + getPolinico();
    }
}
