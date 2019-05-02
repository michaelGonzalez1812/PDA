import stages_definition_pkg::*;

module PDA_tb();
	logic clk, halt, reset;
	inst_header inst_head;
	logic [16:0] contador;

	PDA DUT (clk, reset, halt, inst_head);
	
	initial begin
		halt=1'b0;
		reset=1'b0;
		clk=1'b1;
		contador = 16'b0;
	end
	always begin
		#1
		clk=~clk;
	end

	always@(posedge clk) begin
		contador <= contador + 1;
		if (contador >= 18)
			$stop;
	end

endmodule 