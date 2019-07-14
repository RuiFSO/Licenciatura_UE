/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package so2.trabalho1;

/**
 *
 * @author sfmelo
 */
public interface QuestionariosInterface extends java.rmi.Remote {
    
    public void CriaQuest(Questionario questionario) throws java.rmi.RemoteException;
    public Questionario ProcuraQuestionario(String nome) throws java.rmi.RemoteException;
    public String ConsultaQuest() throws java.rmi.RemoteException;
    public void ApagaQuestionario(Questionario questionario) throws java.rmi.RemoteException;
    public int RespondeQuest(Questionario questionario) throws java.rmi.RemoteException;
    public void fechaBD() throws java.rmi.RemoteException;
}