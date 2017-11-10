Program seq;
Const N = 25;
Var
  j, ptr, err, i, maximum, zeros : integer;
  symbol : char;
  io : text;
  input : string;
  buf : array[1..N] of string;
  numbers : array[1..N] of integer;
  Keys : set of char;
{ - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }  
procedure Error(num : integer);
begin
  case num of 
  1 : writeln('Fatal Error(' + num + '): ������ ������ ����� ������ � ���������.');
  2 : writeln('Fatal Error(' + num + '): ������ �������� �����.');
  3 : writeln('Fatal Error(' + num + '): ���� ������ ��� ���� ������ '
              + '�������������� ������ �� �����. ��. �������� (-h)'
              );
  end;
  halt();
  readln();
end;
{ - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
function isDigit(symbol : char) : boolean;
begin
  if (symbol <= '9') AND (symbol >= '0') then
    isDigit := TRUE
  else
    isDigit := FALSE;
end;
{ - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }

Begin
  if ParamCount <> 0 then
  begin
    for i := 1 to ParamCount do
      if ParamStr(i)[1] = '-' then
        Keys := Keys + [ParamStr(i)[2]];
  end;
  if (('e' in Keys) and ('r' in Keys)) or (('e' in Keys) and ('f' in Keys)) or (('r' in Keys) and ('f' in Keys)) then
    Error(1)
  else
  begin
    if 'h' in Keys then
      writeln('� ����� ����� �������� ������ a[1..n]. ����� ����� �����'
               + ' �������, ������ ������, ������������������ �����.'
               + '��� ��� ��������, �� ������ ����, ���������� '
               + '(�������� �� �������) � ������ �������, � ������� - � �����. '
               + '������� �������������� � ��������� �������.'
               );
    if 'i' in Keys then
      writeln('���������� ������');
    if 'g' in Keys then
      writeln('�8�-111�');
    if ('r' in Keys) or ('e' in Keys) then
      Error(3) 
  else if NOT fileexists(ParamStr(ParamCount)) then
    Error(2)
  else
    begin
      Assign(io, ParamStr(ParamCount));
      Reset(io);
      while NOT Eof(io) do
        begin
          read(io, symbol);
          input := input + symbol;
        end;
      
{* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -*}
{*                             ����� ������                                   *}
{* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -*}
      i := 1;
      while length(input) <> 0 do
        begin
          symbol := input[1];
          if isDigit(symbol) then
            buf[i] := buf[i] + symbol
          else if symbol = ' ' then
            begin
              val(buf[i], numbers[i], err);
              inc(i);
            end;
          delete(input, 1, 1);
          if length(input) = 0 then
            val(buf[i], numbers[i], err);
        end;
//    dec(i);
{* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -*}
      for i := 1 to i do
        write(numbers[i], ' ');
      writeln;
      ptr := 1;
      maximum := 0;
      zeros := 0;
{* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -*}
{*                ����� ������������ ������������������ �����                 *}
{* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -*}
      while ptr < i do
        begin
          if numbers[ptr] <> 0 then
            inc(ptr)
          else
            begin
              inc(zeros);
              j := ptr + 1;
              while (numbers[j] = 0) AND (j <= i) do
                begin
                  inc(j);
                  inc(zeros);
                end;
              if zeros > maximum then
                maximum := zeros;
              zeros := 0;
              inc(ptr);
            end;
        end;
        j := 0;
        ptr := 1;
{* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -*}
{*                             ���������� �������                             *}
{* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -*}     
      while ptr < i do
        begin
          if numbers[ptr] <> 0 then
            inc(ptr)
          else
            begin
              j := ptr + 1;
              while (numbers[j] = 0) AND (j <= i) do
                inc(j);
              if (j <= i) AND (numbers[j] <> 0) then
                begin
                  numbers[ptr] := numbers[j];
                  numbers[j] := 0;
                  j := ptr;
                end
              else
                inc(ptr);
            end;
        end;
      writeln('������������ ������������������ �����: ', maximum);
      for i:= 1 to i do
        write(numbers[i], ' ');
    end;
  end;
End.
