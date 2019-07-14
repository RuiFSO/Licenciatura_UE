/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package so2.trabalho1;


import java.rmi.RemoteException;
import java.rmi.server.UnicastRemoteObject;

/**
 *
 * @author sfmelo
 */

public class QuestImpl extends UnicastRemoteObject implements QuestionariosInterface, java.io.Serializable{
    
    PostgresConnector db;
    
    public QuestImpl(String host, String bd, String user, String pw) throws RemoteException, Exception{
        //super();
        db = new PostgresConnector(host, bd, user, pw);
        db.connect();
    }
    
    public void CriaQuest(Questionario questionario) throws RemoteException{
        db.queryCriaQuest(questionario);
    }
    
    public Questionario ProcuraQuestionario(String nome) throws RemoteException{
        return db.queryProcuraQuestionario(nome);
    }
    
    public String ConsultaQuest() throws RemoteException{
        return db.queryConsultaQuest();
    }
    
    public void ApagaQuestionario(Questionario questionario) throws RemoteException{
        db.queryApagaQuestionario(questionario);
    }
    
    public int RespondeQuest(Questionario questionario) throws RemoteException{
        return db.queryRespondeQuest(questionario);
    }
    
    
    public void fechaBD() throws RemoteException {
        db.disconnect();
    }
}
