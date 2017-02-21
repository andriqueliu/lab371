
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
# Auto-generated simulation script

# ----------------------------------------
# Initialize variables
if ![info exists SYSTEM_INSTANCE_NAME] { 
  set SYSTEM_INSTANCE_NAME ""
} elseif { ![ string match "" $SYSTEM_INSTANCE_NAME ] } { 
  set SYSTEM_INSTANCE_NAME "/$SYSTEM_INSTANCE_NAME"
}

if ![info exists TOP_LEVEL_NAME] { 
  set TOP_LEVEL_NAME "proj_qsys"
}

if ![info exists QSYS_SIMDIR] { 
  set QSYS_SIMDIR "./../"
}

if ![info exists QUARTUS_INSTALL_DIR] { 
  set QUARTUS_INSTALL_DIR "C:/altera/14.0/quartus/"
}

# ----------------------------------------
# Initialize simulation properties - DO NOT MODIFY!
set ELAB_OPTIONS ""
set SIM_OPTIONS ""
if ![ string match "*-64 vsim*" [ vsim -version ] ] {
} else {
}

set Aldec "Riviera"
if { [ string match "*Active-HDL*" [ vsim -version ] ] } {
  set Aldec "Active"
}

if { [ string match "Active" $Aldec ] } {
  scripterconf -tcl
  createdesign "$TOP_LEVEL_NAME"  "."
  opendesign "$TOP_LEVEL_NAME"
}

# ----------------------------------------
# Copy ROM/RAM files to simulation directory
alias file_copy {
  echo "\[exec\] file_copy"
  file copy -force $QSYS_SIMDIR/submodules/proj_qsys_onchip_mem.hex ./
  file copy -force $QSYS_SIMDIR/submodules/proj_qsys_cpu_ic_tag_ram.dat ./
  file copy -force $QSYS_SIMDIR/submodules/proj_qsys_cpu_ic_tag_ram.hex ./
  file copy -force $QSYS_SIMDIR/submodules/proj_qsys_cpu_ic_tag_ram.mif ./
  file copy -force $QSYS_SIMDIR/submodules/proj_qsys_cpu_ociram_default_contents.dat ./
  file copy -force $QSYS_SIMDIR/submodules/proj_qsys_cpu_ociram_default_contents.hex ./
  file copy -force $QSYS_SIMDIR/submodules/proj_qsys_cpu_ociram_default_contents.mif ./
  file copy -force $QSYS_SIMDIR/submodules/proj_qsys_cpu_rf_ram_a.dat ./
  file copy -force $QSYS_SIMDIR/submodules/proj_qsys_cpu_rf_ram_a.hex ./
  file copy -force $QSYS_SIMDIR/submodules/proj_qsys_cpu_rf_ram_a.mif ./
  file copy -force $QSYS_SIMDIR/submodules/proj_qsys_cpu_rf_ram_b.dat ./
  file copy -force $QSYS_SIMDIR/submodules/proj_qsys_cpu_rf_ram_b.hex ./
  file copy -force $QSYS_SIMDIR/submodules/proj_qsys_cpu_rf_ram_b.mif ./
}

