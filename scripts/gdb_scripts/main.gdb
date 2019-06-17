dashboard -layout source assembly registers stack memory expressions threads

set pagination off

set logging overwrite on
set logging file ~/.gdb_logs.txt
set logging on

set history filename ~/.gdb_history.txt
set history save on

set print pretty on
set print array on
set filename-display basename
set trace-commands off
# to sho them in saved logs set trace-commands on
set output-radix 16

define reset-gdb
  del
  undisplay
  b hardFaultHandler
end

define i
  info breakpoints
end

define r
  mon reset
end

define g
  continue
end

define l
  load
  reset-gdb
end

define m
  shell make_launcher $1
  l
end

def erase_ext_mem
  call init_flash_spi()
  call extFlashConfigureIO()
  call extFlashEraseChip()
end

def factory_reset
  call ezButtonVeryLongAction()
end

target remote localhost:2331
b hardFaultHandler