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
		unique if(inst_head.op == PROCESSING) begin
			unique if (inst_head.immSignal == WITHOUT_IMM) begin
				unique case (inst_head.cmd)
					NOP: nop_signals (ctr_signal, RegSrcA1, RegSrcA2, bLink);
					AND: and_withoutimm (ctr_signal, RegSrcA1, RegSrcA2, bLink);
					XOR: xor_withoutimm (ctr_signal, RegSrcA1, RegSrcA2, bLink);
					SUB: sub_withoutimm (ctr_signal, RegSrcA1, RegSrcA2, bLink);
					ADD: add_withoutimm (ctr_signal, RegSrcA1, RegSrcA2, bLink);
					CMP: cmp_withoutimm (ctr_signal, RegSrcA1, RegSrcA2, bLink);
					ORR: orr_withoutimm (ctr_signal, RegSrcA1, RegSrcA2, bLink);
					MOV: mov_withoutimm (ctr_signal, RegSrcA1, RegSrcA2, bLink);
					LSL: lsl_withoutimm (ctr_signal, RegSrcA1, RegSrcA2, bLink);
					LSR: lsr_withoutimm (ctr_signal, RegSrcA1, RegSrcA2, bLink);
					MUL: mul_withoutimm (ctr_signal, RegSrcA1, RegSrcA2, bLink);
					SIN: sin_withoutimm (ctr_signal, RegSrcA1, RegSrcA2, bLink);
					COS: cos_withoutimm (ctr_signal, RegSrcA1, RegSrcA2, bLink);
				endcase
			end else if (inst_head.immSignal == WITH_IMM) begin
			/*************************************************
			 *	aun sin definir
			 ************************************************/
				unique case (inst_head.cmd)
					AND: add_withoutimm (ctr_signal, RegSrcA1, RegSrcA2, bLink);
				endcase
			end
		end else if (inst_head.op == MEMORY) begin
			unique case (inst_head.cmd[4:3])
				LDR:
				STR:
				RDP:
				WRP:
			endcase
		end else begin //FLOW

		end
	end
endmodule 