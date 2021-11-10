public class ask2_erg1{
	public static void main(String args[]){
		int aL=2, aR=3;
		int bL=3, bR=4;
		int A[][] = new int [aL][aR];
		int B[][] = new int [bL][bR];
		int C[][] = new int [aL][bR];
		
		int i=0, j=0, x=0;;
		
		//Matrix from Exercise 2
		/*
		A[0][0]=2;	A[0][1]=3;	A[0][2]=1;
		A[1][0]=0;	A[1][1]=2;	A[1][2]=2;		
		
		B[0][0]=1;	B[0][1]=0;	B[0][2]=1;	B[0][3]=2;
		B[1][0]=2;	B[1][1]=3;	B[1][2]=0;	B[1][3]=1;
		B[2][0]=5;	B[2][1]=1;	B[2][2]=2;	B[2][3]=1;
		*/
		
		//Randomize matrix A with 0-9 integers.
		for(i=0; i<aL; i++){
			for(j=0; j<aR; j++){
				A[i][j] = (int)(Math.random()*9);
			}
		}
		
		//Randomize matrix B with 0-9 integers.
		for(i=0; i<bL; i++){
			for(j=0; j<bR; j++){
				B[i][j] = (int)(Math.random()*9);
			}
		}
		
		//Here C becomes A*B
		for(i=0; i<aL; i++){
			for(j=0; j<bR; j++){
				C[i][j]=0;
				for(x=0; x<aR; x++){
					C[i][j] += A[i][x] * B[x][j];
				}
			}
		}
		
		//Prints matrix A
		System.out.print("\nMATRIX A :\n");
		for(i=0; i<aL; i++){
			for(j=0; j<aR; j++){
				System.out.print(A[i][j] + " ");
			}
			System.out.print("\n");
		}
		
		//Prints matrix B
		System.out.print("\nMATRIX B :\n");
		for(i=0; i<bL; i++){
			for(j=0; j<bR; j++){
				System.out.print(B[i][j] + " ");
			}
			System.out.print("\n");
		}
		
		//Prints matrix C
		System.out.print("\nMATRIX C = A * B :\n");
		for(i=0; i<aL; i++){
			for(j=0; j<bR; j++){
				System.out.print(C[i][j] + " ");
			}
			System.out.print("\n");
		}
	}
}
