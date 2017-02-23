library verilog;
use verilog.vl_types.all;
entity gate is
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        openSignal      : in     vl_logic;
        gateClosed      : out    vl_logic
    );
end gate;
