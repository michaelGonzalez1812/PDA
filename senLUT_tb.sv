module SenLUT_tb();
    logic clk;
    logic [31:0] angle;
    logic [31:0] value; 
    logic [16:0] contador;

    SenLUT DUT( clk,
                angle,
                value);
 
    initial begin
		// ADD
        clk=1'b0;
        angle = 32'b111;
        contador = 16'b100;
	end
	
	always begin
		#1
		clk=~clk;
	end

	always@(posedge clk) begin
		contador <= contador + 1;
		if (contador >= 5)
			$stop;
	end

endmodule