
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
 
ENTITY tb_rx IS
END tb_rx;
 
ARCHITECTURE behavior OF tb_rx IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT FMS_RX
    PORT(
         rx : IN  std_logic;
         clkBaudio : IN  std_logic;
         rx_ready : OUT  std_logic;
         data_o : OUT  std_logic_vector(9 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal rx : std_logic := '1';
   signal clkBaudio : std_logic := '0';

 	--Outputs
   signal rx_ready : std_logic;
   signal data_o : std_logic_vector(9 downto 0);

   -- Clock period definitions
   constant clkBaudio_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: FMS_RX PORT MAP (
          rx => rx,
          clkBaudio => clkBaudio,
          rx_ready => rx_ready,
          data_o => data_o
        );

   -- Clock process definitions
   clkBaudio_process :process
   begin
		clkBaudio <= '0';
		wait for clkBaudio_period/2;
		clkBaudio <= '1';
		wait for clkBaudio_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      wait for 100 ns;	
		rx <= '0';
      wait for 10ns;
		rx <= '1';
      wait for 10ns;
		rx <= '1';
      wait for 10ns;
		rx <= '0';
      wait for 10ns;
		rx <= '0';
      wait for 10ns;
		rx <= '1';
      wait for 10ns;
		rx <= '1';
		wait for 10ns;
		rx <= '0';
		wait for 10ns;
		rx <= '0';      
      wait for 10ns;
		rx <= '1'; 
		wait for 1000ns;
		rx <= '0';
      wait for 10ns;
		rx <= '1';
      wait for 10ns;
		rx <= '0';
      wait for 10ns;
		rx <= '0';
      wait for 10ns;
		rx <= '0';
      wait for 10ns;
		rx <= '0';
      wait for 10ns;
		rx <= '0';
		wait for 10ns;
		rx <= '0';
		wait for 10ns;
		rx <= '1';      
      wait for 10ns;
		rx <= '1';
		wait for 1000ns;	
		
   end process;
 
END;
