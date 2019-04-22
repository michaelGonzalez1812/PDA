/**
**********************************************************************
		Instituto Tecnologico de Costa Rica 
			Ingenieria en Electronica

						Sumador
       
		Autores: Michael Gonzalez Rivera
				 Erick Cordero
				 Victor Montero
					
			Lenguaje: SystemVerilog
					Version: 1.0         
	
	Entradas:	-Tres direcciones de registros de N-bits
					-Dato a escribir en registro M-bits
					-PC M-bits
					-Reloj
					-Habilitador de escritura
					
				
	Restricciones:
				- Entradas son de N bits o M-bits
	
   Salidas: - Datos leidos
            
		Arquitectura de Computadores I 2019
				Prof. Ronald Garcia
**********************************************************************
*/
module RegisterFile #(parameter N=4, M=32)
	   (input  logic clk, WE3,
		input  bit   [3:0] A1, A2, A3,
		input  int   WD3, pc,
		output int   RD1, RD2, R0, R1);

	bit [31:0] rf [16]; 
	
	initial begin
		$readmemb("registros.mem", rf);

	end
	
	always_ff@(posedge clk) begin
		if (WE3) 
			if (A3 == 4'b0) rf[A3] <= {23'b0, WD3[8:0]};
			else if (A3 == 4'b1) rf[A3] <= {24'b0, WD3[7:0]};
			else rf[A3] <= WD3;
		
		rf[4'd15] = pc;
	end			

	assign RD1 = rf[A1];
	assign RD2 = rf[A2];
	assign R0 = rf[0];
	assign R1 = rf[1];
endmodule
