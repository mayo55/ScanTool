SetTitleMatchMode, RegEx
flagScanner = 0
; Canon DR-
IfWinExist, ^Canon DR-.* on STI - .*$
{
	flagScanner = 1
}
Else
{
	; FUJITSU TWAIN32(レガシードライバ)
	IfWinExist, ^TWAIN ﾄﾞﾗｲﾊﾞ \(32\)$
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
			; 富士通新ドライバ
			IfWinExist, ^PaperStream IP \(TWAIN\) - fi-.*$
			{
				flagScanner = 1
			}
		}
	}
}
if flagScanner = 1
{
	; Canonスキャナのエラー画面
	IfWinExist, ^警告$
	{
		ControlClick, OK, ^警告$
	}
	Else
	{
		; Canonスキャナのエラー画面
		IfWinExist, ^スキャナエラー$
		{
			ControlClick, OK, ^スキャナエラー$
		}
		Else
		{
			; Canonスキャナのエラー画面
			IfWinExist, ^スキャナーエラー$
			{
				ControlClick, OK, ^スキャナーエラー$
			}
			Else
			{
				; FUJITSU TWAIN32(レガシードライバ)のエラー画面
				IfWinExist, ^TWAIN ﾄﾞﾗｲﾊﾞ$
				{
					; 何故か正規表現で引っかからないので、完全一致で検索する
					SetTitleMatchMode, 3
					ControlClick, 再試行(&R), TWAIN ﾄﾞﾗｲﾊﾞ
					SetTitleMatchMode, RegEx
				}
				Else
				{
					; 富士通の新ドライバのエラー画面(読み取り中画面が同じウィンドウタイトルのため、エラーコードのテキストで区別する)
					IfWinExist, ^PaperStream IP$
					{
						; 何故か正規表現で引っかからないので、完全一致で検索する
						SetTitleMatchMode, 3
						ControlClick, 再試行(&R), PaperStream IP, Code:
						SetTitleMatchMode, RegEx
					}
					Else
					{
						; Canon DR-
						IfWinExist, ^Canon DR-.* on STI - .*$
						{
							ControlClick, スキャン, ^Canon DR-.* on STI - .*$
						}
						Else
						{
							; FUJITSU TWAIN32(レガシードライバ)
							IfWinExist, ^TWAIN ﾄﾞﾗｲﾊﾞ \(32\)$
							{
								ControlClick, 読取, ^TWAIN ﾄﾞﾗｲﾊﾞ \(32\)$
							}
							Else
							{
								; EPSON Scan
								IfWinExist, ^EPSON Scan$
								{
									; 何故か正規表現で引っかからないので、完全一致で検索する
									SetTitleMatchMode, 3
									ControlClick, プレビュー(&P), EPSON Scan
									SetTitleMatchMode, RegEx
								}
								Else
								{
									; 富士通新ドライバ
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
	; タイトルの最後に全角スペースがあるせいか、正規表現でうまくひっかからないので前方一致にしている
	SetTitleMatchMode, 1
	IfWinExist, BTScan
	{
		ControlClick, 入力開始(&T)..., BTScan
		SetTitleMatchMode, RegEx

		Loop, 5
		{
			Sleep, 1000

			; Canon DR-
			IfWinExist, ^Canon DR-.* on STI - .*$
			{
				ControlClick, スキャン, ^Canon DR-.* on STI - .*$
				break
			}
			Else
			{
				; FUJITSU TWAIN32(レガシードライバ)
				IfWinExist, ^TWAIN ﾄﾞﾗｲﾊﾞ \(32\)$
				{
					ControlClick, 読取, ^TWAIN ﾄﾞﾗｲﾊﾞ \(32\)$
					break
				}
				Else
				{
					; EPSON Scan
					IfWinExist, ^EPSON Scan$
					{
						; 何故か正規表現で引っかからないので、完全一致で検索する
						SetTitleMatchMode, 3
						ControlClick, プレビュー(&P), EPSON Scan
						SetTitleMatchMode, RegEx
						break
					}
					Else
					{
						; 富士通新ドライバ
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
