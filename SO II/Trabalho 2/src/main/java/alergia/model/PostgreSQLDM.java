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

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import java.util.LinkedList;


public class PostgreSQLDM implements BusinessLogic {
    
    private String PG_HOST;
    private String PG_DB;
    private String USER;
    private String PWD;

    Connection con = null;
    Statement stmt = null;

    public PostgreSQLDM(String host, String db, String user, String pw) {
        PG_HOST=host;
        PG_DB= db;
        USER=user;
        PWD= pw;
    }

    public void connect() throws Exception {
        try {
            Class.forName("org.postgresql.Driver");
            // url = "jdbc:postgresql://host:port/database",
            con = DriverManager.getConnection("jdbc:postgresql://" + PG_HOST + ":5432/" + PG_DB,
                    USER,
                    PWD);

            stmt = con.createStatement();

        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Problems setting the connection");
        }
    }
    
    public void finish() {    // importante: fechar a ligacao 'a BD
        try {
            stmt.close();
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public Statement getStatement() {
        return stmt;
    }

    
    @Override
    public LinkedList<Ponto> getLocaisPolen(Alergenico tipoPolen) {
      
        String query = "SELECT * FROM ponto_alergico where tipo='" + tipoPolen.getTipo()+"'";
        LinkedList<Ponto> locais = new LinkedList<>();
        try{
           ResultSet ex = stmt.executeQuery(query);
           System.out.println(query);
           while(ex.next()){
               
                double tempLa = ex.getDouble("latitude"); //obtemos as coordenadas da latidude
                double tempLo = ex.getDouble("longitude"); //obtemos as coordenadas da longitude
                System.out.println(tempLa);
                System.out.println(tempLo);

                locais.add(new Ponto(tempLa, tempLo)); // adicionamos o ponto a linkedlist
           }
        }
        catch(Exception e){
            e.printStackTrace();
        }
        
        return locais;
    }

     
    
    @Override
    public long setLocalPolen(PontoAlergico pa, Utilizador user) {
        long cod = System.currentTimeMillis();
        try{
            stmt.executeUpdate("INSERT INTO ponto_alergico VALUES ("+
                    cod + ", " +
                    pa.getLatitude() + ", " + pa.getLongitude() + ", '"
                    + pa.getPolinico() + "', '" + user.getUtilizador() + "')");
        }
        catch(Exception e){
            e.printStackTrace();
        }
        
        return cod;
    }

    
    @Override
    public LinkedList<PontoID> getUserEntradas(String user) {
        String query = "SELECT * FROM ponto_alergico WHERE user_name = '" 
                + user + "'";
        LinkedList<PontoID> listaPontos = new LinkedList<>();

        try{
            ResultSet adiciona = stmt.executeQuery(query);
            Ponto p = new Ponto(0, 0);
            Alergenico a = new Alergenico("vazio");
            
            while(adiciona.next()) {
                a.setTipo(adiciona.getString("tipo"));
                p.setLatitude(adiciona.getDouble("latitude"));
                p.setLongitude(adiciona.getDouble("longitude"));
                
                listaPontos.add(new PontoID(adiciona.getLong("codigo"), new PontoAlergico(p, a)));
                
            }
            adiciona.close();
        }
        catch(Exception e){
            e.printStackTrace();
        }
        
        return listaPontos;
    }

    
    public void removeUserEntrada(long cod_id) {
        try{
            stmt.executeUpdate("DELETE FROM ponto_alergico WHERE codigo= "+cod_id);
        }
        catch(Exception e){
            e.printStackTrace();
        }
    }

    @Override
    public LinkedList<Alergenico> getAlergenicos() {
       String query = "SELECT tipo FROM alergenicos";
       LinkedList<Alergenico> listaAls = new LinkedList<>();
       
       try {
           ResultSet rs = stmt.executeQuery(query);
           
           while (rs.next()) {
           listaAls.add(new Alergenico(rs.getString("tipo")));
           }
           rs.close();
        } catch(Exception e) {
           e.printStackTrace();
       }
       
       
       return listaAls;
    }
    
    @Override
    public void addUser(String user, String pwd) {
        String query = "INSERT INTO utilizador VALUES ('" + user + "', md5('" + pwd + "'))";
        
        try {
            stmt.executeUpdate(query);
        } catch(Exception e) {
            e.printStackTrace();
        }
    }
    
    @Override
    public boolean loginUser(String user, String pwd) {
        String query = "SELECT user_name FROM utilizador WHERE user_name='" + user + "' AND user_pass=md5('" + pwd + "')";
        
        boolean flag = false;
        try {
            ResultSet rs = stmt.executeQuery(query);
            
            rs.next();
            if (rs.getString("user_name").equals(user))
                flag = true;
            else
                flag = false;
            
            rs.close();
        } catch(Exception e) {
            e.printStackTrace();
        }
        
        return flag;
    }
    
     @Override
    public void editUserAlergias(String user, LinkedList<Alergenico> alergias) {
       String query_delete = "DELETE FROM user_alergia WHERE user_name='" + user + "'";
       
       try {
           stmt.executeUpdate(query_delete);
           
           for (Alergenico a: alergias) {
               stmt.executeUpdate("INSERT INTO user_alergia VALUES('"+ user + "', '" + a.getTipo() + "')");
           }
       } catch(Exception e) {
           e.printStackTrace();
       }
    }

    @Override
    public LinkedList<Alergenico> getAlergiasUser(String user) {
        String query = "SELECT tipo FROM user_alergia WHERE user_name='"+ user + "'";
        LinkedList<Alergenico> listaAls = new LinkedList<>();
        try {
            ResultSet rs = stmt.executeQuery(query);
            
            while(rs.next()) {
                listaAls.add(new Alergenico(rs.getString("tipo")));
            }
            
            rs.close();
        } catch(Exception e) {
            e.printStackTrace();
        }
        
        return listaAls;
    }

    

    

    
}
