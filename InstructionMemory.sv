/**
***********************************************
		Instituto Tecnologico de Costa Rica 
			Ingenieria en Electronica

						PixelsMemory
       
		Autores: Michael Gonzalez Rivera
				 Erick Cordero
				 Victor Montero
					
			Lenguaje: SystemVerilog
					Version: 1.0         
	
	Entradas:- 1 operando de entrada
				- Dirección de lectura
				
	Restricciones:
				- Entradas son de N bits 
	
   Salidas: - Dato leido
            
		Arquitectura de Computadores I 2019
				Prof. Ronald Garcia
***********************************************
*/
module InstructionMemory #(parameter N = 32, M=2048) // 8kB
								  (input  logic [N-1:0] address,
									output logic [N-1:0] data_out);
	
	logic [N-1:0] mem [M];
	assign data_out = mem[address];
	initial begin
		$readmemb("D:/ArquiI/PDA/instrucciones.mem", mem); // cambiar ruta de cada uno
	end
	
endmodule