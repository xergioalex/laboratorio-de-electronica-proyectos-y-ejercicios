
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

 
ENTITY tb_UART_TEST IS
END tb_UART_TEST;
 
ARCHITECTURE behavior OF tb_UART_TEST IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT UART_TEST
    PORT(
         clk : IN  std_logic;
         rx : IN  std_logic;
         tx : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rx : std_logic := '1';

 	--Outputs
   signal tx : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: UART_TEST PORT MAP (
          clk => clk,
          rx => rx,
          tx => tx
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
		wait for 100 ns;
		rx <= '0';
		wait for 100 ns;
		rx <= '1';
		wait for 100 ns;
		rx <= '0';
		wait for 100 ns;
		rx <= '0';
		wait for 100 ns;
		rx <= '1';
		wait for 100 ns;
		rx <= '0';
		wait for 100 ns; 
		rx <= '0';
		wait for 100 ns;
		rx <= '1';
		wait for 100 ns;
		rx <= '0';
		wait for 100 ns;
		rx <= '1';		
      wait;
   end process;

END;
