/**
***********************************************
		Instituto Tecnologico de Costa Rica 
			Ingenieria en Electronica

						Memory
       
		Autores: Michael Gonzalez Rivera
				 Erick Cordero
				 Victor Montero
					
			Lenguaje: SystemVerilog
					Version: 1.0         
	
	Entradas:- 4 operandos de entrada
				- clock
				- Dirección de almacenamiento/lectura del dato
				- Dato a escribir
				- Dato leido
				
	Restricciones:
				- Entradas son de N bits 
	
   Salidas: - Dato leido
            
		Arquitectura de Computadores I 2019
				Prof. Ronald Garcia
***********************************************
*/ 

//512 MB
module Memory #(parameter N = 32, M=8192) (input  logic clk, wr,
		input  int address, data_in,
		output int data_out);

	int mem [M];

	initial begin
		$readmemb("ram.mem", mem); // cambiar ruta de cada uno
	end

	always_ff @(negedge clk) begin
		if (wr == 1)
			mem[address] <= data_in;	
	end
	
	always_ff @(posedge clk) begin
		if (wr == 0)
			data_out <= mem[address];
	end
	
endmodule