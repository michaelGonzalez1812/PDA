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
		output bit RegSrcA1, RegSrcA2, bLink,
		output bit immSrc);
	
	always_comb begin
		unique if(inst_head.op == PROCESSING) begin
			unique case (inst_head.cmd)
				NOP: nop (ctr_signal, RegSrcA1, RegSrcA2, bLink, immSrc);
				AND: and_signals (ctr_signal, RegSrcA1, RegSrcA2, bLink, immSrc);
				XOR: xor_signals (ctr_signal, RegSrcA1, RegSrcA2, bLink, immSrc);
				SUB: sub (ctr_signal, RegSrcA1, RegSrcA2, bLink, immSrc);
				ADD: add (ctr_signal, RegSrcA1, RegSrcA2, bLink, immSrc);
				CMP: cmp (ctr_signal, RegSrcA1, RegSrcA2, bLink, immSrc);
				ORR: orr (ctr_signal, RegSrcA1, RegSrcA2, bLink, immSrc);
				MOV: mov (ctr_signal, RegSrcA1, RegSrcA2, bLink, immSrc);
				LSL: lsl (ctr_signal, RegSrcA1, RegSrcA2, bLink, immSrc);
				LSR: lsr (ctr_signal, RegSrcA1, RegSrcA2, bLink, immSrc);
				MUL: mul (ctr_signal, RegSrcA1, RegSrcA2, bLink, immSrc);
				SIN: sin (ctr_signal, RegSrcA1, RegSrcA2, bLink, immSrc);
				COS: cos (ctr_signal, RegSrcA1, RegSrcA2, bLink, immSrc);
			endcase
			ctr_signal.aluSrc = inst_head.immSignal;
		end else if (inst_head.op == MEMORY) begin
			unique case (inst_head.cmd[4:3])
				LDR: ldr (ctr_signal, RegSrcA1, RegSrcA2, bLink, immSrc);
				STR: str (ctr_signal, RegSrcA1, RegSrcA2, bLink, immSrc);
				RDP: rdp (ctr_signal, RegSrcA1, RegSrcA2, bLink, immSrc);
				WRP: wrp (ctr_signal, RegSrcA1, RegSrcA2, bLink, immSrc);
			endcase
			ctr_signal.aluSrc = inst_head.immSignal;
		end else begin //FLOW
				B: b(ctr_signal, RegSrcA1, RegSrcA2, bLink, immSrc);
				ctr_signal.aluSrc = 1'b1;
		end
		
	end
endmodule 