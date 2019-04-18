/**
***********************************************
		Instituto Tecnologico de Costa Rica 
			Ingenieria en Electronica

					Etapa Execute
       
		Autores: Michael Gonzalez Rivera
				 Erick Cordero
				 Victor Montero
					
			Lenguaje: SystemVerilog
					Version: 1.0         
	
	Entradas:- Señales de control
				- Operandos Ra y Rb
				- Direccion de Rd
				
	Restricciones:
				- Verificar las señales de control
	
   Salidas: - Señales de control
				- Resultado de la exe
            
		Arquitectura de Computadores I 2019
				Prof. Ronald Garcia
***********************************************
**/

import stages_definition_pkg::*;

module ExecuteStage #(parameter N=32)
       (input deco_exe_interface deco_exe_inter_exe,
	    input bit aluSrc, trigControl,
		input bit [1:0] forwardAluSrc1, forwardAluSrc2,
		input bit [1:0]	forwardAx, forwardAy,
		input bit [3:0] aluControl,
		input int forwardFromWb, forwardFromMem,
		output exe_mem_interface exe_mem_inter_exe,
		output conditional_flags cond_flags);

	int aluSrc1, aluSrc2, aluSrc2Forward;	
	
	/***********************************************
	 * conectar unidad de trigonometria
	 ***********************************************/
	
	ALU #(N) alu (aluSrc1, aluSrc2, aluControl, cond_flags.z, cond_flags.n, cond_flags.v, exe_mem_inter_exe.aluResult);
	
	assign aluSrc1 = (forwardAluSrc1 == 2'b00)? deco_exe_inter_exe.RD1 :
					 (forwardAluSrc1 == 2'b01)? forwardFromWb : forwardFromMem;
	assign aluSrc2Forward = (forwardAluSrc2 == 2'b00)? deco_exe_inter_exe.RD2 :
					 (forwardAluSrc2 == 2'b01)? forwardFromWb : forwardFromMem;
	assign aluSrc2 = (aluSrc)? deco_exe_inter_exe.imm : aluSrc2Forward;
	assign exe_mem_inter_exe.Ax = (forwardAx == 2'b00)? deco_exe_inter_exe.R0 :
					 (forwardAx == 2'b01)? forwardFromWb : forwardFromMem;
	assign exe_mem_inter_exe.Ay = (forwardAy == 2'b00)? deco_exe_inter_exe.R1 :
					 (forwardAy == 2'b01)? forwardFromWb : forwardFromMem;
	assign exe_mem_inter_exe.WD = aluSrc2Forward;
endmodule 