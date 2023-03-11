start_up.o:
	aarch64-linux-gnu-gcc -mcpu=cortex-a53 -shared -g -c start_up.s -o start_up.o
hello.o:
	aarch64-linux-gnu-gcc -mcpu=cortex-a53 -shared -g -c hello.c -O0 -o hello.o 
all: start_up.o hello.o
	
	aarch64-linux-gnu-ld -g start_up.o hello.o -T hello.lds -o hello.out
	aarch64-linux-gnu-objdump -s hello.out > hello.disasm
clean:
	rm ./*.out ./*.o ./*.disasm
run_qemu_abandoned:
	qemu-system-aarch64 -M virt -cpu cortex-a53 -kernel hello.out --nographic -S -s
run_qemu:
	# "-kernel xxx.elf" method makes it start at EL1 
	# and doing "--machine virtualization=on" makes it start at EL2.
	# ref https://lists.nongnu.org/archive/html/qemu-discuss/2021-03/msg00046.html
	# with "-machine type=xxx,secure=true" make it start at EL3
	qemu-system-aarch64 \
	-machine type=virt,secure=true -cpu cortex-a53 \
	--nographic -S -s \
	-kernel hello.out
run_qemu_debug:
	# this method will echo disassmbly code and pc address for debugging
	qemu-system-aarch64 \
	-machine type=virt,secure=true -cpu cortex-a53 \
	--nographic -S -s \
	-d int,exec,in_asm \
	-kernel hello.out
open_gdb:
	# after "make run_qemu" or "make run_qemu_debug"
	# open another terminal andrun "make open_gdb" 
	# run command "target remote:1234" to start debugging in gdb
	gdb-multiarch ./hello.out
