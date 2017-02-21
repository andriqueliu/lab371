
# (C) 2001-2017 Altera Corporation. All rights reserved.
# Your use of Altera Corporation's design tools, logic functions and 
# other software and tools, and its AMPP partner logic functions, and 
# any output files any of the foregoing (including device programming 
# or simulation files), and any associated documentation or information 
# are expressly subject to the terms and conditions of the Altera 
# Program License Subscription Agreement, Altera MegaCore Function 
# License Agreement, or other applicable license agreement, including, 
# without limitation, that your use is for the sole purpose of 
# programming logic devices manufactured by Altera and sold by Altera 
# or its authorized distributors. Please refer to the applicable 
# agreement for further details.

# ACDS 14.0 200 win32 2017.02.20.20:43:58

# ----------------------------------------
# vcsmx - auto-generated simulation script

# ----------------------------------------
# initialize variables
TOP_LEVEL_NAME="proj_qsys"
QSYS_SIMDIR="./../../"
QUARTUS_INSTALL_DIR="C:/altera/14.0/quartus/"
SKIP_FILE_COPY=0
SKIP_DEV_COM=0
SKIP_COM=0
SKIP_ELAB=0
SKIP_SIM=0
USER_DEFINED_ELAB_OPTIONS=""
USER_DEFINED_SIM_OPTIONS="+vcs+finish+100"

# ----------------------------------------
# overwrite variables - DO NOT MODIFY!
# This block evaluates each command line argument, typically used for 
# overwriting variables. An example usage:
#   sh <simulator>_setup.sh SKIP_ELAB=1 SKIP_SIM=1
for expression in "$@"; do
  eval $expression
  if [ $? -ne 0 ]; then
    echo "Error: This command line argument, \"$expression\", is/has an invalid expression." >&2
    exit $?
  fi
done

# ----------------------------------------
# initialize simulation properties - DO NOT MODIFY!
ELAB_OPTIONS=""
SIM_OPTIONS=""
if [[ `vcs -platform` != *"amd64"* ]]; then
  :
else
  :
fi

# ----------------------------------------
# create compilation libraries
mkdir -p ./libraries/work/
mkdir -p ./libraries/rsp_mux_001/
mkdir -p ./libraries/rsp_mux/
mkdir -p ./libraries/rsp_demux_001/
mkdir -p ./libraries/rsp_demux/
mkdir -p ./libraries/cmd_mux_001/
mkdir -p ./libraries/cmd_mux/
mkdir -p ./libraries/cmd_demux_001/
mkdir -p ./libraries/cmd_demux/
mkdir -p ./libraries/cpu_instruction_master_limiter/
mkdir -p ./libraries/router_007/
mkdir -p ./libraries/router_003/
mkdir -p ./libraries/router_002/
mkdir -p ./libraries/router_001/
mkdir -p ./libraries/router/
mkdir -p ./libraries/onchip_mem_s1_agent_rsp_fifo/
mkdir -p ./libraries/onchip_mem_s1_agent/
mkdir -p ./libraries/cpu_data_master_agent/
mkdir -p ./libraries/onchip_mem_s1_translator/
mkdir -p ./libraries/cpu_data_master_translator/
mkdir -p ./libraries/rst_controller/
mkdir -p ./libraries/irq_mapper/
mkdir -p ./libraries/mm_interconnect_0/
mkdir -p ./libraries/led_pio/
mkdir -p ./libraries/sysid/
mkdir -p ./libraries/sys_clk_timer/
mkdir -p ./libraries/jtag_uart/
mkdir -p ./libraries/onchip_mem/
mkdir -p ./libraries/cpu/
mkdir -p ./libraries/altera_ver/
mkdir -p ./libraries/lpm_ver/
mkdir -p ./libraries/sgate_ver/
mkdir -p ./libraries/altera_mf_ver/
mkdir -p ./libraries/altera_lnsim_ver/
mkdir -p ./libraries/cyclonev_ver/
mkdir -p ./libraries/cyclonev_hssi_ver/
mkdir -p ./libraries/cyclonev_pcie_hip_ver/