# ----------------------------------------
# Create compilation libraries
proc ensure_lib { lib } { if ![file isdirectory $lib] { vlib $lib } }
ensure_lib      ./libraries     
ensure_lib      ./libraries/work
vmap       work ./libraries/work
ensure_lib                       ./libraries/altera_ver           
vmap       altera_ver            ./libraries/altera_ver           
ensure_lib                       ./libraries/lpm_ver              
vmap       lpm_ver               ./libraries/lpm_ver              
ensure_lib                       ./libraries/sgate_ver            
vmap       sgate_ver             ./libraries/sgate_ver            
ensure_lib                       ./libraries/altera_mf_ver        
vmap       altera_mf_ver         ./libraries/altera_mf_ver        
ensure_lib                       ./libraries/altera_lnsim_ver     
vmap       altera_lnsim_ver      ./libraries/altera_lnsim_ver     
ensure_lib                       ./libraries/cyclonev_ver         
vmap       cyclonev_ver          ./libraries/cyclonev_ver         
ensure_lib                       ./libraries/cyclonev_hssi_ver    
vmap       cyclonev_hssi_ver     ./libraries/cyclonev_hssi_ver    
ensure_lib                       ./libraries/cyclonev_pcie_hip_ver
vmap       cyclonev_pcie_hip_ver ./libraries/cyclonev_pcie_hip_ver
ensure_lib                                ./libraries/rsp_mux_001                   
vmap       rsp_mux_001                    ./libraries/rsp_mux_001                   
ensure_lib                                ./libraries/rsp_mux                       
vmap       rsp_mux                        ./libraries/rsp_mux                       
ensure_lib                                ./libraries/rsp_demux_001                 
vmap       rsp_demux_001                  ./libraries/rsp_demux_001                 
ensure_lib                                ./libraries/rsp_demux                     
vmap       rsp_demux                      ./libraries/rsp_demux                     
ensure_lib                                ./libraries/cmd_mux_001                   
vmap       cmd_mux_001                    ./libraries/cmd_mux_001                   
ensure_lib                                ./libraries/cmd_mux                       
vmap       cmd_mux                        ./libraries/cmd_mux                       
ensure_lib                                ./libraries/cmd_demux_001                 
vmap       cmd_demux_001                  ./libraries/cmd_demux_001                 
ensure_lib                                ./libraries/cmd_demux                     
vmap       cmd_demux                      ./libraries/cmd_demux                     
ensure_lib                                ./libraries/cpu_instruction_master_limiter
vmap       cpu_instruction_master_limiter ./libraries/cpu_instruction_master_limiter
ensure_lib                                ./libraries/router_007                    
vmap       router_007                     ./libraries/router_007                    
ensure_lib                                ./libraries/router_003                    
vmap       router_003                     ./libraries/router_003                    
ensure_lib                                ./libraries/router_002                    
vmap       router_002                     ./libraries/router_002                    
ensure_lib                                ./libraries/router_001                    
vmap       router_001                     ./libraries/router_001                    
ensure_lib                                ./libraries/router                        
vmap       router                         ./libraries/router                        
ensure_lib                                ./libraries/onchip_mem_s1_agent_rsp_fifo  
vmap       onchip_mem_s1_agent_rsp_fifo   ./libraries/onchip_mem_s1_agent_rsp_fifo  
ensure_lib                                ./libraries/onchip_mem_s1_agent           
vmap       onchip_mem_s1_agent            ./libraries/onchip_mem_s1_agent           
ensure_lib                                ./libraries/cpu_data_master_agent         
vmap       cpu_data_master_agent          ./libraries/cpu_data_master_agent         
ensure_lib                                ./libraries/onchip_mem_s1_translator      
vmap       onchip_mem_s1_translator       ./libraries/onchip_mem_s1_translator      
ensure_lib                                ./libraries/cpu_data_master_translator    
vmap       cpu_data_master_translator     ./libraries/cpu_data_master_translator    
ensure_lib                                ./libraries/rst_controller                
vmap       rst_controller                 ./libraries/rst_controller                
ensure_lib                                ./libraries/irq_mapper                    
vmap       irq_mapper                     ./libraries/irq_mapper                    
ensure_lib                                ./libraries/mm_interconnect_0             
vmap       mm_interconnect_0              ./libraries/mm_interconnect_0             
ensure_lib                                ./libraries/led_pio                       
vmap       led_pio                        ./libraries/led_pio                       
ensure_lib                                ./libraries/sysid                         
vmap       sysid                          ./libraries/sysid                         
ensure_lib                                ./libraries/sys_clk_timer                 
vmap       sys_clk_timer                  ./libraries/sys_clk_timer                 
ensure_lib                                ./libraries/jtag_uart                     
vmap       jtag_uart                      ./libraries/jtag_uart                     
ensure_lib                                ./libraries/onchip_mem                    
vmap       onchip_mem                     ./libraries/onchip_mem                    
ensure_lib                                ./libraries/cpu                           
vmap       cpu                            ./libraries/cpu                           

# ----------------------------------------
# Compile device library files
alias dev_com {
  echo "\[exec\] dev_com"
  vlog  "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_primitives.v"                    -work altera_ver           
  vlog  "$QUARTUS_INSTALL_DIR/eda/sim_lib/220model.v"                             -work lpm_ver              
  vlog  "$QUARTUS_INSTALL_DIR/eda/sim_lib/sgate.v"                                -work sgate_ver            
  vlog  "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_mf.v"                            -work altera_mf_ver        
  vlog  "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_lnsim.sv"                        -work altera_lnsim_ver     
  vlog  "$QUARTUS_INSTALL_DIR/eda/sim_lib/aldec/cyclonev_atoms_ncrypt.v"          -work cyclonev_ver         
  vlog  "$QUARTUS_INSTALL_DIR/eda/sim_lib/aldec/cyclonev_hmi_atoms_ncrypt.v"      -work cyclonev_ver         
  vlog  "$QUARTUS_INSTALL_DIR/eda/sim_lib/cyclonev_atoms.v"                       -work cyclonev_ver         
  vlog  "$QUARTUS_INSTALL_DIR/eda/sim_lib/aldec/cyclonev_hssi_atoms_ncrypt.v"     -work cyclonev_hssi_ver    
  vlog  "$QUARTUS_INSTALL_DIR/eda/sim_lib/cyclonev_hssi_atoms.v"                  -work cyclonev_hssi_ver    
  vlog  "$QUARTUS_INSTALL_DIR/eda/sim_lib/aldec/cyclonev_pcie_hip_atoms_ncrypt.v" -work cyclonev_pcie_hip_ver
  vlog  "$QUARTUS_INSTALL_DIR/eda/sim_lib/cyclonev_pcie_hip_atoms.v"              -work cyclonev_pcie_hip_ver
}

