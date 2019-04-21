module MUXE(input logic [7:0] e0,e1,
			  input logic s,
			  output logic [7:0] d);
			  
	assign d = s ? e1:e0;
	
endmodule

module MUXM_Neg(input logic [23:0] m0,m1,
			  input logic s,
			  output logic [23:0] d);
			  
	assign d = s ? m0:m1;
	
endmodule

module complement(input logic[7: 0] A,
	 output logic[7: 0] Q);
	 
	 //Bit mas significativo para hacer el xor
	 logic msb;
	 assign msb = A[7];
	 
	 //resultado del xor
	 logic [7:0] res;
	 
	 //bits para xor con bit msb (1 o 0)
	 logic [7:0] xorbits;
	 
	 //bits para suma de uno
	 logic [7:0] sum;
	 assign sum = 8'b00000001;
	 //carry in para la suma
	 logic carryin;
	 assign carryin = 0;
	 logic carryout;
		
	 always @* begin
		if(msb==0) begin
			xorbits<=8'b00000000;
		end
		else begin
			xorbits<=8'b11111111;
		end
	 end
	 
	 
	 XORN
	 xorn(xorbits,A,res);
	 
	 sumadorNbits 
	 #(8)
	 sumaN(res,sum,carryin,carryout,Q);
	 
	 
endmodule

module MUXM(input logic [22:0] m0,m1,
			  input logic s,
			  output logic [22:0] d);
			  
	assign d = s ? m1:m0;
	
endmodule

module restadorNbits #(parameter N = 8)
			(input logic [N-1:0] A,
			 input logic [N-1:0] B,
			 output logic [N-1:0] Q);

				assign Q = A-B;
			
endmodule 

module srlN(input logic [22:0] mantisa,
		 input logic [7:0] corrimiento,
		 output logic [22:0] y);
	
	assign y = mantisa >> corrimiento;
	
endmodule

module sumador1bit(
		input  A1bit,
		B1bit,
		Cin1bit,
		output logic Q1bit,
		Cout1bit);

		assign Q1bit = A1bit^B1bit^Cin1bit;
		assign Cout1bit =  (A1bit & B1bit) | (A1bit & Cin1bit) | (B1bit & Cin1bit);
endmodule
		
module sumadorNbits #(parameter N = 23)
		(input logic [N-1:0] A,
		 input logic [N-1:0] B,
		 input logic Cin,
		 output logic Cout,
		 output logic [N-1:0] Q);
		 
	    logic [N:0] carrys;
		 assign carrys[0] = Cin;
		 genvar i;
		 
		 generate
			
			for(i=0;i<N;i=i+1)begin:sumador_completo
				sumador1bit sumai(A[i],B[i],carrys[i],Q[i],carrys[i+1]);
			end
			
		endgenerate
		
		assign Cout = carrys[N];
		 
endmodule 

module XORN(input logic [7:0] A,
	 input logic [7:0] B,
	 output logic [7:0] C);
	 
	 assign C = A^B;
endmodule


module FlotingPointOP (input logic [31:0] A,
				  				input logic [31:0] B,
				  				output logic [31:0] result);
				  
	///Separar mantisas, exponentes  signos			  
	logic sign;
	assign sign = A[31];
	
	logic [7:0] expA;
	assign expA = A[30:23];
	logic [7:0] expB;
	assign expB = B[30:23];
	
	logic [22:0] mantA;
	assign mantA = A[22:0];
	logic [22:0] mantB;
	assign mantB = B[22:0];
	
	//variables para mux1
	logic [22:0] resultMux1;
	
	//variables para mux2
	logic [22:0] resultMux2;
	
	///Variables del resultado
	logic [7:0] expRes;
	
	//comparar exponentes
	restadorNbits 
	#(8)
	restaN(expA,expB,expRes);

	//variables de control
	logic control1;
	logic control2;
	assign control1 = expRes[7];
	assign control2 = expRes[7];
	
	//MUX mantisas 1
	MUXM
	muxM1(mantA, mantB, control1, resultMux1);
		
	//MUX mantisas 2
	MUXM_Neg
	muxM2(mantA, mantB, control2, resultMux2);
	
	//resultado para el complemento
	logic[7: 0] expComp;
	
	//complemento
	complement
	complemento(expRes,expComp);
	
	//Resultado de shift
	logic[22:0] corri;
	
	//shift
	srlN
	srlN(resultMux2,expComp,corri);
	
	//variables para la suma
	logic carryin;
	assign carryin = 0;
	logic carryout;
	logic [22:0] sumaRes;
	 
	//suma de mantisas
	sumadorNbits 
	#(23)
	sumaN(corri,resultMux1,carryin,carryout,sumaRes);

	//variables para la suma
	logic carryin2;
	assign carryin2 = 0;
	logic carryout3;
	logic [22:0] sumaRes2;
	 
	//suma de mantisas
	sumadorNbits 
	#(23)
	sumaN2(sumaRes,23'b1,carryin2,carryout3,sumaRes2);
	 
	//shift de normalizacion
	logic[22:0] corrinormal2;
	
	sllN
	alineamiento1(sumaRes2,1,corrinormal2);
	
	
	//shift de normalizacion
	logic[22:0] corrinormal;
	logic[7:0] carryExtnd;
	assign carryExtnd = carryout;
	
	srlN
	alineamiento(corrinormal2,2,corrinormal);


	
	//variables para muxE
	logic [7:0] resultMuxE;
	logic controlE;
	assign controlE = expRes[7];
	
	//mux exponentes
	MUXE
	muxE(expA, expB, controlE, resultMuxE);
	
	//variables para la suma
	//logic carryin2;
	//assign carryin2 = 0;
	logic carryout2;
	logic [7:0] sumaResF;
	
	//suma para alinear
	sumadorNbits 
	#(8)
	sumaExp(resultMuxE,1,carryout,carryout2,sumaResF);
	
	//Unir
	assign result = {sign,sumaResF[7:0], corrinormal[22:0]};

endmodule
	