# ----------------------------------------
# copy RAM/ROM files to simulation directory
if [ $SKIP_FILE_COPY -eq 0 ]; then
  cp -f $QSYS_SIMDIR/submodules/proj_qsys_onchip_mem.hex ./
  cp -f $QSYS_SIMDIR/submodules/proj_qsys_cpu_ic_tag_ram.dat ./
  cp -f $QSYS_SIMDIR/submodules/proj_qsys_cpu_ic_tag_ram.hex ./
  cp -f $QSYS_SIMDIR/submodules/proj_qsys_cpu_ic_tag_ram.mif ./
  cp -f $QSYS_SIMDIR/submodules/proj_qsys_cpu_ociram_default_contents.dat ./
  cp -f $QSYS_SIMDIR/submodules/proj_qsys_cpu_ociram_default_contents.hex ./
  cp -f $QSYS_SIMDIR/submodules/proj_qsys_cpu_ociram_default_contents.mif ./
  cp -f $QSYS_SIMDIR/submodules/proj_qsys_cpu_rf_ram_a.dat ./
  cp -f $QSYS_SIMDIR/submodules/proj_qsys_cpu_rf_ram_a.hex ./
  cp -f $QSYS_SIMDIR/submodules/proj_qsys_cpu_rf_ram_a.mif ./
  cp -f $QSYS_SIMDIR/submodules/proj_qsys_cpu_rf_ram_b.dat ./
  cp -f $QSYS_SIMDIR/submodules/proj_qsys_cpu_rf_ram_b.hex ./
  cp -f $QSYS_SIMDIR/submodules/proj_qsys_cpu_rf_ram_b.mif ./
fi

# ----------------------------------------
# compile device library files
if [ $SKIP_DEV_COM -eq 0 ]; then
  vlogan +v2k           "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_primitives.v"                       -work altera_ver           
  vlogan +v2k           "$QUARTUS_INSTALL_DIR/eda/sim_lib/220model.v"                                -work lpm_ver              
  vlogan +v2k           "$QUARTUS_INSTALL_DIR/eda/sim_lib/sgate.v"                                   -work sgate_ver            
  vlogan +v2k           "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_mf.v"                               -work altera_mf_ver        
  vlogan +v2k -sverilog "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_lnsim.sv"                           -work altera_lnsim_ver     
  vlogan +v2k           "$QUARTUS_INSTALL_DIR/eda/sim_lib/synopsys/cyclonev_atoms_ncrypt.v"          -work cyclonev_ver         
  vlogan +v2k           "$QUARTUS_INSTALL_DIR/eda/sim_lib/synopsys/cyclonev_hmi_atoms_ncrypt.v"      -work cyclonev_ver         
  vlogan +v2k           "$QUARTUS_INSTALL_DIR/eda/sim_lib/cyclonev_atoms.v"                          -work cyclonev_ver         
  vlogan +v2k           "$QUARTUS_INSTALL_DIR/eda/sim_lib/synopsys/cyclonev_hssi_atoms_ncrypt.v"     -work cyclonev_hssi_ver    
  vlogan +v2k           "$QUARTUS_INSTALL_DIR/eda/sim_lib/cyclonev_hssi_atoms.v"                     -work cyclonev_hssi_ver    
  vlogan +v2k           "$QUARTUS_INSTALL_DIR/eda/sim_lib/synopsys/cyclonev_pcie_hip_atoms_ncrypt.v" -work cyclonev_pcie_hip_ver
  vlogan +v2k           "$QUARTUS_INSTALL_DIR/eda/sim_lib/cyclonev_pcie_hip_atoms.v"                 -work cyclonev_pcie_hip_ver
fi

