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
		output inst_header inst_head, 
		output logic [31:0] pixelMemDisplay); // es la instruccion entrante al pipeline
	
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

	conditional_flags cond_flags;

	int instFetch, instInDeco, wbOutput, pcFetch;
	bit regSrcA1, regSrcA2, bLink, immSrc, pcSrcExe, condOut;
	
	HazardUnit hazard_unit (hazard_in, //input
		hazard_out); //output

	ControlUnit cu (inst_head, //input
		deco_exe_cu_sig_deco, regSrcA1, regSrcA2, bLink, immSrc); //output

	ConditionalUnit cond_unit (clk, deco_exe_cu_sig_exe.flagWrite, cond_flags, 
		deco_exe_inter_exe.cond, condOut);

	FetchStage #(32) fetch_stage (clk, mem_wb_cu_sig_wb.pcSrc, //input
		pcSrcExe, hazard_out.stallF, wbOutput, exe_mem_inter_exe.aluResult, //input
		instFetch, pcFetch); //output
					
	DecodeStage #(32) decode_stage (clk, mem_wb_cu_sig_wb.regWrite, //input
		instInDeco, pcFetch, wbOutput, //input
		regSrcA1, regSrcA2, bLink, immSrc, //input
		mem_wb_inter_wb.Rd, //input
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
						 
	Register #(32) if_de (instFetch, ~clk, ~hazard_out.stallD, hazard_out.flushD, instInDeco);
	Register #(181) deco_exe ({deco_exe_cu_sig_deco, deco_exe_inter_deco}, ~clk,
		1'b1, hazard_out.flushF, {deco_exe_cu_sig_exe, deco_exe_inter_exe});
	Register #(170) exe_mem ({exe_mem_cu_sig_exe, exe_mem_inter_exe}, ~clk,
		1'b1, 1'b0, {exe_mem_cu_sig_mem, exe_mem_inter_mem});
	Register #(136) mem_wb ({mem_wb_cu_sig_mem, mem_wb_inter_mem} , ~clk,
		1'b1, 1'b0, {mem_wb_cu_sig_wb, mem_wb_inter_wb});

	/**********************************************
	*	execute stage signals assigment 
	*********************************************/
	assign exe_mem_cu_sig_exe.memToReg = deco_exe_cu_sig_exe.memToReg;

	/**********************************************
	*	memory stage signals assigment 
	*********************************************/
	assign mem_wb_cu_sig_mem.pcSrc = exe_mem_cu_sig_mem.pcSrc;
	assign mem_wb_cu_sig_mem.regWrite = exe_mem_cu_sig_mem.regWrite;
	assign mem_wb_cu_sig_mem.memToReg = exe_mem_cu_sig_mem.memToReg;

	/********************************************
	*	Hazard assigment
	*********************************************/
	assign hazard_in.branchTaken = pcSrcExe;

	/********************************************
	*	Conditional assigment
	*********************************************/
	assign pcSrcExe = condOut & deco_exe_cu_sig_exe.branch;
	assign exe_mem_cu_sig_exe.memPixWrite = condOut & deco_exe_cu_sig_exe.memPixWrite;
	assign exe_mem_cu_sig_exe.memWrite = condOut & deco_exe_cu_sig_exe.memWrite;
	assign exe_mem_cu_sig_exe.regWrite = condOut & deco_exe_cu_sig_exe.regWrite;
	assign exe_mem_cu_sig_exe.pcSrc = condOut & deco_exe_cu_sig_exe.pcSrc;

	/********************************************
	*	Dispaly assigment
	*********************************************/

	assign pixelMemDisplay = mem_wb_inter_mem.pixMemRead;

endmodule 