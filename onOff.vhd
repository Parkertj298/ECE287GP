library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;

ENTITY onOff is
port(CLK_50MHz, permission : IN STD_LOGIC; led : OUT STD_LOGIC);
END onOff;

ARCHITECTURE behavior OF onOff IS
signal counter : STD_LOGIC_VECTOR(25 downto 0);
signal onOffCounter : STD_LOGIC_VECTOR(1 downto 0) := "00";
signal CLK_1HZ : STD_LOGIC;
BEGIN
Prescaler : process (CLK_50MHz, permission)
BEGIN
if permission = '1' then
   onOffCounter <= "00";
elsif CLK_50MHz'event AND CLK_50MHz = '1' AND NOT (onOffCounter = "10") AND permission = '1' then
   if counter < "10111110101111000010000000" then
  counter <= counter + 1;
else
  CLK_1HZ <= NOT CLK_1HZ;
counter <= (others => '0');
onOffCounter <= onOffCounter + 1;
end if;
end if;
END process;
LED <= CLK_1HZ;
END behavior;
