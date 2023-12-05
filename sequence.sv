//SEQUENCE

class f_sequence extends uvm_sequence #(f_sequence_item);
  `uvm_object_utils(f_sequence)
  f_sequence_item req;
  
  
  function new(string name = "f_sequence");
    super.new(name);
  endfunction
  
  virtual task body();
    `uvm_info(get_type_name(), $sformatf("******** Idle condition ********"), UVM_LOW);
    repeat(20) begin
      $display("IDLE");
      req = f_sequence_item::type_id::create("req");
      start_item(req);
      assert(req.randomize() with {i_rden==0;i_wren==0;});
      finish_item(req);
      end
    
      `uvm_info(get_type_name(), $sformatf("********Continuous writes ********"), UVM_LOW);
    repeat(20) begin
      $display("CONTINUOUS WRITES");
      req = f_sequence_item::type_id::create("req");
      start_item(req);
      assert(req.randomize() with {i_rden==0;i_wren==1;});
      finish_item(req);
    end
    
      `uvm_info(get_type_name(), $sformatf("******** Continuous reads ********"), UVM_LOW);
    repeat(20) begin
      $display("CONTINUOUS READS");
      req = f_sequence_item::type_id::create("req");
      start_item(req);
      assert(req.randomize() with {i_rden==1;i_wren==0;});
      finish_item(req);
    end
    
      `uvm_info(get_type_name(), $sformatf("******** Parallel write and read ********"), UVM_LOW);
    repeat(20) begin
      $display("PARALLEL WRITE AND READ");
      req = f_sequence_item::type_id::create("req");
      start_item(req);
      assert(req.randomize() with  {i_rden==1;i_wren==1;});
      finish_item(req);
    end
    
      `uvm_info(get_type_name(), $sformatf("******** Alternate write and read ********"), UVM_LOW);
    repeat(20) begin
      $display("ALTERNATE WRITE AND READ");
      req = f_sequence_item::type_id::create("req");
      start_item(req);
      assert(req.randomize() with {i_rden==0;i_wren==1;});
      finish_item(req);
      
      //req = f_sequence_item::type_id::create("req");
      start_item(req);
      assert(req.randomize() with {i_rden==1;i_wren==0;});
      finish_item(req);
    end
  endtask
endclass
