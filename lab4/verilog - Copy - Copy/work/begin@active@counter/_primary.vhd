library verilog;
use verilog.vl_types.all;
entity beginActiveCounter is
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        startStandby    : in     vl_logic;
        startActive     : out    vl_logic
    );
end beginActiveCounter;
