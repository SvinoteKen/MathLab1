.686p
.model flat, stdcall
option casemap :none   
GetModuleHandleA PROTO STDCALL :DWORD
LoadCursorA PROTO STDCALL :DWORD,:DWORD
LoadIconA PROTO STDCALL :DWORD,:DWORD
RegisterClassExA PROTO STDCALL :DWORD
CreateWindowExA PROTO STDCALL :DWORD,:DWORD, :DWORD, :DWORD, :DWORD, :DWORD, :DWORD, :DWORD, :DWORD, :DWORD, :DWORD, :DWORD
ShowWindow PROTO STDCALL :DWORD,:DWORD
UpdateWindow PROTO STDCALL :DWORD
GetMessageA PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD
TranslateMessage PROTO STDCALL :DWORD
DispatchMessageA PROTO STDCALL :DWORD
DefWindowProcA PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD
PostQuitMessage PROTO STDCALL :DWORD
GetCommandLineA PROTO STDCALL
CreateSolidBrush PROTO STDCALL :DWORD
ExitProcess PROTO STDCALL :DWORD
WinMain PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD
GetCursorPos PROTO STDCALL :DWORD
GetClientRect PROTO STDCALL :DWORD,:DWORD 
MessageBoxA PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD
wsprintfA PROTO C :VARARG
SetWindowTextA PROTO STDCALL :DWORD,:DWORD 
GetDesktopRect PROTO STDCALL :DWORD,:DWORD 
Sleep PROTO STDCALL :DWORD
MoveWindow PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
SetWindowPos PROTO STDCALL :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
POINT STRUCT
; ���������� X ��������� ���� � ������ �������� ���������
x DWORD ?
; ���������� Y ��������� ���� � ������ �������� ���������
y DWORD ? 
POINT ENDS

RECT STRUCT
left DWORD ? 
top DWORD ? 
right DWORD ? 
bottom DWORD ? 
RECT ENDS

MSG STRUCT
; ���������� ����, �������� ������������� ���������
hwnd DWORD ?
; ������������� ���������
message DWORD ?
; �������� ��������� wParam
wParam DWORD ?
; �������� ��������� lParam
lParam DWORD ?
; ����� ��������� ��������� � �������
time DWORD ?
; ���������� ��������� ���� � ������ �������� ���������
MSG ENDS

WNDCLASSEXA STRUCT
; ������ ��������� � ������ (30h)
cbSize DWORD ?
; �����, ����������� ����� ������
style DWORD ? 
; ��������� �� ������� ���������
lpfnWndProc DWORD ?
; ���������� �������������� ������ ������, ������� 
; ����������� ����� �� ���������� ������ ����
cbClsExtra DWORD ?
; ���������� �������������� ������ ����, ������� 
; ����������� ����� �� ���������� ���������� ����
cbWndExtra DWORD ?
; ���������� ���������� ����������, ������� �������� 
; ������� ��������� ��� ������
hInstance DWORD ?
; ���������� ������ ������, ���������� ������� ������
hIcon DWORD ?
; ���������� ������� ������, ���������� ������� �������
hCursor DWORD ?
; ���������� ����� ���� ������, ���������� ���������� 
; �����, ������� ������������ ��� �������� ���� ����
hbrBackground DWORD ?
; ��������� �� ���������� ������ � ������ ������� ���� 
lpszMenuName DWORD ?
; ��������� �� ���������� ������ � ������ ������
lpszClassName DWORD ?
; ���������� ������� ������, ���������� � ������ �����
hIconSm DWORD ?
WNDCLASSEXA ENDS

.data
myRECT RECT<>
myWRECT RECT<>
myXY POINT <>
TitleMsg db '����������',0
; ��������� ����� ��� ���������������� ������
buffer db 128 dup(0)
; ��������� ������ ������� �� �������������� ��������
format db 'x=%d y=%d', 0
; ���������� ������, ������� ���������� ��� ������ ����
ClassName db "SimpleWinClass",0
; ���������� ������, ������� ���������� ��� ����
AppName db "���� ������ ����",0
NewName db "---------",0
; ���������� ���������� ����������
hInstance dd 00000000h
; ��������� �� ��������� ������ �������� ��������
CommandLine dd 00000000h
.const
; ������������� ���������, ������������� ��� �������� ����
WM_DESTROY equ 2h
; ������������� ���������, ������������� ��� ������� 
; ����������� �������
WM_KEYDOWN equ 100h

VK_F9 equ 78h

