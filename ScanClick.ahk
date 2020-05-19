SetTitleMatchMode, RegEx
flagScanner = 0
; Canon DR-
IfWinExist, ^Canon DR-.* on STI - .*$
{
	flagScanner = 1
}
Else
{
	; FUJITSU TWAIN32(���K�V�[�h���C�o)
	IfWinExist, ^TWAIN ��ײ�� \(32\)$
	{
		flagScanner = 1
	}
	Else
	{
		; EPSON Scan
		IfWinExist, ^EPSON Scan$
		{
			flagScanner = 1
		}
		Else
		{
			; �x�m�ʐV�h���C�o
			IfWinExist, ^PaperStream IP \(TWAIN\) - fi-.*$
			{
				flagScanner = 1
			}
		}
	}
}
if flagScanner = 1
{
	; Canon�X�L���i�̃G���[���
	IfWinExist, ^�x��$
	{
		ControlClick, OK, ^�x��$
	}
	Else
	{
		; Canon�X�L���i�̃G���[���
		IfWinExist, ^�X�L���i�G���[$
		{
			ControlClick, OK, ^�X�L���i�G���[$
		}
		Else
		{
			; Canon�X�L���i�̃G���[���
			IfWinExist, ^�X�L���i�[�G���[$
			{
				ControlClick, OK, ^�X�L���i�[�G���[$
			}
			Else
			{
				; FUJITSU TWAIN32(���K�V�[�h���C�o)�̃G���[���
				IfWinExist, ^TWAIN ��ײ��$
				{
					; ���̂����K�\���ň���������Ȃ��̂ŁA���S��v�Ō�������
					SetTitleMatchMode, 3
					ControlClick, �Ď��s(&R), TWAIN ��ײ��
					SetTitleMatchMode, RegEx
				}
				Else
				{
					; �x�m�ʂ̐V�h���C�o�̃G���[���(�ǂݎ�蒆��ʂ������E�B���h�E�^�C�g���̂��߁A�G���[�R�[�h�̃e�L�X�g�ŋ�ʂ���)
					IfWinExist, ^PaperStream IP$
					{
						; ���̂����K�\���ň���������Ȃ��̂ŁA���S��v�Ō�������
						SetTitleMatchMode, 3
						ControlClick, �Ď��s(&R), PaperStream IP, Code:
						SetTitleMatchMode, RegEx
					}
					Else
					{
						; Canon DR-
						IfWinExist, ^Canon DR-.* on STI - .*$
						{
							ControlClick, �X�L����, ^Canon DR-.* on STI - .*$
						}
						Else
						{
							; FUJITSU TWAIN32(���K�V�[�h���C�o)
							IfWinExist, ^TWAIN ��ײ�� \(32\)$
							{
								ControlClick, �ǎ�, ^TWAIN ��ײ�� \(32\)$
							}
							Else
							{
								; EPSON Scan
								IfWinExist, ^EPSON Scan$
								{
									; ���̂����K�\���ň���������Ȃ��̂ŁA���S��v�Ō�������
									SetTitleMatchMode, 3
									ControlClick, �v���r���[(&P), EPSON Scan
									SetTitleMatchMode, RegEx
								}
								Else
								{
									; �x�m�ʐV�h���C�o
									IfWinExist, ^PaperStream IP \(TWAIN\) - fi-.*$
									{
										WinGetPos,,, Width, Height, ^PaperStream IP \(TWAIN\) - fi-.*$
										Y = %Height%
										Y -= 32
										ControlClick, X88 Y%Y%, ^PaperStream IP \(TWAIN\) - fi-.*$,, LEFT,, Pos
									}
								}
							}
						}
					}
				}
			}
		}
	}
}
Else
{
	; �^�C�g���̍Ō�ɑS�p�X�y�[�X�����邹�����A���K�\���ł��܂��Ђ�������Ȃ��̂őO����v�ɂ��Ă���
	SetTitleMatchMode, 1
	IfWinExist, BTScan
	{
		ControlClick, ���͊J�n(&T)..., BTScan
		SetTitleMatchMode, RegEx

		Loop, 5
		{
			Sleep, 1000

			; Canon DR-
			IfWinExist, ^Canon DR-.* on STI - .*$
			{
				ControlClick, �X�L����, ^Canon DR-.* on STI - .*$
				break
			}
			Else
			{
				; FUJITSU TWAIN32(���K�V�[�h���C�o)
				IfWinExist, ^TWAIN ��ײ�� \(32\)$
				{
					ControlClick, �ǎ�, ^TWAIN ��ײ�� \(32\)$
					break
				}
				Else
				{
					; EPSON Scan
					IfWinExist, ^EPSON Scan$
					{
						; ���̂����K�\���ň���������Ȃ��̂ŁA���S��v�Ō�������
						SetTitleMatchMode, 3
						ControlClick, �v���r���[(&P), EPSON Scan
						SetTitleMatchMode, RegEx
						break
					}
					Else
					{
						; �x�m�ʐV�h���C�o
						IfWinExist, ^PaperStream IP \(TWAIN\) - fi-.*$
						{
							WinGetPos,,, Width, Height, ^PaperStream IP \(TWAIN\) - fi-.*$
							Y = %Height%
							Y -= 32
							ControlClick, X88 Y%Y%, ^PaperStream IP \(TWAIN\) - fi-.*$,, LEFT,, Pos
							break
						}
					}
				}
			}
		}
	}
}
