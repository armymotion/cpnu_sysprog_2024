default rel ; ����� ��������������� ������ ������ ��� 64-���� �����������
; ��� 64-���� ���� Windows
extern ExitProcess
extern GetStdHandle
extern WriteConsoleA
section .data
message db 'KI-232 Reshetnyk', 0Ah, 0 ; �������� �����, �� ������� �������
section .bss
written resq 1 ; ��������� ������ ��� ������� ��������� �������
section .text
global main�
main:
; �������� ���������� ������������ ������
mov rcx, -11 ; STD_OUTPUT_HANDLE
call GetStdHandle
mov r12, rax ; �������� ���������� ������
; ϳ�������� ��������� ��� WriteConsoleA
mov rcx, r12 ; hConsoleOutput
lea rdx, [message] ; lpBuffer
mov r8, 20 ; nNumberOfCharsToWrite (������� 1 ��� ������ �����)
lea r9, [written] ; lpNumberOfCharsWritten
xor rax, rax ; ��������� ������ rax
push rax ; lpReserved (must be 0)
sub rsp, 32 ; �������� 32 ����� �������� ��������
; �������� �����������
call WriteConsoleA
; ³��������� ����
add rsp, 40 ; 32 + 8 (��� lpReserved)
; �������� � ��������
xor rcx, rcx ; exit code 0
call ExitProcess