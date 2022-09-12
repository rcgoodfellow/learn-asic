//=============================================================================
// this code is taken from
//   - https://projectf.io/posts/hello-arty-1/
//=============================================================================
module blinky (
    input wire logic [1:0] sw,
    output logic [3:0] led
);

always_comb begin
    if (sw[0]) begin
        led[1:0] = 2'b11;
    end else begin
        led[1:0] = 2'b00;
    end

    if (sw[1]) begin
        led[3:2] = 2'b11;
    end else begin
        led[3:2] = 2'b00;
    end
end

endmodule
