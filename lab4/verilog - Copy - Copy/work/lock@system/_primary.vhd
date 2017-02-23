library verilog;
use verilog.vl_types.all;
entity lockSystem is
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        increase        : in     vl_logic;
        decrease        : in     vl_logic;
        gateR           : in     vl_logic;
        gateL           : in     vl_logic;
        gondInL         : out    vl_logic;
        gondInChamber   : out    vl_logic;
        gondInR         : out    vl_logic;
        gateRClosed     : out    vl_logic;
        gateLClosed     : out    vl_logic
    );
end lockSystem;
