
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Top_Box is
    Port ( clk : in  STD_LOGIC;
           rx : in  STD_LOGIC;
           tx_ready : in  STD_LOGIC;
           data_i : in  STD_LOGIC_VECTOR (9 downto 0);
           read_write : in  STD_LOGIC;
           btn0 : in  STD_LOGIC;
           btn1 : in  STD_LOGIC;
           btn2 : in  STD_LOGIC;
           tx : out  STD_LOGIC;
           nodos : out  STD_LOGIC_VECTOR (3 downto 0);
           siete_segs : out  STD_LOGIC_VECTOR (6 downto 0);
           leds : out  STD_LOGIC_VECTOR (7 downto 0));
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
	signal data: std_logic_vector (7 downto 0) := (others =>'0'); 
	signal ready: std_logic := '0'; 	
	
	--Box Memory
	component Box_Memory is
	Port ( clk : in  STD_LOGIC;
			  ready : in  STD_LOGIC;
           read_write : in  STD_LOGIC;
           btn2 : in  STD_LOGIC;
           btn1 : in  STD_LOGIC;
           btn0 : in  STD_LOGIC;			  
           dato : in  STD_LOGIC_VECTOR (7 downto 0);
			  select_memory : out STD_LOGIC;
			  dato_displays : out  STD_LOGIC_VECTOR (7 downto 0);
           cont_leds : out  STD_LOGIC_VECTOR (7 downto 0)
           );
	end component;
	signal select_memory : STD_LOGIC;
	signal dato_displays : STD_LOGIC_VECTOR (7 downto 0):= (others =>'0');	
   
	--Decifrador
	component Decifrador is
	Port ( dato_in : in  STD_LOGIC_VECTOR (7 downto 0);
           memory : in  STD_LOGIC;
			  dato_completo : out std_logic_vector (15 downto 0)
			  );
	end component;
	signal dato_completo : std_logic_vector (15 downto 0):= (others =>'0');
	
	--Display
	component Display is
	Port ( clk : in STD_LOGIC;
			  dato_completo : in STD_LOGIC_VECTOR (15 downto 0);
			  anodos_out : out  STD_LOGIC_VECTOR (3 downto 0);
           siete_segmentos : out  STD_LOGIC_VECTOR (6 downto 0));
	end component;
	
	--Divisor_Frecuencia_Display
	component Divisor_Frecuencia_Display is
	Port ( clk : in  STD_LOGIC;
           clk_out : out  STD_LOGIC);
	end component;
	signal clk_displays : std_logic := '0';
	
	--PTD
	component PTD is
	Port ( clk : in  STD_LOGIC;
          pulse : in  STD_LOGIC;
			 pulse_out : out STD_LOGIC 
			 );
	end component;
	signal pulse_0 : std_logic := '0';
	signal pulse_1 : std_logic := '0';
	signal pulse_2 : std_logic := '0';
	signal pulse_ready : std_logic := '0';
begin
	Detector_0 : PTD port map(clk,btn0,pulse_0);
	Detector_1 : PTD port map(clk,btn1,pulse_1);
	Detector_2 : PTD port map(clk,btn2,pulse_2);
	Detector_Ready : PTD port map(clk,ready,pulse_ready);

	UART_COMPONENT: UART port map(clk, data_i,tx_ready,rx,ready,tx,data);
	Memory_Servos: Box_Memory port map(clk, pulse_ready,read_write,pulse_2,pulse_1,pulse_0,data,select_memory,dato_displays,leds);
	Decifrador_Modulo: Decifrador port map(dato_displays,select_memory,dato_completo);
	Display_Module : Display port map(clk_displays,dato_completo,nodos,siete_segs);
	Divisor_Displays: Divisor_Frecuencia_Display port map(clk,clk_displays);
	
end Behavioral;

