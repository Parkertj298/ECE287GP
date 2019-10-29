library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;

ENTITY simonClassic IS
port (clock, b0, b1, b2, b3 : IN STD_LOGIC; l0, l1,l2,l3 : OUT STD_LOGIC);
END simonClassic;

ARCHITECTURE behavior OF simonClassic IS
signal counter : STD_LOGIC;
signal CLK_1HZ : STD_LOGIC;
signal numOfMoves : STD_LOGIC;
signal simonVector : STD_LOGIC_VECTOR (0 to 9);
signal numOfInputs : STD_LOGIC;
BEGIN --behavior
randCounter : process
BEGIN -- randCounter: this will be the counter that will generate a random number
if clock'event and clock = '1' then  -- rising clock edge
if counter < "11" then   -- Binary value is
counter <= counter + 1;
else
counter <= (others => '0');
end if;
end if;
END process randCounter;
patternCreator : process -- will be adding one value (two bits) to the simonVector after a signal is changed

END PROCESS patternCreator;

userInput : process
BEGIN -- userInput
if
END PROCESS push0;
