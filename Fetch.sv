/**
**********************************************************************
		Instituto Tecnologico de Costa Rica 
			Ingenieria en Electronica
						Fetch
       
		Autores: Michael Gonzalez Rivera
				 Erick Cordero
				 Victor Montero
					
			Lenguaje: SystemVerilog
					Version: 1.0         
	
	Entradas:- 3 operandos de entrada
				- clock
				- Fuente para leer pec
				- PC proveniente de la ALU
				
	Restricciones:
				- Entradas son de N bits 
	
   Salidas: - instrucción leida
				- PC actual
            
		Arquitectura de Computadores I 2019
				Prof. Ronald Garcia
**********************************************************************
*/
module Fetch #(parameter N = 32)
              (input  logic clk, PCsrc,
		  		   input  logic [N-1:0] PCalu,
				   output logic [N-1:0] inst,
					output logic [N-1:0] PCout);
					
	logic [N-1:0] PCin, PCplus1;
	
	Register #(N) PC (PCin, ~clk, 1'b1, PCout);
	nBitsADD #(N) Sumador (PCout, 32'b1, 1'b0, PCplus1);
	InstructionMemory #(N) memoria_instrucciones(PCout, inst);
	
	assign PCin = (PCsrc)? PCalu : PCplus1;

endmodule