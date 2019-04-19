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
		a = 32'b0011;
		b = 32'b1011;
		clk=1'b0;
        control = 4'b0000;
		contador = 16'b0;
		#2
		control = 4'b0001;
		#2
		control = 4'b0010;
		#2
		control = 4'b0011;
		#2
		control = 4'b0100;
		#2
		control = 4'b0101;
		#2
		control = 4'b0110;
		#2
		control = 4'b0111;
		#2
		control = 4'b1000;
	end

	always begin
		#1
		clk=~clk;
	end

	always@(posedge clk) begin
		contador <= contador + 1;
		if (contador >= 30)
			$stop;
	end

endmodule 