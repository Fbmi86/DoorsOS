AS      = nasm
CC      = x86_64-elf-gcc
LD      = x86_64-elf-ld
CFLAGS  = -I include -ffreestanding -O2 -Wall -nostdlib

OBJS    = src/boot.o src/kmain.o src/vga.o

all: kernel.bin iso

kernel.bin: $(OBJS) link.ld
	$(LD) -nostdlib -T link.ld -o $@ $(OBJS)

%.o: %.asm
	$(AS) -f elf64 $< -o $@
%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

iso: kernel.bin
	mkdir -p iso/boot/grub
	cp kernel.bin iso/boot/
	echo 'set timeout=0' > iso/boot/grub/grub.cfg
	echo 'menuentry "Doors v0.0.1" {' >> iso/boot/grub/grub.cfg
	echo '  multiboot2 /boot/kernel.bin' >> iso/boot/grub/grub.cfg
	echo '  boot' >> iso/boot/grub/grub.cfg
	echo '}' >> iso/boot/grub/grub.cfg
	grub-mkrescue -o doors-f0.iso iso

clean:
	rm -f $(OBJS) kernel.bin doors-f0.iso
	rm -rf iso

run: iso
	qemu-system-x86_64 -cdrom doors-f0.iso -m 256M -vga std

.PHONY: all clean run
