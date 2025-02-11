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
