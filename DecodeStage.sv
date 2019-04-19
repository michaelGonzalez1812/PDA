/**
***********************************************
		Instituto Tecnologico de Costa Rica 
			Ingenieria en Electronica

					Etapa Decode
       
		Autores: Michael Gonzalez Rivera
				 Erick Cordero
				 Victor Montero

			Lenguaje: SystemVerilog
					Version: 1.0         
	
	Entradas:- Instruccion
				- PC
				- Dato a escribir en banco de 
				registros
				- Direccion de Rd
				- Clk
				- Señal de control
				- Parametro N bits
				
	Restricciones:
				- Instruccion de N bits
				
   Salidas: - Señales de control
				- Valor del registro a y b
				- Direccion de Rd
				- Resultado de la extension de signo
            
		Arquitectura de Computadores I 2019
				Prof. Ronald Garcia
***********************************************
**/

import stages_definition_pkg::*;

module DecodeStage #(parameter N=32)
	   (input  logic clk, regWrite,
		input  int   inst, pc, WD3,
		input  logic regSrcA1, regSrcA2, bLink,
		input  bit   [3:0] A3,
		output bit   [3:0] A1, A2, 
		output inst_header inst_head,
		output deco_exe_interface deco_exe_inter_deco);
	
	instruction_arguments inst_arguments;
	deco_exe_cu_signals deco_exe_cu_sig_deco;

	RegisterFile #(4, N) BancoRegistro 
	   (clk, regWrite, A1, A2, A3, WD3, pc, 
		deco_exe_inter_deco.RD1, deco_exe_inter_deco.RD2,
		deco_exe_inter_deco.R0, deco_exe_inter_deco.R1);

	/***********************************************
	 * conectar unidad de extension
	 ***********************************************/
	//Extend Extension (ImmMux, ImmSrc, ImmExt, ExtImm);
	
	assign A1 = (regSrcA1) ? 32'd15 : inst_arguments.Rn;
	assign A2 = (regSrcA2) ? inst_arguments.Rd : inst_arguments.Rs;

	assign inst_arguments.imm  = inst[26:0];
	assign inst_arguments.Rd   = inst[20:17];
	assign inst_arguments.Rn   = inst[16:13];
	assign inst_arguments.Rs   = inst[3:0];
	assign inst_arguments.cond = inst[31:29];
	assign inst_head.cmd  = inst[25:21];
	assign inst_head.op   = inst[28:27];
	assign inst_head.immSignal = inst[26];
	assign deco_exe_inter_deco.Rd = inst_arguments.Rd;
endmodule 