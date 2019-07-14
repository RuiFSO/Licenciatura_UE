/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package so2.trabalho1;


import java.rmi.RemoteException;
import java.util.Scanner;
/**
 *
 * @author rui
 */
public class QuestCliente implements java.io.Serializable{
    
    public String regHost;
    public String regPort;
    public Scanner scanner;
    
    public QuestCliente(String regHost, String regPort){
        this.regHost=regHost;
        this.regPort=regPort;
        this.scanner = new Scanner(System.in);
    }
    
    void menuErro(){
        while(!scanner.hasNextInt()){
            System.out.println("A opção não existe");
            System.out.println("Menu:\n"
                    + "1: Criar questionario\n"
                    + "2: Consultar questionarios\n"
                    + "3: Obter perguntas de um questionario\n"
                    + "4: Responder a questionario\n"
                    + "5: Obter medias de um questionario\n"
                    + "6: Apagar questionario\n"
                    + "7: Sair");
            scanner.next();
        }
    }
    
    void menu(QuestionariosInterface q) throws RemoteException{
        Scanner scanner = new Scanner(System.in);
        Questionario quest;
        String nome;
          
          while(true){
              
              System.out.println("Menu:\n"
                    + "1: Criar questionario\n"
                    + "2: Consultar questionarios\n"
                    + "3: Obter perguntas de um questionario\n"
                    + "4: Responder a questionario\n"
                    + "5: Obter medias de um questionario\n"
                    + "6: Apagar questionario\n"
                    + "7: Sair");
              
              int input = scanner.nextInt();
              
              switch(input){
                  
                case 1:
                    Questionario questionario = new Questionario();
                    q.CriaQuest(questionario);
                    break;
           
                case 2:
                    System.out.println("Lista de questionários:");
                    System.out.println(q.ConsultaQuest());
                    break;

                case 3:
                    System.out.println("Qual o questionário do qual quer obter perguntas?");
                    System.out.println(q.ConsultaQuest());
                    scanner.nextLine();
                    nome = scanner.nextLine();
                    quest = q.ProcuraQuestionario(nome);
                    System.out.println(quest.getNome());
                    
                    System.out.println("Perguntas desse questionário:");
                    System.out.println(quest.getQuestoes());
                    break;

                case 4:
                    System.out.println("Qual o questionário que deseja responder?");
                    System.out.println(q.ConsultaQuest());
                    scanner.nextLine();
                    nome = scanner.nextLine();
                    quest = q.ProcuraQuestionario(nome);
                    
                    quest.responder();
                    q.RespondeQuest(quest);
                    break;

                case 5:
                    System.out.println("De qual questionário quer saber médias de respostas?");
                    System.out.println(q.ConsultaQuest());
                    scanner.nextLine();
                    nome = scanner.nextLine();
                    quest = q.ProcuraQuestionario(nome);
                    
                    System.out.println(quest.getMedias());
                    break;

                case 6:
                    System.out.println("Qual o questionário que quer apagar?");
                    System.out.println(q.ConsultaQuest());
                    scanner.nextLine();
                    nome = scanner.nextLine();
                    quest = q.ProcuraQuestionario(nome);
                    
                    q.ApagaQuestionario(quest);
                    break;

                case 7:
                    q.fechaBD();
                    System.exit(0);
                    break;
              }
          } 
    }
    
    public void run() {
        try {
            QuestionariosInterface q = (QuestionariosInterface) java.rmi.Naming.lookup("rmi://" + regHost + ":" +
                                                                                        regPort + "/questionarios");
            menu(q);
        } catch (Exception e)
        {
            e.printStackTrace();
        }
    }
    
    public static void main(String[] args) {
        if (args.length !=2) { 
	    System.out.println
		("Usage: java QuestCliente registryHost registryPort");
	    System.exit(1);
	}
        
	QuestCliente c = new QuestCliente(args[0], args[1]);
	
        c.run();  
    }
}