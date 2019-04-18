module ALU_tb();

logic [31:0] a;
logic [31:0] b;
logic [3:0] control;
logic [31:0] result;
logic [3:0] ALUFlags;
logic clk;
logic [16:0] contador;


	ALU DUT (a,b,control,result,ALUFlags);

	initial begin
		a = 32'b11;
		b = 32'b11;
		clk=1'b0;
        control = 32'b0001;
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