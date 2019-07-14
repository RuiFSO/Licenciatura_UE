/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package so2.trabalho1;


import java.sql.*;
import java.util.*;
/**
 *
 * @author rui
 */
public class PostgresConnector{

    private String PG_HOST;
    private String PG_DB;
    private String USER;
    private String PWD;

    Connection con = null;
    Statement stmt = null;

    public PostgresConnector(String host, String db, String user, String pw) {
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

    public void disconnect() {    // importante: fechar a ligacao 'a BD
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
    
    public Questionario queryProcuraQuestionario(String nome) {
        Questionario q = null;
        int nPerguntas = 0;
        int nRespostas = 0;
        int MAX_QUESTOES = 5;
        Questao questoes[] = new Questao[MAX_QUESTOES];
        
        try {
            ResultSet rs = stmt.executeQuery("select numero_respostas from questionario where nome_questionario = '" + nome + "'");
            
            rs.next();
            nRespostas = rs.getInt("numero_respostas");
            rs.close();
            
            rs = stmt.executeQuery("select id, pergunta, media from questao where nome_questionario = '" + nome + "' order by id ");
            
            while (rs.next()) {    
                questoes[nPerguntas] = new Questao(rs.getInt("id"), rs.getString("pergunta"), rs.getFloat("media"));
                nPerguntas += 1;
            } 
            
            rs.close();
            
            q = new Questionario(nome, nPerguntas, questoes, nRespostas);
            
        } catch(Exception e) {
            e.printStackTrace();
        }
        
        return q;
    }
    
    
    public void queryCriaQuest(Questionario questionario){
          
            try{
                stmt.executeUpdate("Insert into questionario values ('" + questionario.getNome() + "', 0)");
            }
            catch(Exception e){
                e.printStackTrace();
            }
           
            
            for(int i = 0; i < questionario.getNQuestoes(); i++){
                try{
                    stmt.executeUpdate("Insert into questao values ('" + questionario.getNome()+ 
                                                                "', " + questionario.getQuestao(i).getId() + 
                                                                ", '" + questionario.getQuestao(i).getPergunta() + 
                                                                "', 0)");
                }
                catch(Exception e){
                    e.printStackTrace();
                }
            }

    }
    
    public String queryConsultaQuest(){
        
        String query = "SELECT * from questionario";
        String listaQ = "";
        
        try{
            ResultSet imprime = stmt.executeQuery(query);
            
            while(imprime.next()){
                
                String aux = imprime.getString("nome_questionario");
                
                listaQ+=aux + "\n";
            }
            
            imprime.close();
        }
        catch(Exception e){
            e.printStackTrace();
        }
        
        return listaQ;
    }
    
    
    public void queryApagaQuestionario(Questionario questionario){
        
        try{
            stmt.executeUpdate("DELETE FROM questao WHERE nome_questionario" + "= '" + questionario.getNome() + "'");
            stmt.executeUpdate("DELETE FROM questionario WHERE nome_questionario" + "= '" + questionario.getNome() + "'");
                
            }
            
        catch(Exception e){
            e.printStackTrace();
        }
    }
    
     public int queryRespondeQuest(Questionario questionario){
        
        int codigo = 0;
        int n_respostas;
        String query = "SELECT * from codigo";
        
        try{
            
            for (int i = 0; i < questionario.getNQuestoes(); i++)
                stmt.executeUpdate("UPDATE questao SET media=" + questionario.questoes[i].getMedia() + " WHERE nome_questionario= '" + questionario.getNome() + "' and id=" + (i+1));
            
            
            try (ResultSet aux = stmt.executeQuery("SELECT numero_respostas from questionario WHERE nome_questionario = '" + questionario.getNome() + "'")) {
                aux.next();
                n_respostas = aux.getInt("numero_respostas");
                n_respostas++;
                stmt.executeUpdate("UPDATE questionario SET numero_respostas = " + n_respostas);
                aux.close();
            }
            
            
            
            try (ResultSet aux = stmt.executeQuery(query)) {
                aux.next();
                codigo = aux.getInt("cod");
                codigo++;
                stmt.executeUpdate("UPDATE codigo SET cod = " + codigo);
                aux.close();
            }
        }
        catch(Exception e){
            e.printStackTrace();
        }
        
        return codigo;
    }
}