import java.util.*;

public class Tabuleiro {
	
	static int table[][]; //array que cria o tabuleiro
	int c = 0; // variavel que gera os numeros aleatorios
	int cordX; // coordenada X que pedimos ao utilizador
	int cordY; // coordenada Y que pedimos ao utilizador
	int contador=0; // variavel que conta o numero de jogadas
	int tamanho; //tamanho do tabuleiro
	
	public Tabuleiro(){
		int aux=1;
		do{
			try{
				//utilizador escolhe o tamanho
				System.out.println("Qual o tamanho do tabuleiro: ");
				Scanner input = new Scanner(System.in);
				this.tamanho = input.nextInt();
				if(this.tamanho < 3 || this.tamanho > 6){
					System.out.println("Insira um tamanho entre 3 e 6");
				}else{
					table = new int[this.tamanho][this.tamanho];
					aux=2;
				}
			}
			catch(Exception e){
				System.out.println("Valor errado, insira um numero inteiro");
			}
		}while(aux==1);
	}
	
	public void init(){
		int aux=1;
		do{
			try{
				//utilizador escolhe a quantidade de cores//
				System.out.println("Quantas cores quer: ");
				Scanner cor = new Scanner(System.in);
				int c = cor.nextInt();
				
				if (c < 3 || c > 6){
					System.out.println("Não tem cores suficientes (escolha entre 3 a 6)");
					
				} 
				else{
					preencheTab(c);
					printTabuleiro();
					aux=2;
				}	
			}catch(Exception e){
				System.out.println("Valor errado, insira um numero inteiro");
			}
		}while(aux==1);	
	}
	//função que preenche o tabuleiro com os numeros
	void preencheTab(int ncores){
		
		Random rand = new Random();
		
		for (int i = 0; i < table.length; i++){
			for (int j = 0; j < table.length; j++){
				table[i][j] = rand.nextInt(ncores)+1;
			}
			System.out.println();
		}
	}
	
	public static void printTabuleiro(){
		
		for (int i = 0; i < table.length; i++){
			for (int j = 0; j < table.length; j++){
				System.out.print(table[i][j]);
			}
			System.out.println();
		}
	}
	
	
	// pede as coordenadas ao utlizador,e chama recursivamente a função jogar1()
	public void jogar(){
		int aux=1;
		do{
			try{
				System.out.println("Insira a cordenada y: (tenha em atençaõ que a primeira posição do tabuleiro é (0,0))");
				Scanner inputX = new Scanner(System.in);
				cordX = inputX.nextInt();
				
				System.out.println("Insira a cordenada x: (tenha em atençaõ que a primeira posição do tabuleiro é (0,0)");
				Scanner inputY = new Scanner(System.in);
				cordY = inputY.nextInt();
				aux=2;
				// pede as cordenadas de X e Y
				jogar1();
			}catch(Exception e){
				System.out.println("Valor errado, insira um numero inteiro");
			}
		}while(aux==1);
	}
    //função utilizada para igual cordX e cordY a 0
    public void remove(){
    	table[cordX][cordY] = 0;
   }
    
    public int jogar1(){
        
        //verifica para a direita
      if( (cordX >= 0 && cordX < table.length && cordY +1 >= 0 && cordY+1 < table.length) && (table[cordX][cordY] - table[cordX][cordY+1]) == 0){
        contador++;
        table[cordX][cordY+1] = 0;
        jogar1();
      }
      //verifica para baixo
      if((cordX+1 >= 0 && cordX+1 < table.length && cordY >= 0 && cordY < table.length) && (table[cordX][cordY] - table[cordX+1][cordY]) == 0 ){
        contador++;
        table[cordX+1][cordY] = 0;
        jogar1();
      }
      //verifica a esquerda
      if((cordX >= 0 && cordX < table.length && cordY-1 >= 0 && cordY-1 < table.length) && (table[cordX][cordY] - table[cordX][cordY-1]) == 0){
        contador++;
        table[cordX][cordY-1] = 0;
        jogar1();
      }
      //verifica para cima
      if((cordX -1 >= 0 && cordX -1 < table.length && cordY >= 0 && cordY < table.length) && (table[cordX][cordY] - table[cordX-1][cordY]) == 0){
        contador++;
        table[cordX-1][cordY] = 0;
        jogar1();
      }
      else{
    	//caso em que já não há numeros iguais na vizinhança
        contador+=0;
        System.out.println("Não há mais jogadas com as coordenadas: " +  cordX + "x " + cordY + "y");
        remove();
        printTabuleiro();
        System.out.println("Já somou: " + contador + " pontos.");
        jogar();
      }
      return contador;
    }
}