# ----------------------------------------
# Compile the design files in correct order
alias com {
  echo "\[exec\] com"
  vlog  "$QSYS_SIMDIR/submodules/altera_merlin_arbitrator.sv"                  -work rsp_mux_001                   
  vlog  "$QSYS_SIMDIR/submodules/proj_qsys_mm_interconnect_0_rsp_mux_001.sv"   -work rsp_mux_001                   
  vlog  "$QSYS_SIMDIR/submodules/altera_merlin_arbitrator.sv"                  -work rsp_mux                       
  vlog  "$QSYS_SIMDIR/submodules/proj_qsys_mm_interconnect_0_rsp_mux.sv"       -work rsp_mux                       
  vlog  "$QSYS_SIMDIR/submodules/proj_qsys_mm_interconnect_0_rsp_demux_001.sv" -work rsp_demux_001                 
  vlog  "$QSYS_SIMDIR/submodules/proj_qsys_mm_interconnect_0_rsp_demux.sv"     -work rsp_demux                     
  vlog  "$QSYS_SIMDIR/submodules/altera_merlin_arbitrator.sv"                  -work cmd_mux_001                   
  vlog  "$QSYS_SIMDIR/submodules/proj_qsys_mm_interconnect_0_cmd_mux_001.sv"   -work cmd_mux_001                   
  vlog  "$QSYS_SIMDIR/submodules/altera_merlin_arbitrator.sv"                  -work cmd_mux                       
  vlog  "$QSYS_SIMDIR/submodules/proj_qsys_mm_interconnect_0_cmd_mux.sv"       -work cmd_mux                       
  vlog  "$QSYS_SIMDIR/submodules/proj_qsys_mm_interconnect_0_cmd_demux_001.sv" -work cmd_demux_001                 
  vlog  "$QSYS_SIMDIR/submodules/proj_qsys_mm_interconnect_0_cmd_demux.sv"     -work cmd_demux                     
  vlog  "$QSYS_SIMDIR/submodules/altera_merlin_traffic_limiter.sv"             -work cpu_instruction_master_limiter
  vlog  "$QSYS_SIMDIR/submodules/altera_merlin_reorder_memory.sv"              -work cpu_instruction_master_limiter
  vlog  "$QSYS_SIMDIR/submodules/altera_avalon_sc_fifo.v"                      -work cpu_instruction_master_limiter
  vlog  "$QSYS_SIMDIR/submodules/altera_avalon_st_pipeline_base.v"             -work cpu_instruction_master_limiter
  vlog  "$QSYS_SIMDIR/submodules/proj_qsys_mm_interconnect_0_router_007.sv"    -work router_007                    
  vlog  "$QSYS_SIMDIR/submodules/proj_qsys_mm_interconnect_0_router_003.sv"    -work router_003                    
  vlog  "$QSYS_SIMDIR/submodules/proj_qsys_mm_interconnect_0_router_002.sv"    -work router_002                    
  vlog  "$QSYS_SIMDIR/submodules/proj_qsys_mm_interconnect_0_router_001.sv"    -work router_001                    
  vlog  "$QSYS_SIMDIR/submodules/proj_qsys_mm_interconnect_0_router.sv"        -work router                        
  vlog  "$QSYS_SIMDIR/submodules/altera_avalon_sc_fifo.v"                      -work onchip_mem_s1_agent_rsp_fifo  
  vlog  "$QSYS_SIMDIR/submodules/altera_merlin_slave_agent.sv"                 -work onchip_mem_s1_agent           
  vlog  "$QSYS_SIMDIR/submodules/altera_merlin_burst_uncompressor.sv"          -work onchip_mem_s1_agent           
  vlog  "$QSYS_SIMDIR/submodules/altera_merlin_master_agent.sv"                -work cpu_data_master_agent         
  vlog  "$QSYS_SIMDIR/submodules/altera_merlin_slave_translator.sv"            -work onchip_mem_s1_translator      
  vlog  "$QSYS_SIMDIR/submodules/altera_merlin_master_translator.sv"           -work cpu_data_master_translator    
  vlog  "$QSYS_SIMDIR/submodules/altera_reset_controller.v"                    -work rst_controller                
  vlog  "$QSYS_SIMDIR/submodules/altera_reset_synchronizer.v"                  -work rst_controller                
  vlog  "$QSYS_SIMDIR/submodules/proj_qsys_irq_mapper.sv"                      -work irq_mapper                    
  vlog  "$QSYS_SIMDIR/submodules/proj_qsys_mm_interconnect_0.v"                -work mm_interconnect_0             
  vlog  "$QSYS_SIMDIR/submodules/proj_qsys_led_pio.v"                          -work led_pio                       
  vlog  "$QSYS_SIMDIR/submodules/proj_qsys_sysid.vo"                           -work sysid                         
  vlog  "$QSYS_SIMDIR/submodules/proj_qsys_sys_clk_timer.v"                    -work sys_clk_timer                 
  vlog  "$QSYS_SIMDIR/submodules/proj_qsys_jtag_uart.v"                        -work jtag_uart                     
  vlog  "$QSYS_SIMDIR/submodules/proj_qsys_onchip_mem.v"                       -work onchip_mem                    
  vlog  "$QSYS_SIMDIR/submodules/proj_qsys_cpu.vo"                             -work cpu                           
  vlog  "$QSYS_SIMDIR/submodules/proj_qsys_cpu_jtag_debug_module_sysclk.v"     -work cpu                           
  vlog  "$QSYS_SIMDIR/submodules/proj_qsys_cpu_jtag_debug_module_tck.v"        -work cpu                           
  vlog  "$QSYS_SIMDIR/submodules/proj_qsys_cpu_jtag_debug_module_wrapper.v"    -work cpu                           
  vlog  "$QSYS_SIMDIR/submodules/proj_qsys_cpu_oci_test_bench.v"               -work cpu                           
  vlog  "$QSYS_SIMDIR/submodules/proj_qsys_cpu_test_bench.v"                   -work cpu                           
  vlog  "$QSYS_SIMDIR/proj_qsys.v"                                                                                 
}

