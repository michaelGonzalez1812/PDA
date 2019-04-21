
package cu_definitions_pkg;
    import stages_definition_pkg::*;
    
    /********************************************
    *      OP definitions
    ********************************************/
    parameter PROCESSING = 2'b00; 
    parameter MEMORY     = 2'b01; 
    parameter FLOW       = 2'b10; 
    
    /********************************************
    *      PROCESSING cmd definitions
    ********************************************/
    parameter NOP = 5'b00000;
    parameter AND = 5'b00001;
    parameter XOR = 5'b00010;
    parameter SUB = 5'b00011;
    parameter ADD = 5'b00100;
    parameter CMP = 5'b00101;
    parameter ORR = 5'b00110;
    parameter MOV = 5'b00111;
    parameter LSL = 5'b01000;
    parameter LSR = 5'b01001;
    parameter MUL = 5'b01010;
    parameter SIN = 5'b01011;
    parameter COS = 5'b01100;

    /********************************************
    *      MEMORY cmd definitions
    ********************************************/
    parameter LDR = 2'b00;
    parameter STR = 2'b01;
    parameter RDP = 2'b10;
    parameter WRP = 2'b11;    

    /********************************************
    *      FLOW cmd definitions
    ********************************************/
    parameter B  = 1'b0;
    parameter BL = 1'b1;
    
    /********************************************
    *      IMM definitions
    ********************************************/
    parameter WITH_IMM    = 1'b1;
    parameter WITHOUT_IMM = 1'b0;

    /********************************************
    *      tasks for processing without imm
    ********************************************/
    task processing_common (output deco_exe_cu_signals ctr_signal,
            output bit RegSrcA1, RegSrcA2, bLink, immSrc);
        begin
            ctr_signal.pcSrc = 1'b0;  
            RegSrcA1 = 1'b0;
            RegSrcA2 = 1'b0;
            immSrc = 1'b1;
            ctr_signal.memWrite = 1'b0; 
            ctr_signal.memPixWrite = 1'b0;
            ctr_signal.branch = 1'b0; 
            bLink = 1'b0;
        end
    endtask

    task nop (output deco_exe_cu_signals ctr_signal,
            output bit RegSrcA1, RegSrcA2, bLink,
            output bit immSrc);
        begin
            processing_common (ctr_signal, RegSrcA1, RegSrcA2, bLink, immSrc);
            ctr_signal.regWrite = 1'b0;
            ctr_signal.trigControl = 1'b0; 
            ctr_signal.aluControl = 4'b0000;
            ctr_signal.memToReg = 2'b00;
            ctr_signal.flagWrite = 1'b0;      
        end
    endtask

    task and_signals (output deco_exe_cu_signals ctr_signal,
            output bit RegSrcA1, RegSrcA2, bLink, 
            output bit immSrc);
        begin
            processing_common (ctr_signal, RegSrcA1, RegSrcA2, bLink, immSrc);
            ctr_signal.regWrite = 1'b1;
            ctr_signal.trigControl = 1'b0; 
            ctr_signal.aluControl = 4'b0101;
            ctr_signal.memToReg = 2'b01;
            ctr_signal.flagWrite = 1'b0;
        end
    endtask
    
    task xor_signals (output deco_exe_cu_signals ctr_signal,
            output bit RegSrcA1, RegSrcA2, bLink,
            output bit immSrc);
        begin
            processing_common (ctr_signal, RegSrcA1, RegSrcA2, bLink, immSrc);
            ctr_signal.regWrite = 1'b1;
            ctr_signal.trigControl = 1'b0; 
            ctr_signal.aluControl = 4'b0100;
            ctr_signal.memToReg = 2'b01;
            ctr_signal.flagWrite = 1'b0;
        end
    endtask

    task sub (output deco_exe_cu_signals ctr_signal,
            output bit RegSrcA1, RegSrcA2, bLink,
            output bit immSrc);
        begin
            processing_common (ctr_signal, RegSrcA1, RegSrcA2, bLink, immSrc);
            ctr_signal.regWrite = 1'b1;
            ctr_signal.trigControl = 1'b0; 
            ctr_signal.aluControl = 4'b0001;
            ctr_signal.memToReg = 2'b01;
            ctr_signal.flagWrite = 1'b0;
        end
    endtask

    task add (output deco_exe_cu_signals ctr_signal,
            output bit RegSrcA1, RegSrcA2, bLink,
            output bit immSrc);
        begin
            processing_common (ctr_signal, RegSrcA1, RegSrcA2, bLink, immSrc);
            ctr_signal.regWrite = 1'b1;
            ctr_signal.trigControl = 1'b0; 
            ctr_signal.aluControl = 4'b0010;
            ctr_signal.memToReg = 2'b01;
            ctr_signal.flagWrite = 1'b0;
        end
    endtask

    task cmp (output deco_exe_cu_signals ctr_signal,
            output bit RegSrcA1, RegSrcA2, bLink,
            output bit immSrc);
        begin
            processing_common (ctr_signal, RegSrcA1, RegSrcA2, bLink, immSrc);
            ctr_signal.regWrite = 1'b0;
            ctr_signal.trigControl = 1'b0; 
            ctr_signal.aluControl = 4'b0001;
            ctr_signal.memToReg = 2'b00;
            ctr_signal.flagWrite = 1'b1;
        end
    endtask
    
    task orr (output deco_exe_cu_signals ctr_signal,
            output bit RegSrcA1, RegSrcA2, bLink,
            output bit immSrc);
        begin
            processing_common (ctr_signal, RegSrcA1, RegSrcA2, bLink, immSrc);
            ctr_signal.regWrite = 1'b1;
            ctr_signal.trigControl = 1'b0; 
            ctr_signal.aluControl = 4'b0011;
            ctr_signal.memToReg = 2'b01;
            ctr_signal.flagWrite = 1'b0;
        end
    endtask

    task mov (output deco_exe_cu_signals ctr_signal,
            output bit RegSrcA1, RegSrcA2, bLink, 
            output bit immSrc);
        begin
            processing_common (ctr_signal, RegSrcA1, RegSrcA2, bLink, immSrc);
            ctr_signal.regWrite = 1'b1;
            ctr_signal.trigControl = 1'b0; 
            ctr_signal.aluControl = 4'b0000;
            ctr_signal.memToReg = 2'b01;
            ctr_signal.flagWrite = 1'b0;
        end
    endtask

    task lsl (output deco_exe_cu_signals ctr_signal,
            output bit RegSrcA1, RegSrcA2, bLink,
            output bit immSrc);
        begin
            processing_common (ctr_signal, RegSrcA1, RegSrcA2, bLink, immSrc);
            ctr_signal.regWrite = 1'b1;
            ctr_signal.trigControl = 1'b0; 
            ctr_signal.aluControl = 4'b0111;
            ctr_signal.memToReg = 2'b01;
            ctr_signal.flagWrite = 1'b0;
        end
    endtask

    task lsr (output deco_exe_cu_signals ctr_signal,
            output bit RegSrcA1, RegSrcA2, bLink,
            output bit immSrc);
        begin
            processing_common (ctr_signal, RegSrcA1, RegSrcA2, bLink, immSrc);
            ctr_signal.regWrite = 1'b1;
            ctr_signal.trigControl = 1'b0; 
            ctr_signal.aluControl = 4'b1000;
            ctr_signal.memToReg = 2'b01;
            ctr_signal.flagWrite = 1'b0;
        end
    endtask

    task mul (output deco_exe_cu_signals ctr_signal,
            output bit RegSrcA1, RegSrcA2, bLink,
            output bit immSrc);
        begin
            processing_common (ctr_signal, RegSrcA1, RegSrcA2, bLink, immSrc);
            ctr_signal.regWrite = 1'b1;
            ctr_signal.trigControl = 1'b0; 
            ctr_signal.aluControl = 4'b0110;
            ctr_signal.memToReg = 2'b01;
            ctr_signal.flagWrite = 1'b0;
        end
    endtask

    task sin (output deco_exe_cu_signals ctr_signal,
            output bit RegSrcA1, RegSrcA2, bLink,
            output bit immSrc);
        begin
            processing_common (ctr_signal, RegSrcA1, RegSrcA2, bLink, immSrc);
            ctr_signal.regWrite = 1'b1;
            ctr_signal.trigControl = 1'b0; 
            ctr_signal.aluControl = 4'b0000;
            ctr_signal.memToReg = 2'b11;
            ctr_signal.flagWrite = 1'b0;
        end
    endtask

    task cos (output deco_exe_cu_signals ctr_signal,
            output bit RegSrcA1, RegSrcA2, bLink,
            output bit immSrc);
        begin
            processing_common (ctr_signal, RegSrcA1, RegSrcA2, bLink, immSrc);
            ctr_signal.regWrite = 1'b1;
            ctr_signal.trigControl = 1'b1; 
            ctr_signal.aluControl = 4'b0000;
            ctr_signal.memToReg = 2'b11;
            ctr_signal.flagWrite = 1'b0;
        end
    endtask

    /********************************************
    *      tasks for memory with imm
    ********************************************/
    task memory_common (output deco_exe_cu_signals ctr_signal,
            output bit RegSrcA1, bLink, immSrc);
        begin 
            ctr_signal.pcSrc = 1'b0;
            RegSrcA1 = 1'b0;
            immSrc = 1'b1;
            ctr_signal.trigControl = 1'b0; 
            ctr_signal.branch = 1'b0; 
            ctr_signal.flagWrite = 1'b0;
            bLink = 1'b0;
        end
    endtask
    
    task ldr (output deco_exe_cu_signals ctr_signal,
            output bit RegSrcA1, RegSrcA2, bLink, 
            output bit immSrc);
        begin
            memory_common (ctr_signal, RegSrcA1, bLink, immSrc);
            RegSrcA2 = 1'b0;
            ctr_signal.regWrite = 1'b1;
            ctr_signal.aluControl = 4'b0010;
            ctr_signal.memWrite = 1'b0;
            ctr_signal.memPixWrite = 1'b0;
            ctr_signal.memToReg = 2'b00;
        end
    endtask

    task str (output deco_exe_cu_signals ctr_signal,
            output bit RegSrcA1, RegSrcA2, bLink, 
            output bit immSrc);
        begin
            memory_common (ctr_signal, RegSrcA1, bLink, immSrc);
            RegSrcA2 = 1'b1;
            ctr_signal.regWrite = 1'b0;
            ctr_signal.aluControl = 4'b0010;
            ctr_signal.memWrite = 1'b1;
            ctr_signal.memPixWrite = 1'b0;
            ctr_signal.memToReg = 2'b00;
        end
    endtask

    task rdp (output deco_exe_cu_signals ctr_signal,
            output bit RegSrcA1, RegSrcA2, bLink, 
            output bit immSrc);
        begin
            memory_common (ctr_signal, RegSrcA1, bLink, immSrc);
            RegSrcA2 = 1'b0;
            ctr_signal.regWrite = 1'b1;
            ctr_signal.aluControl = 4'b0000;
            ctr_signal.memWrite = 1'b0;
            ctr_signal.memPixWrite = 1'b0;
            ctr_signal.memToReg = 2'b10;
        end
    endtask

    task wrp (output deco_exe_cu_signals ctr_signal,
            output bit RegSrcA1, RegSrcA2, bLink, 
            output bit immSrc);
        begin
            memory_common (ctr_signal, RegSrcA1, bLink, immSrc);
            RegSrcA2 = 1'b1;
            ctr_signal.regWrite = 1'b0;
            ctr_signal.aluControl = 4'b0000;
            ctr_signal.memWrite = 1'b0;
            ctr_signal.memPixWrite = 1'b1;
            ctr_signal.memToReg = 2'b00;
        end
    endtask
endpackage