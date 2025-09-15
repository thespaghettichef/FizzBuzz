; fizzbuzz.asm
; FizzBuzz 1..100 using NASM Intel syntax on Linux

global main          ; entry point for linker
extern printf        ; printf from libc

section .data
fizz     db "Fizz",0Ah,0
buzz     db "Buzz",0Ah,0
fizzbuzz db "FizzBuzz",0Ah,0
fmt      db "%d",0Ah,0

section .text
main:
    push rbp
    mov rbp, rsp
    sub rsp, 16              ; reserve space if needed

    mov dword [rbp-4], 1     ; int i = 1

.loop:
    cmp dword [rbp-4], 100
    jg .done                  ; exit loop if i > 100

    mov eax, dword [rbp-4]
    mov ecx, 15
    cdq
    idiv ecx
    cmp edx, 0
    je .print_fizzbuzz        ; if divisible by 15

    mov eax, dword [rbp-4]
    mov ecx, 3
    cdq
    idiv ecx
    cmp edx, 0
    je .print_fizz            ; if divisible by 3

    mov eax, dword [rbp-4]
    mov ecx, 5
    cdq
    idiv ecx
    cmp edx, 0
    je .print_buzz            ; if divisible by 5

    ; else print number
    mov esi, dword [rbp-4]    ; second argument to printf
    lea rdi, [rel fmt]        ; first argument: "%d\n"
    xor eax, eax              ; required for variadic function
    call printf
    jmp .inc

.print_fizzbuzz:
    lea rdi, [rel fizzbuzz]
    xor eax, eax
    call printf
    jmp .inc

.print_fizz:
    lea rdi, [rel fizz]
    xor eax, eax
    call printf
    jmp .inc

.print_buzz:
    lea rdi, [rel buzz]
    xor eax, eax
    call printf

.inc:
    add dword [rbp-4], 1
    jmp .loop

.done:
    mov eax, 0
    leave
    ret
