
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY tb_divisor IS
END tb_divisor;
 
ARCHITECTURE behavior OF tb_divisor IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Divisor_Frecuencia
    PORT(
         clk : IN  std_logic;
         clk_out : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';

 	--Outputs
   signal clk_out : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Divisor_Frecuencia PORT MAP (
          clk => clk,
          clk_out => clk_out
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;



END;
