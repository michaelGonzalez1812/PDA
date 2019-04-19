module MUX #(parameter width = 3)
	   (input logic [width-1:0] d0, d1, d2, d3, d4, d5, d6, d7, d8,
		input logic [3:0] s,
		output logic [width-1:0] result);
			  
	assign result = s[3] ? (d5) : (s[2] ? (s[1] ? (s[0] ? (d4) : (d7) ) : (s[0] ? (d2) : (d6) )) : (s[1] ? (s[0] ? (d3) : (d0) ) : (s[0] ? (d1) : (d8) ) ));	
endmodule

module nopNbits #(parameter N = 32)
	   (input logic [N-1:0] A,
		input logic [N-1:0] B,
		output logic [N-1:0] Q);
		 
	assign Q = A;		 
endmodule 

module multiplicadorNbits #(parameter N = 32)
	   (input logic [N-1:0] A,
		input logic [N-1:0] B,
		output logic [N-1:0] Q);
		 
	assign Q = A*B; 
endmodule 

module xorN #(parameter N=32)
	   (input logic[N-1: 0] A,
		input logic[N-1: 0] B,
		output logic[N-1: 0] Q);
	 
	assign Q = A^B;
endmodule

module srlN #(parameter width =32)
	   (input logic [width-1:0] a,
		input logic [width-1:0] b,
		output logic [width-1:0] y);
		
	assign y = a >> b;
endmodule

module sllN #(parameter width =32)
	   (input logic [width-1:0] a,
		input logic [width-1:0] b,
		output logic [width-1:0] y);
		
	assign y = a << b;
endmodule

module orN #(parameter width =32)
	   (input logic [width-1:0] a,
		input logic [width-1:0] b,
		output logic [width-1:0] y);
		
	assign y = a | b;
endmodule

module andN #(parameter width =32)
       (input logic [width-1:0] a,
		input logic [width-1:0] b,
		output logic [width-1:0] y);

	assign y = a & b;
endmodule

module restadorNbits #(parameter N = 32)
	   (input logic [N-1:0] A,
		input logic [N-1:0] B,
		output logic [N-1:0] Q,
		output logic negativo,
		output logic zero,
		output logic overflow);

	always @* begin
		Q <= A-B;
		overflow <= 0;

		if(Q == 0) begin 
			zero <= 1;
		end else if(A<B)begin
			negativo <= 1;
		end else begin 						
			zero <= 0;
			negativo <= 0;
		end
	end			
endmodule 

module sumador1bit(
		input  A1bit, B1bit, Cin1bit,
		output logic Q1bit, Cout1bit);

	assign Q1bit = A1bit^B1bit^Cin1bit;
	assign Cout1bit =  (A1bit & B1bit) | (A1bit & Cin1bit) | (B1bit & Cin1bit);
endmodule

module sumadorNbits #(parameter N = 32)
	   (input logic [N-1:0] A,
		input logic [N-1:0] B,
		input logic Cin,
		output logic Cout,
		output logic [N-1:0] Q);
		
	logic [N:0] carrys;
	assign carrys[0] = Cin;
	genvar i;
		
	generate	
		for (i=0;i<N;i=i+1) begin : sumador_completo
			sumador1bit sumai(A[i],B[i],carrys[i],Q[i],carrys[i+1]);
		end
	endgenerate
	
	assign Cout = carrys[N];
endmodule 

module ALU #(parameter width = 32)
	   (input logic [width-1:0] a,
		input logic [width-1:0] b,
		input logic [3:0] control,
		output logic [width-1:0] result,
		output logic [3:0] ALUFlags);		//Flags en orden: n,z,c,v
			  
	
	logic [width-1:0] d0, d1, d2, d3, d4, d5, d6, d7, d8;
	
	generate
		
		sumadorNbits 
		#(width)
		sumaN(a, b, 0, ALUFlags[1], d0);
		
		restadorNbits
		#(width)
		restador(a, b, d1, ALUFlags[3], ALUFlags[2], ALUFlags[0]);
		
		andN
		#(width)
		andgate(a,b,d2);
		
		orN
		#(width)
		orgate(a,b,d3);
		
		sllN
		#(width)
		shiftL(a,b,d4);
		
		srlN
		#(width)
		shiftR(a,b,d5);
		
		xorN
		#(width)
		xorgate(a,b,d6);

		multiplicadorNbits
		#(width)
		multi(a,b,d7);

		nopNbits
		#(width)
		nop(a,b,d8);
		
		
		//Elige resultado de acuerdo a la documentación
		MUX
		#(width)
		muxresult(d0,d1,d2,d3,d4,d5,d6,d7,d8,control,result);
	endgenerate
endmodule
