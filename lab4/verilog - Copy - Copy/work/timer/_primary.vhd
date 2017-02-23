library verilog;
use verilog.vl_types.all;
entity timer is
    generic(
        DELAY           : integer := 25000000
    );
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        enable          : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of DELAY : constant is 1;
end timer;
