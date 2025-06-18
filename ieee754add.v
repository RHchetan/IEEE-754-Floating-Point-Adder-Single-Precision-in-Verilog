module ieee754add(
    input [31:0] operand_1,
    input [31:0] operand_2,
    output reg [31:0] sum 
    
);

     reg [7:0] exponent_1, exponent_2, exponent, new_exponent_1, new_exponent_2, new_exponent;
     reg [22:0] mantissa_1, mantissa_2, mantissa;
     reg [23:0] shifted_mantissa_1, shifted_mantissa_2, shifted_mantissa;
     reg carry;
     reg [23:0] shifted_complement;
     reg [23:0] shifted_data;

    always @(operand_1 or operand_2) 
    begin
        // Extracting Exponents and Mantissas:
        exponent_1 = operand_1[30:23];
        exponent_2 = operand_2[30:23];
        mantissa_1 = {operand_1[22:0]};
        mantissa_2 = {operand_2[22:0]};
    end
    always@(mantissa_1 or mantissa_2 or exponent_1 or exponent_2)begin
        // Exponent and mantissa alignment
        if (exponent_1 == exponent_2) begin
            shifted_mantissa_1 = {1'b1, mantissa_1};
            shifted_mantissa_2 = {1'b1, mantissa_2};
            new_exponent_1 = exponent_1;
            new_exponent_2 = exponent_2;
        end 
        else if (exponent_1 > exponent_2) begin
            shifted_mantissa_1 = {1'b1, mantissa_1};
            shifted_mantissa_2 = {1'b1, mantissa_2} >> (exponent_1 - exponent_2);
            new_exponent_1 = exponent_1; 
            new_exponent_2 = exponent_1;
        end 
        else if (exponent_1 < exponent_2) begin
            shifted_mantissa_1 = {1'b1, mantissa_1} >> (exponent_2 - exponent_1);
            shifted_mantissa_2 = {1'b1, mantissa_2};
            new_exponent_1 = exponent_2;   
            new_exponent_2 = exponent_2;
        end  
      end
      always@(operand_1 or shifted_mantissa_1 or shifted_mantissa_2 or new_exponent_1 or new_exponent_2)  begin

        // Mantissa addition
        if (operand_1[31] == operand_2[31]) begin
            {carry, shifted_mantissa} = shifted_mantissa_1 + shifted_mantissa_2; 
            if (carry == 1'b1) begin
            sum[31] = operand_1[31];
            exponent =  new_exponent_1 + 1;
            mantissa = shifted_mantissa[23:1];
            end
            if (carry == 1'b0) begin  
            sum[31] = operand_1[31];
            exponent =  new_exponent_1;
            mantissa = shifted_mantissa[22:0];
            end 
            sum[30:23] = exponent; // Adjusted exponent
            sum[22:0] = mantissa;
        end 
        
        end     
        reg [24:0] shifted_mantissak,shifted_mantissakk;
        
        
        //reg c;
        always@(operand_1 or operand_2 or shifted_mantissa_1 or shifted_mantissa_2 or new_exponent_1) begin
       if (operand_1[31] != operand_2[31]) begin 
       	    shifted_mantissak = (~{1'b0,shifted_mantissa_2}) + 1;
            {carry,shifted_mantissakk} = {1'b0,shifted_mantissa_1} + shifted_mantissak; 
             shifted_mantissa = shifted_mantissakk[23:0]; 
             //k = shifted_mantissakk[22]; 
            
		             
            if (carry == 1'b1) begin
            sum[31] = operand_1[31];
            end
            else if (carry == 1'b0)begin
            sum[31] = operand_2[31]; 
            end
            if ((shifted_mantissa[23] == 1'b1) && (carry == 1'b1)) begin
                mantissa[22:0] = shifted_mantissa[22:0];
                exponent = new_exponent_1; 
                end
            else if ((shifted_mantissa[23] == 1'b0) && (carry == 1'b1)) begin
                 if (shifted_mantissa[23] == 1'b1) begin
                 shifted_data = shifted_mantissa << 0; 
                 exponent = new_exponent_1 - 0;
                 mantissa[22:0] = shifted_data[22:0];
                 end
                 else if (shifted_mantissa[23:22] == 2'b01)  begin
                 shifted_data = shifted_mantissa << 1;   
                 exponent = new_exponent_1 - 1;
                 mantissa[22:0] = shifted_data[22:0];
                 end
                 else if (shifted_mantissa[23:21] == 3'b001) begin
                 shifted_data = shifted_mantissa << 2;
                 exponent = new_exponent_1 - 2;
                 mantissa[22:0] = shifted_data[22:0];
                 end                 
                 else if (shifted_mantissa[23:20] == 4'b0001)     begin
                 shifted_data = shifted_mantissa << 3; 
                 exponent = new_exponent_1 - 3;
                 mantissa[22:0] = shifted_data[22:0];
                 end 
                 else if (shifted_mantissa[23:19] == 5'b00001) begin
                 shifted_data = shifted_mantissa << 4;   
                 exponent = new_exponent_1 - 4;
                 mantissa[22:0] = shifted_data[22:0];
                 end
                 else if (shifted_mantissa[23:18] == 6'b000001) begin
                 shifted_data = shifted_mantissa << 5;  
                 exponent = new_exponent_1 - 5;
                 mantissa[22:0] = shifted_data[22:0];
                 end 
                 else if (shifted_mantissa[23:17] == 7'b0000001) begin
                 shifted_data = shifted_mantissa << 6; 
                 exponent = new_exponent_1 - 6;
                 mantissa[22:0] = shifted_data[22:0];
                 end              
                 else if (shifted_mantissa[23:16] == 8'b00000001) begin
                 shifted_data = shifted_mantissa << 7;    
                 exponent = new_exponent_1 - 7;
                 mantissa[22:0] = shifted_data[22:0];
                 end  
                 else if (shifted_mantissa[23:15] == 9'b000000001) begin
                 shifted_data = shifted_mantissa << 8;    
                 exponent = new_exponent_1 - 8;
                 mantissa[22:0] = shifted_data[22:0];
                 end
                 else if (shifted_mantissa[23:14] == 10'b0000000001) begin
                 shifted_data = shifted_mantissa << 9;   
                 exponent = new_exponent_1 - 9;
                 mantissa[22:0] = shifted_data[22:0];
                 end       
                 else if (shifted_mantissa[23:13] == 11'b00000000001)  begin
                 shifted_data = shifted_mantissa << 10; 
                 exponent = new_exponent_1 - 10;
                 mantissa[22:0] = shifted_data[22:0];
                 end   
                 else if (shifted_mantissa[23:12] == 12'b000000000001) begin
                 shifted_data = shifted_mantissa << 11;   
                 exponent = new_exponent_1 - 11;
                 mantissa[22:0] = shifted_data[22:0];
                 end                 
                 else if (shifted_mantissa[23:11] == 13'b0000000000001) begin
                 shifted_data = shifted_mantissa << 12;
                 exponent = new_exponent_1 - 12;
                 mantissa = shifted_data[22:0];
                 end                           
                 else if (shifted_mantissa[23:10] == 14'b00000000000001) begin
                 shifted_data = shifted_mantissa << 13; 
                 exponent = new_exponent_1 - 13;
                 mantissa = shifted_data[22:0];
                 end                   
                 else if (shifted_mantissa[23:9] == 15'b000000000000001) begin
                 shifted_data = shifted_mantissa << 14;
                 exponent = new_exponent_1 - 14;
                 mantissa = shifted_data[22:0];
                 end                      
                 else if (shifted_mantissa[23:8] == 16'b0000000000000001) begin
                 shifted_data = shifted_mantissa << 15;   
                 exponent = new_exponent_1 - 15;
                 mantissa = shifted_data[22:0];
                 end                                   
                 else if (shifted_mantissa[23:7] == 17'b00000000000000001) begin
                 shifted_data = shifted_mantissa << 16;  
                 exponent = new_exponent_1 - 16;
                 mantissa = shifted_data[22:0];
                 end                          
                 else if (shifted_mantissa[23:6] == 18'b000000000000000001) begin
                 shifted_data = shifted_mantissa << 17;  
                 exponent = new_exponent_1 - 17;
                 mantissa = shifted_data[22:0];
                 end                                  
                 else if (shifted_mantissa[23:5] == 19'b0000000000000000001) begin
                 shifted_data = shifted_mantissa << 18; 
                 exponent = new_exponent_1 - 18;
                 mantissa = shifted_data[22:0];
                 end                                 
                 else if (shifted_mantissa[23:4] == 20'b00000000000000000001) begin
                 shifted_data = shifted_mantissa << 19; 
                 exponent = new_exponent_1 - 19;
                 mantissa = shifted_data[22:0];
                 end                             
                 else if (shifted_mantissa[23:3] == 21'b000000000000000000001) begin
                 shifted_data = shifted_mantissa << 20;
                 exponent = new_exponent_1 - 20;
                 mantissa = shifted_data[22:0];
                 end                    
                 else if (shifted_mantissa[23:2] == 22'b0000000000000000000001) begin
                 shifted_data = shifted_mantissa << 21;
                 exponent = new_exponent_1 - 21;
                 mantissa = shifted_data[22:0];
                 end  
                 else if (shifted_mantissa[23:1] == 23'b00000000000000000000001) begin
                 shifted_data = shifted_mantissa << 22; 
                 exponent = new_exponent_1 - 22;
                 mantissa = shifted_data[22:0];
                 end                         
                 else if (shifted_mantissa[23:0] == 24'b000000000000000000000001) begin
                 shifted_data = shifted_mantissa << 23;
                 exponent = new_exponent_1 - 23;
                 mantissa = shifted_data[22:0];
                 end     
            end   
            
            else if (carry == 1'b0) begin
            shifted_complement = ~(shifted_mantissa) + 1;
             //   while (shifted_value[23] != 1'b1) begin
              /*  shifted_data[22:0] = {shifted_mantissa_1, shifted_complement} << (32-shift[32:0]);  
                exponent = shifted_mantissa_1 - shifted_data[22:0];
                mantissa = shifted_data[22:0];  
                end
            end */           
             if (shifted_complement[23] == 1'b1) begin
                 shifted_data = shifted_complement << 0; 
                 exponent = new_exponent_1 - 0;
                 mantissa = shifted_data[22:0];
                 end
                 else if (shifted_complement[23:22] == 2'b01)  begin
                 shifted_data = shifted_complement << 1;   
                 exponent = new_exponent_1 - 1;
                 mantissa = shifted_data[22:0];
                 end
                 else if (shifted_complement[23:21] == 3'b001) begin
                 shifted_data = shifted_complement << 2;
                 exponent = new_exponent_1 - 2;
                 mantissa = shifted_data[22:0];
                 end                 
                 else if (shifted_complement[23:20] == 4'b0001)     begin
                 shifted_data = shifted_complement << 3; 
                 exponent = new_exponent_1 - 3;
                 mantissa = shifted_data[22:0];
                 end 
                 else if (shifted_complement[23:19] == 5'b00001) begin
                 shifted_data = shifted_complement<< 4;   
                 exponent = new_exponent_1 - 4;
                 mantissa = shifted_data[22:0];
                 end
                 else if (shifted_complement[23:18] == 6'b000001) begin
                 shifted_data = shifted_complement << 5;  
                 exponent = new_exponent_1 - 5;
                 mantissa = shifted_data[22:0];
                 end 
                 else if (shifted_complement[23:17] == 7'b0000001) begin
                 shifted_data = shifted_complement << 6; 
                 exponent = new_exponent_1 - 6;
                 mantissa = shifted_data[22:0];
                 end              
                 else if (shifted_complement[23:16] == 8'b00000001) begin
                 shifted_data = shifted_complement << 7;    
                 exponent = new_exponent_1 - 7;
                 mantissa = shifted_data[22:0];
                 end  
                 else if (shifted_complement[23:15] == 9'b000000001) begin
                 shifted_data = shifted_complement << 8;    
                 exponent = new_exponent_1 - 8;
                 mantissa = shifted_data[22:0];
                 end
                 else if (shifted_complement[23:14] == 10'b0000000001) begin
                 shifted_data = shifted_complement << 9;   
                 exponent = new_exponent_1 - 9;
                 mantissa = shifted_data[22:0];
                 end       
                 else if (shifted_complement[23:13] == 11'b00000000001)  begin
                 shifted_data = shifted_complement << 10; 
                 exponent = new_exponent_1 - 10;
                 mantissa = shifted_data[22:0];
                 end   
                 else if (shifted_complement[23:12] == 12'b000000000001) begin
                 shifted_data = shifted_complement << 11;   
                 exponent = new_exponent_1 - 11;
                 mantissa = shifted_data[22:0];
                 end                 
                 else if (shifted_complement[23:11] == 13'b0000000000001) begin
                 shifted_data = shifted_complement << 12;
                 exponent = new_exponent_1 - 12;
                 mantissa = shifted_data[22:0];
                 end                           
                 else if (shifted_complement[23:10] == 14'b00000000000001) begin
                 shifted_data = shifted_complement << 13; 
                 exponent = new_exponent_1 - 13;
                 mantissa = shifted_data[22:0];
                 end                   
                 else if (shifted_complement[23:9] == 15'b000000000000001) begin
                 shifted_data = shifted_complement << 14;
                 exponent = new_exponent_1 - 14;
                 mantissa = shifted_data[22:0];
                 end                      
                 else if (shifted_complement[23:8] == 16'b0000000000000001) begin
                 shifted_data = shifted_complement << 15;   
                 exponent = new_exponent_1 - 15;
                 mantissa = shifted_data[22:0];
                 end                                   
                 else if (shifted_complement[23:7] == 17'b00000000000000001) begin
                 shifted_data = shifted_complement << 16;  
                 exponent = new_exponent_1 - 16;
                 mantissa = shifted_data[22:0];
                 end                          
                 else if (shifted_complement[23:6] == 18'b000000000000000001) begin
                 shifted_data = shifted_complement<< 17;  
                 exponent = new_exponent_1 - 17;
                 mantissa = shifted_data[22:0];
                 end                                  
                 else if (shifted_complement[23:5] == 19'b0000000000000000001) begin
                 shifted_data = shifted_complement<< 18; 
                 exponent = new_exponent_1 - 18;
                 mantissa = shifted_data[22:0];
                 end                                 
                 else if (shifted_mantissa[23:4] == 20'b00000000000000000001) begin
                 shifted_data = shifted_mantissa << 19; 
                 exponent = new_exponent_1 - 19;
                 mantissa = shifted_data[22:0];
                 end                             
                 else if (shifted_complement[23:3] == 21'b000000000000000000001) begin
                 shifted_data = shifted_complement<< 20;
                 exponent = new_exponent_1 - 20;
                 mantissa = shifted_data[22:0];
                 end                    
                 else if (shifted_complement[23:2] == 22'b0000000000000000000001) begin
                 shifted_data = shifted_complement << 21;
                 exponent = new_exponent_1 - 21;
                 mantissa = shifted_data[22:0];
                 end  
                 else if (shifted_complement[23:1] == 23'b00000000000000000000001) begin
                 shifted_data = shifted_complement<< 22; 
                 exponent = new_exponent_1 - 22;
                 mantissa = shifted_data[22:0];
                 end                         
                 else if (shifted_complement[23:0] == 24'b000000000000000000000001) begin
                 shifted_data = shifted_complement << 23;
                 exponent = new_exponent_1 - 23;
                 mantissa = shifted_data[22:0];
                 end 
                 end      
                 end 
                 sum[30:23] = exponent; // Adjusted exponent
                 sum[22:0] = mantissa;            
                 end
                                    // Mantissa
   
        //Sum[31] = operand_1[31];                  // Sign bit                       
endmodule

