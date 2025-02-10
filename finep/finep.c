#include <linux/kernel.h>
#include <linux/syscalls.h>

SYSCALL_DEFINE0(finep) {
	printk("==== FINEP systemcall ====\n");
	printk("====      START       ====\n");
	panic("FINE PANIC!");
	printk("====     PANICKED     ====\n");
	printk("====       END        ====\n");
	return 0;
}