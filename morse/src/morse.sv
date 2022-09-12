//=============================================================================
// A simple Morse code programmable ASIC.
//=============================================================================

module morse (
    input wire logic clk,
    output     logic emitter
);

//
// Memory
//

logic [7:0] program_memory [0:255];

//
// Logic elements
//

logic [7:0] pc;
logic [1:0] op;
logic is_spc;
logic busy = 0;

//
// Counters
//

logic [63:0] dit_c = 0;

//
// Initialization
//

`define spc 8'b00000000
`define dit 8'b10000000
`define dah 8'b01000000

// TODO for now we're just statically defining the program to run. Next up is
// loading the program dynamically.
initial begin
    program_memory[0]   <= `dit;
    program_memory[1]   <= `spc;
    program_memory[2]   <= `dah;
    program_memory[3]   <= `spc;
    program_memory[4]   <= `dit;

    program_memory[5]   <= `spc;
    program_memory[6]   <= `spc;
    program_memory[7]   <= `spc;
end

//
// Logic
//

always @( posedge clk ) begin

    if ( busy == 1'b0 ) begin
        //
        // decode
        //

        // extract operand from instruction
        op = program_memory[pc][7:6];
        if ( op == 2'b00 ) begin
            is_spc = 1'b1;
            dit_c = 50000000;
        end
        else if ( op == 2'b10 ) begin
            is_spc = 1'b0;
            // clock is 100MHz so 50000000 cycles -> 500 milliseconds
            dit_c = 50000000;
        end
        else if ( op == 2'b01 ) begin
            is_spc = 1'b0;
            dit_c = 250000000;
        end

        //
        // program counter
        //

        if ( pc == 8'h7 ) begin
            // rollover
            pc = 8'h00;
        end
        else begin
            pc = pc + 8'h1;
        end
    end

    // emitter
    if ( dit_c > 64'h0 ) begin
        busy = 1'b1;
        dit_c = dit_c - 1;
        if ( is_spc == 1'b1 ) begin
            emitter = 1'b0;
        end
        else begin
            emitter = 1'b1;
        end
    end
    else begin
        emitter = 1'b0;
        busy = 1'b0;
    end

end

endmodule
