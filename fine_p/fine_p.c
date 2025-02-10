#include <linux/kernel.h>
#include <linux/syscalls.h>

SYSCALL_DEFINE0(fine_p) {
	printk("====FINE_P systemcall====\n");
	printk("====      START      ====\n");
	panic();
	printk("====     PANICED     ====\n");
	printk("====       END       ====\n");
	return 0;
}