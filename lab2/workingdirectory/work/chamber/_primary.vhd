library verilog;
use verilog.vl_types.all;
entity chamber is
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        gateR           : in     vl_logic;
        gateL           : in     vl_logic;
        gondInWater     : out    vl_logic;
        gondInR         : in     vl_logic;
        gondInL         : in     vl_logic;
        rightGood       : in     vl_logic;
        leftGood        : in     vl_logic
    );
end chamber;
