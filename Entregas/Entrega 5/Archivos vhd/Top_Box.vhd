
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Top_Box is
    Port ( clk : in  STD_LOGIC;
           rx : in  STD_LOGIC;
           tx_ready : in  STD_LOGIC;
           data_i : in  STD_LOGIC_VECTOR (9 downto 0);
           read_write : in  STD_LOGIC;
           tx : out  STD_LOGIC;
           leds : out  STD_LOGIC_VECTOR (7 downto 0);
			  servo1 : out std_logic;
			  servo2 : out std_logic
			  );
end Top_Box;

architecture Behavioral of Top_Box is

	--UART
	component UART is
	port( clk: in std_logic;
		   data_i: in std_logic_vector (9 downto 0);
		   tx_ready: in std_logic;
		   rx: in std_logic;
		   rx_ready: out std_logic;
		   tx: out std_logic;
		   data_o: out std_logic_vector (7 downto 0));
	end component;
	
	signal dato: std_logic_vector (7 downto 0) := (others =>'0'); 
	signal ready: std_logic := '0'; 	
	
	--Memory
	component Memorias is
	port(	clk: in std_logic;
			clk_PWM : in std_logic;
			read_write: in std_logic;
			ready: in std_logic;
			dato: in std_logic_vector(7 downto 0);
			dato_M1: out std_logic_vector(7 downto 0);
			dato_M2:out std_logic_vector(7 downto 0)
		 );
	end component;
	signal dato_M1 : std_logic_vector (7 downto 0) := (others => '0');
	signal dato_M2 : std_logic_vector (7 downto 0) := (others => '0');
	
	--PTD
	component PTD is
	Port ( clk : in  STD_LOGIC;
          pulse : in  STD_LOGIC;
			 pulse_out : out STD_LOGIC 
			 );
	end component;
	signal pulse_ready : std_logic := '0';
	
	--Memoria ROM
	component Memorias_PWM is
   Port ( dato_memoria1 : in  STD_LOGIC_VECTOR (7 downto 0);
			  dato_memoria2 : in  STD_LOGIC_VECTOR (7 downto 0);
           numero_ciclos1 : out  STD_LOGIC_VECTOR (15 downto 0);
			  numero_ciclos2 : out  STD_LOGIC_VECTOR (15 downto 0)
			  );
	end component;
	
	signal numero_ciclos1 : std_logic_vector (15 downto 0) := (others => '0');
	signal numero_ciclos2 : std_logic_vector (15 downto 0) := (others => '0');
	
	--Divisor PWM
	component Divisor_PWM is
   Port ( clk : in  STD_LOGIC;
          clk_out : out  STD_LOGIC);
	end component;
	signal clk_PWM : std_logic := '0';
	
	--PWM
	component PWM is
	port( clk : in std_logic;
		ciclos : in std_logic_vector (15 downto 0);
		grado_servo : out std_logic
		);
	end component;
	
begin

	Detector_Ready : PTD port map(clk,ready,pulse_ready);
	RS232 : UART port map (clk, data_i, tx_ready, rx, ready, tx, dato);
	RAM : Memorias port map(clk, clk_PWM, read_write, pulse_ready, dato, dato_M1, dato_M2);
	D_PWM : Divisor_PWM port map (clk, clk_PWM);
	Mem_PWM : Memorias_PWM port map (dato_M1, dato_M2, numero_ciclos1, numero_ciclos2);
	PWM1 : PWM port map (clk, numero_ciclos1, servo1);
	PWM2 : PWM port map (clk, numero_ciclos2, servo2);
	
	leds <= dato;
	
	
end Behavioral;

