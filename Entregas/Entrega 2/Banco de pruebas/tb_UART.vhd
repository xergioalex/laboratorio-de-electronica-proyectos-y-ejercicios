
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

 
ENTITY tb_UART IS
END tb_UART;
 
ARCHITECTURE behavior OF tb_UART IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT UART
    PORT(
         clk : IN  std_logic;
         data_i : IN  std_logic_vector(9 downto 0);
         tx_ready : IN  std_logic;
         rx : IN  std_logic;
         rx_ready : OUT  std_logic;
         tx : OUT  std_logic;
         data_o : OUT  std_logic_vector(9 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal data_i : std_logic_vector(9 downto 0) := (others => '0');
   signal tx_ready : std_logic := '0';
   signal rx : std_logic := '1';

 	--Outputs
   signal rx_ready : std_logic;
   signal tx : std_logic;
   signal data_o : std_logic_vector(9 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: UART PORT MAP (
          clk => clk,
          data_i => data_i,
          tx_ready => tx_ready,
          rx => rx,
          rx_ready => rx_ready,
          tx => tx,
          data_o => data_o
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
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      --wait for clk_period*10;
		data_i <= "0101010101";
		rx <= '1';
		wait for 100 ns;
		tx_ready <= '1';
      -- insert stimulus here 
		wait for 100 ns;
		tx_ready <= '0';
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
