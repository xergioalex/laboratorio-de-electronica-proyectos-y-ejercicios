
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Box_Memory is
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
end Box_Memory;

architecture Behavioral of Box_Memory is
	component Decodificador is
	port( pulso : in  STD_LOGIC;
         select_cont : out  STD_LOGIC;
         en_cont_1 : out  STD_LOGIC;
         en_cont_2 : out  STD_LOGIC);
	end component;
	
	component Memorias is
	port( clk: in std_logic;
			selector : in std_logic;
			read_write: in std_logic;
			ready: in std_logic;
			cont_1 : in std_logic_vector(7 downto 0);
			cont_2 : in std_logic_vector(7 downto 0);
			dato: in std_logic_vector(7 downto 0);
			dato_display: out std_logic_vector(7 downto 0));
	end component;
	
	component Registros is
	port( clk : in std_logic;
			add : in std_logic;
			sub : in std_logic;			
			out_cont : out std_logic_vector(7 downto 0));
	end component;
	
	--Senales Decodificador
	signal select_mem : std_logic := '0';
	signal en_cont_1 : std_logic := '0';
	signal en_cont_2 : std_logic := '0';
	--Senales Registros Contador
	signal add_1 : std_logic := '0';
	signal sub_1 : std_logic := '0';
	signal add_2 : std_logic := '0';
	signal sub_2 : std_logic := '0';
	signal out_cont_1 : std_logic_vector(7 downto 0) := (others => '0');
	signal out_cont_2 : std_logic_vector(7 downto 0) := (others => '0');
	
	signal displays : std_logic_vector(7 downto 0) := (others => '0');
	
begin
	Dec: Decodificador port map(btn2,select_mem,en_cont_1,en_cont_2);
	Cont_Memory_1: Registros port map(clk,add_1,sub_1,out_cont_1);
	Cont_Memory_2: Registros port map(clk,add_2,sub_2,out_cont_2);
	Mems : Memorias port map(clk, select_mem,read_write,ready,out_cont_1,out_cont_2,dato,displays);
	
	add_1 <= en_cont_1 and btn0;
	sub_1 <= en_cont_1 and btn1;
	add_2 <= en_cont_2 and btn0;
	sub_2 <= en_cont_2 and btn1;
	
	dato_displays <= displays;
	select_memory <= select_mem;
	
	cont_leds <= out_cont_1 when select_mem='0' else out_cont_2;
	
end Behavioral;

