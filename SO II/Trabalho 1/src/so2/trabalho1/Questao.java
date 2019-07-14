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
public class Questao implements java.io.Serializable {
    
    private String pergunta;
    private float media;
    int id;
    
    public Questao(int id, String pergunta){
        this.id=id;
        this.pergunta = pergunta;
        this.media = 0;
    }
   
    public Questao(int id, String pergunta, float media)
    {
        this.id = id;
        this.pergunta = pergunta;
        this.media = media;
    }
    
    public void setPergunta(String pergunta){
        this.pergunta=pergunta;
    }
    
    public void updateMedia(int resposta, int nRespostas){
        int soma = ( (int)this.media * (nRespostas));
        soma += resposta;
        this.media = (soma/(nRespostas+1));
    }
    
    public String getPergunta(){
        return this.pergunta;
    }
    
    public float getMedia(){
       return this.media; 
    }
    
    public int getId() {
        return this.id;
    }
    
    @Override
    public String toString(){
        return "Questão nº" + this.id + ": " + this.pergunta + "?\n";
    }
}