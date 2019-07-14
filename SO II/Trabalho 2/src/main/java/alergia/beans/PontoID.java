/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package alergia.beans;

public class PontoID {
    private long id;
    private double latitude;
    private double longitude;
    private String polinico;
    
    public PontoID(long i, PontoAlergico pa) {
        id = i;
        latitude = pa.getLatitude();
        longitude = pa.getLongitude();
        polinico = pa.getPolinico();
    }
    
    public long getId() {
        return id;
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
    
    public void setId(long i) {
        id = i;
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
    
  
}
