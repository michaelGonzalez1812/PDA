// Mux de selector 3 bits
module mux3 #(parameter N=32)
				 (input logic [N-1:0] in1, in2, in3, in4, in5, in6, in7, in8,
				  input logic [2:0] sel,
				  output logic [N-1:0] out);
	assign out = (sel == 3'b0) ? in1 : (sel == 3'b1) ? in2 : (sel == 3'b10) ? in3 : (sel == 3'b11) ? in4 : 
					 (sel == 3'b100) ? in5 : (sel == 3'b101) ? in6 : (sel == 3'b110) ? in7 : in8;
endmodule

/**
***********************************************
		Instituto Tecnologico de Costa Rica 
			Ingenieria en Electronica

					Unidad de Condicion
       
		Autores: Michael Gonzalez Rivera
				 Erick Cordero
				 Victor Montero
					
			Lenguaje: SystemVerilog
					Version: 1.0         
	
	Entradas:- Banderas z, n y v
				- 2 Activadores 
				- Clock
				- Condicion
				
	Restricciones:
				- Entradas (excepto cond de 3 bits)
				son de 1 bit
	
   Salidas: - Resultado de comparar banderas
            
		Arquitectura de Computadores I 2019
				Prof. Ronald Garcia
***********************************************
**/
/*
module ConditionalUnit (input logic z, v, n, enable1, enable2, clk, // enable1 es FlagWrite/CMP, enable2 es BranchInst
								input logic [2:0] cond, // CondFlag
								output logic out); // sale PCSrc
	logic [2:0] regMem, regFlags;
	logic outCond;
	assign regFlags[0]=z;
	assign regFlags[1]=v;
	assign regFlags[2]=n;
	Register #(3) REG (regFlags, clk, enable1, regMem);
	mux3 #(1) MUX (regMem[0] & 1'b1, // z==1
					 ~(regMem[0] ^ 1'b0), // z==0
					 ~(regMem[2] ^ regMem[1]), // n==v
						regMem[2] ^ regMem[1], // n!=v
					 ~(regMem[0] ^ 1'b0) & ~(regMem[2] ^ regMem[1]), // z==0 y n==v
						(regMem[0] & 1'b1) | (regMem[2] ^ regMem[1]), // z==1 o n!=v
						1'b0, // vacio
						1'b1, // salto incondicional
						cond, outCond);
	assign out = (enable2) ? outCond : 1'b0 ;
endmodule */

import stages_definition_pkg::*;

module ConditionalUnit (input logic clk,
	input  bit [2:0] cond,
	input  conditional_flags cond_flags,
	input  bit flagWrite, memPixWrite, branch, memWrite, regWrite, pcSrc,
	output bit memPixWriteOut, memWriteOut, regWriteOut, pcSrcOut, branchOut);

	assign memPixWriteOut = memPixWrite;
	assign memWriteOut = memWrite;
	assign regWriteOut = regWrite;
	assign pcSrcOut = pcSrc;
	assign branchOut = branch;
endmodule