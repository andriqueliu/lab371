library verilog;
use verilog.vl_types.all;
entity delayInput is
    generic(
        MINUTES         : integer := 1;
        CLOCK           : integer := 20
    );
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        start           : in     vl_logic;
        enable          : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of MINUTES : constant is 1;
    attribute mti_svvh_generic_type of CLOCK : constant is 1;
end delayInput;
