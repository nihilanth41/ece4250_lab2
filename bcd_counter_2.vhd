library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity bcd_counter_2 is
  port(EN, LD, UP, CLR, CLK : in std_logic;
       D1, D2 : in std_logic_vector(3 downto 0);
       CO : out std_logic;
       Q1, Q2 : out std_logic_vector(3 downto 0));
end bcd_counter_2;

architecture bcd_counter_2_arch of bcd_counter_2 is

  component bcd_counter1
    port(EN, LD, UP, CLR, CLK : in std_logic;
         D		: in std_logic_vector(3 downto 0);
         CO		: out std_logic;
         Q		: out std_logic_vector(3 downto 0));
  end component;

  signal carry_int : std_logic_vector(1 downto 0);
  signal q1_int, q2_int : std_logic_vector(3 downto 0);
  
begin
  BCD1: bcd_counter1 port map(EN, LD, UP, CLR, CLK, D1, carry_int(0), q1_int);
  BCD2: bcd_counter1 port map(carry_int(0), LD, UP, CLR, CLK, D2, carry_int(1), q2_int);

  Q1 <= q1_int;
  Q2 <= q2_int;
  CO <= carry_int(1);

end bcd_counter_2_arch;
