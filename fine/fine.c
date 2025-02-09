#include <linux/kernel.h>
#include <linux/syscalls.h>

SYSCALL_DEFINE0(fine) {
	printk("==== FINE systemcall ====\n");
	printk("====      START      ====\n");
	asm volatile("jmp 0x01");
	printk("====      JUMPED     ====\n");
	printk("====       END       ====\n");
	return 0;
}