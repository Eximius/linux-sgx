/*
* Math library
*
* Copyright (C) 2016 Intel Corporation. All rights reserved.
*
* Redistribution and use in source and binary forms, with or without
* modification, are permitted provided that the following conditions
* are met:
*
*   * Redistributions of source code must retain the above copyright
*     notice, this list of conditions and the following disclaimer.
*   * Redistributions in binary form must reproduce the above copyright
*     notice, this list of conditions and the following disclaimer in
*     the documentation and/or other materials provided with the
*     distribution.
*   * Neither the name of Intel Corporation nor the names of its
*     contributors may be used to endorse or promote products derived
*     from this software without specific prior written permission.
*
* THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
* "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
* LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
* A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
* OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
* SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
* LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
* DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
* THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
* (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
* OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*
*
* Author Name <jingwei.zhang@intel.com>
*   History:
*   03-14-2016 Initial version. numerics svn rev. 12864
*/
	.file "roundl.c"
	.text
..TXTST0:
# -- Begin  roundl
	.text
       .align    16,0x90
	.globl roundl
roundl:
# parameter 1: 8 + %ebp
..B1.1:
..L1:

        pushl     %ebp
        movl      %esp, %ebp
        andl      $-16, %esp
        pushl     %esi
        pushl     %edi
        subl      $24, %esp
..B1.2:
        fnstcw    14(%esp)
..B1.3:
        movzwl    16(%ebp), %eax
        andl      $32767, %eax
        call      ..L2
..L2:
        popl      %esi
        lea       _GLOBAL_OFFSET_TABLE_+[. - ..L2](%esi), %esi
        cmpl      $16446, %eax
        jge       ..B1.25
..B1.4:
        cmpl      $16383, %eax
        jl        ..B1.19
..B1.5:
        cmpl      $16414, %eax
        jge       ..B1.7
..B1.6:
        movl      12(%ebp), %edi
        lea       2(%eax), %ecx
        negl      %eax
        movl      %edi, %edx
        addl      $30, %eax
        shll      %cl, %edx
        movl      %eax, %ecx
        shrl      %cl, %edi
        shll      %cl, %edi
        movl      %edi, 12(%ebp)
        movl      $0, 8(%ebp)
        jmp       ..B1.10
..B1.7:
        jle       ..B1.9
..B1.8:
        movl      8(%ebp), %edi
        lea       2(%eax), %ecx
        negl      %eax
        movl      %edi, %edx
        addl      $30, %eax
        shll      %cl, %edx
        movl      %eax, %ecx
        shrl      %cl, %edi
        shll      %cl, %edi
        movl      %edi, 8(%ebp)
        jmp       ..B1.10
..B1.9:
        movl      8(%ebp), %edx
        movl      $0, 8(%ebp)
..B1.10:
        testl     %edx, %edx
        jge       ..B1.18
..B1.11:
        movzwl    14(%esp), %edx
        movl      %edx, %eax
        andl      $768, %eax
        cmpl      $768, %eax
        je        ..B1.31
..B1.12:
        orl       $-64768, %edx
        movw      %dx, 12(%esp)
..B1.13:
        fldcw     12(%esp)
..B1.14:
        movl      $1, %edx
..B1.15:
        fldt      8(%ebp)
        movzbl    17(%ebp), %eax
        andl      $128, %eax
        shrl      $7, %eax
        testl     %edx, %edx
        faddl     _ones@GOTOFF(%esi,%eax,8)
        fstpt     (%esp)
        je        ..B1.17
..B1.16:
        fldcw     14(%esp)
..B1.17:
        fldt      (%esp)
        addl      $24, %esp
        popl      %edi
        popl      %esi
        movl      %ebp, %esp
        popl      %ebp
        ret       
..B1.18:
        fldt      8(%ebp)
        addl      $24, %esp
        popl      %edi
        popl      %esi
        movl      %ebp, %esp
        popl      %ebp
        ret       
..B1.19:
        cmpl      $16382, %eax
        je        ..B1.33
..B1.20:
        testl     %eax, %eax
        jne       ..B1.24
..B1.21:
        cmpl      $0, 12(%ebp)
        jne       ..B1.23
..B1.22:
        cmpl      $0, 8(%ebp)
        je        ..B1.24
..B1.23:
        fldl      _smallest_value_64@GOTOFF(%esi)
        fstpl     16(%esp)
..B1.24:
        movzbl    17(%ebp), %eax
        andl      $128, %eax
        shrl      $7, %eax
        fldl      _zeros@GOTOFF(%esi,%eax,8)
        addl      $24, %esp
        popl      %edi
        popl      %esi
        movl      %ebp, %esp
        popl      %ebp
        ret       
..B1.25:
        movzwl    14(%esp), %edx
        movl      %edx, %eax
        andl      $768, %eax
        cmpl      $768, %eax
        je        ..B1.32
..B1.26:
        orl       $-64768, %edx
        movw      %dx, 12(%esp)
..B1.27:
        fldcw     12(%esp)
..B1.28:
        fldt      8(%ebp)
        fmull     _ones@GOTOFF(%esi)
        fstpt     (%esp)
..B1.29:
        fldcw     14(%esp)
..B1.30:
        fldt      (%esp)
        addl      $24, %esp
        popl      %edi
        popl      %esi
        movl      %ebp, %esp
        popl      %ebp
        ret       
..B1.31:
        xorl      %edx, %edx
        jmp       ..B1.15
..B1.32:
        fldt      8(%ebp)
        fmull     _ones@GOTOFF(%esi)
        fstpt     (%esp)
        jmp       ..B1.30
..B1.33:
        movzbl    17(%ebp), %eax
        andl      $128, %eax
        shrl      $7, %eax
        fldl      _ones@GOTOFF(%esi,%eax,8)
        addl      $24, %esp
        popl      %edi
        popl      %esi
        movl      %ebp, %esp
        popl      %ebp
        ret       
        .align    16,0x90
	.type	roundl,@function
	.size	roundl,.-roundl
	.data
# -- End  roundl
	.section .rodata, "a"
	.align 4
	.align 4
_ones:
	.long	0
	.long	1072693248
	.long	0
	.long	3220176896
	.type	_ones,@object
	.size	_ones,16
	.align 4
_smallest_value_64:
	.long	1
	.long	0
	.long	1
	.long	2147483648
	.type	_smallest_value_64,@object
	.size	_smallest_value_64,16
	.align 4
_zeros:
	.long	0
	.long	0
	.long	0
	.long	2147483648
	.type	_zeros,@object
	.size	_zeros,16
	.data
	.section .note.GNU-stack, ""
# End