VK_SPACE equ 20h
; ����������� ��� ������� ESC
VK_ESCAPE equ 1Bh
; ������������� ����������� ������
IDI_APPLICATION equ 32512
; ������������� ������������ �������-�������
IDC_ARROW equ 32512
; ������������� ����������� ������ ������ ����
SW_SHOWNORMAL equ 1
; ������������� ����������� ���� ��� ��������� ������ ����
CS_HREDRAW equ 2h
; ������������� ����������� ���� ��� ��������� ������ ����
CS_VREDRAW equ 1h
; ������������� ����� ����� ���� ������ ����
COLOR_BTNFACE equ 15
; ������������� �������� �� ��������� ������� ��� �������
CW_USEDEFAULT equ 80000000h
; ������������� ���������� ���� ������� ������
WS_OVERLAPPED equ 0h
; ������������� ���� � ����������
WS_CAPTION equ 0C00000h
; ������������� ���� � ��������� ���� � ���������
WS_SYSMENU equ 80000h
; ������������� ���� � ������
WS_THICKFRAME equ 40000h
; ������������� ���� � ������� ����������� ����
WS_MINIMIZEBOX equ 20000h
; ������������� ���� � ������� ������������� ����
WS_MAXIMIZEBOX equ 10000h
; ������������� ���������������� ���� � ����������, 
; ��������� ����, ������, �������� ����������� � 
; �������������
WS_OVERLAPPEDWINDOW equ WS_OVERLAPPED OR WS_CAPTION OR WS_SYSMENU OR WS_THICKFRAME OR WS_MINIMIZEBOX OR WS_MAXIMIZEBOX
; ������������� ������ ���� ��������, �������� �� ���������
SW_SHOWDEFAULT equ 10
WM_LBUTTONDOWN equ 201h
WM_RBUTTONDBLCLK equ 206h
WM_LBUTTONDBLCLK equ 203h
SWP_SHOWWINDOW equ 40h
HWND_TOP equ 0
WM_SETTEXT equ 0h
.code
start:
; �������� ���������� ���������� ���������� hInstance
invoke GetModuleHandleA, 0
mov hInstance,eax
; �������� ��������� �� ��������� ������ �������� ��������
invoke GetCommandLineA
mov CommandLine,eax
; �������� ������� �������
invoke WinMain, hInstance, 0 , CommandLine, SW_SHOWDEFAULT
; ��������� �������
invoke ExitProcess,eax

WinMain proc hInst:DWORD ,hPrevInst:DWORD, CmdLine:DWORD, CmdShow:DWORD
; ��������� ���������� ���� ��������� ������ ����
LOCAL wc:WNDCLASSEXA
; ��������� ���������� ���� ��������� ���������
LOCAL msg:MSG
; ��������� ���������� � ���������� ����
LOCAL hwnd:DWORD
; ���������� ����� ��������� c ���������� ������ ����
; ������ ���������
mov wc.cbSize,SIZEOF WNDCLASSEXA
; ����������� ���� ��� ��������� ��� ������ � ������
mov wc.style, CS_HREDRAW or CS_VREDRAW
; ��������� �� ������� ��������� ��������� ����
mov wc.lpfnWndProc, OFFSET WndProc
; ����� �������������� ���� �� ���������� ������ ����
mov wc.cbClsExtra,0
; ����� �������������� ���� �� ����������� ����
mov wc.cbWndExtra,0
; ���������� ���������� ����������
push hInst
pop wc.hInstance
; ��� ���� � �����
invoke CreateSolidBrush,00FF0000h
mov wc.hbrBackground,eax
; ������� ���� �����������
mov wc.lpszMenuName,0
; ��� ������ ����
mov wc.lpszClassName,OFFSET ClassName
; ����������� ������ � ������ ������ ����������
invoke LoadIconA,0,IDI_APPLICATION
mov wc.hIcon,eax
mov wc.hIconSm,eax
; ����������� ������-�������
invoke LoadCursorA,0,IDC_ARROW
mov wc.hCursor,eax
; ����������� ������ ����
invoke RegisterClassExA, addr wc
invoke CreateWindowExA,0,ADDR ClassName, ADDR AppName, WS_OVERLAPPEDWINDOW, 20, 20, CW_USEDEFAULT,CW_USEDEFAULT,0,0, hInst,0
mov hwnd,eax; ���������� ���������� ����
; ����������� ����
invoke ShowWindow, hwnd,SW_SHOWNORMAL
; ���������� ����������� ����
invoke UpdateWindow, hwnd
; ���� ��������� ���������
.WHILE 1
; �������� ���������
invoke GetMessageA, ADDR msg,0,0,0
.BREAK .IF (!eax)
; ������������� ���������� ��������� � ����������
invoke TranslateMessage, ADDR msg
; �������� ��������� ������� ������� ��� ���������
invoke DispatchMessageA, ADDR msg
.ENDW
mov eax,msg.wParam
ret
WinMain endp

WndProc proc hWnd:DWORD, wMsg:DWORD, wParam:DWORD, lParam:DWORD

LOCAL h:DWORD
LOCAL w:DWORD

.IF wMsg==200h
invoke GetCursorPos, addr myXY
invoke GetClientRect, hWnd ,addr myRECT
mov eax, myRECT.bottom
cdq
mov ebx,2
idiv ebx
.IF myXY.y<eax
invoke Sleep,300
invoke SetWindowTextA, hWnd, addr NewName
invoke Sleep,300
invoke SetWindowTextA, hWnd, addr AppName
.ENDIF
.ENDIF


.IF wMsg==100h
.IF wParam==VK_F9
invoke SetWindowPos,hWnd,HWND_TOP,1425,0,500,300,SWP_SHOWWINDOW
.ENDIF
.ENDIF


; ��������� � ������������� ����������� ����
.IF wMsg==WM_DESTROY
; ��������� � ������� ��������� WM_QUIT
invoke PostQuitMessage,0
; ���� ������ �������

.ELSE
; ����� ������� ��������� ��������� �� ���������
invoke DefWindowProcA,hWnd,wMsg,wParam,lParam
ret
.ENDIF
xor eax,eax
ret
WndProc endp
end start