# ----------------------------------------
# Elaborate top level design
alias elab {
  echo "\[exec\] elab"
  eval vsim +access +r -t ps $ELAB_OPTIONS -L work -L rsp_mux_001 -L rsp_mux -L rsp_demux_001 -L rsp_demux -L cmd_mux_001 -L cmd_mux -L cmd_demux_001 -L cmd_demux -L cpu_instruction_master_limiter -L router_007 -L router_003 -L router_002 -L router_001 -L router -L onchip_mem_s1_agent_rsp_fifo -L onchip_mem_s1_agent -L cpu_data_master_agent -L onchip_mem_s1_translator -L cpu_data_master_translator -L rst_controller -L irq_mapper -L mm_interconnect_0 -L led_pio -L sysid -L sys_clk_timer -L jtag_uart -L onchip_mem -L cpu -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver $TOP_LEVEL_NAME
}

# ----------------------------------------
# Elaborate the top level design with -dbg -O2 option
alias elab_debug {
  echo "\[exec\] elab_debug"
  eval vsim -dbg -O2 +access +r -t ps $ELAB_OPTIONS -L work -L rsp_mux_001 -L rsp_mux -L rsp_demux_001 -L rsp_demux -L cmd_mux_001 -L cmd_mux -L cmd_demux_001 -L cmd_demux -L cpu_instruction_master_limiter -L router_007 -L router_003 -L router_002 -L router_001 -L router -L onchip_mem_s1_agent_rsp_fifo -L onchip_mem_s1_agent -L cpu_data_master_agent -L onchip_mem_s1_translator -L cpu_data_master_translator -L rst_controller -L irq_mapper -L mm_interconnect_0 -L led_pio -L sysid -L sys_clk_timer -L jtag_uart -L onchip_mem -L cpu -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver $TOP_LEVEL_NAME
}

# ----------------------------------------
# Compile all the design files and elaborate the top level design
alias ld "
  dev_com
  com
  elab
"

# ----------------------------------------
# Compile all the design files and elaborate the top level design with -dbg -O2
alias ld_debug "
  dev_com
  com
  elab_debug
"

# ----------------------------------------
# Print out user commmand line aliases
alias h {
  echo "List Of Command Line Aliases"
  echo
  echo "file_copy                     -- Copy ROM/RAM files to simulation directory"
  echo
  echo "dev_com                       -- Compile device library files"
  echo
  echo "com                           -- Compile the design files in correct order"
  echo
  echo "elab                          -- Elaborate top level design"
  echo
  echo "elab_debug                    -- Elaborate the top level design with -dbg -O2 option"
  echo
  echo "ld                            -- Compile all the design files and elaborate the top level design"
  echo
  echo "ld_debug                      -- Compile all the design files and elaborate the top level design with -dbg -O2"
  echo
  echo 
  echo
  echo "List Of Variables"
  echo
  echo "TOP_LEVEL_NAME                -- Top level module name."
  echo
  echo "SYSTEM_INSTANCE_NAME          -- Instantiated system module name inside top level module."
  echo
  echo "QSYS_SIMDIR                   -- Qsys base simulation directory."
  echo
  echo "QUARTUS_INSTALL_DIR           -- Quartus installation directory."
}
file_copy
h
