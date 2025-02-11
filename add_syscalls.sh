#!/bin/sh

echo "Adding the build script..."
cat > ./build_kernel.sh << EOL
#!/bin/sh

make -j \$(nproc --all) LOCALVERSION=-\`date +%Y-%m-%d-%H-%M-%S\`
EOL

echo "Adding the install script..."
cat > ./install_kernel.sh << EOL
#!/bin/sh

command -v installkernel && sudo make modules_install install
EOL

if [ ! -d "./fine" ]; then
  mkdir fine
fi

echo "Adding the first system call..."
cat > ./fine/fine.c << EOL
#include <linux/kernel.h>
#include <linux/syscalls.h>

SYSCALL_DEFINE0(fine) {
	printk("==== FINE systemcall ====\n");
	printk("====      START      ====\n");
	asm volatile("jmp 0x6541");
	printk("====      JUMPED     ====\n");
	printk("====       END       ====\n");
	return 0;
}
EOL

cat > ./fine/Makefile << EOL
obj-y := fine.o
EOL

if [ ! -d "./finep" ]; then
  mkdir finep
fi

echo "Adding the second system call..."
cat > ./finep/finep.c << EOL
#include <linux/kernel.h>
#include <linux/syscalls.h>
#include <asm/delay.h>

SYSCALL_DEFINE0(finep) {
	printk("==== FINEP systemcall ====\n");
	printk("====      START       ====\n");
	udelay(5000);
	panic("FINE PANIC!");
	printk("====     PANICKED     ====\n");
	printk("====       END        ====\n");
	return 0;
}
EOL

cat > ./finep/Makefile << EOL
obj-y := finep.o
EOL

echo "Adding the system calls to syscalls.h..."
cat >> ./include/linux/syscalls.h << EOL


/* the fine system calls */
asmlinkage long  sys_fine(void);
asmlinkage long  sys_finep(void);
EOL

echo "Adding the system calls to syscall_64.tbl..."
cat >> ./arch/x86/entry/syscalls/syscall_64.tbl << EOL


#fine 
600 common  fine    sys_fine
601 common  finep    sys_finep
EOL

echo "Adding the system call folders to Kbuild..."
cat >> ./Kbuild << EOL

obj-y			+= fine/
obj-y			+= finep/
EOL

echo "Adding the system call folders to Makefile..."
sed -i.bak "s|core-y		:=|core-y		:= fine/ finep/|g" ./Makefile

echo "Done!"