# ----------------------------------------
# compile design files in correct order
if [ $SKIP_COM -eq 0 ]; then
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/altera_merlin_arbitrator.sv"                  -work rsp_mux_001                   
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/proj_qsys_mm_interconnect_0_rsp_mux_001.sv"   -work rsp_mux_001                   
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/altera_merlin_arbitrator.sv"                  -work rsp_mux                       
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/proj_qsys_mm_interconnect_0_rsp_mux.sv"       -work rsp_mux                       
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/proj_qsys_mm_interconnect_0_rsp_demux_001.sv" -work rsp_demux_001                 
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/proj_qsys_mm_interconnect_0_rsp_demux.sv"     -work rsp_demux                     
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/altera_merlin_arbitrator.sv"                  -work cmd_mux_001                   
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/proj_qsys_mm_interconnect_0_cmd_mux_001.sv"   -work cmd_mux_001                   
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/altera_merlin_arbitrator.sv"                  -work cmd_mux                       
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/proj_qsys_mm_interconnect_0_cmd_mux.sv"       -work cmd_mux                       
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/proj_qsys_mm_interconnect_0_cmd_demux_001.sv" -work cmd_demux_001                 
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/proj_qsys_mm_interconnect_0_cmd_demux.sv"     -work cmd_demux                     
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/altera_merlin_traffic_limiter.sv"             -work cpu_instruction_master_limiter
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/altera_merlin_reorder_memory.sv"              -work cpu_instruction_master_limiter
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/altera_avalon_sc_fifo.v"                      -work cpu_instruction_master_limiter
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/altera_avalon_st_pipeline_base.v"             -work cpu_instruction_master_limiter
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/proj_qsys_mm_interconnect_0_router_007.sv"    -work router_007                    
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/proj_qsys_mm_interconnect_0_router_003.sv"    -work router_003                    
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/proj_qsys_mm_interconnect_0_router_002.sv"    -work router_002                    
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/proj_qsys_mm_interconnect_0_router_001.sv"    -work router_001                    
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/proj_qsys_mm_interconnect_0_router.sv"        -work router                        
  vlogan +v2k           "$QSYS_SIMDIR/submodules/altera_avalon_sc_fifo.v"                      -work onchip_mem_s1_agent_rsp_fifo  
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/altera_merlin_slave_agent.sv"                 -work onchip_mem_s1_agent           
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/altera_merlin_burst_uncompressor.sv"          -work onchip_mem_s1_agent           
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/altera_merlin_master_agent.sv"                -work cpu_data_master_agent         
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/altera_merlin_slave_translator.sv"            -work onchip_mem_s1_translator      
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/altera_merlin_master_translator.sv"           -work cpu_data_master_translator    
  vlogan +v2k           "$QSYS_SIMDIR/submodules/altera_reset_controller.v"                    -work rst_controller                
  vlogan +v2k           "$QSYS_SIMDIR/submodules/altera_reset_synchronizer.v"                  -work rst_controller                
  vlogan +v2k -sverilog "$QSYS_SIMDIR/submodules/proj_qsys_irq_mapper.sv"                      -work irq_mapper                    
  vlogan +v2k           "$QSYS_SIMDIR/submodules/proj_qsys_mm_interconnect_0.v"                -work mm_interconnect_0             
  vlogan +v2k           "$QSYS_SIMDIR/submodules/proj_qsys_led_pio.v"                          -work led_pio                       
  vlogan +v2k           "$QSYS_SIMDIR/submodules/proj_qsys_sysid.vo"                           -work sysid                         
  vlogan +v2k           "$QSYS_SIMDIR/submodules/proj_qsys_sys_clk_timer.v"                    -work sys_clk_timer                 
  vlogan +v2k           "$QSYS_SIMDIR/submodules/proj_qsys_jtag_uart.v"                        -work jtag_uart                     
  vlogan +v2k           "$QSYS_SIMDIR/submodules/proj_qsys_onchip_mem.v"                       -work onchip_mem                    
  vlogan +v2k           "$QSYS_SIMDIR/submodules/proj_qsys_cpu.vo"                             -work cpu                           
  vlogan +v2k           "$QSYS_SIMDIR/submodules/proj_qsys_cpu_jtag_debug_module_sysclk.v"     -work cpu                           
  vlogan +v2k           "$QSYS_SIMDIR/submodules/proj_qsys_cpu_jtag_debug_module_tck.v"        -work cpu                           
  vlogan +v2k           "$QSYS_SIMDIR/submodules/proj_qsys_cpu_jtag_debug_module_wrapper.v"    -work cpu                           
  vlogan +v2k           "$QSYS_SIMDIR/submodules/proj_qsys_cpu_oci_test_bench.v"               -work cpu                           
  vlogan +v2k           "$QSYS_SIMDIR/submodules/proj_qsys_cpu_test_bench.v"                   -work cpu                           
  vlogan +v2k           "$QSYS_SIMDIR/proj_qsys.v"                                                                                 
fi

# ----------------------------------------
# elaborate top level design
if [ $SKIP_ELAB -eq 0 ]; then
  vcs -lca -t ps $ELAB_OPTIONS $USER_DEFINED_ELAB_OPTIONS $TOP_LEVEL_NAME
fi

# ----------------------------------------
# simulate
if [ $SKIP_SIM -eq 0 ]; then
  ./simv $SIM_OPTIONS $USER_DEFINED_SIM_OPTIONS
fi
