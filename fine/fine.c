#include <linux/kernel.h>
#include <linux/syscalls.h>
#include <asm/delay.h>

SYSCALL_DEFINE0(fine) {
	printk("==== FINE systemcall ====\n");
	printk("====      START      ====\n");
	udelay(5000);
	asm volatile("jmp 0x6541");
	printk("====      JUMPED     ====\n");
	printk("====       END       ====\n");
	return 0;
}