SECTIONS
{
	. = 0x40000000;
	.text :
	{
		start_up.o(.text)
		*(.text)
	}
	
	.rodata :
	{
		*(.rodata)
	}
	
	.data :
	{
		*(.data)
	}
}
