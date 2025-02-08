#include <linux/kernel.h>
#include <linux/syscalls.h>

SYSCALL_DEFINE0(fine) {
	printk("==== FINE systemcall ====\n");
	return 0;
}