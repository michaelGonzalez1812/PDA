package stages_definition_pkg;
/*    typedef struct packed {
        bit PCSrc, RegWrite, MemWrite, MemPWrite, IOFlag;
		bit [1:0] MemToReg;
		int ALUResult, WriteData; 
		bit [3:0] Rd;
    } exe_mem_interface;
*/

    typedef struct packed {
        //TODO: Revisar si immSrc es de 1 bit
        bit pcSrc, regWrite, memWrite, branch, aluSrc, 
            flagWrite, immSrc, trigSelect, memPixWrite;
        bit [1:0] memToReg;
        bit [3:0] aluControl;
    } deco_exe_cu_signals;

    typedef struct packed {
        bit pcSrc, regWrite, memWrite, memPixWrite;
        bit [1:0] memToReg;
    } exe_mem_cu_signals;

    typedef struct packed {
        bit regWrite, pcSrc;
        bit [1:0] memToReg;
    } mem_wb_cu_signals;

    typedef struct packed {
        bit [26:0] imm;
        bit [4:0]  cmd;
        bit [3:0]  Rd, Rn, Rs;
        bit [2:0]  cond;
        bit [1:0]  op;
        bit immSignal;
    } inst_deco;

    typedef struct packed {
        int RD1, RD2, R0, R1, Rd, imm;
        bit [2:0] cond;
    } deco_exe_interface;

    typedef struct packed {
        int aluResult, trigResult, Ax, Ay, Rd, WD;
    } exe_mem_interface;

    typedef struct packed {
        int dataMemRead, pixMemRead, aluResult, trigResult;
    } mem_wb_interface;
endpackage