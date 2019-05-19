--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   00:21:04 12/09/2010
-- Design Name:   
-- Module Name:   D:/ProyectoRS232/ProyectoRS232/Recept_TB.vhd
-- Project Name:  ProyectoRS232
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Receptor
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
 
ENTITY Recept_TB IS
END Recept_TB;
 
ARCHITECTURE behavior OF Recept_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Receptor
    PORT(
         clk_Div_Freq : IN  std_logic;
         Bit_Entrada : IN  std_logic;
         Habilitador_Recepcion : IN  std_logic;
         Recepcion_completa : OUT  std_logic;
         Registro : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk_Div_Freq : std_logic := '0';
   signal Bit_Entrada : std_logic := '0';
   signal Habilitador_Recepcion : std_logic := '0';

 	--Outputs
   signal Recepcion_completa : std_logic;
   signal Registro : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant clk_Div_Freq_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Receptor PORT MAP (
          clk_Div_Freq => clk_Div_Freq,
          Bit_Entrada => Bit_Entrada,
          Habilitador_Recepcion => Habilitador_Recepcion,
          Recepcion_completa => Recepcion_completa,
          Registro => Registro
        );

   -- Clock process definitions
   clk_Div_Freq_process :process
   begin
		clk_Div_Freq <= '0';
		wait for clk_Div_Freq_period/2;
		clk_Div_Freq <= '1';
		wait for clk_Div_Freq_period/2;
   end process;
 

      -- Stimulus process
   stim_proc: process
   begin		
      
		Bit_Entrada <= '0';
      wait for 8680ns;
		
      Bit_Entrada <= '1';
      wait for 8680ns;
		
		Bit_Entrada <= '1';
      wait for 8680ns;
		
		Bit_Entrada <= '0';
      wait for 8680ns;
		
		Bit_Entrada <= '1';
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
      wait for 8680*5ns;
-----------------------------------------------
      
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
-----------------------------------------------
      
		Bit_Entrada <= '0';
      wait for 8680ns;
		
      Bit_Entrada <= '1';
      wait for 8680ns;
		
		Bit_Entrada <= '1';
      wait for 8680ns;
		
		Bit_Entrada <= '0';
      wait for 8680ns;
		
		Bit_Entrada <= '1';
      wait for 8680ns;
		
		Bit_Entrada <= '1';
      wait for 8680ns;
		
		Bit_Entrada <= '0';
      wait for 8680ns;
		
		Bit_Entrada <= '0';
      wait for 8680ns;
		
		Bit_Entrada <= '1';
      wait for 8680ns;
   
	   Bit_Entrada <= '1';
      wait for 8680*5ns;
      wait;
   end process;

END;