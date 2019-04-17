/**
***********************************************
		Instituto Tecnologico de Costa Rica 
			Ingenieria en Electronica

					PDA
       
		Autores: Michael Gonzalez Rivera
				 Erick Cordero
				 Victor Montero
					
			Lenguaje: SystemVerilog
					Version: 1.0        
	
	Entradas:- Clk
				- reset
				- halt
				
	Restricciones:
				-
	
   Salidas: - Ejecucion de las instrucciones
            
		Arquitectura de Computadores I 2019
				Prof. Ronald Garcia
***********************************************
**/

import stages_definition_pkg::*;


module PDA(input logic clk, reset, halt, // halt para detener la ejecucion
		output logic [31:0] outFE, DecoVisu, ExeVisu, MemVisu, MemPixVisu, WBVisu); // es la instruccion entrante al pipeline
	
	deco_exe_cu_signals deco_exe_cu_sig_deco;
	deco_exe_interface deco_exe_inter_deco;
	deco_exe_cu_signals deco_exe_cu_sig_exe;
	deco_exe_interface deco_exe_inter_exe;

	exe_mem_cu_signals exe_mem_cu_sig_exe;
	exe_mem_interface exe_mem_inter_exe;
	exe_mem_cu_signals exe_mem_cu_sig_mem;
	exe_mem_interface exe_mem_inter_mem;

	mem_wb_cu_signals mem_wb_cu_sig_mem;
	mem_wb_interface mem_wb_inter_mem;
	mem_wb_cu_signals mem_wb_cu_sig_wb;
	mem_wb_interface mem_wb_inter_wb;

	hazard_input hazard_in;
	hazard_output hazard_out;

	inst_header inst_head;
	conditional_flags cond_flags;

	int instFetch, instInDeco, wbOutput, pcFetch;
	bit pcSrcExe;
	

	ControlUnit cu (inst_head, //input
		deco_exe_cu_sig_deco); //output

	ConditionalUnit condUnit (clk, deco_exe_inter_exe.cond, //input
		cond_flags, deco_exe_cu_sig_exe.flagWrite, //input
		deco_exe_cu_sig_exe.memPixWrite, deco_exe_cu_sig_exe.branch, //input
		deco_exe_cu_sig_exe.memWrite, deco_exe_cu_sig_exe.regWrite, //input
		deco_exe_cu_sig_exe.pcSrc, //input
		exe_mem_cu_sig_exe.memPixWrite, exe_mem_cu_sig_exe.memWrite, //output
		exe_mem_cu_sig_exe.regWrite, exe_mem_cu_sig_exe.pcSrc, //output
		pcSrcExe); //output

	FetchStage #(32) fetch_stage (clk, mem_wb_cu_sig_wb.pcSrc, //input
		pcSrcExe, wbOutput, exe_mem_inter_exe.aluResult, //input
		instInDeco, pcFetch); //output
					
	DecodeStage #(32) decode_stage (clk, mem_wb_cu_sig_wb.regWrite, //input
		instFetch, pcFetch, wbOutput, //input
		hazard_in.decoA1, hazard_in.decoA2, //output
		inst_head, deco_exe_inter_deco); //output

	ExecuteStage #(32) execute_stage (deco_exe_inter_exe, deco_exe_cu_sig_exe.aluSrc, //input
		deco_exe_cu_sig_exe.trigControl, hazard_out.forwardAluSrc1, hazard_out.forwardAluSrc2, //input
		hazard_out.forwardAx, hazard_out.forwardAy, deco_exe_cu_sig_exe.aluControl, //input
		wbOutput, exe_mem_inter_mem.aluResult, //input
		exe_mem_inter_exe, cond_flags); //output
		
	MemoryStage #(32) memory_stage (clk, exe_mem_cu_sig_mem.memWrite, //input
		exe_mem_cu_sig_mem.memPixWrite, exe_mem_inter_mem, //input
		mem_wb_inter_mem); //output
							
	WriteBackStage #(32) writeback_stage (mem_wb_inter_wb, //input
		mem_wb_cu_sig_wb.memToReg, //input
		wbOutput); //output
						 
	Register #(32) if_de (instFetch, ~clk, 1'b1, instInDeco);
	Register #(182) deco_exe ({deco_exe_cu_sig_deco, deco_exe_inter_deco}, ~clk,
		1'b1, {deco_exe_cu_sig_exe, deco_exe_inter_exe});
	Register #(170) exe_mem ({exe_mem_cu_sig_exe, exe_mem_inter_exe}, ~clk,
		1'b1, {exe_mem_cu_sig_mem, exe_mem_inter_mem});
	Register #(136) mem_wb ({mem_wb_cu_sig_mem, mem_wb_inter_mem} , ~clk,
		1'b1, {mem_wb_cu_sig_wb, mem_wb_inter_wb});

	assign hazard_out.forwardAluSrc1 = 0;
	assign hazard_out.forwardAluSrc2 = 0;
	assign hazard_out.forwardAx = 0;
	assign hazard_out.forwardAy = 0;

endmodule 