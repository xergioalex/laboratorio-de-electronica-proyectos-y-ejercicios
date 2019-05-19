--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   00:05:38 12/09/2010
-- Design Name:   
-- Module Name:   D:/ProyectoRS232/ProyectoRS232/RS232_TB.vhd
-- Project Name:  ProyectoRS232
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: RS232
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY RS232_TB IS
END RS232_TB;
 
ARCHITECTURE behavior OF RS232_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT RS232
    PORT(
         clk_fpga : IN  std_logic;
         Bit_Entrada : IN  std_logic;
         Bit_Salida : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk_fpga : std_logic := '0';
   signal Bit_Entrada : std_logic := '0';

 	--Outputs
   signal Bit_Salida : std_logic;

   -- Clock period definitions
   constant clk_fpga_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: RS232 PORT MAP (
          clk_fpga => clk_fpga,
          Bit_Entrada => Bit_Entrada,
          Bit_Salida => Bit_Salida
        );

   -- Clock process definitions
   clk_fpga_process :process
   begin
		clk_fpga <= '0';
		wait for 10ns;
		clk_fpga <= '1';
		wait for 10ns;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
   -- ASCII letra T : 01010100 (bin) = 84(dec)       
		Bit_Entrada <= '0';
      wait for 8680ns;
		
      Bit_Entrada <= '0';
      wait for 8680ns;
		
		Bit_Entrada <= '1';
      wait for 8680ns;
		
		Bit_Entrada <= '0';
      wait for 8680ns;
		
		Bit_Entrada <= '1';
      wait for 8680ns;
		
		Bit_Entrada <= '0';
      wait for 8680ns;
		
		Bit_Entrada <= '1';
      wait for 8680ns;
		
		Bit_Entrada <= '0';
      wait for 8680ns;
		
		Bit_Entrada <= '0';
      wait for 8680ns;
   
	   Bit_Entrada <= '1';
      wait for 8680*5ns;

      wait;
   end process;

END;