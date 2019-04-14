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
module MemoryStage #(parameter N = 32) 
						  (input logic clk, MEMWrite, MemPWrite, PCSrc, RegWrite, IOFlag,
							input logic [1:0] MemToReg,
							input logic [N-1:0] address, WriteData,
							input logic [3:0] RdIn,
							output logic [N-1:0] ReadDataDataMem, ReadDataPixMem, ALUresultOut,
							output logic [3:0]  RdOut,
							output logic PCSrcOut, RegWriteOut, IOFlagOut,
							output logic [1:0] MemToRegOut);
	
	Memory data_memory(clk, MEMWrite, address, WriteData, ReadDataDataMem);

	assign ALUresultOut = address;
	assign RdOut = RdIn;
	assign PCSrcOut = PCSrc;
	assign RegWriteOut = RegWrite;
	assign IOFlagOut = IOFlag;
	assign MemToRegOut = MemToReg;
endmodule