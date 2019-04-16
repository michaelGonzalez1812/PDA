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
	   (input  logic clk, 
		input  bit   pcSrcWb, pcSrcExe ,
		input  int   pcWb, pcAlu,
		output int   inst, pcOut);

	logic [31:0] prePcIn, pcIn, pcPlus1;
	
	Register #(N) pc (pcIn, ~clk, 1'b1, pcOut);
	nBitsADD #(N) Sumador (pcOut, 32'b1, 1'b0, pcPlus1);
	InstructionMemory #(N) memoria_instrucciones(pcOut, inst);
	
	assign prePcIn = (pcSrcWb)?  pcWb  : pcPlus1;
	assign pcIn    = (pcSrcExe)? pcAlu : prePcIn;
endmodule