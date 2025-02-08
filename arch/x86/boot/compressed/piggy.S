.section ".rodata..compressed","a",@progbits
.globl z_input_len
z_input_len = 14600445
.globl z_output_len
z_output_len = 62484444
.globl input_data, input_data_end
input_data:
.incbin "arch/x86/boot/compressed/vmlinux.bin.zst"
input_data_end:
.section ".rodata","a",@progbits
.globl input_len
input_len:
	.long 14600445
.globl output_len
output_len:
	.long 62484444
