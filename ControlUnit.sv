/**
***********************************************
		Instituto Tecnologico de Costa Rica 
			Ingenieria en Electronica

					Unidad de Control
       
		Autores: Michael Gonzalez Rivera
				 Erick Cordero
				 Victor Montero
					
			Lenguaje: SystemVerilog
					Version: 1.0         
	
	Entradas:- Cabecera de instruccion
				
	Restricciones:
				- La cabecera debe ser de 10 bits
	
   Salidas: - Señales de control
            
		Arquitectura de Computadores I 2019
				Prof. Ronald Garcia
***********************************************
**/

import stages_definition_pkg::*;
import cu_definitions_pkg::*;

module ControlUnit(input inst_header inst_head,
		output deco_exe_cu_signals ctr_signal, 
		output bit RegSrcA1, RegSrcA2, bLink);
	always_comb begin
		if(inst_head.op == PROCESSING) begin
			if (inst.immSignal == WITHOUT_IMM) begin
				if (inst.cmd == AND) begin
					add_without (ctr_signal, RegSrcA1, RegSrcA2, bLink);
				end
			end
		end
	end
endmodule 