/**
***********************************************
		Instituto Tecnologico de Costa Rica 
			Ingenieria en Electronica

				Extension de Inmediato
       
		Autores: Michael Gonzalez Rivera
				 Erick Cordero
				 Victor Montero
					
			Lenguaje: SystemVerilog
					Version: 1.0   
	
	Entradas:- Inmediato
				- Señales de control ImmSrc y ImmExt
				
	Restricciones:
				- Inmediato de entrada debe ser de
				27 bits
	
   Salidas: - Inmediato extendido
            
		Arquitectura de Computadores I 2019
				Prof. Ronald Garcia
***********************************************
**/
module Extend (input bit [25:0] imm,
		input  bit ImmSrc,
		output int ExtImm);

	int ext13, ext26;

	assign ext13 = { {19{imm[12]}}, imm[12:0] }; 
	assign ext26 = { {6{imm[25]}} , imm};

	assign ExtImm = (ImmSrc) ? ext13 :ext26;
endmodule 