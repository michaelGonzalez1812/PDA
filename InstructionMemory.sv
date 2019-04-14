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
	   (input  int address,
		output int data_out);
	
	initial begin
		$readmemb("instrucciones.mem", mem); // cambiar ruta de cada uno
	end

	int mem [M];
	assign data_out = mem[address];
	
endmodule