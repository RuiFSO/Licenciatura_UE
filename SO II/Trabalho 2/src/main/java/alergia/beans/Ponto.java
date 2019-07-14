/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package alergia.beans;

public class Ponto {
    
    private double latitude;
    private double longitude;

    public Ponto(double lat, double longi) {
        latitude = lat;
        longitude = longi;
    }
    
    public double getLatitude() {
        return latitude;
    }
    
    public double getLongitude() {
        return longitude;
    }

    public void setLatitude(double lat) {
        latitude = lat;
    }
    
    public void setLongitude(double longi) {
        longitude = longi;
    }
    
    @Override
    public String toString() {
        return " #LOCAL [" + getLatitude() + ", " + getLongitude() + "]";
    }
}