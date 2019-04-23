/**
***********************************************
		Instituto Tecnologico de Costa Rica 
			Ingenieria en Electronica

					Unidad de Condicion
       
		Autores: Michael Gonzalez Rivera
				 Erick Cordero
				 Victor Montero
					
			Lenguaje: SystemVerilog
					Version: 1.0         
	
	Entradas:- Arreglo de Banderas
				- Clock
				- Condicion
				
	Restricciones:
				- Arreglos de banderas 4bits N, Z, C, V
                - Cond 3 bits definidos en la documentación
	
   Salidas: - Resultado de comparar banderas
            
		Arquitectura de Computadores I 2019
				Prof. Ronald Garcia
***********************************************
**/
// Mux de selector 3 bits
module mux3 (input bit d0, d1, d2, d3, d4, d5, d6,
		input  bit [2:0] sel,
		output bit result);
			  
	assign result = (sel == 3'b000) ? d0 :
                    (sel == 3'b001) ? d1 :
                    (sel == 3'b010) ? d2 :
                    (sel == 3'b011) ? d3 :
                    (sel == 3'b100) ? d4 :
                    (sel == 3'b101) ? d5 :
                    (sel == 3'b110) ? d6 : 1'b1;
endmodule


module ConditionalUnit(input logic clk,
        input  bit flagWrite,
        input  bit [3:0] aluFlags,
        input  bit [2:0] Cond,
        output logic out);

    //separar las banderas 
    bit n,z,c,v;
    bit [3:0] condFlags;

    Register #(4) flags (aluFlags, clk, flagWrite, 1'b0, condFlags);

    mux3 muxCond(3'b1,  //000 sin condiciones
        z,              // 001 z=1
        -z,             // 010 z=0
        n==v,           // 011 n=v
        n!=v,           // 100 n!=v
        (z==0 & n==v),  // 101 z=0 y n=v
        (z==1 & n!=v),  // 110 z=1 o n!=v
        Cond,
        out); 

    assign n = condFlags[3];
    assign z = condFlags[2];
    assign c = condFlags[1];
    assign v = condFlags[0];

endmodule