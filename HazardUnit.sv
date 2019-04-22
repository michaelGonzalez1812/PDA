import stages_definition_pkg::*;

module HazardUnit(input  hazard_input hazard_in,
        output hazard_output hazard_out);

    assign hazard_out.flushD = hazard_in.branchTaken;
    assign hazard_out.flushF = hazard_in.branchTaken;

    /***********************************************
            aun sin definir
    ************************************************/
        assign hazard_out.forwardAluSrc1 = 0;
        assign hazard_out.forwardAluSrc2 = 0;
        assign hazard_out.forwardAx = 0;
        assign hazard_out.forwardAy = 0;
endmodule