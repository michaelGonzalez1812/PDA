/**
***********************************************
		Instituto Tecnologico de Costa Rica 
			Ingenieria en Electronica

				Look Up Table Coseno y Seno
       
		Autores: Michael Gonzalez Rivera
				 Erick Cordero
				 Victor Montero
					
			Lenguaje: SystemVerilog
					Version: 1.0         
	
	Entradas: - Selector de operación
                    0 Seno
                    1 Coseno
              - Ángulo
				
	Restricciones:
				- Selector solo 1 o 0
                - Ángulo [0,360]

   Salidas: - Coseno o seno del ángulo dado

            
		Arquitectura de Computadores I 2019
				Prof. Ronald Garcia
***********************************************
**/
module LUT( input logic op_selector, clk,
            input logic [31:0] angle,
            output logic [31:0] value);  
            
    //valores temporales        
    logic [31:0] tmp1;
    logic [31:0] tmp2;
    logic [31:0] tmp3; 
    logic [31:0] tmp4;

    //angulos calculados
    logic [31:0] atmp1; 
    logic [31:0] atmp2; 
    logic [31:0] atmp3; 
    logic [31:0] atmp4; 

    //ángulos equivalentes
    assign atmp1 = angle; 
    assign atmp2 = 32'b10110100 - angle; 
    assign atmp3 = -(32'b10110100 - angle); 
    assign atmp4 = 32'b101101000 - angle; ; 
    
    SenLUT coseno1 (clk, atmp1, tmp1);
    SenLUT coseno2 (clk, atmp2, tmp2);
    SenLUT coseno3 (clk, atmp3, tmp3);
    SenLUT coseno4 (clk, atmp4, tmp4);

    always_ff @ (posedge clk) begin
            $display("%s","atmp1");
            $display("%b",atmp1);
            $display("%s","atmp2");
            $display("%b",atmp2);
            $display("%s","atmp3");
            $display("%b",atmp3);
            $display("%s","atmp4");
            $display("%b",atmp4);

            $display("%s","tmp1");
            $display("%b",tmp1);
            $display("%s","tmp2");
            $display("%b",tmp2);
            $display("%s","tmp3");
            $display("%b",tmp3);
            $display("%s","tmp4");
            $display("%b",tmp4);
        //coseno
        if (op_selector == 1) begin
            if(32'b0 <= angle && angle <= 32'b1011010) begin
                value = tmp1;
            end
            else if(32'b1011011 <= angle && angle <= 32'b10110100) begin
                value = tmp2;
            end
            else if(32'b10110101 <= angle && angle <= 32'b100001110) begin
                value = tmp3;
            end
            else if(32'b100001111 <= angle &&angle <= 32'b101101000) begin
                value = tmp4;
            end
        end
        //seno
        else begin
            if(32'b0 <= angle && angle <= 32'b1011010) begin
                value = tmp1;
            end
            else if(32'b1011011 <= angle && angle <= 32'b10110100) begin
                value = tmp2;
            end
             else if(32'b10110101 <= angle && angle <= 32'b100001110) begin
                value = tmp3;
            end
            else if(32'b100001111 <= angle &&angle <= 32'b101101000) begin
                value = tmp4;
            end
        end
    end
 
endmodule