library verilog;
use verilog.vl_types.all;
entity inputModule is
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        arriving        : in     vl_logic;
        departing       : in     vl_logic;
        arrivingOut     : out    vl_logic;
        departingOut    : out    vl_logic;
        gateR           : in     vl_logic;
        gateL           : in     vl_logic;
        gateROut        : out    vl_logic;
        gateLOut        : out    vl_logic;
        gondInRIn       : in     vl_logic;
        gondInLIn       : in     vl_logic;
        gondInChamberIn : in     vl_logic;
        gondInRLEDR     : out    vl_logic;
        gondInLLEDR     : out    vl_logic;
        gondInChamberLEDR: out    vl_logic;
        increaseEnable  : in     vl_logic;
        decreaseEnable  : in     vl_logic;
        arrivingEnable  : in     vl_logic;
        increaseEnableOut: out    vl_logic;
        decreaseEnableOut: out    vl_logic;
        arrivingEnableOut: out    vl_logic;
        increaseBusy    : in     vl_logic;
        decreaseBusy    : in     vl_logic;
        arrivingBusy    : in     vl_logic
    );
end inputModule;
