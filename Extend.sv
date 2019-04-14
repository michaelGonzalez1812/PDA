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
module Extend (input logic [26:0] imm,
					input logic ImmSrc, ImmExt,
					output logic [31:0] ExtImm);
	logic [31:0] ext14, ext27;
	assign ext14 = (ImmExt) ? { {18{ imm[13] }} , imm[13:0]} : { {18{ 1'b0 }} , imm[13:0]}; // ext de signo o de cero
	assign ext27 = (ImmExt) ? { {5{ imm[26] }} , imm} : { {5{ 1'b0 }} , imm }; // ext de signo o de cero
	assign ExtImm = (ImmSrc) ? ext27 : ext14;
endmodule 