module LUT_tb();
    logic op_selector,clk;
    logic [31:0] angle;
    logic [31:0] value; 
    logic [16:0] contador;

    LUT DUT(op_selector,
                angle,
                value);
 
    initial begin
		// ADD
        clk=1'b0;
		op_selector = 1;
        angle = 32'b111111;
        contador = 16'b0;
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