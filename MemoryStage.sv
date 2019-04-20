/**
*********************************************************************
		Instituto Tecnologico de Costa Rica 
			Ingenieria en Electronica

						MemoryStage
       
		Autores: Michael Gonzalez Rivera
				 Erick Cordero
				 Victor Montero
					
			Lenguaje: SystemVerilog
					Version: 1.0         
	
	Entradas:- 6 operando de entrada
				- Clock
				- Bandera de lectura/escritura de memoria de datos
				- Bandera de lectura/escritura de memoria de pixeles
			   - Direccion de lectura/escritura (ambas memorias)
				- Dato a escribir
				- Registro destino (debe salir el mismo dato)
				
	Restricciones:
				- Entradas son de N bits 
	
   Salidas: - Dato leido de la memoria de datos
				- Dato leido de la memoria de pixeles
				- Resultado proveniente de la execute stage
				- Registro destino
            
		Arquitectura de Computadores I 2019
				Prof. Ronald Garcia
*********************************************************************
*/

import stages_definition_pkg::*;

module MemoryStage #(parameter N = 32) 
	   (input logic clk, 
		input bit memWrite, memPixWrite,
		input exe_mem_interface exe_mem_inter_mem,
		output mem_wb_interface mem_wb_inter_mem
		);
	
	PixelsMemory pixelsMemory(clk, memPixWrite, exe_mem_inter_mem.Ax, //input
		exe_mem_inter_mem.Ay, exe_mem_inter_mem.WD, //input
		mem_wb_inter_mem.pixMemRead); //output

	Memory data_memory(clk, memWrite, //input
		exe_mem_inter_mem.aluResult, exe_mem_inter_mem.WD, //input
		mem_wb_inter_mem.dataMemRead); //output

	assign mem_wb_inter_mem.aluResult = exe_mem_inter_mem.aluResult;
	assign mem_wb_inter_mem.Rd = exe_mem_inter_mem.Rd; 
	
endmodule