Attribute VB_Name = "Calculator"
'==============================================================================
' VBA Calculator Module
' Beschreibung: Ein vollstaendiger Taschenrechner mit grundlegenden und
'               erweiterten mathematischen Funktionen
' Autor: Claude
' Datum: 2025-11-30
'==============================================================================
Option Explicit

'------------------------------------------------------------------------------
' Grundrechenarten
'------------------------------------------------------------------------------

' Addition: Addiert zwei Zahlen
Public Function Addieren(ByVal Zahl1 As Double, ByVal Zahl2 As Double) As Double
    Addieren = Zahl1 + Zahl2
End Function

' Subtraktion: Subtrahiert Zahl2 von Zahl1
Public Function Subtrahieren(ByVal Zahl1 As Double, ByVal Zahl2 As Double) As Double
    Subtrahieren = Zahl1 - Zahl2
End Function

' Multiplikation: Multipliziert zwei Zahlen
Public Function Multiplizieren(ByVal Zahl1 As Double, ByVal Zahl2 As Double) As Double
    Multiplizieren = Zahl1 * Zahl2
End Function

' Division: Dividiert Zahl1 durch Zahl2
Public Function Dividieren(ByVal Zahl1 As Double, ByVal Zahl2 As Double) As Variant
    If Zahl2 = 0 Then
        Dividieren = CVErr(xlErrDiv0)  ' Division durch Null Fehler
    Else
        Dividieren = Zahl1 / Zahl2
    End If
End Function

' Modulo: Gibt den Rest einer Division zurueck
Public Function Modulo(ByVal Zahl1 As Double, ByVal Zahl2 As Double) As Variant
    If Zahl2 = 0 Then
        Modulo = CVErr(xlErrDiv0)
    Else
        Modulo = Zahl1 Mod Zahl2
    End If
End Function

'------------------------------------------------------------------------------
' Erweiterte mathematische Funktionen
'------------------------------------------------------------------------------

' Potenz: Berechnet Basis hoch Exponent
Public Function Potenz(ByVal Basis As Double, ByVal Exponent As Double) As Double
    Potenz = Basis ^ Exponent
End Function

' Quadratwurzel: Berechnet die Quadratwurzel einer Zahl
Public Function Quadratwurzel(ByVal Zahl As Double) As Variant
    If Zahl < 0 Then
        Quadratwurzel = CVErr(xlErrNum)  ' Fehler bei negativen Zahlen
    Else
        Quadratwurzel = Sqr(Zahl)
    End If
End Function

' N-te Wurzel: Berechnet die n-te Wurzel einer Zahl
Public Function NteWurzel(ByVal Zahl As Double, ByVal N As Double) As Variant
    If N = 0 Then
        NteWurzel = CVErr(xlErrDiv0)
    ElseIf Zahl < 0 And (N Mod 2 = 0) Then
        NteWurzel = CVErr(xlErrNum)  ' Gerade Wurzel aus negativer Zahl
    Else
        NteWurzel = Zahl ^ (1 / N)
    End If
End Function

' Prozent: Berechnet den Prozentwert
Public Function Prozent(ByVal Grundwert As Double, ByVal Prozentsatz As Double) As Double
    Prozent = Grundwert * (Prozentsatz / 100)
End Function

' Absolutwert: Gibt den Absolutwert einer Zahl zurueck
Public Function Absolutwert(ByVal Zahl As Double) As Double
    Absolutwert = Abs(Zahl)
End Function

' Runden: Rundet eine Zahl auf die angegebene Anzahl von Dezimalstellen
Public Function Runden(ByVal Zahl As Double, Optional ByVal Dezimalstellen As Integer = 0) As Double
    Runden = Round(Zahl, Dezimalstellen)
End Function

'------------------------------------------------------------------------------
' Trigonometrische Funktionen
'------------------------------------------------------------------------------

' Sinus (Eingabe in Grad)
Public Function SinusGrad(ByVal Winkel As Double) As Double
    Dim Bogen As Double
    Bogen = Winkel * Application.WorksheetFunction.Pi / 180
    SinusGrad = Sin(Bogen)
End Function

' Cosinus (Eingabe in Grad)
Public Function CosinusGrad(ByVal Winkel As Double) As Double
    Dim Bogen As Double
    Bogen = Winkel * Application.WorksheetFunction.Pi / 180
    CosinusGrad = Cos(Bogen)
End Function

' Tangens (Eingabe in Grad)
Public Function TangensGrad(ByVal Winkel As Double) As Variant
    Dim Bogen As Double
    Bogen = Winkel * Application.WorksheetFunction.Pi / 180

    ' Pruefe auf ungueltige Winkel (90, 270 Grad etc.)
    If Cos(Bogen) = 0 Then
        TangensGrad = CVErr(xlErrNum)
    Else
        TangensGrad = Tan(Bogen)
    End If
End Function

'------------------------------------------------------------------------------
' Logarithmische Funktionen
'------------------------------------------------------------------------------

' Natuerlicher Logarithmus (ln)
Public Function NatLog(ByVal Zahl As Double) As Variant
    If Zahl <= 0 Then
        NatLog = CVErr(xlErrNum)
    Else
        NatLog = Log(Zahl)
    End If
