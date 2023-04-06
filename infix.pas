program InfixToPrefixAndPostfix;

uses
  SysUtils;

const
  MAX_SIZE = 100;

type
  Stack = record
    Data: array[1..MAX_SIZE] of string;
    Top: integer;
  end;

function isOperator(ch: char): boolean;
begin
  isOperator := (ch = '+') or (ch = '-') or (ch = '*') or (ch = '/') or (ch = '^');
end;

function precedence(ch: char): integer;
begin
  case ch of
    '^': precedence := 3;
    '*', '/': precedence := 2;
    '+', '-': precedence := 1;
    else precedence := 0;
  end;
end;

procedure push(var s: Stack; x: string);
begin
  if s.Top = MAX_SIZE then
    writeln('Stack Overflow')
  else begin
    Inc(s.Top);
    s.Data[s.Top] := x;
  end;
end;

function pop(var s: Stack): string;
begin
  if s.Top = 0 then
    writeln('Stack Underflow')
  else begin
    pop := s.Data[s.Top];
    Dec(s.Top);
  end;
end;

function infixToPrefix(infixExpr: string): string;
var
  s: Stack;
  i, j: integer;
  token, ch: char;
  prefixExpr: string;
begin
  s.Top := 0;
  prefixExpr := '';

  for i := Length(infixExpr) downto 1 do
  begin
    token := infixExpr[i];
    if token = ' ' then
      Continue
    else if isOperator(token) then
    begin
      while (s.Top > 0) and (precedence(token) < precedence(s.Data[s.Top][1])) do
        prefixExpr := prefixExpr + pop(s) + ' ';
      push(s, token + ' ');
    end
    else if token = ')' then
      push(s, token + ' ')
    else if token = '(' then
    begin
      ch := pop(s)[1];
      while ch <> ')' do
      begin
        prefixExpr := prefixExpr + ch + ' ';
        ch := pop(s)[1];
      end;
    end
    else
      prefixExpr := token + ' ' + prefixExpr;
  end;

  while s.Top > 0 do
    prefixExpr := pop(s) + ' ' + prefixExpr;

  infixToPrefix := Trim(prefixExpr);
end;

function infixToPostfix(infixExpr: string): string;
var
  s: Stack;
  i, j: integer;
  token, ch: char;
  postfixExpr: string;
begin
  s.Top := 0;
  postfixExpr := '';

  for i := 1 to Length(infixExpr) do
  begin
    token := infixExpr[i];
    if token = ' ' then
      Continue
    else if isOperator(token) then
    begin
      while (s.Top > 0) and (precedence(token) <= precedence(s.Data[s.Top][1])) do
        postfixExpr := postfixExpr + pop(s) + ' ';
      push(s, token + ' ');
    end
    else if token = '(' then
      push(s, token + ' ')
    else if token = ')' then
    begin
      ch := pop(s)[1];
      while ch <> '(' do
      begin
        postfixExpr := postfixExpr + ch + ' ';
        ch := pop(s)[1];
  end;
end
else
  postfixExpr := postfixExpr + token + ' ';
  end;

  while s.Top > 0 do
  postfixExpr := postfixExpr + pop(s) + ' ';

  infixToPostfix := Trim(postfixExpr);
end;

var
infixExpr, prefixExpr, postfixExpr: string;

begin
    write('Masukkan Nilai infix: ');
    readln(infixExpr);

    prefixExpr := infixToPrefix(infixExpr);
    postfixExpr := infixToPostfix(infixExpr);

    writeln('Hasil Prefix: ', prefixExpr);
    writeln('Hasil Postfix: ', postfixExpr);

    readln;
end.