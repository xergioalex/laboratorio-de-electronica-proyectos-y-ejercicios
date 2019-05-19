
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY tb_tx IS
END tb_tx;
 
ARCHITECTURE behavior OF tb_tx IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT FMS_TX
    PORT(
         data_i : IN  std_logic_vector(9 downto 0);
         tx_ready : IN  std_logic;
         clkBaudio : IN  std_logic;
         tx : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal data_i : std_logic_vector(9 downto 0) := (others => '0');
   signal tx_ready : std_logic := '0';
   signal clkBaudio : std_logic := '0';

 	--Outputs
   signal tx : std_logic;

   -- Clock period definitions
   constant clkBaudio_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: FMS_TX PORT MAP (
          data_i => data_i,
          tx_ready => tx_ready,
          clkBaudio => clkBaudio,
          tx => tx
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
       -- hold reset state for 100 ns.
      wait for 100 ns;	
			tx_ready <= '1';
			data_i <= "0101011110";
		wait for 100 ns;
			tx_ready <= '0';
      -- insert stimulus here 
 
      wait for 1000 ns;
   end process;

END;