End Function

' Logarithmus zur Basis 10
Public Function Log10(ByVal Zahl As Double) As Variant
    If Zahl <= 0 Then
        Log10 = CVErr(xlErrNum)
    Else
        Log10 = Log(Zahl) / Log(10)
    End If
End Function

' Logarithmus zu beliebiger Basis
Public Function LogBasis(ByVal Zahl As Double, ByVal Basis As Double) As Variant
    If Zahl <= 0 Or Basis <= 0 Or Basis = 1 Then
        LogBasis = CVErr(xlErrNum)
    Else
        LogBasis = Log(Zahl) / Log(Basis)
    End If
End Function

'------------------------------------------------------------------------------
' Speicher-Funktionen
'------------------------------------------------------------------------------
Private mSpeicher As Double

' Speicher loeschen
Public Sub SpeicherLoeschen()
    mSpeicher = 0
End Sub

' Zum Speicher addieren
Public Sub SpeicherPlus(ByVal Zahl As Double)
    mSpeicher = mSpeicher + Zahl
End Sub

' Vom Speicher subtrahieren
Public Sub SpeicherMinus(ByVal Zahl As Double)
    mSpeicher = mSpeicher - Zahl
End Sub

' Speicherwert abrufen
Public Function SpeicherAbrufen() As Double
    SpeicherAbrufen = mSpeicher
End Function

'------------------------------------------------------------------------------
' Universelle Rechenfunktion
'------------------------------------------------------------------------------

' Berechne: Fuehrt eine Berechnung basierend auf dem Operator aus
' Unterstuetzte Operatoren: +, -, *, /, ^, %, mod, sqrt
Public Function Berechne(ByVal Zahl1 As Double, ByVal Operator As String, _
                         Optional ByVal Zahl2 As Double = 0) As Variant
    On Error GoTo ErrorHandler

    Select Case LCase(Trim(Operator))
        Case "+"
            Berechne = Addieren(Zahl1, Zahl2)
        Case "-"
            Berechne = Subtrahieren(Zahl1, Zahl2)
        Case "*", "x"
            Berechne = Multiplizieren(Zahl1, Zahl2)
        Case "/", ":"
            Berechne = Dividieren(Zahl1, Zahl2)
        Case "^", "**"
            Berechne = Potenz(Zahl1, Zahl2)
        Case "%"
            Berechne = Prozent(Zahl1, Zahl2)
        Case "mod"
            Berechne = Modulo(Zahl1, Zahl2)
        Case "sqrt", "wurzel"
            Berechne = Quadratwurzel(Zahl1)
        Case "abs"
            Berechne = Absolutwert(Zahl1)
        Case "sin"
            Berechne = SinusGrad(Zahl1)
        Case "cos"
            Berechne = CosinusGrad(Zahl1)
        Case "tan"
            Berechne = TangensGrad(Zahl1)
        Case "ln"
            Berechne = NatLog(Zahl1)
        Case "log"
            Berechne = Log10(Zahl1)
        Case Else
            Berechne = CVErr(xlErrValue)  ' Ungueltiger Operator
    End Select
    Exit Function

ErrorHandler:
    Berechne = CVErr(xlErrValue)
End Function

'------------------------------------------------------------------------------
' Demo / Test Funktion
'------------------------------------------------------------------------------

' TestCalculator: Testet alle Funktionen und gibt Ergebnisse aus
Public Sub TestCalculator()
    Debug.Print "=== VBA Calculator Test ==="
    Debug.Print ""
    Debug.Print "Grundrechenarten:"
    Debug.Print "  10 + 5 = " & Addieren(10, 5)
    Debug.Print "  10 - 5 = " & Subtrahieren(10, 5)
    Debug.Print "  10 * 5 = " & Multiplizieren(10, 5)
    Debug.Print "  10 / 5 = " & Dividieren(10, 5)
    Debug.Print "  10 mod 3 = " & Modulo(10, 3)
    Debug.Print ""
    Debug.Print "Erweiterte Funktionen:"
    Debug.Print "  2 ^ 8 = " & Potenz(2, 8)
    Debug.Print "  Wurzel(16) = " & Quadratwurzel(16)
    Debug.Print "  3. Wurzel(27) = " & NteWurzel(27, 3)
    Debug.Print "  20% von 150 = " & Prozent(150, 20)
    Debug.Print "  |−42| = " & Absolutwert(-42)
    Debug.Print ""
    Debug.Print "Trigonometrie (Grad):"
    Debug.Print "  sin(30) = " & Runden(SinusGrad(30), 4)
    Debug.Print "  cos(60) = " & Runden(CosinusGrad(60), 4)
    Debug.Print "  tan(45) = " & Runden(TangensGrad(45), 4)
    Debug.Print ""
    Debug.Print "Logarithmen:"
    Debug.Print "  ln(e) = " & Runden(NatLog(2.71828182845905), 4)
    Debug.Print "  log10(100) = " & Log10(100)
    Debug.Print ""
    Debug.Print "=== Test abgeschlossen ==="
End Sub
