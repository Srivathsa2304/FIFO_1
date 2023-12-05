class f_coverage extends uvm_subscriber #(f_sequence_item);
  uvm_analysis_imp#(f_sequence_item, f_coverage) cov_export;
  //----------------------------------------------------------------------------
  `uvm_component_utils(f_coverage)
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  f_sequence_item txn;
  real in_cov, out_cov;
  //----------------------------------------------------------------------------
  
  //----------------------------------------------------------------------------
  covergroup input_cov;
    option.per_instance= 1;
    option.comment     = "input_cov";
    option.name        = "input_cov";
    //option.auto_bin_max= 4;
    A:coverpoint txn.i_wren { 
        bins wren_low  ={0};
        bins wren_high ={1};
    }
    B:coverpoint txn.i_rden { 
        bins rden_low  ={0};
        bins rden_high ={1};
    }
    AXB:cross A,B;//{ ignore_bins cxd = binsof(C.full_high) && binsof(D.empty_high);
                 //}
    
  endgroup:input_cov;
  
  covergroup output_cov;
    option.per_instance= 1;
    option.comment     = "output_cov";
    option.name        = "output_cov";
    C:coverpoint txn.o_full { 
        bins full_low  ={0};
        bins full_high ={1};
    }
    D:coverpoint txn.o_empty { 
        bins empty_low  ={0};
        bins empty_high ={1};
    }
      CXD:cross C,D {
        illegal_bins cxd = binsof(C.full_high) && binsof(D.empty_high);
    }
    E:coverpoint txn.o_alm_full { 
        bins alm_full_low  ={0};
        bins alm_full_high ={1};
    }
    F:coverpoint txn.o_alm_empty { 
        bins alm_empty_low  ={0};
        bins alm_empty_high ={1};
    }
 endgroup:output_cov;
  //----------------------------------------------------------------------------
function new(string name="f_coverage",uvm_component parent);
    super.new(name,parent);
    cov_export = new("cov_export", this);
    input_cov=new();
    output_cov=new();
  endfunction
  //---------------------  write method ----------------------------------------
  function void write(f_sequence_item t);
    txn=t;
    input_cov.sample();
    output_cov.sample();
  endfunction
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  function void extract_phase(uvm_phase phase);
    super.extract_phase(phase);
    $display("HIIIIIIIII");
    in_cov=input_cov.get_coverage();
    out_cov=output_cov.get_coverage();
  endfunction
  //----------------------------------------------------------------------------


  //----------------------------------------------------------------------------
  function void report_phase(uvm_phase phase);
    super.report_phase(phase);
    `uvm_info(get_type_name(),$sformatf("Input Coverage is %f \n Output Coverage is %f",in_cov, out_cov),UVM_MEDIUM)
  endfunction
  //----------------------------------------------------------------------------
  
endclass
            
