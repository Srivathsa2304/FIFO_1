class fifo_subscriber extends uvm_subscriber#(f_sequence_item);

  `uvm_component_utils(fifo_subscriber)
  uvm_analysis_imp#(f_sequence_item, fifo_subscriber) item_got_export1;

  f_sequence_item tr;

covergroup cg_in;
  option.auto_bin_max=1024;

  read:coverpoint tr.i_rden;

  write:coverpoint tr.i_wren;

  data: coverpoint tr.i_wrdata;
endgroup
  
covergroup cg_out;
  option.auto_bin_max=1024;

  full: coverpoint tr.o_full;

  alm_full: coverpoint tr.o_alm_full;

  alm_empty: coverpoint tr.o_alm_empty;

  empty: coverpoint tr.o_empty;

  dataout : coverpoint tr.o_rddata;

endgroup

 

function new(string name="f_subscriber",uvm_component parent);

  super.new(name,parent);

  item_got_export1= new("item_got_export1", this);

  tr=f_sequence_item::type_id::create("tr");

  cg_in=new();
  
  cg_out=new();

endfunction

 

  function void write(f_sequence_item t);

   tr=t;

   cg_in.sample();

    $display("input coverage =%0d ",cg_in.get_coverage());
     cg_out.sample();

    $display("output coverage =%0d ",cg_out.get_coverage());

endfunction

endclass
