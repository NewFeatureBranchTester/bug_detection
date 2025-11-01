Sub OpenWorkbookAndActivateSheet()
    Dim wb As Object
    Dim FilePath As String
     On Error GoTo ErrorHandler
     FilePath = ThisWorkbook.Path & "\vba\Workbook1.xlsx"
    ' Check if file exists
    If Dir(FilePath) = "" Then
        MsgBox "File not found: " & FilePath
        Exit Sub
    End If
    
    Set wb = Workbooks.Open(FilePath)
    
    ' Check if sheet 2 exists
    Set wb = Workbooks.Open(FilePath)
    
    ' Make Excel visible
    wb.Application.Visible = True

    ' Check if sheet 2 exists
    If wb.Sheets.Count >= 2 Then
        wb.Sheets(2).Activate
ErrorHandler:
    MsgBox "Error " & Err.Number & ": " & Err.Description
End Sub
ErrorHandler:
    MsgBox "Error: " & Err.Description
End Sub
