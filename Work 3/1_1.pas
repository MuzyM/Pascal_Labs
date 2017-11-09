Program saw;
Var
  io : text;
  smth, input : string;
  mx, value, saw_length, position, maximum, current_element, count, i, err, N : integer;
  Keys : set of char;
  buf : array[1..50] of string;
  numbers : array[1..50] of integer;
  symbol : char;

{ - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }  
procedure Error(num : integer);
begin
  case num of 
  1 : writeln('Fatal Error(' + num + '): ������ ������ ����� ������ � ���������.');
  2 : writeln('Fatal Error(' + num + '): ������ �������� �����.');
  3 : writeln('Fatal Error(' + num + '): ���� ������ ��� ���� ������ '
              + '�������������� ������ � ����������. ��. �������� (-h)'
              );
  end;
  halt();
  readln();
end;
{ - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
function isDigit(symbol : char) : boolean;
begin
  if (symbol <= '9') and (symbol >= '0') then
    isDigit := TRUE
  else
    isDigit := FALSE;
end;
{ - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
    
begin
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
      writeln('� ���������� ����� ������ a[1..N]. ����� ����� ����� '
               + '������� ������������ ������������������ ����� (��'
               + '����� � ��������).'
               );
    if 'i' in Keys then
      writeln('���������� ������');
    if 'g' in Keys then
      writeln('�8�-111�');
    if ('r' in Keys) or ('f' in Keys) then
      Error(3);
    write('������� �������� �������: ');
    readln(input);
    i := 1;
{* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - *}
{*                               ����� ������                                  *}
{* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - *}    
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
   
   dec(i);
   position := 2;
   maximum := 0;
   while position < i do
      if (numbers[position] > numbers[position - 1]) and (numbers[position] > numbers[position + 1]) then
      begin
        value := position;
        saw_length := 0;
        while (numbers[value] > numbers[value - 1]) and (numbers[value] > numbers[value + 1]) do
        begin
          inc(saw_length);
          value := value + 2;
        end;
        if saw_length > 0 then
          maximum := 2 * saw_length + 1;
        position := position + 2 * saw_length + 1;  
      end
      else
        inc(position);
  end;
  if (maximum = 0) and ('o' in Keys) then
  begin
    Assign(io, 'out.txt');
    Rewrite(io);
    writeln(io, '������������ ������������������� ���');
    Close(io);
  end
  else if (maximum = 0) then
    writeln('������������ ������������������� ���')
  else
    writeln('������������ ������������ ������������������: ', maximum);
end.