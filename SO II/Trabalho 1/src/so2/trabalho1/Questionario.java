/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package so2.trabalho1;

import java.util.Scanner;

/**
 *
 * @author sfmelo
 */
public class Questionario implements java.io.Serializable {
    private static final int MAX_QUESTOES = 5;
    
    String nome;
    Questao questoes[] = new Questao[MAX_QUESTOES];
    int nquestoes;
    int nrespondido;
    
    public Questionario() {
        Scanner scanner = new Scanner(System.in);
        
        System.out.println("Nome do Questionário?");
        this.nome = scanner.nextLine();
        
        this.nquestoes = 0;
        System.out.println("Número de Perguntas? (entre 3 e 5)");
        while (this.nquestoes < 3 || this.nquestoes > 5)
            {    
                this.nquestoes = scanner.nextInt();
                if (this.nquestoes < 3 || this.nquestoes > 5)
                    System.out.println("O número de perguntas tem de ser entre 3 e 5!");
            }
        scanner.nextLine();
        
        for (int i = 1; i <= this.nquestoes; i++) {
            System.out.println("Insira pergunta nº" + i);
            this.questoes[i-1] = new Questao(i, scanner.nextLine());
        }
        
        this.nrespondido = 0;
    }
    
    public Questionario(String nome, int nPerguntas, Questao[] questoes, int nRespostas) {
        this.nome = nome;
        this.nquestoes = nPerguntas;
        this.nrespondido = nRespostas;
        
        System.arraycopy(questoes, 0, this.questoes, 0, nPerguntas);
        
        
    }
    
    public String getNome() {
        return this.nome;
    }
    
    public int getNQuestoes() {
        return this.nquestoes;
    }
    
    public int getNRespondido() {
        return this.nrespondido;
    }
    
    public String getQuestoes() {
        String s = "Perguntas do questionário \"" + this.getNome() + "\":\n";
        for (int i = 0; i < this.nquestoes; i++) {
            s += this.questoes[i].toString();
        }
        
        return s;
    }
    
    public String getMedias() {
        String s = "Média de respostas do questionário \"" + this.getNome() + "\":\n";
        for (int i = 1; i <= this.nquestoes; i++) {
            s += "Questão nº" + i + " ";
            s += Float.toString(this.questoes[i-1].getMedia()) + "\n";
        }
        
        return s;
    }
    
    public Questao getQuestao(int i) {
        return this.questoes[i];
    }
    
    public void responder() {
        Scanner scanner = new Scanner(System.in);
        int resposta;
       // this.nrespondido += 1;
        
        for (int i = 0; i < this.nquestoes; i++)
        {
            resposta = 0;
            System.out.println(this.questoes[i].toString());
            while (resposta < 1 || resposta > 10)
            {    
                resposta = scanner.nextInt();
                if (resposta < 1 || resposta > 10)
                    System.out.println("A resposta tem de ser entre 1 e 10!");
            }
            this.questoes[i].updateMedia(resposta, this.nrespondido);
        }
        
        
    }
    
}