module ALU
			#(parameter width = 32)
			 (input logic [width-1:0] a,
			  input logic [width-1:0] b,
			  input logic [3:0] control,
			  output logic [width-1:0] result,
			  output logic [3:0] ALUFlags);		//Flags en orden: n,z,c,v
			  
	
	logic [width-1:0] d0,d1,d2,d3,d4,d5,d6,d7,d8;
	
	generate
		
		sumadorNbits 
		#(width)
		sumaN(a,b,0,ALUFlags[1],d0);
		
		restadorNbits
		#(width)
		restador(a,b,d1,ALUFlags[3],ALUFlags[2],ALUFlags[0]);
		
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
