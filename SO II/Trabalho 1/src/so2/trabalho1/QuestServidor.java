/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package so2.trabalho1;

import java.rmi.Remote;

/**
 *
 * @author sfmelo
 */

public class QuestServidor implements java.io.Serializable {
    
    public static void main(String[] args) throws Exception {
        int regPort = 9000;
        
        if (args.length != 5) {
            System.out.println("Usage: java Servidor registryPort host bd user password");
            System.exit(1);
        }
        try {
            
            regPort = Integer.parseInt(args[0]);
                     
            QuestionariosInterface q ;
            q = new QuestImpl(args[1], args[2], args[3], args[4]);
            
            java.rmi.registry.LocateRegistry.createRegistry(regPort);
            
            java.rmi.registry.Registry registry = java.rmi.registry.LocateRegistry.getRegistry(regPort);
            
            registry.rebind("questionarios", (Remote) q);
            
            
        }
        catch (Exception e) {
            e.printStackTrace();
        }
        
        System.out.println("Bound RMI object in registry");
        
        System.out.println("servidor pronto");
    }
}