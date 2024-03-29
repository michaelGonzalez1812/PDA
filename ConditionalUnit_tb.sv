module ConditionalUnit_tb();
	logic clk, out;
	logic [2:0] cond;
	logic [16:0] contador;
    logic [3:0] ALUFlags;
    logic [31:0] A;
    logic [31:0] B;
    logic [31:0] Q;

    restadorNbits DUT1(A,B,Q,ALUFlags[3],ALUFlags[2],ALUFlags[0]);
	ConditionalUnit DUT (clk, ALUFlags, cond ,out); 

	initial begin
		contador = 16'b0;
		clk=1'b0;
        A = 32'b10;
        B = 32'b10;
        cond = 3'b001;
        ALUFlags = 4'b0000;
		#1;
		/* cond = 3'b001;
        ALUFlags = 4'b0100;
		#1;
        cond = 3'b010;
        ALUFlags = 4'b0100;
		#1;
        cond = 3'b011;
        ALUFlags = 4'b1001;
		#1;
        cond = 3'b100;
        ALUFlags = 4'b0001;
		#1;
        cond = 3'b101;
        ALUFlags = 4'b1001;
		#1;
        cond = 3'b110;
        ALUFlags = 4'b1100;
		#1; */
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